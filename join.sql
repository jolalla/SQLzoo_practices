-- matchid and player name for all goals scored by Germany

SELECT matchid, player 
FROM goal 
WHERE teamid = 'GER';

-- From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.


SELECT id,
       stadium,
       team1,
       team2
FROM   game
       JOIN goal
         ON goal.matchid = game.id
WHERE  matchid = 1012
GROUP  BY id,
          stadium,
          team1,
          team2;

-- Show the player, teamid, stadium and mdate for every German goal.

SELECT player,
       teamid,
       stadium,
       mdate
FROM   game
       JOIN goal
         ON  game.id = goal.matchid 
WHERE  teamid = 'GER';


-- Show the team1, team2 and player for every goal scored by a player called Mario

SELECT team1, team2, player
FROM   game
       JOIN goal
         ON  game.id = goal.matchid 
WHERE  player like 'Mario%';

-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach, gtime
FROM goal 
        JOIN eteam 
          ON goal.teamid = eteam.id
 WHERE gtime<=10;

-- List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

 SELECT mdate,
       teamname
FROM   game
       JOIN eteam
         ON eteam.id = game.team1
WHERE  eteam.coach LIKE 'Fernando Santos';

-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT player
FROM   goal
       JOIN game
         ON goal.matchid = game.id
WHERE  stadium = 'National Stadium, Warsaw' ;

-- Show the name of all players who scored a goal against German

SELECT DISTINCT player
FROM   game
       JOIN goal
         ON matchid = id
WHERE  ( team1 = 'GER'
          OR team2 = 'GER' )
       AND goal.teamid != 'GER' ;

-- Show teamname and the total number of goals scored 

SELECT teamname,
       Count(gtime)
FROM   eteam
       JOIN goal
         ON id = teamid
GROUP  BY teamname
ORDER  BY teamname;

-- Show the stadium and the number of goals scored in each stadium.
SELECT stadium,
       Count(gtime)
FROM   game
       JOIN goal
         ON goal.matchid = game.id
GROUP  BY stadium;

-- For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid,
       mdate,
       Count(gtime)
FROM   game
       JOIN goal
         ON matchid = id
WHERE  ( team1 = 'POL'
          OR team2 = 'POL' )
GROUP  BY mdate,
          matchid; 

-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid,
       mdate,
       Count(gtime)
FROM   goal
       JOIN game
         ON game.id = goal.matchid
WHERE  teamid = 'GER'
        OR teamid = 'GER'
GROUP  BY matchid,
          mdate; 


-- List every match with the goals scored by each team as shown

SELECT mdate,
  team1, 
  sum(CASE 
WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
team2,
  sum(CASE 
WHEN teamid=team2 THEN 1 ELSE 0 END) score2
FROM
    game LEFT JOIN goal ON (id = matchid)
    GROUP BY goal.matchid, mdate,team1,team2
    ORDER BY mdate, matchid, team1, team2;