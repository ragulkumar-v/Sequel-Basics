--shortcut key press CTRL+K, then next need to press CTRL+U to uncomment
--shortcut key press CTRL+K, then next need to press CTRL+C to comment

--Sql Basics 
--Create DB
create database EMPLOYEE;
create database order_new;

--Switch to other DB
use EMPLOYEE

--delete Database
--drop database order_new;

--Create table
create table EMP(
ID int,
NAME varchar(30),
SALARY int,
ADDRESS varchar(100)
);


create table employee(
id int,
name varchar(30),
address varchar(100),
salary int,
bonus float
)

--Insert values
Insert into employee values(1,'ragul', 'miami', 6000, 2.5000);
Insert into employee values(2,'mathan', 'Tampa', 10000, 25.50000);
insert into employee (id,name,bonus) values(3,'abi',40.5)
insert into employee (id,address) values(4,'NJ')
--INSERT OR REPLACE, REPLACE INTO and INSERT OR IGNORE.
--Select tables 
select * from employee

--constraints:
--NOT NULL, UNIQUE
create table contact(
id int,
email varchar(128) not null,
phone_number int unique
)
select * from contact

insert into contact values (1,'abc@gmail.com', 1234);
--//error for inserting a null// insert into contact (id,phone_number) values (2, 2234);
--//error for inserting a duplicate//insert into contact values (2,'def@gmail.com',1234);
insert into contact values (2,'def@gmail.com',12345);

--check and default
create table address (
id int,
age int check(age>18),
country varchar(30) default 'India'
)

select * from address

insert into address values(1,20,'united states');
--//error for inserting  >18//insert into address values(2,10,'united states');
--//default india for inserting a null//
insert into address (id, age) values(2,21);

--Primary key - cant have a null value, but a unique key can
create table contact1(
id int primary key,
email varchar(128) unique,
phone int
)
select * from contact1
insert into contact1 values (1,'abc',123);
--//error for inserting a duplicate key//insert into contact1 values (1,'def',1234);
--//error for inserting a null value//insert into contact1 values (NULL,'def',1234);
insert into contact1 values (2,Null,1234);

--foreign key referencing a table by their primary key of releated table
create table department (
dept_id int primary key,
dep_name varchar(50)
)

create table student(
id int primary key,
name varchar(128),
dept_id int foreign key(dept_id) references department(dept_id)
)

select * from student

--filtering and sort

create table EMPL(
id int,
name varchar(128),
location varchar(128),
dept varchar(30),
salary int
)
Insert into EMPL values(1,'ragul', 'miami', 'CSE',25000);
Insert into EMPL values(2,'rag', 'tampa', 'IT',35000);
Insert into EMPL values(3,'ragu', 'fort', 'AI',55000);
Insert into EMPL values(4,'ragulV', 'kendal', 'DE',65000);
Insert into EMPL values(5,'Matt', 'fort', 'AI',85000);
Insert into EMPL values(6,'Kurt', 'texas', 'DE',115000);
Insert into EMPL values(7,'Max', 'Newyork', 'AI',15000);
Insert into EMPL values(8,'Kunal', 'California', 'DE',185000);

select * from EMPL where salary >50000
select * from EMPL where location = Null
select * from EMPL order by salary desc

--Delete vs Drop vs Truncate 
select * from EMPL
--delete from EMPL where id=4
--truncate table EMPL
--Drop table EMPL

--update in sql
select * from EMPL
update EMPL set dept = 'Data Eng' where id >=5;

--COnditional statements AND,OR/IN, NOT, <,>, =,!=
update EMPL set dept = 'SDE' where id >=3 and id < 5
select * from EMPL where location = 'fort' or dept = 'SDE'
select * from EMPL where id in(2,5,6)
select * from EMPL where id not in (1,4)
select * from EMPL where dept != 'SDE'


--Aggregate functions 
--to find max,min,sum,count,avg salary of emp,GROUP_CONCAT(name)
select max(salary) as maximum,
min(salary) as minimum,
sum(salary) as total,
count(*) as Total_records,
avg(salary) as Average_sal
from EMPL

--Groupby
select * from EMPL
--to find no of emp in each loc
select count(id) as count, location from EMPL group by location
--max sal in each loc
select max(salary) as max,location from EMPL group by location
--low sal in each loc
select min(salary),location from EMPL group by location
--tot sal in each dept
select sum(salary) as Total, dept from EMPL group by dept

--Like '..%', '%...', '%...%'
select * from EMPL where location like 'f%'

--having
---diff b/w where and having 
-- both clause used for filtering rows based on cloumns
--having is a alternate key used along with aggregate functions to filter, 
--where can't be used with aggregate
--a WHERE statement in a GROUP BY will only group the fields that match the criteria:
--A HAVING statement will filter the resulting grouped data set using the result of the aggregation:
select * from EMPL where location='fort'
select sum(salary) as total,dept from EMPL group by dept having sum(salary) > 10000
select sum(salary) as total,location from EMPL group by location having sum(salary) > 100000 

--Top/Limit in sql
--first 3 records
select top 3 * from empl 
--50%
select top 50 percent * from empl
--top 2 high salary
select top 2 * from empl order by salary desc
--top 2  salary recrds from DE dept
select top 2 * from empl where dept ='DE' order by salary desc

--Unique records(distinct)

Select distinct name from empl

--COALESCE in sql - used to deal with Null
select * from employee
--replace name with null as unknown
select id, COALESCE(name,'Unknown') from employee
--salary + bonus
select salary * coalesce(bonus,1) from employee