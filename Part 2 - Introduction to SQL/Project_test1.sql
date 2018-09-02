SELECT DISTINCT film.film_id, sum(amount) as totalfilmsales
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
			film.film_id;