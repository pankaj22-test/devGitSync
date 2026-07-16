---
name: database-schema-designer
description: Design and evolve Xano database tables — field types, nullable vs optional, indexes, relationships, and safe migrations.
scope: workspace
mode: auto
knowledge_type: skill
enabled: true
guid: S6HbfGrSSqEyqBy6-dHpzDLTRg4
---

# Skill: Database Schema Designer

Design new tables and safely evolve existing ones in this workspace. Produces valid
`table` XanoScript (`.xs`) and avoids the migration traps that silently corrupt data.

## Trigger Phrases
- "Create a table for [X]"
- "Add a column / field to [table]"
- "Design the schema for [feature]"
- "Make [field] nullable / unique / indexed"
- "Set up a relationship between [A] and [B]"

## Workflow

### 1. Model the data
- One `table` per file under `/table/{name}.xs`.
- Choose precise types: `int`, `decimal`, `text`, `email`, `password`, `bool`,
  `timestamp`, `json`, `enum`, `uuid`.
- Add `auth = true` only on tables that back authentication (e.g. `user`).

### 2. Write the schema block
```
table food {
  schema {
    int id                              // primary key
    text name filters=trim              // pipe-chained filters
    enum type { values = ["fruit", "veg", "grain"] }
    int calories
    timestamp created_at?=now           // ?=optional/nullable, =now default
  }

  index = [
    {type: "primary",      field: [{name: "id"}]}
    {type: "btree",        field: [{name: "type"}]}
    {type: "btree|unique", field: [{name: "name"}]}
  ]
}
```

### 3. Nullable vs optional (they are NOT the same)
- **`text?`** → the *type* is nullable (column can hold SQL NULL).
- **`text name?`** → the *input* is optional (may be omitted), but the column is not nullable.
- Get both with `text name?` on a `text?` type; be explicit about what you need.

### 4. Indexes
- Valid `type` values ONLY: `primary`, `btree`, `gin`, `btree|unique`, `search`, `vector`.
- **Unique = `"btree|unique"`**, never `"unique"` (fails validation).
- Every table needs a `primary` index on its id.

### 5. Relationships
- Model a foreign key as an `int` column referencing the related table's `id`
  (e.g. `int user_id` on `run_log`).
- Add a `btree` index on the FK column for query performance.

### 6. Subskills & Patterns
- Consult reference files in the `references/` folder for specialized patterns.
- **Soft Deletes**: Use `deleted_at` timestamp instead of hard deletes.
- **Auditing**: Include `created_by`, `updated_at`, etc.
- See `references/newskillreference_inherits.md` for implementation details.

### 7. Migrate safely
- Validate the `.xs` with the XanoScript validator before pushing.
- Push, then **pull into a scratch dir and re-read** to confirm the change landed.
- Numeric inputs on endpoints default to `0` — for patch semantics use `int? x?=null`
  and build the update object conditionally (see quirks below).

## Known migration traps (workspace-specific)
- **Non-nullable → nullable ALTER does not drop NOT NULL (CS-1580).** Changing an existing
  column from `text` to `text?` updates metadata but the Postgres column stays `NOT NULL`,
  so a real null write fails with `SQLSTATE[23502]`. If you must make an existing column
  nullable, verify with a literal-null write after deploy; the CREATE path is fine, only
  the ALTER is broken.
- **int/decimal columns get `default:"0"`** regardless of nullable/optional, and an explicit
  `=null` is dropped on XanoScript round-trip. Don't rely on "omitted → null" for numbers.

## Success Criteria
- A valid `table` `.xs` file exists under `/table/`, validated and pushed.
- Indexes use the correct `btree|unique` form; primary key present.
- Nullable/optional intent is explicit and verified against the live column after migration.
- Relationships are modeled as indexed FK columns.
