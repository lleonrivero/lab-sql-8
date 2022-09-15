## Lab | SQL Join (Part II) ##

USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country.

SELECT * FROM sakila.store;
SELECT store_id AS 'Store', address AS 'Address', district AS 'District', city_id AS 'City'
FROM sakila.store s
JOIN sakila. address a USING (address_id);

-- 2. Write a query to display how much business, in dollars, each store brought in.

SELECT * FROM sakila.customer;
SELECT * FROM sakila.payment;

SELECT store_id AS 'Store', SUM(amount) AS 'Turnover'
FROM sakila.customer c
JOIN sakila.payment p USING (customer_id)
GROUP BY store_id;

-- 3. Which film categories are longest?


SELECT * FROM sakila.film;
SELECT * FROM sakila.film_category;
SELECT * FROM sakila.category;

SELECT avg(length) AS 'Average length', name AS 'Genre' 
FROM sakila.film f
JOIN sakila.film_category fc USING (film_id)
JOIN sakila.category c
ON fc.category_id = c.category_id
GROUP BY name
ORDER BY avg(length) DESC;

-- 4. Display the most frequently rented movies in descending order.
SELECT * FROM sakila.inventory;
SELECT * FROM sakila.film;
SELECT * FROM sakila.rental;

SELECT title AS 'Title', count(rental_id) AS 'Frequency'
FROM sakila.rental r
JOIN sakila.inventory i USING (inventory_id)
JOIN sakila.film f USING (film_id)
GROUP BY title
ORDER BY count(rental_id) DESC;


-- 5. List the top five genres in gross revenue in descending order.

SELECT SUM(amount) AS 'Gross revenue', name AS 'Genre' 
FROM sakila.payment p
JOIN sakila.rental r USING (rental_id)
JOIN sakila.inventory i USING (inventory_id)
JOIN sakila.film_category fc USING (film_id)
JOIN sakila.category c USING (category_id)
GROUP BY name
ORDER BY SUM(amount) DESC
LIMIT 5;

-- 6. Is "Academy Dinosaur" available for rent from Store 1?

SELECT * FROM sakila.inventory;
SELECT * FROM sakila.film;
SELECT * FROM sakila.store;

SELECT store_id AS 'Store', title AS 'Film', count(title) AS 'Copies available' 
FROM sakila.inventory i
JOIN sakila.film f USING (film_id)
JOIN sakila.store s USING (store_id)
WHERE title = 'ACADEMY DINOSAUR' AND store_id = 1
GROUP BY title;

-- 7. Get all pairs of actors that worked together. 
-- I think this one is expected to be done joining the same table, but I'm still quite confused about how to deal with it.
-- My solution is showing the actors that appeared in each film, but not pairs. 

SELECT title, last_name, first_name
FROM sakila.actor a1
JOIN sakila.film_actor fa USING (actor_id)
JOIN sakila.film f USING (film_id)
ORDER BY title;

-- 8. Get all pairs of customers that have rented the same film more than 3 times. 
-- I have tried several things for this one but I'm not being able to get to the expected output. Not sure how I should proceed. 
SELECT * FROM sakila.customer;
SELECT * FROM sakila.rental;
SELECT * FROM film;
SELECT * FROM inventory;

SELECT r1.customer_id, r1.inventory_id
FROM sakila.rental r1
RIGHT JOIN sakila.rental r2
ON r1.inventory_id = r2.inventory_id AND r1.customer_id <> r2.customer_id 
ORDER BY r1.inventory_id ASC;


-- 9. For each film, list actor that has acted in more films.