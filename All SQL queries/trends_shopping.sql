select * from shop_trends;
SET SQL_SAFE_UPDATES = 0;

-- total category count

SELECT category, COUNT(*) AS category_count
FROM shop_trends
GROUP BY category;

-- total gender count
SELECT gender, COUNT(*) AS total_count
FROM shop_trends
WHERE gender IN ('male', 'female')
GROUP BY gender;

-- total payment categorywise
SELECT PaymentMethod, COUNT(*) AS Payment_type
FROM shop_trends
GROUP BY PaymentMethod;

-- total Sales Seasonwise
SELECT Season, COUNT(*) AS SeasonType
FROM shop_trends
GROUP BY Season;


-- total max and min values
SELECT 'max' AS value_type, MAX(PurchaseAmt) AS max_value, COUNT(*) AS count_of_max_values
FROM shop_trends
WHERE PurchaseAmt = (SELECT MAX(PurchaseAmt) FROM shop_trends)
UNION ALL
SELECT 'min' AS value_type, MIN(PurchaseAmt) AS min_value, COUNT(*) AS count_of_min_values
FROM shop_trends
WHERE PurchaseAmt = (SELECT MIN(PurchaseAmt) FROM shop_trends);

-- total shipping type shippingtypewise
SELECT ShippingType, COUNT(ShippingType) AS ShippingCount
FROM shop_trends
GROUP BY ShippingType;


-- total subscription count
SELECT SubscriptionStatus, COUNT(*) AS total_count
FROM shop_trends
WHERE SubscriptionStatus IN ('No', 'Yes')
GROUP BY SubscriptionStatus;


-- avg purchaseAmt
SELECT avg(PurchaseAmt) as avgpurchase
FROM shop_trends;

-- total colour type
SELECT Color, COUNT(Color) AS color
FROM shop_trends
GROUP BY Color;


-- min max avg age of customer
SELECT 'max' AS value_type, MAX(Age) AS max_value, COUNT(*) AS count_of_max_values
FROM shop_trends
WHERE Age = (SELECT MAX(Age) FROM shop_trends)
UNION ALL
SELECT 'min' AS value_type, MIN(Age) AS min_value, COUNT(*) AS count_of_min_values
FROM shop_trends
WHERE Age = (SELECT MIN(Age) FROM shop_trends)
UNION ALL
SELECT 'avg' AS value_type, avg(Age) AS avg_value, NULL AS count_of_avg_values
FROM shop_trends;

-- location count
SELECT Location, COUNT(*) AS Location_count
FROM shop_trends
GROUP BY Location;

-- season count
SELECT Season, COUNT(*) AS Season
FROM shop_trends
GROUP BY Season;

-- iteam purchased
SELECT 
    ItemPurchased,
    SUM(CASE WHEN Gender = 'male' THEN 1 ELSE 0 END) AS MaleCount,
    SUM(CASE WHEN Gender = 'female' THEN 1 ELSE 0 END) AS FemaleCount
FROM shop_trends
GROUP BY ItemPurchased;


-- changing size column
UPDATE shop_trends
SET Size = 
    CASE 
        WHEN Size = 'L' THEN 'LARGE'
        WHEN Size = 'M' THEN 'MEDIUM'
        WHEN Size = 'S' THEN 'SMALL'
        WHEN Size = 'XL' THEN 'EXTRA LARGE'
        ELSE Size -- If none of the above conditions match, keep the original value
    END;

select * from shop_trends;

-- subscription status and gender count
SELECT 
    SubscriptionStatus,
    DiscountApplied,
    SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) AS female_count
FROM 
    shop_trends
WHERE 
    SubscriptionStatus IS NOT NULL 
    AND DiscountApplied IS NOT NULL
GROUP BY 
    SubscriptionStatus,
    DiscountApplied;

-- location with gender count
SELECT  Location,
    SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) AS female_count
FROM 
    shop_trends
GROUP BY 
    Location;
    
SELECT SUM(PurchaseAmt) as Total_Sale
FROM shop_trends;

select * from shop_trends;

select Avg(ReviewRat) as avgrat, max(ReviewRat) as highest , min(ReviewRat) as lowest
from shop_trends; 

select FrequencyofPurchases, count(FrequencyofPurchases) as fop
from shop_trends
group by FrequencyofPurchases;

select count(*) as recent_above 
from shop_trends
where PurchaseAmt> PreviousPurchases;





SELECT
    top5.PurchaseAmt AS Highest_PurchaseAmt,
    bottom5.PurchaseAmt AS Lowest_PurchaseAmt
FROM
    -- Top 5 sales data
    (
        SELECT
            PurchaseAmt
        FROM
            shop_trends
        ORDER BY
            PurchaseAmt DESC
        LIMIT 2
    ) AS top5
CROSS JOIN
    -- Bottom 5 sales data
    (
        SELECT
            PurchaseAmt
        FROM
            shop_trends
        ORDER BY
            PurchaseAmt ASC
        LIMIT 2
    ) AS bottom5;



select * from shop_trends;

select distinct(age)
from shop_trends
order by age asc;


select
	case
		when age>=18 and age <=24 then '18-24'
        when age>=25 and age <=34 then '25-34'
        when age>=35 and age <=44 then '35-44'
        when age>=45 and age <=54 then '45-54'
        when age>=55 and age <=64 then '55-64'
        else '65+'
        end as age_group,
        count(*) as count
        from shop_trends
        group by age_group
        order by age_group;
        
        
SELECT
    CASE
        WHEN age >= 18 AND age <= 24 THEN '18-24'
        WHEN age >= 25 AND age <= 34 THEN '25-34'
        WHEN age >= 35 AND age <= 44 THEN '35-44'
        WHEN age >= 45 AND age <= 54 THEN '45-54'
        WHEN age >= 55 AND age <= 64 THEN '55-64'
        ELSE '65+'
    END AS age_group,
    SUM(PurchaseAmt) AS total_purchase_amount
FROM
    shop_trends
GROUP BY
    age_group,
    Gender
ORDER BY
    age_group,
    Gender;

select * from shop_trends;

SELECT
    Age,
    COUNT(*) AS entry_count
FROM
    shop_trends
GROUP BY
    Age
ORDER BY
    Age;
