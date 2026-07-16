# Subskill: Soft Deletes & Auditing

Patterns for implementing soft deletes and basic audit trails in Xano tables.

## Soft Deletes

Instead of deleting rows, mark them with a `deleted_at` timestamp.

### 1. Schema Definition
Add a nullable timestamp to your table:
```xs
table my_table {
  schema {
    ...
    timestamp deleted_at?=null
  }
}
```

### 2. Query Pattern (Read)
Always filter out deleted rows in your `stack`:
```xs
db.query my_table {
  where = { deleted_at: null }
} as $results
```

### 3. Query Pattern (Delete)
Replace `db.delete` with `db.patch`:
```xs
db.patch my_table {
  id = $input.id
  data = { deleted_at: now }
}
```

## Basic Auditing

Track when and by whom a record was created or modified.

### 1. Schema Definition
```xs
table my_table {
  schema {
    ...
    int created_by?
    timestamp created_at?=now
    int updated_by?
    timestamp updated_at?=null
  }
}
```

### 2. Update Pattern
Ensure `updated_at` and `updated_by` are set on every write:
```xs
db.patch my_table {
  id = $input.id
  data = {
    ...
    updated_at: now
    updated_by: $auth.id
  }
}
```
