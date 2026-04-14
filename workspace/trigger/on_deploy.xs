// Workspace trigger that runs when a branch goes live
// Triggered on branch events
workspace_trigger on_deploy {
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
    // Log deployment
    debug.log {
      value = "Branch " ~ ($input.from_branch.label|to_text) ~ " is now LIVE"
    }
  }

  history = 100
  actions = {branch_live: true}
}