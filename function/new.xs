function new {
  input {
  }

  stack {
    db.query dbtest1 {
      return = {type: "list"}
      addon = [{name: "category", as: "_category"}]
    } as $dbtest11
  }

  response = $dbtest11
}