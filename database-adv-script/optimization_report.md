## 🧾 Step 1: Initial Query (Unoptimized)

Let’s assume your schema looks roughly like this:

* **users** → `user_id`, `first_name`, `last_name`, `email`
* **properties** → `property_id`, `name`, `location`
* **bookings** → `booking_id`, `guest_id`, `property_id`, `check_in_date`, `check_out_date`
* **payments** → `payment_id`, `booking_id`, `amount`, `status`

We can write an **initial query** to retrieve **all bookings** along with related user, property, and payment details:

```sql
-- performance.sql

-- 1️⃣ Initial Query (Unoptimized)
SELECT 
    b.booking_id,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location,
    pay.amount,
    pay.status,
    b.check_in_date,
    b.check_out_date
FROM bookings AS b
INNER JOIN users AS u ON b.guest_id = u.user_id
INNER JOIN properties AS p ON b.property_id = p.property_id
LEFT JOIN payments AS pay ON b.booking_id = pay.booking_id;
```

This gives you complete booking info including:

* user details
* property details
* and payment info (if any)

---

## 🔍 Step 2: Analyze Query Performance

Before optimizing, use:

```sql
EXPLAIN
SELECT 
    b.booking_id,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location,
    pay.amount,
    pay.status,
    b.check_in_date,
    b.check_out_date
FROM bookings AS b
INNER JOIN users AS u ON b.guest_id = u.user_id
INNER JOIN properties AS p ON b.property_id = p.property_id
LEFT JOIN payments AS pay ON b.booking_id = pay.booking_id;
```

You’ll get output like this:

| id | select_type | table | type | possible_keys | key  | rows  | Extra       |
| -- | ----------- | ----- | ---- | ------------- | ---- | ----- | ----------- |
| 1  | SIMPLE      | b     | ALL  | NULL          | NULL | 10000 |             |
| 1  | SIMPLE      | u     | ALL  | NULL          | NULL | 5000  | Using where |
| 1  | SIMPLE      | p     | ALL  | NULL          | NULL | 2000  | Using where |
| 1  | SIMPLE      | pay   | ALL  | NULL          | NULL | 3000  | Using where |

This indicates **no indexes are being used** — MySQL is scanning entire tables.

---

## ⚙️ Step 3: Optimization Plan

### ✅ Add Indexes

In your **`database_index.sql`**, make sure you have these:

```sql
CREATE INDEX idx_bookings_guest_id ON bookings (guest_id);
CREATE INDEX idx_bookings_property_id ON bookings (property_id);
CREATE INDEX idx_payments_booking_id ON payments (booking_id);
CREATE INDEX idx_users_user_id ON users (user_id);
CREATE INDEX idx_properties_property_id ON properties (property_id);
```

---

## 🚀 Step 4: Refactored Query (Optimized)

Now rewrite the same query, but structured efficiently to leverage the indexes:

```sql
-- 2️⃣ Optimized Query (Using Indexes)

SELECT 
    b.booking_id,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    pay.amount,
    pay.status
FROM bookings AS b
JOIN users AS u ON b.guest_id = u.user_id
JOIN properties AS p ON b.property_id = p.property_id
LEFT JOIN payments AS pay ON pay.booking_id = b.booking_id;
```

### Improvements:

* Removed unnecessary columns (`location`, etc.) if not needed.
* Joins now use indexed fields.
* Reduced column fetch to minimize I/O.

---

## 🔬 Step 5: Re-Analyze Performance

Run:

```sql
EXPLAIN SELECT ... (optimized query)
```

Expected improvement:

* You’ll see **“type: ref”** or **“type: eq_ref”** for most joins instead of **“ALL”**.
* The **rows** scanned per table drop drastically.
* **Extra** column may show “Using index,” which means MySQL fetched data directly via indexes.

---

## ✅ Final performance.sql File

Here’s the complete file content you can save as **`performance.sql`**:

```sql
-- performance.sql
-- Purpose: Analyze and optimize booking retrieval query performance

-- Step 1: Initial Query (Unoptimized)
SELECT 
    b.booking_id,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location,
    pay.amount,
    pay.status,
    b.check_in_date,
    b.check_out_date
FROM bookings AS b
INNER JOIN users AS u ON b.guest_id = u.user_id
INNER JOIN properties AS p ON b.property_id = p.property_id
LEFT JOIN payments AS pay ON b.booking_id = pay.booking_id;

-- Step 2: Analyze Performance
EXPLAIN
SELECT 
    b.booking_id,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    p.location,
    pay.amount,
    pay.status,
    b.check_in_date,
    b.check_out_date
FROM bookings AS b
INNER JOIN users AS u ON b.guest_id = u.user_id
INNER JOIN properties AS p ON b.property_id = p.property_id
LEFT JOIN payments AS pay ON b.booking_id = pay.booking_id;

-- Step 3: Optimized Query (with Index Usage)
SELECT 
    b.booking_id,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    pay.amount,
    pay.status
FROM bookings AS b
JOIN users AS u ON b.guest_id = u.user_id
JOIN properties AS p ON b.property_id = p.property_id
LEFT JOIN payments AS pay ON pay.booking_id = b.booking_id;

-- Step 4: Verify Optimization
EXPLAIN
SELECT 
    b.booking_id,
    u.first_name,
    u.last_name,
    u.email,
    p.name AS property_name,
    pay.amount,
    pay.status
FROM bookings AS b
JOIN users AS u ON b.guest_id = u.user_id
JOIN properties AS p ON b.property_id = p.property_id
LEFT JOIN payments AS pay ON pay.booking_id = b.booking_id;
```