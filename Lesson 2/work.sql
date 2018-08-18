/*Quiz: Join Questions Part 1*/


/*1.Provide a table for all web_events associated with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to add a fourth column to assure only Walmart events were chosen. */

SELECT accounts.primary_poc, web_events.occurred_at, web_events.channel
FROM web_events
JOIN accounts
ON web_events.accounts_id = account.id
WHERE accounts.name = 'Walmart'



/*2. Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/

SELECT  region.name reg, sales_reps.name repers, accounts.name county
FROM region
JOIN sales_reps
ON sales_reps.region_id = region.id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
ORDER BY accounts.name


/*3. Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. Your final table should have 3 columns: region name, account name, and unit price. A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.*/

SELECT region.name as reggie, accounts.name as countie, (orders.total_amt_usd/(total+.00001)) as unit_price
FROM region
JOIN sales_reps
ON sales_reps.region_id = region.id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
JOIN orders
ON accounts.id = orders.account_id

/*Quiz: last check*/

/*1.Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/
 
SELECT r.name region_name, a.name account_name, s.name rep_name
FROM region r
JOIN sales_reps s
ON s.id = r.sales_rep_id
JOIN accounts a
ON s.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name

/*2. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a first name starting with S and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/
 
SELECT a.name Account, r.name Region, SR.name ReppiePoo
FROM sales_reps SR
JOIN accounts a
ON SR.id = a.sales_rep_id
JOIN region r
ON r.id = SR.region_id
WHERE r.name = 'Midwest' and SR.name like 'S%'
ORDER by a.name


/*3. Provide a table that provides the region for each sales_rep along with their associated accounts. This time only for accounts where the sales rep has a last name starting with K and in the Midwest region. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/

SELECT r.name as Region, SR.name as RepName, a.name as Account
FROM sales_rep as SR
JOIN accounts a
ON SR.id = a.sales_rep_id
JOIN region r
ON r.id = SR.region_id
WHERE r.name = 'Midwest' and SR.name like '% K%'
ORDER BY a.name

/*4.Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100. Your final table should have 3 columns: region name, account name, and unit price. In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).*/

SELECT r.name as Region, a.name as Account, o.total_amt_usd/(o.total+0.01) as unit_price
from orders AS o
LEFT JOIN accounts as a
ON o.account_id = a.id
JOIN sales_reps as SR
ON SR.id = sales_rep_id
JOIN region as r
ON r.id = SR.region_id
WHERE o.standard_qty >100

/*5.Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the smallest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).*/

SELECT r.name as Region, a.name as Account, o.total_amt_usd/(o.total+0.01) as unit_price
from orders AS o
LEFT JOIN accounts as a
ON o.account_id = a.id
JOIN sales_reps as SR
ON SR.id = sales_rep_id
JOIN region as r
ON r.id = SR.region_id
WHERE o.standard_qty >100 and o.poster_qty > 50
ORDER BY unit_price

/*6.Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).*/

SELECT r.name as Region, a.name as Account, o.total_amt_usd/(o.total+0.01) as unit_price
from orders AS o
LEFT JOIN accounts as a
ON o.account_id = a.id
JOIN sales_reps as SR
ON SR.id = sales_rep_id
JOIN region as r
ON r.id = SR.region_id
WHERE o.standard_qty >100 and o.poster_qty > 50
ORDER BY unit_price DESC

/*7.What are the different channels used by account id 1001? Your final table should have only 2 columns: account name and the different channels. You can try SELECT DISTINCT to narrow down the results to only the unique values.*/

SELECT DISTINCT we.account_id as Account, we.channel as Channel
FROM web_events AS we
WHERE we.account_id = 1001

/*Find all the orders that occurred in 2015. Your final table should have 4 columns: occurred_at, account name, order total, and order total_amt_usd.*/

SELECT a.name as Account, o.total as Total, o.total_amt_usd as Amount, o.occurred_at as TimeOrderPlaced
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
WHERE o.occurred_at between '2015-01-01' and '2016-01-01'