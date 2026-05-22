query "API/1" verb=GET {
  api_group = "new"

  input {
    dblink {
      table = "dbtest1"
      override = {created_at: {hidden: true}}
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