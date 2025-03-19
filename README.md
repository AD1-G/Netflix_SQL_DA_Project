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
