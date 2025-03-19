-- SQL Project with Netflix Dataset
-- Lets create netflix dataset tables


drop table if exists netflix;
create table netflix (
	show_id varchar(10),
	type varchar(14),
	title varchar(200),
	director varchar(250),
	casts varchar(2000),
	country varchar(200),
	date_added varchar(100),
	release_year int,
	rating varchar(100),
	duration varchar(100),
	listed_in varchar(100),
	description varchar(250)
);	

-- Lets import the dataset

-- Lets check our dataset

select * from netflix


-- Lets check what type of content is there in the dataset and what all countries content is present in the dataset
select distinct(type)
from netflix;

-- lets check for countries where the TV shows will be releasing
select distinct(country)
from netflix;


-- lets dive into business problems

-- 1. Count the number of Movies vs TV Shows

select 
distinct(type) as Type_of_Show,
count(type) as total_Count_of_Each_Type
from netflix
group by Type_of_Show


-- 2. Find the most common rating for movies and TV shows

select distinct(type) as TV_Category, rating,
count(rating) as total_count_of_rating
from netflix
group by TV_Category,rating
order by total_count_of_rating desc;

-- Query giving the rank
select
type,
rating,
count(*),
rank()
over (partition by type order by count(*) desc) as ranking
from netflix
group by type,rating;



-- 3.List all movies released in a specific year (e.g., 2020)


select type, title,release_year
from netflix
where 
     type = 'Movie' and release_year = '2020'


-- 4. Find the top 5 countries with the most content on Netflix

select country, count(show_id) as total_content_on_netflix
from netflix
group by country
order by total_content_on_netflix desc limit 5;


-- here, if we check the dataset there are multiple countries in the single row.
select * from netflix;

-- lets separate those first and then count the total content as per each country who uploaded content in netflix

select
   unnest(string_to_array (country,',')) as new_country,
   count(show_id) as total_content_on_netflix
from netflix
	group by 1
	order by 2 desc
	limit 5
   
-- 5. Identify the longest movie

select * from
	netflix
	where 
		type = 'Movie'
		and
		duration = (select max(duration) from netflix);


-- 6. Find all the movies/TV shows by director 'Robert Vince'!

select *
from netflix
where director like '%Robert Vince%'


-- 7. List all TV shows with more than 5 seasons

select * 
	from netflix
	where type = 'TV Show'
	and 
	duration >= '5 Season'

-- Alternate Method

select *
		from netflix
		where
		type = 'TV Show'
		and
		split_part(duration,' ',1):: numeric > 5


-- 8. Count the number of content items in each genre

select 
	unnest(string_to_array(listed_in,',')) as genre_sep,
	count(show_id) as total_content
from netflix
group by 1


-- 9. List all movies that are documentaries


with np as
(
select 
	unnest(string_to_array(listed_in,',')) as genre_sep,
	count(show_id) as total_content
from netflix
where type = 'Movie'
group by 1
)

select * from 
np
where genre_sep = 'Documentaries'


-- 10. Find all content without a director

select * from netflix
where director is  null;



-- 11.  Find the top 10 actors who have appeared in the highest number of movies produced in India.

select 
    unnest(string_to_array(casts, ',')) AS actor,
    count(*) as number_of_movies_appeared
from netflix
where country = 'India'
and type = 'Movie'
group by actor
order by number_of_movies_appeared desc
limit 10;


-- 12. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
--the description field. Label content containing these keywords as 'Bad' and all other 
--content as 'Good'. Count how many items fall into each category.


select * 
		from netflix
			where  description ilike '%kill%'
			or
			  		description ilike '%violence%'

-- lets use Case statement to solve this issue

with bg as
(
select 
		*,
		case 
		 	when description ilike '%kill%'
			 or
			 	 description ilike '%violence%'
				then 'bad_content'
		else 'good_content'
end category
from netflix
)
select category,
		count(*) as total_content
		from bg
		group by category








