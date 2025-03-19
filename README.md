# Netflix_SQL_DA_Project

![Netflix Logo](https://github.com/AD1-G/Netflix_SQL_DA_Project/blob/main/Netflix_logo.svg)


##  Overview  

This project involves a **comprehensive analysis** of Netflix's **movies and TV shows** dataset using **SQL**. The goal is to **extract valuable insights** and answer various business questions based on the dataset.  

---

## Objectives  

-- Analyze the **distribution of content types** (Movies vs. TV Shows).  
-- Identify the **most common ratings** for movies and TV shows.  
-- List and analyze content based on **release years, countries, and durations**.  
-- Explore and categorize content based on **specific criteria and keywords**.  

## Business Problems & Solutions  

### **1️⃣ Content Type Analysis**  
**Question:** How many movies and TV shows are available on Netflix?  
**Solution:**  
```sql
SELECT 
    type AS Content_Type, 
    COUNT(*) AS Total_Count 
FROM netflix 
GROUP BY type;

Finding: Movies outnumber TV shows on Netflix.


### 2️⃣ Most Common Ratings
Question: What are the most frequent ratings for movies and TV shows?
Solution:

sql
Copy
Edit
SELECT 
    type AS Content_Type, 
    rating, 
    COUNT(*) AS Rating_Count 
FROM netflix 
GROUP BY type, rating 
ORDER BY Rating_Count DESC;
Finding: TV Shows and Movies have different dominant ratings, indicating audience preferences.

3️⃣ Top 5 Countries with the Most Content
Question: Which countries contribute the most content to Netflix?
Solution:

sql
Copy
Edit
SELECT 
    country, 
    COUNT(*) AS Total_Content 
FROM netflix 
GROUP BY country 
ORDER BY Total_Content DESC 
LIMIT 5;
Finding: The United States, India, and the UK have the highest number of Netflix titles.

4️⃣ Longest Movie on Netflix
Question: What is the longest movie available?
Solution:

sql
Copy
Edit
SELECT * FROM netflix 
WHERE type = 'Movie' 
AND duration = (SELECT MAX(duration) FROM netflix);
Finding: The longest movie has significant runtime, possibly a documentary or special edition film.

5️⃣ TV Shows with More Than 5 Seasons
Question: Which TV Shows have more than 5 seasons?
Solution:

sql
Copy
Edit
SELECT * FROM netflix 
WHERE type = 'TV Show' 
AND CAST(SPLIT_PART(duration, ' ', 1) AS INTEGER) > 5;
Finding: Only a handful of TV Shows have longer seasons, indicating a preference for shorter series.

6️⃣ Categorizing Content Based on Keywords
Question: How many titles contain keywords like "kill" or "violence"?
Solution:

sql
Copy
Edit
SELECT 
    CASE 
        WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' 
        THEN 'Bad Content' 
        ELSE 'Good Content' 
    END AS Category, 
    COUNT(*) AS Total_Content 
FROM netflix 
GROUP BY Category;
Finding: A small percentage of content has violent themes, useful for parental control insights.


