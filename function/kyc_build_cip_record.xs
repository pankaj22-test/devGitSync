// Build an immutable CIP record from applicant data, all signals, and the final decision. Satisfies BSA/AML CIP, FinCEN CDD, and SEC 17a-4 7-year retention.
function "kyc/build_cip_record" {
  input {
    int applicant_id
    int decision_id
    enum final_outcome {
      values = ["approved", "denied"]
    }
  
    text[] reason_codes
    int? decided_by
  }

  stack {
    db.external.mysql.direct_query {
      sql = "SELECT * FROM applicant WHERE id = ?"
      response_type = "single"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = [$input.applicant_id]
    } as $applicant
  
    precondition ($applicant != null) {
      error_type = "notfound"
      error = "Applicant not found"
    }
  
    db.external.mysql.direct_query {
      sql = "SELECT * FROM kyc_signal WHERE applicant_id = ? ORDER BY waterfall_step ASC, created_at ASC"
      response_type = "list"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = [$input.applicant_id]
    } as $all_signals
  
    db.external.mysql.direct_query {
      sql = "SELECT * FROM decision WHERE applicant_id = ? ORDER BY created_at ASC"
      response_type = "list"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = [$input.applicant_id]
    } as $all_decisions
  
    db.external.mysql.direct_query {
      sql = "SELECT * FROM document_artifact WHERE applicant_id = ? AND status = 'verified'"
      response_type = "list"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = [$input.applicant_id]
    } as $verified_docs
  
    var $identity_snapshot {
      value = {
        first_name   : $applicant.first_name
        last_name    : $applicant.last_name
        ssn_encrypted: $applicant.ssn_encrypted
        date_of_birth: $applicant.date_of_birth
        address      : {
          line_1: $applicant.address_line_1,
          line_2: $applicant.address_line_2,
          city: $applicant.city,
          state: $applicant.state,
          zip: $applicant.zip,
          country: $applicant.country
        }
        email        : $applicant.email
        phone        : $applicant.phone
      }
    }
  
    var $verification_methods {
      value = ```
        $all_signals|map:{
                provider: $$.provider,
                method: $$.signal_type,
                timestamp: $$.created_at,
                outcome: $$.outcome,
                score: $$.score
              }
        ```
    }
  
    var $decision_chain {
      value = ```
        $all_decisions|map:{
                decision_id: $$.id,
                type: $$.decision_type,
                outcome: $$.outcome,
                reason_codes: $$.reason_codes,
                timestamp: $$.created_at,
                decided_by: $$.decided_by
              }
        ```
    }
  
    var $documents_verified {
      value = ```
        $verified_docs|map:{
                doc_id: $$.id,
                type: $$.doc_type,
                provider: $$.provider,
                confidence: $$.confidence_score,
                verified_at: $$.verified_at
              }
        ```
    }
  
    var $retention_expires {
      value = now|transform_timestamp:"+2557 days"
    }
  
    var $record_content {
      value = {
        applicant_id: $input.applicant_id
        identity    : $identity_snapshot
        methods     : $verification_methods
        decisions   : $decision_chain
        documents   : $documents_verified
        outcome     : $input.final_outcome
        reason_codes: $input.reason_codes
        timestamp   : now
      }
    }
  
    security.jws_encode {
      claims = $record_content
      key = $env.CIP_RECORD_SIGNING_KEY
      signature_algorithm = "HS256"
    } as $record_hash
  
    db.external.mysql.direct_query {
      sql = "INSERT INTO cip_record (created_at, applicant_id, cip_version, identity_snapshot, verification_methods, decision_chain, documents_verified, final_outcome, reason_codes, decided_by, decision_timestamp, retention_expires_at, is_immutable, record_hash) VALUES (NOW(), ?, '1.0', ?, ?, ?, ?, ?, ?, ?, NOW(), ?, 1, ?)"
      response_type = "single"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = [
        $input.applicant_id
        $identity_snapshot|json_encode
        $verification_methods|json_encode
        $decision_chain|json_encode
        $documents_verified|json_encode
        $input.final_outcome
        $input.reason_codes|json_encode
        $input.decided_by
        $retention_expires
        $record_hash
      ]
    }
  
    db.external.mysql.direct_query {
      sql = "SELECT * FROM cip_record WHERE id = LAST_INSERT_ID()"
      response_type = "single"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = []
    } as $cip
  
    db.external.mysql.direct_query {
      sql = "UPDATE decision SET is_final = 1 WHERE id = ?"
      response_type = "single"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = [$input.decision_id]
    }
  
    db.external.mysql.direct_query {
      sql = "UPDATE applicant SET status = ?, reviewed_by = ?, reviewed_at = NOW(), updated_at = NOW() WHERE id = ?"
      response_type = "single"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = [
        $input.final_outcome
        $input.decided_by
        $input.applicant_id
      ]
    }
  }

  response = $cip
  tags = ["cip-retention"]
}