

------SQL Proficiency Test: -------

--1 total sales for each category
SELECT isnull(C.Product_category,'Total Sales') as [Product_category] ,
SUM(PRICE) + sum([Freight_value]) AS [TOTAL SALES]
FROM Order_items O INNER JOIN Products P
ON P.Product_id = O.Product_id
INNER JOIN Categories C ON C.Product_category = P.Product_category
group by rollup  (C.Product_category) 

--------------------
--2
SELECT 
    c.customer_id,
    c.[City],c.Zip_code_prefix,
    c.[State],
    o.[Purchase_timestamp] AS Purchase_timestamp
FROM
    Customers c
INNER JOIN
    Orders o ON c.customer_id = o.customer_id
WHERE
    DATEPART(YEAR, [Purchase_timestamp]) = DATEPART(YEAR, DATEADD(MONTH, -1, '2018-03-19'))
    AND DATEPART(MONTH, [Purchase_timestamp]) = DATEPART(MONTH, DATEADD(MONTH, -1, '2018-03-19'))
order by  [Purchase_timestamp]

--you can replace mentioned date with getdate() but data is between 2016:2018

---------------------

--3--avg order value
SELECT
    AVG(order_value) AS [Average order value]
FROM
    (SELECT
         o.order_id,
         SUM(oi.price)+sum([Freight_value]) AS order_value
     FROM
         Orders o
     INNER JOIN
         Order_Items oi ON o.order_id = oi.order_id
     GROUP BY
         o.order_id) AS order_values;


-- 3- AVG sold for each category

SELECT 
    C.Product_category,
    AVG(TotalOrderValue) AS AvgOrderValue
FROM (
    SELECT 
        O.order_id,
        SUM(O.price + O.freight_value) AS TotalOrderValue,
        P.Product_category
    FROM 
        Order_Items O
    INNER JOIN 
        Products P ON P.Product_id = O.Product_id
    GROUP BY 
        O.order_id, P.Product_category
) AS OrderTotals
INNER JOIN 
    Categories C ON C.Product_category = OrderTotals.Product_category
GROUP BY 
    C.Product_category;




--checking for me
--ensure that item_id is representing no. of product sold
SELECT  [Order_id]
      ,[Item_id]
      ,[Product_id]
  FROM [Ecommerce].[dbo].[Order_items]
  where [Order_id] = 'fffb9224b6fc7c43ebb0904318b10b5f'
 SELECT Order_id, Product_id, COUNT(*) AS Product_count
FROM [Ecommerce].[dbo].[Order_items]
where [Order_id] = 'fffb9224b6fc7c43ebb0904318b10b5f'
GROUP BY Order_id, Product_id;



