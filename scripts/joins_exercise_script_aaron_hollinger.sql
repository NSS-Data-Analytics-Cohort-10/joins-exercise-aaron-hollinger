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



-- Write a query that returns the five distributors with the highest average movie budget.

-- How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

-- Which have a higher average rating, movies which are over two hours long or movies which are under two hours?