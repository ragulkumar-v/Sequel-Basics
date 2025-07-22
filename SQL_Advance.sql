
--Window Function:
-- OVER CLAUSE AND PARTITION BY 

-- OVER 
--The OVER clause in SQL is used with window functions (like SUM, COUNT, ROW_NUMBER, etc.) 
--to perform calculations across a specific set of rows related to the current row.

--The OVER clause allows for partitioning and ordering rows
--without collapsing them into a single result like aggregate


--In SQL, window functions perform calculations across a specified range of rows 
--that are related to the current row, without collapsing 
--them into a single row as aggregate functions do. 

--TABLE
CREATE TABLE sales (
    sales_id INT,
    salesperson VARCHAR(50),
    region VARCHAR(50),
    amount DECIMAL(10, 2)
);

INSERT INTO sales (sales_id, salesperson, region, amount) VALUES 
(1, 'Alice', 'North', 500),
(2, 'Bob', 'South', 300),
(3, 'Alice', 'North', 200),
(4, 'Charlie', 'South', 700),
(5, 'Bob', 'South', 400),
(6, 'Alice', 'North', 800);


select * from sales;
select sum(amount) as Total,region from sales group by region;
select *,sum(amount) over(partition by region) from sales;

--This allows for advanced analytical queries, such as ranking, running totals, moving averages, and more.

--Types of Window Functions
-- Aggregate Functions: SUM(), AVG(), MIN(), MAX(), COUNT()
-- Ranking Functions: ROW_NUMBER(), RANK(), DENSE_RANK(), NTILE()
-- Value Functions: LEAD(), LAG(), FIRST_VALUE(), LAST_VALUE()

--Aggregate fucntion:
select *,min(amount)  over(partition by region) as min_amount from sales
select *,max(amount)  over(partition by region) as max_amount from sales
select *,avg(amount)  over(partition by region) as avg_amount from sales

select *,min(amount)  over(partition by region) as min_amount,
max(amount)  over(partition by region) as max_amount,
avg(amount)  over(partition by region) as avg_amount
from sales 

--Ranking function
-- ROW_NUMBER(): unique sequential row number per row
-- RANK(): ties share a rank; sequence skips after ties
-- DENSE_RANK(): ties share a rank; no skips in sequence
CREATE TABLE emp_sal (
    employee_id INT primary key,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO emp_sal (employee_id, name, department, salary) VALUES 
(1, 'Alice', 'Sales', 5000),
(2, 'Bob', 'Sales', 3000),
(3, 'Charlie', 'Sales', 3000),
(4, 'David', 'Sales', 3000),
(5, 'Eve', 'Sales', 2000),
(6, 'ice', 'Sales', 4000),
(7, 'Buck', 'Sales', 4000),
(8, 'lee', 'Sales', 4000),
(9, 'Dutch', 'Sales', 4000),
(10, 'Elai', 'Sales', 1000);

select * from emp_sal

select *, ROW_NUMBER()
over(order by salary desc) as Row_num
from emp_sal

select *, DENSE_RANK()
over(order by salary desc) as dens_rank
from emp_sal

select *,RANK()
over(order by salary desc) as Rnk
from emp_sal

--In sql, The alias is the “table name” for your subquery’s output. 
--Without it, SQL has no identifier for that rowset and will fail to parse your query.
select *  from (select *, rank()
over (order by salary desc) as rnk
from emp_sal)  AS ranked_salaries
where rnk =2

--Lead and lag
CREATE TABLE emp_sal1 (
    transaction_id INT,
    salesperson VARCHAR(50),
    transaction_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO emp_sal1 (transaction_id, salesperson, transaction_date, amount) VALUES 
(1, 'ice', '2025-01-01', 500.00),
(2, 'Buck', '2025-01-03', 300.00),
(3, 'lieev', '2025-01-05', 450.00),
(4, 'Bob', '2025-01-02', 200.00),
(5, 'Bond', '2025-01-06', 700.00),
(6, 'cornel', '2025-01-08', 300.00);

select *,lag(amount,1,0)
over(order by transaction_date) as prev_amt
from emp_sal1
select *,lag(amount,2,0)
over(order by transaction_date) as prev_amt
from emp_sal1

select *,lead(amount,1,0)
over(order by transaction_date) next_amt
from emp_sal1
select *,lead(amount,4,0)
over(order by transaction_date) next_amt
from emp_sal1

--CTE
----A Common Table Expression (CTE) in SQL is a temporary result set that you can
--reference within a SELECT, INSERT, UPDATE, or DELETE statement.

--CTEs are often used to simplify complex queries,
--make queries more readable, and allow for recursive queries.

--CTEs are powerful for organizing SQL code, 
--especially in multi-step analyses or when calculating intermediate results.

--Reusable Logic: Once defined, you can refer to a CTE multiple times within the main query.

--WITH CTE AS(
--SELECT * FROM EMPLOYEES
--)
--SELECT * FROM CTE

select * from emp_sal
--to find 3rd highest sal

with sal_ord as(
select *,DENSE_RANK() over(order by salary desc) as sal_rnk from emp_sal )
select * from sal_ord where sal_rnk =3

