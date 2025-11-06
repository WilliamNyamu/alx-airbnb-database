-- Subquery to get all the properties whose average rating is greater than 4.0
SELECT p.name, AVG(r.rating) AS avg_rating
FROM properties AS p
INNER JOIN reviews AS r
ON p.property_id=r.property_id
GROUP BY p.name
HAVING avg_rating > 4.0;