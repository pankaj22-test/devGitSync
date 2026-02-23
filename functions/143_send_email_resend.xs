// Test Resend API integration with delivery time tracking and error handling
function send_email_resend {
  input {
    // Email recipient address
    text recipient filters=trim
  
    // Email subject line
    text subject filters=trim
  
    // Plain text email body
    text body
  
    // Optional HTML version of email body
    text body_html?
  
    // Sender email address
    text from_email?="noreply@bank.example.com" filters=trim
  
    // Sender display name
    text from_name?="Virtual Bank" filters=trim
  }

  stack {
    // Format sender address with name
    var $from_address {
      value = $input.from_name ~ " <" ~ $input.from_email ~ ">"
    }
  
    // Build base email parameters
    var $email_params {
      value = {
        from   : $from_address
        to     : [$input.recipient]
        subject: $input.subject
        text   : $input.body
      }
    }
  }

  response = $email_params
}