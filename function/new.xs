function new {
  input {
  }

  stack {
    db.query dbtest1 {
      return = {type: "list"}
    } as $dbtest11
  }

  response = $dbtest11
}