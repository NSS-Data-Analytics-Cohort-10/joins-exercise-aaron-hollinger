-- -- Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT film_title, release_year, worldwide_gross
FROM specs
LEFT JOIN revenue
USING(movie_id)
ORDER BY worldwide_gross ASC

--Answer: Semi-Tough

-- -- What year has the highest average imdb rating?

SELECT film_title, imdb_rating
FROM specs
LEFT JOIN rating
USING(movie_id)
ORDER BY imdb_rating DESC

--Answer: The Dark Knight

-- What is the highest grossing G-rated movie? Which company distributed it?

SELECT company_name, film_title, imdb_rating, mpaa_rating, worldwide_gross
FROM distributors
LEFT JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
LEFT JOIN rating
USING (movie_id)
LEFT JOIN revenue
USING (movie_id)
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC

--Answer: Toy Story 4

-- Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT company_name, COUNT(film_title) AS movie_count
FROM distributors
FULL JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
GROUP BY company_name
ORDER BY movie_count DESC

-- Write a query that returns the five distributors with the highest average movie budget.

SELECT company_name, ROUND(AVG(film_budget),0) AS avg_budget
FROM distributors
LEFT JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
LEFT JOIN revenue
USING (movie_id)
WHERE film_budget IS NOT NULL
GROUP BY company_name
ORDER BY avg_budget DESC
LIMIT 5;

-- How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

SELECT DISTINCT headquarters
FROM distributors

SELECT company_name, film_title, headquarters, imdb_rating
FROM distributors
LEFT JOIN specs
ON distributors.distributor_id = specs.domestic_distributor_id
LEFT JOIN rating
USING (movie_id)
WHERE headquarters NOT LIKE '%CA%'
ORDER BY imdb_rating DESC

--Answer: Dirty Dancing has the highest rating


-- Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

SELECT
    movie_length_category,
    AVG(imdb_rating) AS average_rating
FROM (
    SELECT
        CASE
            WHEN specs.length_in_min > 120 THEN 'Over Two Hours'
            ELSE 'Under Two Hours'
        END AS movie_length_category,
        rating.imdb_rating
    FROM
        specs
    JOIN
        rating ON specs.movie_id = rating.movie_id
) AS subquery
GROUP BY
    movie_length_category;

-- Answer: Movies over two hours have higher average rating
