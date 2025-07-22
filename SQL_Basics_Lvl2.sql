--Join
--combine 2 tables based on common column(identifier eg:dept_id)
--inner join - returns only matching records based on the values of identifier/column
--left join -- returns all rows from left table and only the matching rows from right table
--right join -- returns all rows from right table and only the matching rows from left table
--full join -- all records from both table

create table dept(
dept_id int not null primary key ,
dep_name varchar(50)
)
create table Staff(
id int not null primary key ,
name varchar(128),
dept_id int,
salary int
)
insert into dept values (101,'Computer Science')
insert into dept values (102,'Information Tech')
insert into dept values (103,'Artificial Intelli')
insert into dept values (104,'Data Engg')

Insert into staff values(501,'Matt', 101,85000);
Insert into staff values(601,'Kurt', 102,115000);
Insert into staff values(701,'Max',103,15000);
Insert into staff values(801,'Kunal',103,185000);
Insert into staff values(901,'Max',105,185000);
select * from staff
select * from dept
--Inner Join
select * from staff 
inner join dept
ON staff.dept_id = dept.dept_id

--left Join
select * from staff
left join dept
On staff.dept_Id = dept.dept_id

--right join 
select * from staff
right join dept
On staff.dept_Id = dept.dept_id

--Full Join
select * from staff
full join dept
On staff.dept_Id = dept.dept_id

--Union vs Union ALL 
-- combining 2 tables which has same schema or having some similar columns
--for diff schema it will not work
--union will remove dupilcate records of the primarykey / unionall shows all records

create table Staff_2024(
id int not null primary key ,
name varchar(128),
dept_id int,
salary int
)
create table Staff_2025(
id int not null primary key ,
name varchar(128),
dept_id int,
salary int
)


Insert into Staff_2024 values(501,'Matt', 101,85000);
Insert into Staff_2024 values(601,'Kurt', 102,115000);
Insert into Staff_2024 values(701,'Max',103,15000);

Insert into Staff_2025 values(701,'Max',103,15000);
Insert into Staff_2025 values(801,'Kunal',103,185000);
Insert into Staff_2025 values(901,'Max',105,185000);

select * from Staff_2024
select * from Staff_2025

--Union 
select * from Staff_2024 union select * from Staff_2025
select * from Staff_2024 union all select * from Staff_2025
--union of 2 tables having similar columns not schema 
select dept_id from Staff_2024 union select dept_id from dept

--Alter - to change the structure of table
select * from Staff_2025
--EXEC sp_help Staff_2025
alter table  staff_2025 add  location varchar(50)
alter table staff_2025 alter column location int
alter table staff_2025 drop column salary
