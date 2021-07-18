
Question 1
We want to understand more about the movies that families are watching. The following categories are considered family movies: Animation, Children, Classics, Comedy, Family and Music.
Create a query that lists each movie, the film category it is classified in, and the number of times it has been rented out.
 
 SELECT  fi.title AS film_title,
        ca.name AS category_name,
        COUNT(re.rental_id) AS rental_count
FROM film_category  fica
JOIN  category  ca
ON ca.category_id=fica.category_id
JOIN film  fi
ON fi.film_id=fica.film_id
JOIN inventory  invo
ON fi.film_id=invo.film_id
JOIN rental  re
ON invo.inventory_id=re.inventory_id
WHERE ca.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
GROUP BY 1,2
ORDER BY 2 DESC;











Question 2
Now we need to know how the length of rental duration of these family-friendly movies compares to the duration that all movies are rented for. Can you provide a table with the movie titles and divide them into 4 levels (first_quarter, second_quarter, third_quarter, and final_quarter) based on the quartiles (25%, 50%, 75%) of the rental duration for movies across all categories? Make sure to also indicate the category that these family-friendly movies fall into.
SELECT  s.standard_quartile as quratile,
           s.name as category,
          COUNT(*) as rental_duration
  FROM (SELECT 
               fi.rental_duration,ca.name,
               NTILE(4) OVER(ORDER BY fi.rental_duration)  standard_quartile
          FROM film_category  fica
               JOIN  category  ca
                ON ca.category_id = fica.category_id 
         JOIN film AS fi
                ON fi.film_id = fica.film_id
                AND ca.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
              ) S
 GROUP BY 2,1
 ORDER BY 2,1,3;












Question 3
We want to find out how the two stores compare in their count of rental orders
during every month for all the years we have data for.
Write a query that returns the store ID for the store,
the year and month and the number of rental orders each store has fulfilled
for that month. Your table should include a column for each of the following:
year, month, store ID and count of rental orders fulfilled during that month.


SELECT store_id as Id_of_store,
	      EXTRACT(ISOYEAR FROM re.rental_date) AS Year_Of_Rental,
	      EXTRACT(MONTH FROM re.rental_date) AS month_of_Rental,
	      COUNT(re.rental_id) AS count_rentals
     FROM  staff AS sta 
      JOIN store AS st
    USING (store_id)
     JOIN rental AS re  
    USING (staff_id)
     
 GROUP BY 1, 3, 2
 ORDER BY 1, 2, 2 DESC;









Q4:
Question 4
provide a table with the family-friendly film category, each of the quartiles, and the corresponding count of movies within each combination of film category for each corresponding rental duration category.
The resulting table should have three columns:
Category
Rental length category
Count
-------------------------------------------------------------------------------

 SELECT quartiles AS Standard_Quratiles,
category_name AS Name,   
COUNT(category_name) as Count
FROM (SELECT
        
  ca.name category_name,
       NTILE(4) OVER (ORDER BY fi.rental_duration) AS quartiles
  
FROM  film_category AS fica
      JOIN category CA
  ON ca.category_id = fica.category_id
JOIN  film AS FI
  ON fi.film_id = fica.film_id

WHERE ca.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')) S
GROUP BY 2,1
ORDER BY 3 DESC;



