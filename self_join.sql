/*select count(id) from stops;*/

SELECT Count(id)
FROM   stops; 

/*
Find the id value for the stop 'Craiglockhart'*/

SELECT( id )
FROM   stops
WHERE  NAME = 'Craiglockhart'; 

/*Give the id and the name for the stops on the '4' 'LRT' service.*/

SELECT id,
       NAME
FROM   stops
       JOIN route
         ON stops.id = route.stop
WHERE  num = '4'
       AND company = 'LRT' 

/*The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). 
Run the query and notice the two services that link these stops have a count of 2. 
Add a HAVING clause to restrict the output to these two routes.*/

SELECT company,
       num,
       Count(*)
FROM   route
WHERE  stop = 149
        OR stop = 53
GROUP  BY company,
          num
HAVING Count(*) = 2; 


/*Show the services from Craiglockhart to London Road.*/

SELECT a.company,
       a.num,
       a.stop,
       b.stop
FROM   route a
       JOIN route b
         ON ( a.company = b.company
              AND a.num = b.num )
WHERE  a.stop = (SELECT id
                 FROM   stops
                 WHERE  NAME = 'Craiglockhart')
       AND b.stop = (SELECT id
                     FROM   stops
                     WHERE  NAME = 'London Road') 