// Logs branch events to the logs table
// Logs all branch lifecycle events for auditing
workspace_trigger branch_logger {
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
    // Add an entry to the logs table
    db.add logs {
      data = {
        type    : "branch"
        message : "Branch action: " ~ $input.action
        metadata: {
        to    : $input.to_branch
        from  : $input.from_branch
        action: $input.action
      }
      }
    }
  }

  actions = {branch_live: true, branch_merge: true, branch_new: true}
}