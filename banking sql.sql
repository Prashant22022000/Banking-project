--- SQL BANKING Project

--- Creating table
--- creating clients table


create table clients(
Client_ID varchar(10),
Name varchar(25),
Age int ,
Location_ID int,	
Joined_Bank date,
Banking_Contact varchar(25),
Nationality varchar(15),
Occupation varchar(40),
Fee_Structure varchar (5),
Loyalty_Classification varchar(8),
Estimated_Income float,
Superannuation_Savings float,
Amount_of_Credit_Cards int,
Credit_Card_Balance float,
Bank_Loans float	,
Bank_Deposits float,
Checking_Accounts float,
Saving_Accounts float 	,
Foreign_Currency_Account float,
Business_Lending float	,
Properties_Owned int	,
Risk_Weighting int	,
BRId int,
GenderId int,
IAId int
);

------ creating  gender table
 create table gender(
GenderId int	,
Gender varchar(10)
 )

 insert into gender(genderid,gender)
 values(1,'Male'),(2,'Female')

---- creating table investment advisior

create table investment_advisior(
	IAId int,	
	Investment_Advisor varchar(20)
)
------- adding primary key and forigen key--------
alter table gender
add primary key (genderid)
------------------------------------
alter table investment_advisior
add primary key (iaid)
------------------------------------
alter table clients
add foreign key (genderid) references gender(genderid),
add foreign key (iaid) references investment_advisior(iaid)

------data Exploration-------------------------------------------
select * from clients
select * from gender
select * from investment_advisior
---- data cleaning
----checking the null values in table
select *
from clients
where row (Client_ID,Name,Age,Location_ID,Joined_Bank,Banking_Contact,Nationality,
Occupation ,Fee_Structure,Loyalty_Classification,Estimated_Income,Superannuation_Savings,
Amount_of_Credit_Cards,Credit_Card_Balance,Bank_Loans,Bank_Deposits,Checking_Accounts,
Saving_Accounts,Foreign_Currency_Account,Business_Lending,Properties_Owned,Risk_Weighting,
BRId,GenderId,IAId) is null
----------------------------------------------------------------------------------------------------
select *
from investment_advisior
where row(IAId ,Investment_Advisor) is null
------------------------------------------------------------------------------------------------
---Finding business insights and KPI

-----Demographic Insights--------------------------------

----- gender wise total clients

select
g.gender,
count(*)
from clients as c
join gender as g
on c.genderid = g.genderid
group by 1

--------Age distribution:

 SELECT
  CASE
    WHEN Age BETWEEN 17 AND 25 THEN '17-25'
    WHEN Age BETWEEN 26 AND 35 THEN '26-35'
    WHEN Age BETWEEN 36 AND 45 THEN '36-45'
    WHEN Age BETWEEN 46 AND 55 THEN '46-55'
    WHEN Age BETWEEN 56 AND 65 THEN '56-65'
    WHEN Age >= 66 THEN '66+'
  END AS Age_Group,
  count(client_id)
FROM clients
group by 1
ORDER BY 1

--------Client count by nationality:

select
nationality,
count(client_id) as client_count
from clients
group by 1
order by 2 desc

---------- client count by Risk_weighting

with risk as (
select 
case
	when risk_weighting = 1 then 'Very_low'
	when risk_weighting = 2 then 'low'
	when risk_weighting = 3 then 'Medium'
	when risk_weighting = 4 then 'High'
	when risk_weighting = 5 then 'Very_high'
	end as risk_weighting,
	count(client_id)
from clients
group by 1)
select
*
from risk
order by 
	case 
	when risk_weighting = 'Very_low' then 1
	when risk_weighting = 'low' then 2
	when risk_weighting = 'Medium' then 3
	when risk_weighting = 'High' then 4
	when risk_weighting = 'Very_high' then 5
	end
;

--------- client count by loyalty_classification

select 
loyalty_classification ,
count(client_id)
from clients
group by 1

----- top 10 clients by Income of both gender
with ranks as (
select 
name,
gender,
estimated_income,
rank()over(partition by gender order by estimated_income asc )
from clients as c
join gender as g
on c.genderid = g.genderid
group by 1,2,3
)
select
rank,
name,
gender,
round(estimated_income)
from ranks
where rank <= 10

--------total clients total saving ,total deposits, total loan

select
count(client_id),
round(sum(estimated_income)) estimated_income,
round(sum(bank_loans))bank_loans,
round(sum(bank_deposits))bank_deposits,
round(sum(saving_accounts))saving_accounts
from clients

