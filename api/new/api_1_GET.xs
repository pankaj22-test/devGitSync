query "API/1" verb=GET {
  api_group = "new"

  input {
    dblink {
      table = ""
      override = {
        name             : {hidden: false}
        user             : {hidden: false}
        image            : {hidden: false}
        servings         : {hidden: true}
        created_at       : {hidden: true}
        description      : {hidden: false}
        instructions     : {hidden: false}
        cook_time_minutes: {hidden: true}
        prep_time_minutes: {hidden: false}
      }
    }
  }

  stack {
    var $x1 {
      value = $input.text
    }
  }

  response = $x1

  test Nest_unit {
    input = {text: []|push:"new", txx: "ns"}
  
    expect.to_equal ($response) {
      value = '["new"]'|json_decode
    }
  }
}