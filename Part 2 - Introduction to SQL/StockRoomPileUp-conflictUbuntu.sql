--How full does the stock room get each day?

WITH 
	qryReturnsByHour 
	AS(
	SELECT 
		date_trunc('hour', return_date) as returnHour,
		COUNT(rental_id) as countByHour,
		store_id as storeNum
	FROM rental
	JOIN customer
	ON rental.customer_id = customer.customer_id
	GROUP BY returnHour, storeNum
	ORDER BY returnHour
	),

	qryRunningSum 
	AS(
	SELECT 
		returnHour, 
		countByHour,
		storeNum,
		SUM(countByHour) OVER (PARTITION BY date_trunc('day', returnHour) ORDER BY returnHour) as SumByDay
	FROM qryReturnsByHour

)
SELECT 
	to_char(returnHour,'hh12 AM') as returnHourUnique,
	avg(SumByDay)::int as avgPerHour,
	storeNum
FROM qryRunningSum
GROUP BY returnHourUnique, storeNum
ORDER BY storeNum, returnHourUnique

