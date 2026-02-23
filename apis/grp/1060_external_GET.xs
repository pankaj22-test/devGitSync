query external verb=GET {
  api_group = "grp"

  input {
  }

  stack {
    api.request {
      url = "https://webhook.site/fbc4355e-f4b6-4c4f-a8e4-5f95c7ee666c"
      method = "GET"
    } as $api1
  }

  response = $api1
}