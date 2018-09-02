/*Self JOINs

One of the most common use cases for self JOINs is in cases where two events occurred, one after another. As you may have noticed in the previous video, using inequalities in conjunction with self JOINs is common.

Modify the query from the previous video, which is pre-populated in the SQL Explorer below, to perform the same interval analysis except for the web_events table. Also:

    * change the interval to 1 day to find web events that occur within one after another within one day
    * add a column for the channel variable in both instances of the table in your query

You can find more on the types of INTERVALS (and other date related functionality) in the Postgres documentation here.*/


SELECT we1.id AS we1_id,
       we1.account_id AS we1_account_id,
       we1.occurred_at AS we1_occurred_at,
       we1.channel AS we1_channel
       we2.id AS we2_id,
       we2.account_id AS we2_account_id,
       we2.occurred_at AS we2_occurred_at
       we2.channel AS we2_channel
  FROM web_events we1
 LEFT JOIN web_events we2
   ON we1.account_id = we2.account_id
  AND we2.occurred_at > we1.occurred_at
  AND we2.occurred_at <= we1.occurred_at + INTERVAL '1 day'
ORDER BY we1.account_id, we1.occurred_at