create database allopathy_drugs

-- 
CREATE VIEW base AS (
    SELECT
        id,
        name,
        TRY_CONVERT(decimal(18,2), price) AS price,
        is_discontinued,
        manufacturer_name,
        pack_size_label,          
        NULLIF(LTRIM(RTRIM(short_composition1)), '') AS sc1,
        NULLIF(LTRIM(RTRIM(short_composition2)), '') AS sc2
    FROM allopathy_drugs
) 

 -- composition pairs
CREATE VIEW pairs AS (
    SELECT
        id,
        manufacturer_name,
        CASE 
          WHEN sc1 IS NULL AND sc2 IS NULL THEN NULL
          WHEN sc1 IS NULL THEN sc2
          WHEN sc2 IS NULL THEN sc1
          WHEN sc1 <= sc2 THEN CONCAT(sc1, ', ', sc2)
          ELSE CONCAT(sc2, ', ', sc1)
        END AS composition_pair
    FROM base
)

select * from base
-- Price distribution (min/max/avg/median) excluding zero/NULL
SELECT 
   ROUND(MIN(price),2) AS min_price,
   ROUND(MAX(price),2) AS max_price,
   ROUND(AVG(price),2) AS avg_price,
   (SELECT TOP 1
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) OVER () AS median_price
   FROM base) as median_price
FROM base
WHERE price IS NOT NULL AND price>0;

--manufacturer ranked based on their pricing 
WITH manufacturer_stats AS (
   SELECT 
     manufacturer_name, 
     ROUND(AVG(price),2) AS avg_price,
     count(*) AS item_count
   FROM base 
   WHERE manufacturer_name IS NOT NULL AND price>0
   GROUP BY manufacturer_name
)
SELECT 
  manufacturer_name,
  avg_price,
  ROW_NUMBER () OVER(ORDER BY avg_price DESC) AS costliest_rank,
  ROW_NUMBER () OVER(ORDER BY avg_price ASC) AS cheapest_rank,
  item_count
FROM manufacturer_stats
ORDER BY costliest_rank ASC;

-- Price by pack size
SELECT
    DISTINCT pack_size_label,
    ROUND(AVG(price), 2) AS average_price,
    COUNT(*) AS items_count
FROM base
WHERE pack_size_label IS NOT NULL AND price > 0
GROUP BY pack_size_label
ORDER BY average_price DESC;

--top 10 most expensive drugs
SELECT  TOP 10
  name, 
  price,
  ROW_NUMBER () OVER(ORDER BY price DESC) AS price_rank
  FROM base 
  WHERE price IS NOT NULL AND price>0

  --top 10 least expensive drugs
SELECT TOP 10
  name, 
  price,
  ROW_NUMBER () OVER(ORDER BY price ASC) AS price_rank
  FROM base 
  WHERE price IS NOT NULL AND price>0
  ORDER BY price_rank ASC
  
  --active and discontinued count by manufacturer
  SELECT 
    manufacturer_name, 
    count(*) AS total_products,
    SUM(CASE WHEN is_discontinued= 0 THEN 1 ELSE 0 END) AS active_count,
    SUM(CASE WHEN is_discontinued= 1 THEN 1 ELSE 0 END) AS discontinued_count,
    CAST(100.0 * SUM(CASE WHEN is_discontinued = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0) AS decimal(5,2)) AS discontinued_rate,
    CAST(100.0 * SUM(CASE WHEN is_discontinued = 0 THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0) AS decimal(5,2)) AS active_rate
FROM base
GROUP BY manufacturer_name
ORDER BY discontinued_count DESC

-- Manufacturer product counts
SELECT 
  manufacturer_name, 
  count(*) AS product_count
FROM base
WHERE manufacturer_name IS NOT NULL
GROUP BY manufacturer_name
ORDER BY product_count DESC;

-- Unique composition pair list as a view
IF OBJECT_ID ('composition_pairs', 'V') IS NOT NULL
DROP VIEW composition_pairs;
GO 

CREATE VIEW composition_pairs AS
SELECT
    id,
    manufacturer_name,
    CASE
        WHEN sc1 IS NULL AND sc2 IS NULL THEN NULL
        WHEN sc1 IS NOT NULL AND sc2 IS NULL THEN sc1
        WHEN sc1 IS NULL AND sc2 IS NOT NULL THEN sc2
        WHEN sc1 <= sc2 THEN CONCAT(sc1, ', ', sc2)
        ELSE CONCAT(sc2, ', ', sc1)
    END AS composition_pair
FROM base;   
GO

--manufacturer diveristy
SELECT 
  manufacturer_name, 
  COUNT(DISTINCT composition_pair) AS manufacturer_diversity
FROM composition_pairs
GROUP BY manufacturer_name
ORDER BY manufacturer_diversity DESC;

-- Active vs Inactive view
IF OBJECT_ID ('active_vs_inactive', 'V') IS NOT NULL
DROP VIEW active_vs_inactive;
GO 
CREATE VIEW active_vs_inactive AS
SELECT 
   manufacturer_name,
   COUNT(*) AS total_products,
   SUM(CASE WHEN is_discontinued=1 THEN 1 ELSE 0 END) AS discontinued_count,
   SUM(CASE WHEN is_discontinued=0 THEN 1 ELSE 0 END) AS active_count,
   CAST (100* SUM(CASE WHEN is_discontinued=1 THEN 1 ELSE 0 END)/NULLIF(COUNT(*),0) AS DECIMAL(5,2)) AS discontinued_rate,
   CAST (100* SUM(CASE WHEN is_discontinued=0 THEN 1 ELSE 0 END)/NULLIF(COUNT(*),0) AS DECIMAL(5,2)) AS active_rate
FROM base
GROUP BY manufacturer_name;
GO

SELECT * 
FROM active_vs_inactive 
ORDER BY active_count DESC;

-- Price comparison between active and inactive
SELECT 
   is_discontinued,
   AVG(price) AS avg_price,
   MAX(price) AS max_price,
   MIN(price) AS min_price,
      (SELECT TOP 1
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY price) OVER () AS median_price
   FROM base) as median_price,
   COUNT(*) AS total_products
FROM base
WHERE price>0
GROUP BY is_discontinued;

-- Manufacturer-wise summary (grouped, not row-per-product)
SELECT
   manufacturer_name,
   CAST(is_discontinued AS int) AS is_discontinued,
   ROUND(AVG(price), 2) AS avg_price,
   MIN(price) AS min_price,
   MAX(price) AS max_price,
   COUNT(*) AS items
FROM base
WHERE manufacturer_name IS NOT NULL AND price > 0
GROUP BY manufacturer_name, CAST(is_discontinued AS int)
ORDER BY manufacturer_name, is_discontinued;

-- Discontinuation counts by manufacturer
SELECT 
    manufacturer_name, 
    COUNT(*) AS products_discontinued
FROM base 
WHERE is_discontinued=1
GROUP BY manufacturer_name
ORDER BY products_discontinued DESC;

-- Flattened compositions into a single column (UNION ALL) as a view
IF OBJECT_ID('all_compositions', 'V') IS NOT NULL DROP VIEW all_compositions;
GO
CREATE VIEW all_compositions
AS
SELECT NULLIF(LTRIM(RTRIM(short_composition1)), '') AS composition
FROM allopathy_drugs
UNION ALL
SELECT NULLIF(LTRIM(RTRIM(short_composition2)), '') AS composition
FROM allopathy_drugs;
GO

-- Most common single compositions
SELECT 
  TOP (50)
  composition,
  COUNT(*) AS frequency
FROM all_compositions
WHERE composition IS NOT NULL
GROUP BY composition
ORDER BY frequency DESC

-- Most often paired compositions
SELECT TOP (50)
   composition_pair,
   COUNT(*) AS frequency 
FROM composition_pairs
WHERE composition_pair IS NOT NULL
GROUP BY composition_pair
ORDER BY frequency DESC

-- Most/least common package sizes
SELECT TOP (1) WITH TIES
    pack_size_label, COUNT(*) AS frequency
FROM base
GROUP BY pack_size_label
ORDER BY frequency DESC;

SELECT TOP (1) WITH TIES
    pack_size_label, COUNT(*) AS frequency
FROM base
GROUP BY pack_size_label
ORDER BY frequency ASC;

-- Active vs inactive by pack size
SELECT 
  pack_size_label,
  is_discontinued,
  COUNT(*) AS discontinued_count
FROM base
GROUP BY pack_size_label, is_discontinued
ORDER BY discontinued_count DESC

