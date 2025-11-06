-- total number of bookings made by each user
SELECT u.first_name, u.last_name, COUNT(*) AS No_of_bookings
FROM users AS u
INNER JOIN bookings AS b
ON u.user_id=b.guest_id
GROUP BY u.first_name, u.last_name;

-- rank properties based on the total number of bookings they have received.
SELECT
  p.name AS property_name,
  COUNT(b.id) AS total_bookings,

  -- Assigns the same rank to properties with equal booking counts
  RANK() OVER (ORDER BY COUNT(b.id) DESC) AS property_rank,

  -- Always gives a unique sequential number regardless of ties
  ROW_NUMBER() OVER (ORDER BY COUNT(b.id) DESC) AS property_row_number

FROM properties AS p
LEFT JOIN bookings AS b
  ON p.property_id = b.property_id

GROUP BY p.property_id, p.name
ORDER BY property_rank;

