function repro_datasource {
  input {
  }

  stack {
    var $env_before {
      value = $env.$datasource
    }
  
    db.set_datasource {
      value = "test"
    }
  
    var $env_after {
      value = $env.$datasource
    }
  }

  response = {
    env_datasource_before: $env_before
    env_datasource_after : $env_after
    bug_present          : $env_before == $env_after
  }
}