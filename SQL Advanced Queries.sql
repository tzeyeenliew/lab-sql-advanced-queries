SET sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
USE sakila;

### Q2 For each film, list actor that has acted in more films.

### Credits to Oktay for miraculously simple and elegant code! I couldn't crack the problem using CTE, which is what I construe from the lab instructions, so I had to try another way :(

SELECT F.title,FA.actor_id, CONCAT(b.first_name,' ', b.last_name) AS Name
FROM film AS F
JOIN film_actor FA
USING (film_id)
JOIN actor AS B
USING (actor_id)
GROUP BY film_id
ORDER BY FA.actor_id IN (SELECT * FROM
                        (SELECT actor_id 
						FROM film_actor 
                         GROUP BY actor_id 
                         ORDER BY count(film_id) 
                         DESC 
                         LIMIT 1 ) 
                         AS subtable);