// Reconcile a customer's metered usage for a period, apply plan tiers, push an invoice line to the billing provider, and log the reconciliation.
query "billing/reconcile_usage" verb=POST {
  api_group = "food"

  input {
    int customer_id
    text period_start
    text period_end
    enum currency {
      values = ["usd", "eur", "gbp"]
    }
  
    decimal credit_adjustment?
    bool dry_run?
  }

  stack {
    db.get "" {
      field_name = "id"
      field_value = $input.customer_id
    } as $customer
  
    precondition ($customer != null) {
      error_type = "notfound"
      error = "Customer not found"
    }
  
    db.query "" {
      where = $db.usage_event.customer_id == $input.customer_id && $db.usage_event.occurred_at >= $input.period_start && $db.usage_event.occurred_at <= $input.period_end
      sort = {occurred_at: "asc"}
      return = {type: "list"}
    } as $events
  
    var $metered {
      value = 0
    }
  
    var $tiered {
      value = 0
    }
  
    var $units {
      value = 0
    }
  
    foreach ($events) {
      each as $ev {
        var $line_cost {
          value = $ev.quantity * $ev.unit_rate
        }
      
        conditional {
          if ($ev.quantity > 1000) {
            math.add $tiered {
              value = $line_cost * 0.9
            }
          }
        
          else {
            math.add $metered {
              value = $line_cost
            }
          }
        }
      
        math.add $units {
          value = $ev.quantity
        }
      }
    }
  
    var $subtotal {
      value = $metered + $tiered
    }
  
    var $net {
      value = $subtotal + $input.credit_adjustment
    }
  
    var $invoice_payload {
      value = {
        customer_ref   : $customer.provider_ref
        currency       : $input.currency
        period         : {start: $input.period_start, end: $input.period_end}
        lines          : [
          {code: "METERED", amount: $metered, units: $units},
          {code: "TIERED", amount: $tiered},
          {code: "CREDIT", amount: $input.credit_adjustment}
        ]
        total          : $net
        idempotency_key: $input.customer_id ~ "-" ~ $input.period_end
      }
    }
  
    conditional {
      if ($input.dry_run == false) {
        api.request {
          url = "https://api.billing-provider.example/v1/invoices"
          method = "POST"
          params = $invoice_payload
          headers = [
            "Authorization: Bearer " ~ $env.BILLING_API_KEY
            "Content-Type: application/json"
          ]
        } as $provider_resp
      
        db.add "" {
          data = {
            customer_id        : $input.customer_id
            period_start       : $input.period_start
            period_end         : $input.period_end
            subtotal           : $subtotal
            net                : $net
            provider_invoice_id: $provider_resp.response.result.id
            status             : "posted"
          }
        } as $recon
      }
    
      else {
        db.add "" {
          data = {
            customer_id        : $input.customer_id
            period_start       : $input.period_start
            period_end         : $input.period_end
            subtotal           : $subtotal
            net                : $net
            provider_invoice_id: null
            status             : "dry_run"
          }
        } as $recon
      }
    }
  }

  response = {
    reconciliation_id: $recon.id
    net              : $net
    event_count      : $events|count
    dry_run          : $input.dry_run
  }

  tags = ["billing", "usage"]
}