-- Subquery to get all the properties whose average rating is greater than 4.0
SELECT p.name, AVG(r.rating) AS avg_rating
FROM properties AS p
INNER JOIN reviews AS r
ON p.property_id=r.property_id
WHERE r.rating > 1
GROUP BY p.name
HAVING avg_rating > 4.0;

-- Correlated subquery to find users who have made more than 3 bookings
SELECT u.first_name, u.last_name, COUNT(*) AS No_of_bookings
FROM users AS u
INNER JOIN bookings AS b
ON u.user_id=b.guest_id
GROUP BY u.first_name, u.last_name
HAVING No_of_bookings > 3;