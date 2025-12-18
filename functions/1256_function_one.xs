function functionOne {
  input {
  }

  stack {
    db.query xanoLinkUUID {
      return = {type: "list"}
    } as $xanoLinkUUID1
  }

  response = $xanoLinkUUID1
}