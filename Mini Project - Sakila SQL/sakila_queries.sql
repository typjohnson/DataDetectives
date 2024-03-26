USE sakila;
SHOW TABLES;


-- 1. Select all titles from film ordered by alphabet
SELECT title FROM film
ORDER BY title asc;

-- 2. Get the description, release year, length, rating for Kentuckian Giant
SELECT description, release_year, length, rating FROM film 
WHERE title = 'KENTUCKIAN GIANT';

select first_name, last_name, address from customer, address
where customer.address_id = address.address_id;
-- 3. Getting the first and last name of each employee
SELECT last_name, first_name FROM staff;

-- 4. Selecting employee name as combined
SELECT CONCAT(last_name, ', ', first_name) AS name FROM staff;

-- 5. Getting the total number of customers
SELECT COUNT(*) AS num_customers FROM customer;

-- 6. Getting inactive vs active customers in system
SELECT COUNT(*) AS active FROM customer GROUP BY active;

-- 7. Getting the average amount a customer spends on a rental
SELECT ROUND(AVG(AMOUNT),2) AS average_amount FROM payment;

-- 8. Getting the max amount a customer has spent on a rental
SELECT MAX(amount) AS max_payment FROM payment;

-- 9. Getting the actor name and ordering by last name descending
SELECT CONCAT(last_name, ', ', first_name) AS actor_name FROM actor ORDER BY last_name desc;

-- 10. Getting actor name and ordering it by last name ascending
SELECT CONCAT(last_name, ', ', first_name) AS actor_name FROM actor ORDER BY last_name asc;

-- 11. Getting actor name with a m or v in beg of name, and ordering it by last name descending
SELECT CONCAT(last_name, ', ', first_name) AS actor_name FROM actor
WHERE last_name LIKE 'M%' OR last_name LIKE 'V%' ORDER BY last_name ASC;


-- 12. Getting actor name and ordering by last name, where name between m and v inclusive
SELECT CONCAT(last_name, ', ', first_name) AS actor_name FROM actor
WHERE last_name BETWEEN 'M%' and 'Vz%' ORDER BY last_name asc;

-- 13. Getting the customer id and number of rentals they have
SELECT customer_id, COUNT(customer_id) as 'Number of Rentals' FROM rental
GROUP BY customer_id ORDER BY count(customer_id) desc;


-- MULTI TABLE QUERIES 
-- 1. Getting number of movies in each category 
SELECT name AS 'category', COUNT(film_category.category_id) AS 'num_films'
FROM category, film_category
WHERE category.category_id = film_category.category_id 
GROUP BY name
ORDER BY name;

-- 2. Getting number of movies in each category with join method
SELECT name AS 'category', COUNT(film_category.category_id) AS 'num_films' FROM film_category
INNER JOIN category ON film_category.category_id = category.category_id
GROUP BY name
ORDER BY name;

-- 3. Country name and count for cities in each country
SELECT country, COUNT(city) AS 'num_cities'
FROM city, country
WHERE city.country_id = country.country_id
GROUP BY country
ORDER BY country ASC;




-- 4. Getting country name and count for cities with join clause
SELECT country, COUNT(city) AS 'num_cities' FROM city
INNER JOIN country ON city.country_id = country.country_id
GROUP BY country ORDER BY country ASC;

-- 5. Get customer last name, first name, and number of rentals they have
SELECT last_name, first_name, COUNT(rental.customer_id) AS 'num_rentals' FROM customer, rental
WHERE customer.customer_id = rental.customer_id
GROUP BY rental.customer_id 
ORDER BY count(rental.customer_id) DESC, customer.last_name ASC;

-- 6. Getting customer name and number of rentals with a join 
SELECT last_name, first_name, COUNT(rental.customer_id) AS 'num_rentals' FROM customer
INNER JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY rental.customer_id
ORDER BY count(rental.customer_id) DESC, customer.last_name ASC;

-- 7. Getting customer last_name, first_name, and amount spent on rentals
SELECT last_name, first_name, SUM(payment.amount) FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY SUM(payment.amount) DESC, last_name ASC;

-- 8. Getting the number of actors in each film 
SELECT title, COUNT(actor_id) AS 'num_actors' FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.film_id
ORDER BY COUNT(actor_id) DESC;


-- 9. Get the number of films each manager holds.  Use manager staff id to idenify.Name column “num_films”.
SELECT store.manager_staff_id, COUNT(inventory.inventory_id) AS 'num_films' FROM inventory
INNER JOIN store ON store.store_id = inventory.store_id
GROUP BY store.manager_staff_id;

-- 10. Getting number of customers per manager
SELECT store.manager_staff_id, COUNT(customer.customer_id) AS 'num_customers' FROM customer
INNER JOIN store ON store.store_id = customer.store_id
GROUP BY store.manager_staff_id
ORDER BY store.store_id ASC;

-- 11. Getting the titles and film category on each film
SELECT film.title, category.name AS 'category' FROM film
INNER JOIN film_category ON film_category.film_id = film.film_id
INNER JOIN category ON category.category_id = film_category.category_id
ORDER BY category.name ASC;

-- 12. Getting customer name, full address, city, country
SELECT customer.first_name, customer.last_name, address.address, city.city, country.country FROM customer
INNER JOIN address ON customer.address_id = address.address_id 
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
ORDER BY customer.last_name ASC;

-- 13. Selecting inactive customers from china
SELECT customer.first_name, customer.last_name, address.address, city.city, country.country FROM customer
INNER JOIN address ON customer.address_id = address.address_id 
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
WHERE country = 'China' AND active = 0
ORDER BY customer.last_name ASC;

-- 14. Getting a list of the titles each customer has rented
SELECT customer.last_name, customer.first_name, film.title FROM customer
INNER JOIN rental on customer.customer_id = rental.customer_id
INNER JOIN inventory on rental.inventory_id = inventory.inventory_id
INNER JOIN film on inventory.film_id = film.film_id
ORDER BY customer.last_name ASC, film.title ASC;

-- 15. Getting a list of the titles each customer has rented and the category
SELECT customer.last_name, customer.first_name, film.title, category.name as 'category' FROM customer
INNER JOIN rental ON customer.customer_id = rental.customer_id
INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
INNER JOIN film ON inventory.film_id = film.film_id
INNER JOIN film_category ON film_category.film_id = film.film_id
INNER JOIN category ON category.category_id = film_category.category_id
ORDER BY customer.last_name ASC, film.title ASC;

-- 16. getting first, last name, amount of films rented, total amount spend
SELECT customer.first_name, customer.last_name, count(rental.rental_id) AS 'num_rented', sum(amount) AS 'total_spent' 
FROM customer
INNER JOIN rental ON customer.customer_id = rental.customer_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY customer.customer_id
ORDER BY customer.last_name ASC;

-- 17. doing the same as above but with the customer country and formatting as last name, first name
SELECT customer.last_name, customer.first_name, country, count(rental.rental_id) AS 'num_rented', sum(amount) AS 'total_spent' 
FROM customer
INNER JOIN rental ON customer.customer_id = rental.customer_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
GROUP BY customer.customer_id
ORDER BY customer.last_name ASC;



-- 
SELECT country, SUM(payment.amount) AS total_amount FROM payment
INNER JOIN customer ON payment.customer_id = customer.customer_id
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
GROUP BY country
ORDER BY SUM(payment.amount) DESC
LIMIT 10;