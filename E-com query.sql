create table e_com.Supplier(
SUPP_ID INT NOT NULL auto_increment,
SUPP_NAME VARCHAR(50),
SUPP_CITY VARCHAR(50),
SUPP_PHONE BIGINT,
primary key (SUPP_ID)
) ;

create table e_com.Customer(
CUS_ID int NOT NULL auto_increment,
CUS_NAME varchar(50),
CUS_PHONE bigint,
CUS_CITY varchar(50),
CUS_GENDER char,
primary key (CUS_ID)
) ;

create table e_com.Category(
CAT_ID int NOT NULL auto_increment,
CAT_NAME varchar(50),
primary key (CAT_ID)
) ;

create table e_com.Product(
PRO_ID int NOT NULL auto_increment,
PRO_NAME varchar(50),
PRO_DESC varchar(50),
CAT_ID int,
primary key (PRO_ID),
FOREIGN KEY (CAT_ID)
        REFERENCES Category(CAT_ID)
);

create table e_com.Product_Details(
PROD_ID int NOT NULL auto_increment,
PRO_ID int,
SUPP_ID int,
PRICE int,
primary key (PROD_ID),
FOREIGN KEY (PRO_ID)
        REFERENCES Product(PRO_ID)
);  

create table e_com.Prod_Order(
ORD_ID int NOT NULL,
ORD_AMOUNT int,
ORD_DATE date,
CUS_ID int,
PROD_ID int,
primary key (ORD_ID),
FOREIGN KEY (PROD_ID)
        REFERENCES Product_Details(PROD_ID)
);

create table e_com.Rating(
RAT_ID int NOT NULL auto_increment,
CUS_ID int,
SUPP_ID int,
RAT_RATSTARS int,
primary key (RAT_ID),
FOREIGN KEY (CUS_ID)
        REFERENCES Customer(CUS_ID),
        FOREIGN KEY (SUPP_ID)
        REFERENCES Supplier(SUPP_ID)
);  

Insert into e_com.Supplier values(1,"Rajesh Retails","Delhi",1234567890 );
Insert into e_com.Supplier values(2,"Appario Ltd.","Mumbai",2589631470);
Insert into e_com.Supplier values(3,"Knome products","Bangalore",9785462315);
Insert into e_com.Supplier values(4,"Bansal Retails","Kochi",8975463285);
Insert into e_com.Supplier values(5,"Mittal Ltd.","Lucknow",7898456532);

Insert into e_com.Customer values(1,"AAKASH",9999999999 ,"DELHI",'M');
Insert into e_com.Customer values(2,"AMAN",9785463215,"NOIDA",'M');
Insert into e_com.Customer values(3,"NEHA",9999999999,"MUMBAI",'F');
Insert into e_com.Customer values(4,"MEGHA",9994562399,"KOLKATA",'F');
Insert into e_com.Customer values(5,"PULKIT",7895999999 ,"LUCKNOW",'M');

Insert into e_com.Category values(1,"BOOKS");
Insert into e_com.Category values(2,"GAMES");
Insert into e_com.Category values(3,"GROCERIES");
Insert into e_com.Category values(4,"ELECTRONICS");
Insert into e_com.Category values(5,"CLOTHES");

Insert into e_com.Product values(1,"GTA V","DFJDJFDJFDJFDJFJF",2);
Insert into e_com.Product values(2,"TSHIRT","DFDFJDFJDKFD",5);
Insert into e_com.Product values(3,"ROG LAPTOP","DFNTTNTNTERND",4);
Insert into e_com.Product values(4,"OATS","REURENTBTOTH",3);
Insert into e_com.Product values(5,"HARRY POTTER","NBEMCTHTJTH",1);

Insert into e_com.Product_Details values(1,1,2,1500);
Insert into e_com.Product_Details values(2,3,5,30000);
Insert into e_com.Product_Details values(3,5,1,3000);
Insert into e_com.Product_Details values(4,2,3,2500);
Insert into e_com.Product_Details values(5,4,1,1000);

Insert into e_com.Prod_Order values(20,1500,'2021-10-12',3,5);
Insert into e_com.Prod_Order values(25,30500,'2021-09-16',5,2);
Insert into e_com.Prod_Order values(26,2000,'2021-10-05',1,1);
Insert into e_com.Prod_Order values(30,3500,'2021-08-16',4,3);
Insert into e_com.Prod_Order values(50,2000,'2021-10-06',2,1);

insert into e_com.Rating values(1,2,2,4);
insert into e_com.Rating values(2,3,4,3);
insert into e_com.Rating values(3,5,1,5);
insert into e_com.Rating values(4,1,3,2);
insert into e_com.Rating values(5,4,5,4);

/*3)	Display the number of the customer group by their genders who have placed any order of amount greater than or equal to Rs.3000. */
select count(c.CUS_GENDER) as Gender, 
					c.CUS_GENDER
from e_com.Customer c, e_com.Prod_Order o
where o.CUS_ID=c.CUS_ID 
	and o.ORD_AMOUNT>=3000
	group by CUS_GENDER;

/*4)	Display all the orders along with the product name ordered by a customer having Customer_Id=2. */
select O.ORD_ID as Order_ID, 
		  P.PRO_ID as Product_ID,
          P.PRO_NAME as Product_name,
          P.PRO_DESC as Product_Description,
          PD.PRICE as Price,
          O.CUS_ID as Customer_ID
from e_com.Product P, 
		e_com.Product_Details PD,
        e_com.Prod_order O
where O.PROD_ID=PD.PROD_ID 
	and PD.PRO_ID=P.PRO_ID
	and O.CUS_ID=2;


/*5)	Display the Supplier details who can supply more than one product. */

select count(PD.SUPP_ID) as supplier_count,
		  S.SUPP_ID as Supplier_ID,
		  S.SUPP_NAME as name,
          S.SUPP_CITY as City,
          S.SUPP_PHONE as phone
from e_com.Product_Details PD
join e_com.supplier S on PD.SUPP_ID=S.SUPP_ID
group by PD.SUPP_ID
having count(PD.SUPP_ID)>1;

 /*OR*/
 
select count(PD.SUPP_ID) as supplier_count,
		  S.SUPP_ID as Supplier_ID,
		  S.SUPP_NAME as name,
          S.SUPP_CITY as City,
          S.SUPP_PHONE as phone
from e_com.Product_Details PD, e_com.supplier S
where S.SUPP_ID=PD.SUPP_ID
group by PD.SUPP_ID
having count(PD.SUPP_ID)>1;

/*6)	Find the category of the product whose order amount is minimum. */
select *
from e_com.Prod_Order O
join e_com.Product_Details PD on O.PROD_ID=PD.PROD_ID
join e_com.Product P on P.PRO_ID=PD.PRO_ID
join e_com.Category C on C.CAT_ID=P.CAT_ID
having min(O.ORD_AMOUNT);
    
		  
/*7)	Display the Id and Name of the Product ordered after “2021-10-05”. */
select O.ORD_ID,
		  P.PRO_ID,
		  P.PRO_NAME
from e_com.Prod_Order O
join e_com.Product_Details PD
	on O.PROD_ID=PD.PROD_ID
join e_com.Product P
	on PD.PRO_ID=P.PRO_ID
where ORD_DATE>'21-10-05';

/*8)	Print the top 3 supplier name and id and their rating on the basis of their rating along with the customer name who has given the rating. */
select S.SUPP_ID,
S.SUPP_NAME,
R.RAT_RATSTARS
from e_com.Supplier S
join e_com.Rating R on R.SUPP_ID=S.SUPP_ID
order by R.RAT_RATSTARS desc
LIMIT 3;

/*9)	Display customer name and gender whose names start or end with character 'A'. */
select C.CUS_NAME,
		   C.CUS_GENDER
from e_com.Customer C
where CUS_NAME like'A%' or CUS_NAME like '%A';

/*10)	Display the total order amount of the male customers. */
select sum(ORD_AMOUNT)
from e_com.Prod_Order O,
		e_com.Customer C
where C.CUS_ID=O.CUS_ID 
	and C.CUS_GENDER='M';
    
/*11)	Display all the Customers left outer join with  the orders. */
SELECT *
FROM e_com.Customer C
LEFT OUTER JOIN e_com.Prod_Order O on O.CUS_ID=C.CUS_ID;



