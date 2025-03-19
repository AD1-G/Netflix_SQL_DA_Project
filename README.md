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
```

### **2️⃣ Most Common Ratings**  
**Question:** Identify the most frequent ratings for movies and TV shows.  
**Solution:**  
```sql
SELECT 
    type AS TV_Category, rating, 
    COUNT(*) AS Total_Count 
FROM netflix 
GROUP BY TV_Category, rating 
ORDER BY Total_Count DESC;
```

### **3️⃣ Movies Released in a Specific Year**  
**Question:** List all movies released in a given year (e.g., 2020).  
**Solution:**  

```sql
SELECT 
    type, title, release_year 
FROM netflix 
WHERE type = 'Movie' AND release_year = 2020;
```


### **4️⃣ Top 5 Countries with the Most Content**  
**Question:** Identify which countries contribute the most content to Netflix.  
**Solution:**  

```sql

SELECT 
    country, COUNT(show_id) AS Total_Content 
FROM netflix 
GROUP BY country 
ORDER BY Total_Content DESC 
LIMIT 5;

```

### **5️⃣ Identifying the Longest Movie**  
**Question:** Find the longest movie available on Netflix.  
**Solution:**  

```sql
SELECT * FROM netflix 
WHERE type = 'Movie' 
AND duration = (SELECT MAX(duration) FROM netflix);
```

### **6️⃣ Movies/TV Shows by a Specific Director**  
**Question:** Find all movies or TV shows directed by 'Robert Vince'.  
**Solution:** 

```sql
SELECT * FROM netflix 
WHERE director LIKE '%Robert Vince%';
```

### **7️⃣ TV Shows with More Than 5 Seasons**  
**Question:** List all TV Shows with more than 5 seasons.  
**Solution:**  

```sql
SELECT * FROM netflix 
WHERE type = 'TV Show' 
AND duration >= '5 Season';

```

### **8️⃣ Content Count per Genre**  
**Question:** Count the number of content items in each genre.  
**Solution:**  

```sql
SELECT 
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS Genre, 
    COUNT(show_id) AS Total_Content 
FROM netflix 
GROUP BY 1;

```sql

### **9️⃣ Listing All Documentary Movies**  
**Question:** Extract all movies that belong to the "Documentary" genre.  
**Solution:**

```sql

WITH Genre_Count AS (
    SELECT 
        UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS Genre, 
        COUNT(show_id) AS Total_Content 
    FROM netflix 
    WHERE type = 'Movie' 
    GROUP BY 1
) 
SELECT * FROM Genre_Count WHERE Genre = 'Documentaries';

```

### **🔟 Identifying Content Without a Director**  
**Question:** Find all Netflix content that does not list a director.  
**Solution:**  

```sql
SELECT * FROM netflix WHERE director IS NULL;

```

### **1️⃣1️⃣ Top 10 Actors in Indian Movies**  
**Question:** Identify the top 10 actors who have appeared in the most Indian movies.  
**Solution:**  

```sql
SELECT 
    UNNEST(STRING_TO_ARRAY(casts, ',')) AS Actor, 
    COUNT(*) AS Number_of_Movies_Appeared 
FROM netflix 
WHERE country = 'India' AND type = 'Movie' 
GROUP BY Actor 
ORDER BY Number_of_Movies_Appeared DESC 
LIMIT 10;

```

### **1️⃣2️⃣ Categorizing Content Based on Keywords**  
**Question:** Categorize content based on the presence of keywords like 'kill' and 'violence'.  
**Solution:**  

```sql

WITH Content_Category AS (
    SELECT 
        *, 
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' 
            THEN 'Bad Content' 
            ELSE 'Good Content' 
        END AS Category 
    FROM netflix
) 
SELECT Category, COUNT(*) AS Total_Content 
FROM Content_Category 
GROUP BY Category;

```





