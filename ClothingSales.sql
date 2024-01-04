Use practice;

CREATE TABLE ClothingSales (
Gender VARCHAR (5),
Age	INT,
Age_Group VARCHAR (10),
Month	VARCHAR(10),
Status	VARCHAR(25),
Channel 	VARCHAR(25),
Category	VARCHAR(25),
Size	VARCHAR(5),
Qty	INT,
currency VARCHAR(5),	
Amount	INT,
ship_city	VARCHAR(20),
ship_state	VARCHAR(20),
ship_country	VARCHAR(5),
B2B VARCHAR(10))
;


# How many unique genders, Age groups, Delivery channels, clothing categories, cloth sizes, currencies, shipping city, shipping states, shipping countries are in the dataset;

#Genders
Select Distinct Gender from ClothingSales; 

#Age Groups
Select distinct Age_Group from ClothingSales;

# Delivery status
Select distinct Status from ClothingSales;

# Categories
select distinct Category from ClothingSales;

# Sizes
select distinct size from ClothingSales;

# Currencies
select distinct currency from ClothingSales;

# Shipping Cities
select distinct ship_city from ClothingSales;

# Shipping state
select distinct ship_state from ClothingSales;

#shipping country
select distinct ship_country from ClothingSales;

# Some analysis of sales
1. Sales volume for each gender, Month, Age Group, Cloth Size, Cloth Category, Shipping state, shipping city, and shipping state;

# Sales for each gender
Select Gender, sum(Amount) as Total
From ClothingSales
Group BY Gender
Order By Total Desc;

# Sales for each month
Select Month, sum(Amount) as Total
From ClothingSales
Group BY Month
Order by Total Desc;

# Sales for each age group
Select Age_Group, sum(Amount) as Total
From ClothingSales
Group BY Age_Group
Order by Total Desc;

# Sales for each clothing sizes
Select Size, sum(Amount) as Total
From ClothingSales
Group BY Size
Order by Total Desc; 

# Sales to different cities
Select ship_city, sum(Amount) as Total
From ClothingSales
Group BY ship_city
Order by Total Desc;

# sales to different states
Select ship_state, sum(Amount) as Total
From ClothingSales
Group BY ship_state
Order by Total Desc;

# B2B vs NON-B2B sales
Select B2B, sum(Amount) as Total
From ClothingSales
Group BY B2B
Order by Total Desc;

# Lets check on the delivery status of the orders that were made
select distinct (Status), COUNT(Status) as Volume
FROM ClothingSales
Group by (Status)
order by Volume Desc;

# Lets subset all sales that were either retuned, cancelled, or refunded into a separate table('Clothing2') for a closer look

CREATE TABLE Clothing2 as (
SELECT * 
FROM ClothingSales
WHERE Status != 'Delivered');

# Cancellation rates for women and women
## First I'll create a table of all order by women and men (MWorders)

Create TABLE MWorders as 
	(SELECT Gender, COUNT(Status) as Count_Total
    FROM ClothingSales
    Group by Gender);


Create Table unsmen as (
Select Status, count(Status)
from Clothing2
WHERE GENDER = 'Men'
Group by Status);

Create Table unswm as (
Select Status, count(Status) as unsuccessful
from Clothing2
WHERE GENDER = 'Women'
Group by Status);


Create Table unsorders as (
Select Status, count(Status) as unsuccessful
from Clothing2
Group by Status);


select * from unsorders;

SELECT * FROM unswm;

SELECT * FROM unsmen;

CREATE TABLE unsgender as (
Select * from unsorders uo
LEFT JOIN unswm uw
ON uo.status = uw.status
RIGHT JOIN unsmen um
on uo.status = um.status); 

SELECT * FROM ClothingSales;

Create Table UnsAgeGroup as
		(SELECT Age_Group, Status
        FROM ClothingSales
        WHERE Status != 'Delivered'
        Order by Age_group);


Create Table Unschannel as (
	Select Channel, COUNT(Channel)
	From ClothingSales
    Where Status != 'Delivered'
	Group by Channel);
    
Create TABLE Unsmonth as (
	Select Month, COUNT(Month)
    From ClothingSales
    WHERE Status != 'Delivered'
    Group by Month);
    
Create Table Unscategory as (
	Select Category, COUNT(Category)
    From ClothingSales
    WHERE Status !='Delivered'
    Group by Category);
    
Create Table Unsstate as (
	Select ship_state, COUNT(ship_state)
    From ClothingSales
    WHERE Status !='Delivered'
    Group by ship_state);
