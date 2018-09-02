/*SELECT city, country --count(rental_id) as countRentals
FROM city
--ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country.id
--ORDER BY countRentals DESC;
*/

SELECT country, count(rental_id) as numRentals
FROM country
JOIN city
ON country.country_id = city.country_id
JOIN address
ON city.city_id = address.city_id
JOIN customer
ON address.address_id = customer.address_id
JOIN rental
ON customer.customer_id = rental.customer_id
GROUP BY country
ORDER BY numRentals DESC;
