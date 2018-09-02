-- Questions: MIN, MAX, & AVERAGE

-- Use the SQL environment below to assist with answering the following questions. Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept.

-- 1. When was the earliest order ever placed? You only need to return the date.

    Select MIN(occurred_at)
    FROM orders

-- 2. Try performing the same query as in question 1 without using an aggregation function.

    SELECT occurred_at
    FROM orders
    LIMIT 1

-- 3. When did the most recent (latest) web_event occur?

    Select MAX(occurred_at)
    FROM web_events

-- 4. Try to perform the result of the previous query without using an aggregation function.
    
    SELECT occurred_at
    FROM web_events
    LIMIT 1
    ORDER BY occurred_at DESC
    

-- 5.Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.
    
    SELECT AVG(standard_qty), AVG(poster_qty), AVG(gloss_qty), AVG(standard_qty), AVG(poster_qty), AVG(gloss_qty)

-- 6. Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?
    


-- Quiz: GROUP BY
 /* GROUP BY Note
Now that you have been introduced to JOINs, GROUP BY, and aggregate functions, the real power of SQL starts to come to life. Try some of the below to put your skills to the test!*/

-- Questions: GROUP BY

-- Use the SQL environment below to assist with answering the following questions. Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept.

-- One part that can be difficult to recognize is when it might be easiest to use an aggregate or one of the other SQL functionalities. Try some of the below to see if you can differentiate to find the easiest solution.

-- 1.Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.

SELECT a.name as Account, o.occurred_at as OrderDate
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
ORDER BY o.occurred_at
LIMIT 1

-- 2.Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.

SELECT a.name AS Account, TO_CHAR(SUM(o.total_amt_usd), '$999G999G990D00') as Total
FROM accounts AS a
JOIN orders AS o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY SUM(o.total_amt_usd) DESC

-- 3.Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.

SELECT to_char(we.occurred_at, 'MM/DD/YYYY') AS event_date, we.channel AS channel, a.name as account
FROM web_events as we
JOIN accounts as a
ON we.account_id = a.id
ORDER BY we.occurred_at DESC
LIMIT 1

-- 4.Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.

SELECT we.channel as channel, COUNT(we.id) as countey
from web_events as we
GROUP BY we.channel
ORDER BY countey DESC

-- 5.Who was the primary contact associated with the earliest web_event?

SELECT to_char(we.occurred_at,'MM/DD/YYYY') AS eventdate, a.primary_poc as contact
FROM web_events as we
JOIN accounts as a
ON we.account_id = a.id
ORDER BY eventdate
LIMIT 1

-- 6. What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.

SELECT a.name as account, to_char(MIN(o.total_amt_usd),'$999G999G990D00') as minamount
FROM accounts as a
JOIN orders as o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY MIN(o.total_amt_usd)

-- 7. Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.

SELECT r.name as region, COUNT(sr.id) as numreps
FROM region as r
JOIN sales_reps as sr
ON r.id = sr.region_id
GROUP BY r.name
ORDER BY numreps desc


-- Questions: GROUP BY Part II

-- Use the SQL environment below to assist with answering the following questions. Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept.

-- 1. For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.

SELECT a.name, AVG(gloss_qty)::numeric::integer as gloss, AVG(poster_qty)::numeric::integer as poster, AVG(standard_qty)::numeric::integer as standard
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY a.name
ORDER BY a.name

-- 2. For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.

SELECT a.name, AVG(gloss_amt_usd)::float8::numeric::money as gloss, AVG(poster_amt_usd)::float8::numeric::money as poster, AVG(standard_amt_usd)::float8::numeric::money as standard
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id
GROUP BY a.name
ORDER BY a.name

-- 3. Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

SELECT sr.name as rep, we.channel as channel, COUNT(we.*) as numevents
FROM web_events as we
JOIN accounts as a
on a.id = we.account_id
JOIN sales_reps as sr
ON a.sales_rep_id = sr.id
GROUP BY sr.name, we.channel
ORDER BY sr.name, numevents DESC

-- 4. Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.

SELECT r.name as region , we.channel as channel, COUNT(we.*) as numevents
FROM region as r

JOIN sales_reps as sr
ON sr.region_id = r.id

JOIN accounts as a
ON sr.id = a.sales_rep_id

JOIN web_events as we
ON we.account_id = a.id

GROUP BY region, channel
ORDER BY numevents DESC


-- Questions: DISTINCT

-- Use the SQL environment below to assist with answering the following questions. Whether you get stuck or you just want to double check your solutions, my answers can be found at the top of the next concept.

-- 1. Use DISTINCT to test if there are any accounts associated with more than one region.
SELECT DISTINCT accounts.name as accountname, region.name as regionname
FROM accounts
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
JOIN region
ON sales_reps.region_id = region.id
ORDER BY accountname

-- 2. Have any sales reps worked on more than one account?