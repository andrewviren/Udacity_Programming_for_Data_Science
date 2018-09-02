/*
-- How many rentals per day

SELECT 
	date_trunc('day', rental_date) as rentalDateGroup,
	COUNT(*) as numRentals
FROM 
	rental r
GROUP BY 
	rentalDateGroup
ORDER BY 
	numRentals	DESC
*/

/*
	-- What happened on February 14, 2006?

		SELECT 
			f.title
		FROM 
			film as f
		JOIN 
			inventory i
		ON 
			f.film_id=i.film_id
		JOIN rental r on
			i.inventory_id = r.inventory_id
		WHERE 
			date_trunc('day',rental_date) = '2006-02-14')

		SELECT
			COUNT(*)
		FROM
			qryValentinesDayRentals
*/

/*
-- What was our highest grossing day?

	SELECT 
		-- extract(dow from rental_date) as rental_dow,
		CASE 
			WHEN extract(hour from rental_date) between 18 and 24 THEN 'evening'
			WHEN extract(hour from rental_date) between 12 and 18 THEN 'afternoon'
			WHEN extract(hour from rental_date) between 6 and 12 THEN 'morning'
			WHEN extract(hour from rental_date) between 0 and 6 THEN 'drunk people'
		END 

		c.name as categoryName,
		sum(p.amount) as totalAmount
	FROM 
		rental r
	JOIN 
		payment p
	ON
		p.rental_id = r.rental_id
	JOIN
		inventory as i
	ON
		r.inventory_id = i.inventory_id
	JOIN
		film f
	ON
		i.film_id = f.film_id
	JOIN
		film_category fc
	ON
		f.film_id = fc.film_id
	JOIN 
		category c
	ON
		c.category_id = fc.category_id
	WHERE
		extract(hour from rental_date) between 0 and 6
	GROUP BY 
		categoryName
		--rental_dow
	ORDER BY 
		totalAmount DESC;


-- Which staff person sold more?


SELECT s.first_name as staffname, sum(amount)
FROM staff s
JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY staffname;


 
-- Do specific features affect rentals?
 
SELECT 
	count(rental_id),
	CASE 
		WHEN 'Trailers' = ANY(special_features) THEN 'Trailers'
		WHEN 'Commentaries' = ANY(special_features) THEN 'Commentaries'
		WHEN 'Deleted Scenes' = ANY(special_features) THEN 'Deleted Scenes'
		WHEN 'Behind the Scenes' = ANY(special_features) THEN 'Behind the Scenes'
	END as SpecialFeature
FROM 
	film
JOIN 
	inventory
ON
	inventory.film_id = film.film_id
JOIN
	rental
ON 
	rental.inventory_id = inventory.inventory_id
GROUP BY SpecialFeature
 
--What are the distinct special_features
--SELECT DISTINCT(special_features)
--FROM film;
--Trailers
--Commentaries
--Deleted Scenes
--Behind the Scenes*/

WITH 
	qryTotalRentalsTrailers as 
		(SELECT film.film_id, sum(amount) as totalfilmsales
		FROM 
			film
		JOIN 
			inventory
		ON
			inventory.film_id = film.film_id
		JOIN
			rental
		ON 
			rental.inventory_id = inventory.inventory_id
		JOIN 
			payment
		ON
			rental.rental_id = payment.rental_id
		WHERE
			'Trailers' = ANY(special_features) = True
		GROUP BY
			film.film_id),

	qryTotalRentalsCommentaries as 
		(SELECT film.film_id, sum(amount) as totalfilmsales
		FROM 
			film
		JOIN 
			inventory
		ON
			inventory.film_id = film.film_id
		JOIN
			rental
		ON 
			rental.inventory_id = inventory.inventory_id
		JOIN 
			payment
		ON
			rental.rental_id = payment.rental_id
		WHERE
			'Commentaries' = ANY(special_features) = True
		GROUP BY
			film.film_id),

	qryTotalRentalsDeletedScenes as 
		(SELECT film.film_id, sum(amount) as totalfilmsales
		FROM 
			film
		JOIN 
			inventory
		ON
			inventory.film_id = film.film_id
		JOIN
			rental
		ON 
			rental.inventory_id = inventory.inventory_id
		JOIN 
			payment
		ON
			rental.rental_id = payment.rental_id
		WHERE
			'Deleted Scenes' = ANY(special_features) = True
		GROUP BY
			film.film_id),	

	qryTotalRentalsBehindScenes as 
		(SELECT film.film_id, sum(amount) as totalfilmsales
		FROM 
			film
		JOIN 
			inventory
		ON
			inventory.film_id = film.film_id
		JOIN
			rental
		ON 
			rental.inventory_id = inventory.inventory_id
		JOIN 
			payment
		ON
			rental.rental_id = payment.rental_id
		WHERE
			'Behind the Scenes' = ANY(special_features) = True
		GROUP BY
			film.film_id)


SELECT 
	sum(qryTotalRentalsTrailers.totalfilmsales) as sumtrailerfilms,
	sum(qryTotalRentalsCommentaries.totalfilmsales) as sumcommentaryfilms,
	sum(qryTotalRentalsDeletedScenes.totalfilmsales) as sumdelectedScenesfilms,
	sum(qryTotalRentalsBehindScenes.totalfilmsales) as sumbehindtheScenesfilms
FROM
	film
LEFT JOIN
	qryTotalRentalsTrailers
ON
	film.film_id = qryTotalRentalsTrailers.film_id
LEFT JOIN
	qryTotalRentalsCommentaries
ON
	film.film_id = qryTotalRentalsCommentaries.film_id
LEFT JOIN
	qryTotalRentalsDeletedScenes
ON
	film.film_id = qryTotalRentalsDeletedScenes.film_id
LEFT JOIN
	qryTotalRentalsBehindScenes
ON
	film.film_id = qryTotalRentalsBehindScenes.film_id