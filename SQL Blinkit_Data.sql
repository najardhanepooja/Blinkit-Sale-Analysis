Select * From Blinkit_Data

Select COUNT(*) From Blinkit_Data

Update Blinkit_Data
set Item_Fat_Content =
Case 
When Item_Fat_Content IN ('LF', 'low fat') Then 'Low Fat'
When Item_Fat_Content = 'reg' Then 'Regular'
Else Item_Fat_Content 
End

Select Distinct (Item_Fat_Content) From Blinkit_Data






Select * From Blinkit_Data;
--- 1. Total Sale:
SELECT 
    CAST(SUM(Sales) / 1000000.0 AS DECIMAL(10,2)) AS Total_Sales_Millions
FROM 
    Blinkit_Data
Where 
     Outlet_Establishment_Year = 2022

--- 2. Average Sales:
Select 
     Cast(AVG(Sales) As decimal(10,1)) As Avg_Sales From Blinkit_Data
Where 
     Outlet_Establishment_Year = 2022

--- 3. Number of Items:
Select Count(*) As No_Of_Items From Blinkit_Data
Where 
     Outlet_Establishment_Year = 2022

--- 4. Average Rating:
Select Cast(AVG(Rating) As decimal(10,2)) As Avg_Rating From Blinkit_Data


-- Granular Requirements
-- 1. Total sales by fat content: Objective:- Analyze the impact of fat content on total sales.KPI(Average sales,Number of items, Average Rating)


SELECT 
    Item_Fat_Content, 
    CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
    Cast(AVG(Sales) As decimal(10,1)) As Avg_Sales,
    Count(*) As No_Of_Items,
    Cast(AVG(Rating) As decimal(10,2)) As Avg_Rating
FROM 
    Blinkit_Data

GROUP BY 
    Item_Fat_Content
ORDER BY 
    Total_Sales_Thousands DESC;


-- 2. Total Sales by Item Type:Objective:- Identify the performance of different item types in terms of total sales. KPT(Average Sales, Number of Items, Average rating)
SELECT 
    Item_Type, 
    CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
    Cast(AVG(Sales) As decimal(10,1)) As Avg_Sales,
    Count(*) As No_Of_Items,
    Cast(AVG(Rating) As decimal(10,2)) As Avg_Rating
FROM 
    Blinkit_Data

GROUP BY 
    Item_Type
ORDER BY 
    Total_Sales_Thousands DESC;

  -- Top 5 Item_Type
 SELECT Top 5
    Item_Type, 
    CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales,
    Cast(AVG(Sales) As decimal(10,1)) As Avg_Sales,
    Count(*) As No_Of_Items,
    Cast(AVG(Rating) As decimal(10,2)) As Avg_Rating
FROM 
    Blinkit_Data

GROUP BY 
    Item_Type
ORDER BY 
    Total_Sales ASC;

-- 3. fat Content by Outlet for Total Sales:Objective:- Compare total sales across different outlets segmented by fat content. KPI(Average sales, Number of Items, Average Rating)

SELECT Outlet_Location_Type,Item_Fat_Content,
    
    CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales,
    Cast(AVG(Sales) As decimal(10,1)) As Avg_Sales,
    Count(*) As No_Of_Items,
    Cast(AVG(Rating) As decimal(10,2)) As Avg_Rating
FROM 
    Blinkit_Data

GROUP BY 
   Outlet_Location_Type,Item_Fat_Content
ORDER BY 
    Total_Sales ASC;

    ----------------
SELECT 
    Outlet_Location_Type,
    ISNULL([Low Fat], 0) AS Low_Fat,
    ISNULL([Regular], 0) AS Regular
FROM
(
    SELECT 
        Outlet_Location_Type,
        Item_Fat_Content,
        CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM 
        Blinkit_Data
    GROUP BY 
        Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT
(
    SUM(Total_Sales)
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY 
    Outlet_Location_Type;


-- 4. Total Sales by Outlet Establishment: Objective:- Evaluate how the age or type of outlet establishment influences total sales
SELECT 
    Outlet_Establishment_Year,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM 
    Blinkit_Data
GROUP BY 
    Outlet_Establishment_Year
ORDER BY 
    Total_Sales DESC;

-- 5. Percentage of sales by Outlet Size:
-- Objective: Analyze the correlation between Outlet size and total sales.
SELECT 
     Outlet_Size,
     CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
     CAST((SUM(Sales) * 100.0/SUM(SUM(Sales))Over()) As DECIMAL(10,2)) AS Sales_Percentage
FROM Blinkit_Data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

-- 6. Sales by Outlet Location:
-- Objective: Assess the geographic distribution of sales across different locations.
SELECT 
    Outlet_Location_Type,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Sales) * 100.0/SUM(SUM(Sales))Over()) As DECIMAL(10,2)) AS Sales_Percentage,
    CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM 
    Blinkit_Data
Where 
     Outlet_Establishment_Year = 2022
GROUP BY 
    Outlet_Location_Type
ORDER BY 
    Total_Sales DESC;

-- 7. All Metrics by Outlet Type:
-- Objective: Provide a comprehensive view of all key metrics(Total Sales,Average sales,Number of Items, Average Rating) broken down by different outlet types.
SELECT 
    Outlet_Type,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Sales) * 100.0/SUM(SUM(Sales))Over()) As DECIMAL(10,2)) AS Sales_Percentage,
    CAST(AVG(Sales) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating
FROM 
    Blinkit_Data

GROUP BY 
    Outlet_Type
ORDER BY 
    Total_Sales DESC;

