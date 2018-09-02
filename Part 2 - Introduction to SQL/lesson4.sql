/*More Subqueries Quizzes

Above is the ERD for the database again - it might come in handy as you tackle the quizzes below. You should write your solution as a subquery or subqueries, not by finding one solution and copying the output. The importance of this is that it allows your query to be dynamic in answering the question - even if the data changes, you still arrive at the right answer.*/

-- 1. Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.

SELECT qryMaxByRegion.regionname, qryMaxByRegion.maxsumamount, qrySumBySalesRep1.SalesRepName
    
FROM(SELECT r.name as RegionName, sr.Name SalesRepName, sum(o.total_amt_usd) as SalesRepSum
     FROM orders as o
     JOIN accounts as a
     ON o.account_id = a.id
     JOIN sales_reps as sr
     ON a.sales_rep_id = sr.id
     JOIN region as r
     On sr.region_id = r.id
     GROUP BY r.name, sr.name
     ) as qrySumBySalesRep1
    
JOIN(SELECT max(SalesRepSum) as maxsumamount, RegionName
    FROM (SELECT r.name as RegionName, sr.Name SalesRepName, sum(o.total_amt_usd) as SalesRepSum
            FROM orders as o
            JOIN accounts as a
            ON o.account_id = a.id
            JOIN sales_reps as sr
            ON a.sales_rep_id = sr.id
            JOIN region as r
            On sr.region_id = r.id
            GROUP BY r.name, sr.name) as qrySumBySalesRep2
     GROUP BY RegionName) as qryMaxByRegion

ON  qryMaxByRegion.RegionName = qrySumBySalesRep1.RegionName and 
    qryMaxByRegion.maxsumamount = qrySumBySalesRep1.SalesRepSum


-- 2. For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?

SELECT r.name as RegionName, COUNT(o.*)
FROM region as r
JOIN sales_reps as sr
ON sr.region_id = r.id
JOIN accounts as a
ON a.sales_rep_id = sr.id
JOIN orders as o
ON o.account_id = a.id
GROUP BY RegionName
HAVING sum(total_amt_usd) =(

Select Max(SumByRegion) as maxsum
    From
    (SELECT r.name as region, sum(total_amt_usd) as SumByRegion
    FROM region as r
    JOIN sales_reps as sr
    ON sr.region_id = r.id
    JOIN accounts as a
    ON a.sales_rep_id = sr.id
    JOIN orders as o
    ON o.account_id = a.id
    GROUP BY r.name) as qrySumByRegion )

-- 3. For the name of the account that purchased the most (in total over their lifetime as a customer) standard_qty paper, how many accounts still had more in total purchases?

SELECT  a.name as AccountName,
        (sum(standard_qty)+
         sum(gloss_qty)+
         sum(poster_qty)) as totalPurchased
FROM accounts as a
JOIN orders as o
ON o.account_id = a.id 
GROUP BY AccountName
HAVING (sum(standard_qty)+
         sum(gloss_qty)+
         sum(poster_qty)) >= (
    SELECT max(SumOfStandard) as MaxOfStandard
        FROM(
            SELECT a.name as Account,
                    sum(standard_qty) as sumofstandard
            FROM accounts as a
            JOIN orders as o
            ON o.account_id = a.id
            GROUP BY Account
            ) as qryMaxOfStandard)
ORDER BY totalpurchased

-- 4. For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?



-- qryAccountsSpending: all accounts with sum spending per account
WITH qryAccountsSpending as(
    SELECT a.name as Account, sum(o.total_amt_usd) as totalspend
            FROM accounts as a
            JOIN orders as o
            ON a.id = o.account_id
            GROUP BY Account
            ORDER BY totalspend DESC)

-- qryMaxSpendAllCustomers
WITH qryMaxSpendAllCustomers as (
    SELECT Max(totalSpend) as MaxOfTotalSpend
    FROM qryAccountsSpending)

-- Select 
SELECT Account
    FROM qryAccountsSpending as a
    JOIN orders as o
    ON a.id = o.account_id
    GROUP BY Account 
    HAVING sum(o.total_amt_usd) =  
    )
        
/*SELECT we.channel || ' ' || a.name as chan, count(we.*) as numevents
    FROM web_events as we
    JOIN accounts as a
    ON a.id = we.account_id
    WHERE a.name = aname.account
    GROUP BY chan
    ORDER BY numevents DESC*/

-- 5. What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?

    What is the lifetime average amount spent in terms of total_amt_usd for only the companies that spent more than the average of all orders.
