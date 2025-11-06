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
WHERE pay.amount > 1 AND b.booking_id > 0
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
