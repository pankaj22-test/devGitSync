workspace_trigger trigger {
  input {
    object to_branch {
      schema {
        int id
        text label
      }
    }
  
    object from_branch {
      schema {
        int id
        text label
      }
    }
  
    enum action {
      values = ["branch_live", "branch_merge", "branch_new"]
    }
  }

  stack {
    db.add db1 {
      data = {created_at: "now", text: $env.triggertest}
    } as $db11
  }

  actions = {branch_merge: true}
}