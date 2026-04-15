workflow_test Work1 {
  stack {
    api.call products verb=GET {
      api_group = "Store"
      input = {discount_percent: 0}
    } as $endpoint1
  }
}