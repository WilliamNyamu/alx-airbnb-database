
````markdown
# 🧩 Understanding SQL JOINS — INNER, LEFT & FULL OUTER JOIN

This guide explains how different types of SQL JOINs work using a simple example involving **bookings** and **users** tables in a MySQL database.

---

## 📘 1. INNER JOIN

### 🔹 Description
`INNER JOIN` returns only the rows where there’s a **matching record** in both tables.

### 🧠 Example
```sql
SELECT *
FROM bookings AS b
INNER JOIN users AS u
ON b.guest_id = u.user_id;
````

### 📊 Result

* Includes only bookings **linked to existing users**.
* Excludes:

  * bookings without a registered user
  * users who haven’t made any booking

| booking_id | guest_id | user_id | first_name |
| ---------- | -------- | ------- | ---------- |
| 1          | 2        | 2       | Mary       |
| 2          | 3        | 3       | Kevin      |

---

## 📘 2. LEFT JOIN

### 🔹 Description

`LEFT JOIN` returns **all records from the left table** (`bookings`), and the matching ones from the right table (`users`).
If there’s no match, the right-side columns return `NULL`.

### 🧠 Example

```sql
SELECT *
FROM bookings AS b
LEFT JOIN users AS u
ON b.guest_id = u.user_id;
```

### 📊 Result

* Keeps **all bookings** (even if the user doesn’t exist)
* Fills unmatched `users` fields with `NULL`

| booking_id | guest_id | user_id | first_name |
| ---------- | -------- | ------- | ---------- |
| 1          | 2        | 2       | Mary       |
| 2          | 3        | 3       | Kevin      |
| 4          | 9        | NULL    | NULL       |

---

## 📘 3. FULL OUTER JOIN

### 🔹 Description

`FULL OUTER JOIN` combines the results of both a `LEFT JOIN` and a `RIGHT JOIN`.
It returns **all records from both tables**, matching them where possible and filling missing fields with `NULL`.

> ⚠️ Note: MySQL doesn’t support `FULL OUTER JOIN` directly.

### ✅ MySQL-Compatible Alternative

Use a combination of `LEFT JOIN` and `RIGHT JOIN` with `UNION`:

```sql
SELECT *
FROM bookings AS b
LEFT JOIN users AS u
ON b.guest_id = u.user_id

UNION

SELECT *
FROM bookings AS b
RIGHT JOIN users AS u
ON b.guest_id = u.user_id;
```

### 📊 Result

* Includes:

  * bookings with matching users
  * bookings without users
  * users without bookings

| booking_id | guest_id | user_id | first_name |
| ---------- | -------- | ------- | ---------- |
| 1          | 2        | 2       | Mary       |
| 2          | 3        | 3       | Kevin      |
| 3          | NULL     | 5       | David      |
| 4          | 9        | NULL    | NULL       |

---

## 🪄 Summary Table

| JOIN Type       | Returns Matching | Returns Left Non-Matching | Returns Right Non-Matching |
| --------------- | ---------------- | ------------------------- | -------------------------- |
| INNER JOIN      | ✅                | ❌                         | ❌                          |
| LEFT JOIN       | ✅                | ✅                         | ❌                          |
| FULL OUTER JOIN | ✅                | ✅                         | ✅                          |

---

## 🧠 Quick Tip

When writing joins, always connect **related keys**:

```sql
ON bookings.guest_id = users.user_id
```

Avoid using same-name fields blindly (`property_id = property_id`) — instead, specify which table each belongs to.

### Subquery
- Wrote a subquery to retrieve all the properties whose average rating is greater than 4.0
```sql
SELECT p.name, AVG(r.rating) AS avg_rating
FROM properties AS p
INNER JOIN reviews AS r
ON p.property_id=r.property_id
GROUP BY p.name
HAVING avg_rating > 4.0;
```
- I'm proud of myself 

### Applying window functions
✅ Final Query
SELECT
  p.name AS property_name,
  COUNT(b.id) AS total_bookings,
  RANK() OVER (ORDER BY COUNT(b.id) DESC) AS property_rank
FROM properties AS p
LEFT JOIN bookings AS b
  ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY property_rank;

💡 How It Works
Clause	What it does
LEFT JOIN	Ensures even properties with zero bookings are included.
COUNT(b.id)	Counts how many bookings each property has.
RANK() OVER (ORDER BY COUNT(b.id) DESC)	Assigns a rank — properties with the same number of bookings get the same rank.
GROUP BY	Groups results by each unique property.
ORDER BY property_rank	Displays in rank order.

---

### 🧾 Author

**Billy Liam** — Redemptive Technologist & Data Learner
Exploring SQL joins to build smarter, relational databases.


