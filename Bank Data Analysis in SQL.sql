create database mybank;

use mybank;

-- RETRIEVE ALL TABLE DATA

select * from customers;

select * from accounts;

select * from transactions;

select * from loans;

select * from creditcards;

select * from branches;

select * from ATMs;

-- CALCULATE TOTAL NUMBER OF CUSTOMERS
select count(*) totalcustomers from customers;

-- CALCULATE TOTAL NUMBER OF ACCOUNTS  
select count(*) as totalaccounts from accounts;

-- CALCULATE TOTAL LOAN AMOUNT  
select sum(amount) as totalloansamount from loans;

-- CALCULATE TOTAL CREDIT LIMIT ACROSS ALL CREDIT CARDS  
select sum(creditlimit) as totalcreditlimit from creditcards;

-- FIND ALL ACTIVE ACCOUNTS  
select * from accounts where status = 'active';

-- FIND ALL ACCOUNTS MADE ON 15TH JAN 2023  
select * from transactions where transactiondate > '2023-01-15';

-- FIND LOANS WITH INTEREST RATES ABOVE 5.0  
select * from loans where interestrate > 5.0;

-- FIND CREDIT CARDS WITH BALANCES EXCEEDING THE CREDIT LIMIT  
select * from creditcards where balance > creditlimit;

-- RETRIEVE CUSTOMER DETAILS ALONG WITH THEIR ACCOUNTS  
select c.customerid, c.name, c.age, a.accountnumber, a.accounttype, a.balance  
from customers c  
join accounts a on c.customerid = a.customerid;

-- RETRIEVE TRANSACTION DETAILS ALONG WITH ASSOCIATED ACCOUNT AND CUSTOMER INFORMATION  
select t.transactionid, t.transactiondate, t.amount, t.type, t.description,  
a.accountnumber, a.accounttype, c.name as customername  
from transactions t  
join accounts a on t.accountnumber = a.accountnumber  
join customers c on a.customerid = c.customerid;


-- TOP 10 CUSTOMERS WITH HIGHEST LOAN AMOUNT  
select c.name, l.amount as loanamount  
from customers c  
join loans l on c.customerid = l.customerid  
order by l.amount desc  
limit 10;

-- DELETE INACTIVE ACCOUNTS  
set sql_safe_updates = 0;  
delete from accounts  
where status = 'inactive';

-- FIND CUSTOMERS WITH MULTIPLE ACCOUNTS  
select c.customerid, c.name, count(a.accountnumber) as numaccounts  
from customers c  
join accounts a on c.customerid = a.customerid  
group by c.customerid, c.name  
having count(a.accountnumber) > 1;


-- PRINT THE FIRST 3 CHARACTERS OF NAME FROM CUSTOMERS TABLE  
select substring(name, 1, 3) as firstthreecharactersofname  
from customers;

-- PRINT THE NAME FROM CUSTOMERS TABLE INTO TWO COLUMNS FIRSTNAME AND LASTNAME  
select  
    substring_index(name, ' ', 1) as firstname,  
    substring_index(name, ' ', -1) as lastname  
from customers;

-- SQL QUERY TO SHOW ONLY ODD ROWS FROM CUSTOMERS TABLE  
select * from customers  
where mod(customerid, 2) <> 0;

-- SQL QUERY TO DETERMINE THE 5TH HIGHEST LOAN AMOUNT WITHOUT USING LIMIT KEYWORD  
select distinct amount  
from loans l1  
where 5 = (  
    select count(distinct amount)  
    from loans l2  
    where l2.amount >= l1.amount  
);

-- SQL QUERY TO SHOW THE SECOND HIGHEST LOAN FROM THE LOANS TABLE USING SUB-QUERY  
select max(amount) as secondhighestloan  
from loans  
where amount < (  
    select max(amount)  
    from loans  
);

-- SQL QUERY TO LIST CUSTOMERID WHOSE ACCOUNT IS INACTIVE  
select customerid  
from accounts  
where status = 'inactive';  

-- SQL QUERY TO FETCH THE FIRST ROW OF THE CUSTOMERS TABLE  
select *  
from customers  
limit 1;  

-- SQL QUERY TO SHOW THE CURRENT DATE AND TIME  
select now() as currentdatetime;

 
 -- SQL QUERY TO CREATE A NEW TABLE WHICH CONSISTS OF DATA AND STRUCTURE COPIED FROM THE CUATOMERS
 create table customersclone like customers;
 insert into customersclone select * from customers;
 
 -- QUERY TO CALCULATE HOW MANY DAYS ARE REMAINING FOR CUSTOMERS TO PAY OFF THE LOANS
 select customerid,
 datediff(enddate,curdate())as daysremaining
 from loans
 where enddate>curdate();
 
 use mybank;
 
 -- QUERY TO FIND THE LATEST TRANSACTION DATE FOR EACH ACCOUNT
 select accountnumber,max(transactiondate)as latesttransactiondate 
 from transactions
 group by accountnumber;
 
 -- FIND THE AVERAGE AGE OF CUSTOMERS
 select avg(age)as averageage
 from customers;
 
 -- FIND ACCOUNTS WITH LESS THAN MINIMUM AMOUNT FOR ACCOUNTS OPENED BEFORE 1ST JAN 2022
 select accountnumber,balance
 from accounts
 where balance<25000
 and opendate<='2022-01-01';
 
 -- FIND LOANS THAT ARE CURRENTLY ACTIVE
 select * from loans where enddate>=curdate()
 and status ='active';
 
 -- FIND THE TOTAL AMOUNT OF TRANSACTION FOR EACH ACCOUNT FOR A SPECIFIC MONTH
 select accountnumber,sum(amount)as totalamount
 from transactions
 where month(transactiondate)=6
 and year(transactiondate)=2023
 group by accountnumber;
 
 -- FIND THE AVERAGE CREDIT CARD BALANCE FOR EACH CUSTOMER
 select customerid,avg(balance)as averagecreditbalance
 from creditcards
 group by customerid;
 
 -- FIND THE INACTIVE ATMS PER LOCATION WISE
 select location,count(*)as numberofactiveATMs
 from ATMs
 where status='out of service'
 group by location;
 
 -- CATEGORIZE CUSTOMERS INTO THEREE AGR GROUPS
 select
 name,
 age,
 case
 when age<30 then 'below 30'
 when age between 30 and 60 then '30 to 60'
 else 'above 60'
 end as age_group
 from customers;
 
 select distinct amount
 from loans l1
 where 5=(
 select count(distinct amount)
 from loans l2
 where l2.amount>=l1.amount
 );
 
 -- SELECT QUERY TO SHOW THE SECOND HIGHTEST LOAN FROM THE LOANS TABLE USING SUB QUERY
 
 select max(amount)as secondhighestloan
 from loans
 where amount<(
 select max(amount)
 from loans
 );
 
