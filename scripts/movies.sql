/*1. Give the name, release year, and worldwide gross of the lowest grossing movie.*/

SELECT s.film_title,
	s.release_year,
	r.worldwide_gross
FROM specs AS s
INNER JOIN revenue AS r
USING(movie_id)
ORDER BY r.worldwide_gross
LIMIT 1;

--Answer: Semi-Tough - 1977 - 37,187,139

/*2. What year has the highest average imdb rating?*/

SELECT s.release_year,
	AVG(r.imdb_rating) AS avg_imdb_rating
FROM specs AS s
INNER JOIN rating AS r
USING(movie_id)
GROUP BY s.release_year
ORDER BY avg_imdb_rating DESC;

--Answer: 1991

/*3. What is the highest grossing G-rated movie? Which company distributed it?*/

SELECT s.film_title,
	r.worldwide_gross,
	d.company_name
FROM specs AS s
INNER JOIN revenue AS r
USING(movie_id)
INNER JOIN distributors AS d
ON s.domestic_distributor_id = d.distributor_id
WHERE s.mpaa_rating = 'G'
ORDER BY r.worldwide_gross DESC;

--Answer: Toy Story 4 - Walt Disney

/*4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.*/

SELECT d.company_name AS distributor,
	COUNT(s.*) AS num_movies
FROM distributors AS d
LEFT JOIN specs AS s
ON d.distributor_id = s.domestic_distributor_id
GROUP BY d.company_name
ORDER BY num_movies DESC;

/*5. Write a query that returns the five distributors with the highest average movie budget.*/

SELECT d.company_name AS distributor
FROM distributors AS d
INNER JOIN specs AS s
ON d.distributor_id = s.domestic_distributor_id
INNER JOIN revenue AS r
ON s.movie_id = r.movie_id
GROUP BY distributor
ORDER BY AVG(r.film_budget) DESC
LIMIT 5;

--Answer: Walt Disney, Sony Pictures, Lionsgate, DreamWorks, and Warner Bros.

/*6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?*/

SELECT s.film_title, r.imdb_rating
FROM specs AS s
INNER JOIN distributors AS d
ON s.domestic_distributor_id = d.distributor_id
INNER JOIN rating AS r
USING(movie_id)
WHERE d.headquarters NOT LIKE '%, CA'
ORDER BY r.imdb_rating DESC;

--Answer: 2 movies - Dirty Dancing

/*7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?*/

SELECT
    CASE WHEN s.length_in_min >= 120 THEN 'Over 2 Hours'
        ELSE 'Under 2 Hours'
    	END AS length_category,
    AVG(r.imdb_rating) AS avg_rating
FROM specs AS s
INNER JOIN rating AS r 
USING(movie_id)
GROUP BY length_category
ORDER BY avg_rating DESC;

--Answer: Over 2 hours