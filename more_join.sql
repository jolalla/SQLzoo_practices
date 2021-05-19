-- List the films where the yr is 1962 [Show id, title]

SELECT id,
       title
FROM   movie
WHERE  yr = 1962;

-- Give year of 'Citizen Kane'

SELECT yr 
FROM movie 
WHERE title = 'Citizen Kane';

-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

SELECT id,
       title,
       yr
FROM   movie
WHERE  title LIKE '%Star Trek%'
ORDER BY yr;

-- What id number does the actress 'Glenn Close' have?

SELECT id
FROM   actor
WHERE  name = 'Glenn Close'; 

-- What is the id of the film 'Casablanca'

SELECT id 
FROM movie 
WHERE title = 'Casablanca';

-- Obtain the cast list for the film 'Casablanca'

SELECT actor.name
FROM   actor
       JOIN casting
         ON casting.actorid = actor.id
       JOIN movie
         ON movie.id = casting.movieid
WHERE  movie.title = 'Casablanca'; 


-- Obtain the cast list for the film 'Alien'

SELECT actor.name
FROM   actor
       JOIN casting
         ON casting.actorid = actor.id
       JOIN movie
         ON movie.id = casting.movieid
WHERE  movie.title = 'Alien'; 

-- List the films in which 'Harrison Ford' has appeared

SELECT movie.title
FROM   movie
       JOIN casting
         ON casting.movieid = movie.id
       JOIN actor
         ON actor.id = casting.actorid
WHERE  actor.name = 'Harrison Ford'; 

 -- List the films where 'Harrison Ford' has appeared - but not in the starring role.

SELECT movie.title
FROM   movie
       JOIN casting
         ON casting.movieid = movie.id
       JOIN actor
         ON actor.id = casting.actorid
WHERE  actor.name = 'Harrison Ford'; 
AND casting.ord != 1;

-- List the films together with the leading star for all 1962 films.

SELECT movie.title,
       actor.name
FROM   movie
       JOIN casting
         ON casting.movieid = movie.id
       JOIN actor
         ON actor.id = casting.actorid
WHERE  movie.yr = 1962
       AND casting.ord = 1
GROUP  BY movie.title,
          actor.name; 

-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies

SELECT yr, COUNT(title) FROM
    movie JOIN casting ON movie.id=movieid
          JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING Count(title) > 1
ORDER BY Count(title) DESC;

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.

SELECT title,
       name
FROM   movie,
       casting,
       actor
WHERE  movieid = movie.id
       AND actorid = actor.id
       AND ord = 1
       AND movieid IN (SELECT movieid
                       FROM   casting,
                              actor
                       WHERE  actorid = actor.id
                              AND name = 'Julie Andrews'); 


-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.

SELECT actor.name
FROM   casting
       JOIN actor
         ON actorid = actor.id
WHERE  casting.ord = 1
GROUP  BY actor.name
HAVING Count(movieid) >= 15; 

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

SELECT movie.title,
       Count(ord)
FROM   movie
       JOIN casting
         ON movie.id = casting.movieid
       JOIN actor
         ON actor.id = casting.actorid
WHERE  movie.yr = 1978
GROUP  BY movie.title
ORDER  BY Count(ord) DESC,
          title; 

-- List all the people who have worked with 'Art Garfunkel'.

SELECT DISTINCT actor.name
FROM   actor
       JOIN casting
         ON id = actorid
WHERE  movieid IN(SELECT DISTINCT movieid
                  FROM   casting
                         JOIN actor
                           ON actorid = actor.id
                  WHERE  actor.name = 'Art Garfunkel')
       AND actor.name != 'Art Garfunkel'; 

