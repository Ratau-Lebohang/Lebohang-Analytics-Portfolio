---Top Street Food Analysis

-- Retrieve all data

SELECT * 
FROM `data-analysis-project-455101.Data.Street Foods`;



-- Country With the Highest Rank (Most Street Food Dishes)
SELECT
    `Country/Region`,
    COUNT(DISTINCT `Food Name`) AS NumberOfDishes
FROM
    `data-analysis-project-455101.Data.Street Foods`
GROUP BY
    `Country/Region`
ORDER BY
    NumberOfDishes DESC
LIMIT 1;



-- Country with the Longest Preparation Time
SELECT 
    `Food Name`, 
    `Preparation Time`
FROM 
    `data-analysis-project-455101.Data.Street_Foods`
WHERE 
    `Preparation Time` IS NOT NULL
ORDER BY 
    CAST(`Preparation Time` AS INT64) DESC
LIMIT 1;



-- Country with the Most Served Food Category (Assuming 'Category' Column Exists)
SELECT 
    `Country/Region`,
    COUNT(`Category`) AS CategoryCount
FROM 
    `data-analysis-project-455101.Data.Street_Foods`
GROUP BY 
    `Country/Region`
ORDER BY 
    CategoryCount DESC
LIMIT 1;



-- Countries that Offer the Most Popular Street Foods (Ranked by Popularity)
SELECT
    `Country/Region`,
    COUNT(DISTINCT `Food Name`) AS NumberOfDishes,
    RANK() OVER (ORDER BY COUNT(DISTINCT `Food Name`) DESC) AS PopularityRank
FROM
    `data-analysis-project-455101.Data.Street_Foods`
GROUP BY
    `Country/Region`
ORDER BY
    NumberOfDishes DESC;



-- Common Main Ingredients Across Various Street Food Dishes
SELECT
    `Country/Region`,
    `Main Ingredients`, -- Corrected column name
    COUNT(*) AS IngredientFrequency
FROM
    `data-analysis-project-455101.Data.Street_Foods`
GROUP BY
    `Country/Region`,
    `Main Ingredients`
ORDER BY
    `Country/Region`,
    IngredientFrequency DESC;



-- Average Calorie Count for Dishes, Grouped by Country
SELECT
    `Country/Region`,
    AVG(CAST(Calories AS INT64)) AS AverageCalories -- Converting calories to INT64
FROM
    `data-analysis-project-455101.Data.Street_Foods`
WHERE
    Calories IS NOT NULL
GROUP BY
    `Country/Region`
ORDER BY
    AverageCalories DESC;



-- Relationship Between Serving Type (Hot vs. Cold) and Popularity
SELECT
    `Serving Type`, 
    COUNT(*) AS Popularity
FROM
    `data-analysis-project-455101.Data.Street_Foods`
GROUP BY
    `Serving Type`
ORDER BY
    Popularity DESC;