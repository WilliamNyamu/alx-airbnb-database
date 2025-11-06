Perfect 👌 — this is the **performance profiling and optimization** stage of your database work.
Let’s create a complete example you can use to analyze query performance, implement improvements, and document your results.

Below, I’ll give you:

1. ✅ SQL script file (**`performance_monitoring.sql`**)
2. 📊 Example report section (with bottleneck analysis + improvements)

---

## 📁 `performance_monitoring.sql`

```sql
-- ============================================
-- FILE: performance_monitoring.sql
-- PURPOSE: Analyze query performance, identify bottlenecks,
--          and implement indexing improvements.
-- ============================================

-- 1️⃣ STEP 1: Enable Profiling (for query performance monitoring)
SET profiling = 1;

-- ============================================
-- 2️⃣ Run a sample query BEFORE optimization
-- ============================================

-- Example: Retrieve all bookings for a specific user
-- (a frequent query used in dashboards or reports)
SELECT 
    u.first_name,
    u.last_name,
    b.id AS booking_id,
    p.name AS property_name,
    b.total_price,
    b.status
FROM bookings AS b
INNER JOIN users AS u ON b.guest_id = u.user_id
INNER JOIN properties AS p ON b.property_id = p.property_id
WHERE u.user_id = 3;

-- ============================================
-- 3️⃣ Analyze query performance
-- ============================================

SHOW PROFILES;  -- Lists recent queries and their durations
SHOW PROFILE FOR QUERY 1;  -- Replace 1 with your query ID from SHOW PROFILES

-- Alternatively, in MySQL 8.0+, use:
EXPLAIN ANALYZE
SELECT 
    u.first_name,
    u.last_name,
    b.id AS booking_id,
    p.name AS property_name,
    b.total_price,
    b.status
FROM bookings AS b
INNER JOIN users AS u ON b.guest_id = u.user_id
INNER JOIN properties AS p ON b.property_id = p.property_id
WHERE u.user_id = 3;

-- ============================================
-- 4️⃣ Identify Bottlenecks
-- ============================================
-- - Full table scans on bookings, users, or properties
-- - Missing indexes on guest_id, property_id, or user_id
-- - JOINs not using indexed keys

-- ============================================
-- 5️⃣ Add New Indexes for Optimization
-- ============================================

-- Adding indexes to high-usage columns
CREATE INDEX idx_bookings_guest_id ON bookings(guest_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_properties_name ON properties(name);
CREATE INDEX idx_users_email ON users(email);

-- ============================================
-- 6️⃣ Run the same query AGAIN after optimization
-- ============================================

EXPLAIN ANALYZE
SELECT 
    u.first_name,
    u.last_name,
    b.id AS booking_id,
    p.name AS property_name,
    b.total_price,
    b.status
FROM bookings AS b
INNER JOIN users AS u ON b.guest_id = u.user_id
INNER JOIN properties AS p ON b.property_id = p.property_id
WHERE u.user_id = 3;

-- ============================================
-- 7️⃣ Compare before and after profiling
-- ============================================

-- Check runtime difference
SHOW PROFILES;

-- ============================================
-- 8️⃣ (Optional) Clean up profiling
SET profiling = 0;
```

---

## 📊 **Performance Report Summary**

### **Objective:**

Identify slow-running queries in the booking system and optimize them using profiling and indexing.

---

### **Query Profiled:**

```sql
SELECT 
    u.first_name, u.last_name, b.id, p.name, b.total_price, b.status
FROM bookings AS b
INNER JOIN users AS u ON b.guest_id = u.user_id
INNER JOIN properties AS p ON b.property_id = p.property_id
WHERE u.user_id = 3;
```

---

### **Before Optimization:**

| Metric             | Value                         |
| ------------------ | ----------------------------- |
| **Execution Time** | ~1.24 seconds                 |
| **Rows Examined**  | 250,000                       |
| **Execution Plan** | Full Table Scan on `bookings` |
| **Join Type**      | `ALL` (non-indexed)           |
| **Indexes Used**   | None                          |

---

### **Bottlenecks Identified:**

* No indexes on **bookings.guest_id** or **bookings.property_id**
* Frequent JOINs across large tables without optimization
* The **WHERE** clause filters by `user_id`, but `users.user_id` was not indexed properly for JOIN efficiency

---

### **Changes Implemented:**

```sql
CREATE INDEX idx_bookings_guest_id ON bookings(guest_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_properties_name ON properties(name);
CREATE INDEX idx_users_email ON users(email);
```

---

### **After Optimization:**

| Metric             | Value                                               |
| ------------------ | --------------------------------------------------- |
| **Execution Time** | ~0.18 seconds                                       |
| **Rows Examined**  | 3,200                                               |
| **Execution Plan** | Index Lookup (`ref`)                                |
| **Join Type**      | `ref` (index-based)                                 |
| **Indexes Used**   | `idx_bookings_guest_id`, `idx_bookings_property_id` |

---

### **Observed Improvements:**

✅ **~6x faster query execution**
✅ **Reduced I/O load** due to fewer scanned rows
✅ **JOINs now use indexes**, improving lookups
✅ **Better scalability** for future data growth

---

### **Recommendations:**

* Keep profiling heavy queries regularly using `EXPLAIN ANALYZE`
* Use **composite indexes** (e.g., `(guest_id, property_id)`) if multiple columns are always queried together
* Avoid `SELECT *` in production — select only necessary columns
* Rebuild indexes periodically for optimal performance

---

Would you like me to generate this as a **ready-to-download `performance_monitoring.sql`** file (including the detailed profiling report as comments inside)?
That way you can run it directly in MySQL Workbench or VS Code.
