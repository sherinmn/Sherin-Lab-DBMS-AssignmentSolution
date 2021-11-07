CREATE TABLE e_com.Supplier (
    SUPP_ID INT NOT NULL AUTO_INCREMENT,
    SUPP_NAME VARCHAR(50),
    SUPP_CITY VARCHAR(50),
    SUPP_PHONE BIGINT,
    PRIMARY KEY (SUPP_ID)
);

CREATE TABLE e_com.Customer (
    CUS_ID INT NOT NULL AUTO_INCREMENT,
    CUS_NAME VARCHAR(50),
    CUS_PHONE BIGINT,
    CUS_CITY VARCHAR(50),
    CUS_GENDER CHAR,
    PRIMARY KEY (CUS_ID)
);

CREATE TABLE e_com.Category (
    CAT_ID INT NOT NULL AUTO_INCREMENT,
    CAT_NAME VARCHAR(50),
    PRIMARY KEY (CAT_ID)
);

CREATE TABLE e_com.Product (
    PRO_ID INT NOT NULL AUTO_INCREMENT,
    PRO_NAME VARCHAR(50),
    PRO_DESC VARCHAR(50),
    CAT_ID INT,
    PRIMARY KEY (PRO_ID),
    FOREIGN KEY (CAT_ID)
        REFERENCES Category (CAT_ID)
);

CREATE TABLE e_com.Product_Details (
    PROD_ID INT NOT NULL AUTO_INCREMENT,
    PRO_ID INT,
    SUPP_ID INT,
    PRICE INT,
    PRIMARY KEY (PROD_ID),
    FOREIGN KEY (PRO_ID)
        REFERENCES Product (PRO_ID)
);

CREATE TABLE e_com.Prod_Order (
    ORD_ID INT NOT NULL,
    ORD_AMOUNT INT,
    ORD_DATE DATE,
    CUS_ID INT,
    PROD_ID INT,
    PRIMARY KEY (ORD_ID),
    FOREIGN KEY (PROD_ID)
        REFERENCES Product_Details (PROD_ID)
);

CREATE TABLE e_com.Rating (
    RAT_ID INT NOT NULL AUTO_INCREMENT,
    CUS_ID INT,
    SUPP_ID INT,
    RAT_RATSTARS INT,
    PRIMARY KEY (RAT_ID),
    FOREIGN KEY (CUS_ID)
        REFERENCES Customer (CUS_ID),
    FOREIGN KEY (SUPP_ID)
        REFERENCES Supplier (SUPP_ID)
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
SELECT 
    COUNT(c.CUS_GENDER) AS Gender, c.CUS_GENDER
FROM
    e_com.Customer c,
    e_com.Prod_Order o
WHERE
    o.CUS_ID = c.CUS_ID
        AND o.ORD_AMOUNT >= 3000
GROUP BY CUS_GENDER;

/*4)	Display all the orders along with the product name ordered by a customer having Customer_Id=2. */
SELECT 
    O.ORD_ID AS Order_ID,
    P.PRO_ID AS Product_ID,
    P.PRO_NAME AS Product_name,
    P.PRO_DESC AS Product_Description,
    PD.PRICE AS Price,
    O.CUS_ID AS Customer_ID
FROM
    e_com.Product P,
    e_com.Product_Details PD,
    e_com.Prod_order O
WHERE
    O.PROD_ID = PD.PROD_ID
        AND PD.PRO_ID = P.PRO_ID
        AND O.CUS_ID = 2;


/*5)	Display the Supplier details who can supply more than one product. */

SELECT 
    COUNT(PD.SUPP_ID) AS supplier_count,
    S.SUPP_ID AS Supplier_ID,
    S.SUPP_NAME AS name,
    S.SUPP_CITY AS City,
    S.SUPP_PHONE AS phone
FROM
    e_com.Product_Details PD
        JOIN
    e_com.supplier S ON PD.SUPP_ID = S.SUPP_ID
GROUP BY PD.SUPP_ID
HAVING COUNT(PD.SUPP_ID) > 1;

 /*OR*/
 
SELECT 
    COUNT(PD.SUPP_ID) AS supplier_count,
    S.SUPP_ID AS Supplier_ID,
    S.SUPP_NAME AS name,
    S.SUPP_CITY AS City,
    S.SUPP_PHONE AS phone
FROM
    e_com.Product_Details PD,
    e_com.supplier S
WHERE
    S.SUPP_ID = PD.SUPP_ID
GROUP BY PD.SUPP_ID
HAVING COUNT(PD.SUPP_ID) > 1;

/*6)	Find the category of the product whose order amount is minimum. */
SELECT 
    *
FROM
    e_com.Prod_Order O
        JOIN
    e_com.Product_Details PD ON O.PROD_ID = PD.PROD_ID
        JOIN
    e_com.Product P ON P.PRO_ID = PD.PRO_ID
        JOIN
    e_com.Category C ON C.CAT_ID = P.CAT_ID
HAVING MIN(O.ORD_AMOUNT);
    
		  
/*7)	Display the Id and Name of the Product ordered after “2021-10-05”. */
SELECT 
    O.ORD_ID, P.PRO_ID, P.PRO_NAME
FROM
    e_com.Prod_Order O
        JOIN
    e_com.Product_Details PD ON O.PROD_ID = PD.PROD_ID
        JOIN
    e_com.Product P ON PD.PRO_ID = P.PRO_ID
WHERE
    ORD_DATE > '21-10-05';

/*8)	Print the top 3 supplier name and id and their rating on the basis of their rating along with the customer name who has given the rating. */
SELECT 
    S.SUPP_ID, S.SUPP_NAME, R.RAT_RATSTARS
FROM
    e_com.Supplier S
        JOIN
    e_com.Rating R ON R.SUPP_ID = S.SUPP_ID
ORDER BY R.RAT_RATSTARS DESC
LIMIT 3;

/*9)	Display customer name and gender whose names start or end with character 'A'. */
SELECT 
    C.CUS_NAME, C.CUS_GENDER
FROM
    e_com.Customer C
WHERE
    CUS_NAME LIKE 'A%' OR CUS_NAME LIKE '%A';

/*10)	Display the total order amount of the male customers. */
SELECT 
    SUM(ORD_AMOUNT)
FROM
    e_com.Prod_Order O,
    e_com.Customer C
WHERE
    C.CUS_ID = O.CUS_ID
        AND C.CUS_GENDER = 'M';
    
/*11)	Display all the Customers left outer join with  the orders. */
SELECT 
    *
FROM
    e_com.Customer C
        LEFT OUTER JOIN
    e_com.Prod_Order O ON O.CUS_ID = C.CUS_ID;



