##SQL Script for the sales Query##
Sales:

SELECT SUM(SALESAMOUNT) AS SALES, SUM(TOTALPRODUCTCOST) AS COST,
COUNT(DISTINCT SALESORDERNUMBER) AS ORDERS,
SUM(SALESORDERLINENUMBER) AS ORDERLINE,
SUM(ORDERQUANTITY) AS ORDER_QUANTITY,
SUM(DISCOUNTAMOUNT) AS DISCOUNT_AMOUNT,
CAST(CUSTOMERKEY AS VARCHAR(20))+CAST(ORDERDATEKEY AS VARCHAR(20)) AS CUSTOMER_ORDER_KEY,
SUM(TAXAMT) AS TAXAMOUNT,
SUM(FREIGHT) AS FREIGHTAMOUNT,
CASE WHEN ENGLISHPROMOTIONNAME<>'NO DISCOUNT' THEN 0 ELSE 1 END DISCOUNTFLAG,
CASE WHEN SUM(TOTALPRODUCTCOST)< SUM(SALESAMOUNT) THEN 1 ELSE 0 END AS NEG_MARGIN,
SALESORDERNUMBER,
CAST(A.SALESORDERNUMBER AS VARCHAR(20))+CAST(A.PRODUCTKEY AS VARCHAR(20))+
CAST(A.CUSTOMERKEY AS VARCHAR(20)) AS KEY_LINK ,
A.PRODUCTKEY,
CUSTOMERKEY,
A.PROMOTIONKEY,A.ORDERDATEKEY,
A.DUEDATEKEY,A.SHIPDATEKEY,A.CUSTOMERPONUMBER
FROM DBO.FACTINTERNETSALES A INNER JOIN 
DIMDATE B ON A.ORDERDATEKEY=B.DATEKEY INNER JOIN 
DIMPRODUCT C ON A.PRODUCTKEY=C.PRODUCTKEY  INNER JOIN 
DIMPROMOTION D ON A.PROMOTIONKEY=D.PROMOTIONKEY
WHERE CAST(CUSTOMERKEY AS VARCHAR(20))+CAST(ORDERDATEKEY AS VARCHAR(20))='1373520131228'
GROUP BY CASE WHEN ENGLISHPROMOTIONNAME<>'NO DISCOUNT' THEN 0 ELSE 1 END,A.PRODUCTKEY,
CUSTOMERKEY,A.PROMOTIONKEY,
A.DUEDATEKEY,A.SHIPDATEKEY,
SALESORDERNUMBER,A.CUSTOMERPONUMBER,A.ORDERDATEKEY,CAST(CUSTOMERKEY AS VARCHAR(20))+CAST(ORDERDATEKEY AS VARCHAR(20)) ;


Product:
SQL 
SELECT DISTINCT a.productalternatekey,
a.ProductKey,
a.Class,
a.Color,
a.EnglishDescription,
a.ListPrice,
a.ModelName,
a.ListPrice,
a.Size,
a.Weight,
a.WeightUnitMeasureCode,
b.productcategorykey,
b.productsubcategorykey,
englishproductcategoryname,
englishproductsubcategoryname
FROM   dimproduct a
       LEFT JOIN dimproductsubcategory b
              ON a.productsubcategorykey = b.productsubcategorykey
       LEFT JOIN dimproductcategory c
              ON b.productcategorykey = c.productcategorykey;
			  
Promotion:
SQL 
SELECT DISTINCT promotionkey,
                promotionalternatekey,
                englishpromotionname,
                englishpromotiontype,
                englishpromotioncategory
FROM   dimpromotion;


Territory:
sql 

SELECT salesterritorykey,
       salesterritoryregion  AS Region,
       salesterritorycountry AS Country
FROM   dimsalesterritory ;


Cyclic Measure = {
    ("AOV", NAMEOF('Measure'[AOV]),NAMEOF('Measure'[AOV LY]), 0),
    ("Margin", NAMEOF('Measure'[Margin]),NAMEOF('Measure'[Margin LY]), 1),
    ("Net sales Value", NAMEOF('Measure'[Net sales Value]),NAMEOF('Measure'[Net Sale Value (LY)]), 2),
    ("Sales Order", NAMEOF('Measure'[Sales Order]),NAMEOF('Measure'[Sales Order LY]), 3),
    ("Sales Units", NAMEOF('Measure'[Sales Units]),NAMEOF('Measure'[Sales Units LY]), 4),
    ("SPD", NAMEOF('Measure'[SPD]),NAMEOF('Measure'[SPD LY]), 5),
    ("UPT", NAMEOF('Measure'[UPT]),NAMEOF('Measure'[UPT LY]), 6)
}




