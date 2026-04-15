// new test
realtime_channel new {
  public_messaging = {active: false}
  private_messaging = {active: false}
  settings = {
    anonymous_clients: true
    nested_channels  : false
    message_history  : 25
    auth_channel     : false
    presence         : true
  }
}