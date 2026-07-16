---
name: xanoscript-reference
description: Reference for writing valid XanoScript (.xs) and syncing it with the Xano CLI — object syntax, the rules the parser actually enforces, and confirmed server quirks.
scope: workspace
mode: auto
knowledge_type: doc
enabled: true
guid: h6gJ5MWyjdD69FuWEwCx239FVCM
---

# Doc: XanoScript & CLI Reference

Reference material the workspace skills lean on. Grounded in real pushes against
stage/dev instances — trust this over the published docs page when they conflict.
Always run the XanoScript validator before pushing.
 trust this over the published docs page when they conflict.
Always run the XanoScript validator before pushings.


## Object syntax at a glance

**table** — one per file under `/table/`:
```
table user {
  auth = true
  schema {
    int id
    text name filters=trim
    email email filters=trim|lower
    password password
    timestamp created_at?=now
  }
  index = [
    {type: "primary",      field: [{name: "id"}]}
    {type: "btree|unique", field: [{name: "email"}]}
  ]
}
```

**query** (API endpoint) — `/api/<group>/<name>_<VERB>.xs`:
```
query add verb=POST {
  api_group = "counter"          // BARE identifier, not the slashed path form
  input { text note? }
  stack {
    db.add run_log { data = {note: $input.note, created_at: now} } as $row
    db.query run_log { return = {type: "count"} } as $total
  }
  response = {id: $row.id, total_rows: $total}
}
```

**function** with inline test, **middleware**, and **workflow_test** follow the same
`{ input / stack / response }` shape. workflow_test uses `api.call` to hit endpoints and
`expect.*` assertions.

## Rules the parser actually enforces

1. **`api_group` = bare identifier** on new endpoints (`"counter"`, not `"group/1"`).
   The slashed form fails fresh imports with *"Missing valid API Group"*.
2. **Unique index = `"btree|unique"`**, never `"unique"`. Valid types: `primary`, `btree`,
   `gin`, `btree|unique`, `search`, `vector`.
3. **`response = $x`** — a single assignment; there is no `response { value = $x }` block.
4. **Bulk db ops use `items=[...]`**, not `data=`. `bulk.update`/`bulk.patch` need a per-row
   `id`; only `bulk.delete` takes `where=`. `db.patch`/`db.add_or_edit` reject `output=[...]`.
5. **`?` placement matters:** `text?` = nullable type; `text name?` = optional input. Different.
6. **workflow_test: `datasource` must be the first token** in the block (a comment before it
   breaks the parser). Order: `datasource`, `stack`, `tags`.

## Confirmed server quirks

- **int/decimal inputs default to `0`** regardless of nullable/optional; explicit `=null` is
  dropped on XanoScript round-trip. For patch semantics use `int? x?=null` AND build the
  update object conditionally (`if ($input.x != null) { ... }`).
- **CS-1580 — non-nullable → nullable ALTER doesn't drop NOT NULL.** Changing `text` → `text?`
  updates metadata but leaves the Postgres column `NOT NULL`; a literal null write fails with
  `SQLSTATE[23502]`. The CREATE path is fine; only the ALTER is broken. Verify with a real
  null write after deploy.
- **workflow_test persistence depends on datasource:** `"live"` clones each run (writes
  discarded); a custom datasource (e.g. `"staging"`) persists (ids climb across runs).
- **async/await/`run.job`** are documented (2.3.0) but rejected on 2.2.0 instances — write
  synchronous until the instance is upgraded. Check version skew before using new features.

## CLI sync loop

```
1. edit      <object>.xs
2. validate  (XanoScript validator on the file content)
3. push      xano workspace push -i "<path>"     # partial by default
4. verify    xano workspace pull -d /tmp/verify   # then re-read the pulled file
```

- **Partial API-group pushes can delete sibling endpoints** — after any group push, pull and
  `find api/ -type f` to confirm nothing vanished; keep the full group folder to re-push and
  restore (GUIDs are preserved).
- **`WARNING ... table "X" does not exist`** on partial pushes is usually a false positive —
  verify by pulling rather than reordering pushes.
- **Changing what's "selected"** is a profile action, not `workspace edit`:
  `xano profile edit -w <id>` (default workspace), `-b <label>` (default branch),
  `xano profile set <name>` (switch profile), or add `-w`/`-b` per command.
