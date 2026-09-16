 drop table if exists coffee_sales;
 CREATE TABLE coffee_sales (
   
    hour_of_day     SMALLINT,
    cash_type       VARCHAR(10),
    money           NUMERIC(10,2),
    coffee_name     VARCHAR(50),
    time_of_day     VARCHAR(15),
    weekday         VARCHAR(15),
    month_name      VARCHAR(15),
    sale_date       DATE,
    sale_time       TIME
);

select * from coffee_sales;


-- deleting the table(first procedure)
drop table coffee_sales;


--- Baseline metrics
SELECT
    COUNT(*)                       AS total_transactions,
    ROUND(SUM(money), 2)           AS total_revenue,
    ROUND(AVG(money), 2)           AS avg_transaction_value,S
    ROUND(MIN(money), 2)           AS min_transaction,
    ROUND(MAX(money), 2)           AS max_transaction
FROM coffee_sales;


--- Best selling coffee type by revenue and volume
SELECT
    coffee_name,
    COUNT(*)                       AS units_sold,
    ROUND(SUM(money), 2)           AS total_revenue,
    ROUND(AVG(money), 2)           AS avg_price
FROM coffee_sales
GROUP BY coffee_name
ORDER BY total_revenue DESC;


--- monthly trend
select month_name, 
count(*) as transactions, 
sum(money) as revenue
from coffee_sales 
group by month_name
order by min(sale_date) asc;



--weekly sales pattern
select weekday,
count(*) as transactions,
round(sum(money),2) as revenue
from coffee_sales
group by weekday
order by min(sale_date) asc;



---sales distibution time of the day 
SELECT
    time_of_day,
    COUNT(*)                                   AS transactions,
    ROUND(SUM(money), 2)                       AS total_revenue,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_all_transactions
FROM coffee_sales
GROUP BY time_of_day
ORDER BY total_revenue DESC;


---peak hour analysis
SELECT
    hour_of_day,
    COUNT(*)                       AS transactions,
    ROUND(SUM(money), 2)           AS total_revenue
FROM coffee_sales
GROUP BY hour_of_day
ORDER BY transactions desc;


-- Overall split
SELECT
    cash_type,
    COUNT(*)                       AS transactions,
    ROUND(SUM(money), 2)           AS total_revenue,
    ROUND(AVG(money), 2)           AS avg_transaction_value
FROM coffee_sales
GROUP BY cash_type;


-- Payment method preference by coffee type
SELECT
    coffee_name,
    cash_type,
    COUNT(*) AS transactions
FROM coffee_sales
GROUP BY coffee_name, cash_type
ORDER BY coffee_name, transactions DESC;