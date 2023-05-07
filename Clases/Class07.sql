USE SAKILA;



SELECT title, rating, length
FROM film
WHERE length <= (SELECT MIN(length) FROM film);



SELECT title, rating, length
FROM film AS f1
WHERE length <= (SELECT MIN(length) FROM film)
  AND NOT EXISTS(SELECT * FROM film AS f2 WHERE f2.film_id <> f1.film_id AND f2.length <= f1.length);



SELECT first_name, last_name, a.address, MIN(p.amount) AS lowest_payment
FROM customer
         INNER JOIN payment as p ON customer.customer_id = p.customer_id
         INNER JOIN address a on customer.address_id = a.address_id
GROUP BY first_name, last_name, a.address;



SELECT first_name, last_name, a.address, MIN(p.amount) AS lowest_payment, MAX(p.amount) AS highest_payment
from customer
         INNER JOIN payment p on customer.customer_id = p.customer_id
         INNER JOIN address a on customer.address_id = a.address_id
GROUP BY first_name, last_name, a.address;
