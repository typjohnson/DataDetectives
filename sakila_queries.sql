USE sakila;
SHOW TABLES;

SELECT * FROM film
WHERE title = 'ACE GOLDFINGER';


select * from film 
order by length desc;

select first_name, last_name, address from customer, address
where customer.address_id = address.address_id;

select last_name, first_name from staff;
select concat(last_name, ', ', first_name) as name from staff;




select * from film
order by title;

select title, description, release_year, length, rating from film
where title = 'KENTUCKIAN GIANT';


-- Selecting the amount of customers 
select count(*) as num_customers
from customer;

-- Selecting inactive vs active customers
select count(*) as active
from customer 
group by active;

-- Finding the average amount a customer spends on a rental
select round(avg(amount),2) as average_amount from payment;

-- Finding the most spent by a customer on a rental
select max(amount) as max_payment from payment;


-- Selecting actor name and ordering by last_name descending
select concat(last_name, ', ', first_name) as actor_name from actor order by last_name desc;
-- Selecting actor name and ordering by last_name ascending
select concat(last_name, ', ', first_name) as actor_name from actor order by last_name asc;

-- Selecting actor name and ordering by last_name descending with m or v in the name
select concat(last_name, ', ', first_name) as actor_name from actor 
where last_name like 'M%' or last_name like 'V%'
order by last_name asc;

-- Selecting actor name and ordering by last_name descending with between m and v inclusive
select concat(last_name, ', ', first_name) as actor_name from actor 
where last_name between 'M%' and 'Vz%'
order by last_name asc;

-- Selecting the number of customer_id and their amount of rentals
select customer_id, count(customer_id) as 'Number of Rentals' from rental
group by customer_id
order by count(customer_id) desc;

-- MULTI TABLE QUERIES 
-- 1. Getting number of movies in each category 
select name as 'Category', count(film_category.category_id) as 'Amount per Category'
 from category, film_category 
where category.category_id = film_category.category_id
group by name;

-- 2. Doing it with the join method 
select name as 'Category Name', count(film_category.category_id) as 'Amount per Category'
from film_category
inner join category on film_category.category_id = category.category_id
group by name
order by count(film_category.category_id) desc;

-- 3. List of country names and count for cities in each country
select country, count(city) as 'num_cities'
from city, country
where city.country_id = country.country_id
group by country
order by country asc;


-- 4. Repeating the process with join clauses
select country, count(city) as 'num_cities'
from city
inner join country on city.country_id = country.country_id
group by country
order by country asc;

-- 5. Get customer last name, first name, and number of rentals they have
select last_name, first_name, count(rental.customer_id) as 'num_rentals'
from customer, rental
where customer.customer_id = rental.customer_id
group by rental.customer_id
order by count(rental.customer_id) desc;

-- 6. Repeating the process with a join clause
select last_name, first_name, count(rental.customer_id) as 'num rentals' from customer
inner join rental on customer.customer_id = rental.customer_id
group by customer.customer_id
order by count(customer.customer_id) desc nulls last last_name asc;




-- 9. Get the number of films each manager holds.  Use manager staff id to idenify.Name column “num_films”.
select store.manager_staff_id, count(inventory.inventory_id) as "num_films" from inventory
inner join store on store.store_id = inventory.store_id
group by store.manager_staff_id;

-- 10. get number of customers per manager. 
select * from customer;

select store.manager_staff_id, count(customer.customer_id) as "num_customers" from customer
inner join store on store.store_id = customer.store_id
group by store.manager_staff_id
order by store.store_id asc;

-- 11. Get title and film category of each film
select * from film;
select * from film_category;
select * from category;

select film.title, category.name as 'category' from film
inner join film_category on film_category.film_id = film.film_id
inner join category on category.category_id = film_category.category_id
order by category.name asc;

-- 12. get customer name, full address, city, country
select customer.first_name, customer.last_name, address.address, city.city, country.country from customer
inner join address on customer.address_id = address.address_id 
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
order by customer.last_name asc;

-- 13. Selecting inactive customers from china
select customer.first_name, customer.last_name, address.address, city.city, country.country from customer
inner join address on customer.address_id = address.address_id 
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
where country = 'China' and active = 0
order by customer.last_name asc;

-- 14. Getting a list of the titles that each customer has rented
select * from customer;
select * from rental;
select * from film;
select * from inventory;

select * from rental;

select * from payment;

-- 16. getting first, last name, amount of films rented, total amount spend
select customer.first_name, customer.last_name, count(rental.rental_id) as 'num_rented', sum(amount) as 'total_spent' 
from customer
inner join rental on customer.customer_id = rental.customer_id
inner join payment on rental.rental_id = payment.rental_id
group by customer.customer_id
order by customer.last_name asc;

-- 17. doing the same as above but with the customer country and formatting as last name, first name
select customer.last_name, customer.first_name, country, count(rental.rental_id) as 'num_rented', sum(amount) as 'total_spent' 
from customer
inner join rental on customer.customer_id = rental.customer_id
inner join payment on rental.rental_id = payment.rental_id
inner join address on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
group by customer.customer_id
order by customer.last_name asc;


select * from rental;
select * from customer;
select * from country;

-- 12. get customer name, full address, city, country
select country, count(rental_id) from rental
inner join customer on rental.customer_id = rental.customer_id
inner join address on customer.address_id = address.address_id 
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
group by country.country_id
order by count(rental_id) desc
limit 10;



