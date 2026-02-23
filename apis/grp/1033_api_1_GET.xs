query "api/1" verb=GET {
  api_group = "grp"

  input {
  }

  stack {
    var $x1 {
      value = "{\n  \"name\": \"testnew\"\n}"
    }
  }

  response = $x1

  test Unit_test1 {
    expect.to_equal ($response) {
      value = "{\n  \"name\": \"testnew\"\n}"
    }
  }
}