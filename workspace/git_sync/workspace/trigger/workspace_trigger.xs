workspace_trigger workspace_trigger {
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
    var $x1 {
      value = 123
    }
  }

  actions = {branch_live: true, branch_merge: true, branch_new: true}
}