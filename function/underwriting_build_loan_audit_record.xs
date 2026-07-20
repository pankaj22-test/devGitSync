// Build an immutable underwriting audit record from borrower data, all risk signals, and the final decision. Satisfies ECOA adverse-action, FCRA, and SEC 17a-4 7-year retention.
function "underwriting/build_loan_audit_record" {
  input {
    int borrower_id
    int decision_id
    enum final_outcome {
      values = ["approved", "denied"]
    }
  
    text[] adverse_action_codes
    int? underwritten_by
  }

  stack {
    db.external.mysql.direct_query {
      sql = "SELECT * FROM borrower WHERE id = ?"
      response_type = "single"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = [$input.borrower_id]
    } as $borrower
  
    precondition ($borrower != null) {
      error_type = "notfound"
      error = "Borrower not found"
    }
  
    db.external.mysql.direct_query {
      sql = "SELECT * FROM risk_signal WHERE borrower_id = ? ORDER BY waterfall_step ASC, created_at ASC"
      response_type = "list"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = [$input.borrower_id]
    } as $all_signals
  
    db.external.mysql.direct_query {
      sql = "SELECT * FROM decision WHERE borrower_id = ? ORDER BY created_at ASC"
      response_type = "list"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = [$input.borrower_id]
    } as $all_decisions
  
    db.external.mysql.direct_query {
      sql = "SELECT * FROM document_artifact WHERE borrower_id = ? AND status = 'verified'"
      response_type = "list"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = [$input.borrower_id]
    } as $verified_docs
  
    var $identity_snapshot {
      value = {
        first_name   : $borrower.first_name
        last_name    : $borrower.last_name
        ssn_encrypted: $borrower.ssn_encrypted
        date_of_birth: $borrower.date_of_birth
        address      : {
          line_1: $borrower.address_line_1,
          line_2: $borrower.address_line_2,
          city: $borrower.city,
          state: $borrower.state,
          zip: $borrower.zip,
          country: $borrower.country
        }
        email        : $borrower.email
        phone        : $borrower.phone
      }
    }
  
    var $risk_methods {
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
                adverse_action_codes: $$.adverse_action_codes,
                timestamp: $$.created_at,
                underwritten_by: $$.underwritten_by
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
        borrower_id         : $input.borrower_id
        identity            : $identity_snapshot
        methods             : $risk_methods
        decisions           : $decision_chain
        documents           : $documents_verified
        outcome             : $input.final_outcome
        adverse_action_codes: $input.adverse_action_codes
        timestamp           : now
      }
    }
  
    security.jws_encode {
      claims = $record_content
      key = $env.AUDIT_RECORD_SIGNING_KEY
      signature_algorithm = "HS256"
    } as $record_hash
  
    db.external.mysql.direct_query {
      sql = "INSERT INTO loan_audit_record (created_at, borrower_id, audit_version, identity_snapshot, risk_methods, decision_chain, documents_verified, final_outcome, adverse_action_codes, underwritten_by, decision_timestamp, retention_expires_at, is_immutable, record_hash) VALUES (NOW(), ?, '1.0', ?, ?, ?, ?, ?, ?, ?, NOW(), ?, 1, ?)"
      response_type = "single"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = [
        $input.borrower_id
        $identity_snapshot|json_encode
        $risk_methods|json_encode
        $decision_chain|json_encode
        $documents_verified|json_encode
        $input.final_outcome
        $input.adverse_action_codes|json_encode
        $input.underwritten_by
        $retention_expires
        $record_hash
      ]
    }
  
    db.external.mysql.direct_query {
      sql = "SELECT * FROM loan_audit_record WHERE id = LAST_INSERT_ID()"
      response_type = "single"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = []
    } as $audit
  
    db.external.mysql.direct_query {
      sql = "UPDATE decision SET is_final = 1 WHERE id = ?"
      response_type = "single"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = [$input.decision_id]
    }
  
    db.external.mysql.direct_query {
      sql = "UPDATE borrower SET status = ?, reviewed_by = ?, reviewed_at = NOW(), updated_at = NOW() WHERE id = ?"
      response_type = "single"
      connection_string = $env.MYSQL_CONNECTION_STRING
      arg = [
        $input.final_outcome
        $input.underwritten_by
        $input.borrower_id
      ]
    }
  }

  response = $audit
  tags = ["loan-audit-retention"]
}