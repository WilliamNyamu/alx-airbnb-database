
USE alx_airbnb_database;

-- Performing an INNER JOIN on bookings table
SELECT * FROM users INNER JOIN bookings ON user_id=guest_id;

-- Performing a LEFT JOIN to retrieve all properties and their reviews even if a property 
-- does not yet have a review
SELECT p.name, r.rating 
FROM properties AS p 
LEFT JOIN reviews AS r 
ON p.property_id=r.property_id;

-- Performing a FULL OUTER JOIN to retrieve all users and their bookings 
-- even if a USER does not have a Booking, or a Booking does not have a USER
-- mysql does not allow the use of FULL OUTER JOIN like PostgreSQL. You have to use
-- UNION to combine a LEFT JOIN & RIGHT JOIN
SELECT u.first_name, u.last_name, b.check_in_date, b.guest_count, b.total_price
FROM bookings AS b
LEFT JOIN users AS u
ON b.guest_id=u.user_id

UNION

SELECT u.first_name, u.last_name, b.check_in_date, b.guest_count, b.total_price
FROM bookings AS b
RIGHT JOIN users AS u
ON b.guest_id=u.user_id;