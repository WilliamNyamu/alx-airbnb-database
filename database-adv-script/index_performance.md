## 🧩 Step 1: Identify High-Usage Columns

Based on our past joins and queries, here are the **high-usage columns** in your schema:

| Table        | Column        | Reason for Index                                    |
| ------------ | ------------- | --------------------------------------------------- |
| `users`      | `user_id`     | Used in joins (`bookings.guest_id = users.user_id`) |
| `bookings`   | `property_id` | Used in joins and filters                           |
| `bookings`   | `guest_id`    | Used in joins with `users`                          |
| `properties` | `property_id` | Primary join column                                 |
| `properties` | `name`        | Sometimes used in search or display queries         |

---

## 🧱 Step 2: Create Index Commands (database_index.sql)

You can save the following SQL into a file named **`database_index.sql`**:

```sql
-- database_index.sql

-- Index for faster JOIN between bookings and users
CREATE INDEX idx_bookings_guest_id ON bookings (guest_id);

-- Index for faster JOIN and lookups between bookings and properties
CREATE INDEX idx_bookings_property_id ON bookings (property_id);

-- Index on users.user_id (if not already PRIMARY KEY)
CREATE INDEX idx_users_user_id ON users (user_id);

-- Index on properties.property_id (if not already PRIMARY KEY)
CREATE INDEX idx_properties_property_id ON properties (property_id);

-- Optional: If you frequently search or sort by property name
CREATE INDEX idx_properties_name ON properties (name);
```

💡 **Note:** If `user_id` and `property_id` are already **PRIMARY KEY**, they’re automatically indexed. You don’t need to re-index them.

---

## ⚙️ Step 3: Measure Query Performance

Before and after creating indexes, use **`EXPLAIN`** to analyze query performance.

Example:

```sql
EXPLAIN SELECT 
  u.first_name, u.last_name, b.property_id
FROM users AS u
INNER JOIN bookings AS b
  ON u.user_id = b.guest_id;
```

### Without Indexes:

You might see:

```
type: ALL
possible_keys: NULL
rows: 10000
Extra: Using where
```

This means MySQL scans **all rows** — not efficient.

### After Adding Indexes:

You should see:

```
type: ref
possible_keys: idx_bookings_guest_id
rows: 50
Extra: Using index
```

This means MySQL uses your index — the query is much faster 🚀.

---

## 🧠 Optional: Use `ANALYZE FORMAT=JSON`

You can also measure performance in more detail:

```sql
ANALYZE FORMAT=JSON
SELECT 
  u.first_name, b.property_id
FROM users AS u
INNER JOIN bookings AS b
  ON u.user_id = b.guest_id;
```

This shows the actual execution plan and how long it took.
