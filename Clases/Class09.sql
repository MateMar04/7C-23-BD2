USE sakila;

SELECT coun.country, COUNT(ci.city) AS CANTIDAD_CIUDADES
FROM country coun
         INNER JOIN city ci ON coun.country_id = ci.country_id
GROUP BY coun.country, coun.country_id
ORDER BY coun.country, coun.country_id;


SELECT coun.country, COUNT(ci.city) AS CANTIDAD_CIUDADES
FROM country coun
         INNER JOIN city ci ON coun.country_id = ci.country_id
GROUP BY coun.country
HAVING COUNT(ci.city) > 10
ORDER BY CANTIDAD_CIUDADES DESC;


SELECT c.first_name,
       c.last_name,
       a.address,
       (SELECT COUNT(*) FROM rental r WHERE c.customer_id = r.customer_id)       AS TOTAL_PELICULAS_RENTADAS,
       (SELECT SUM(p.amount) FROM payment p WHERE c.customer_id = p.customer_id) AS DINERO_GASTADO
FROM customer c
         INNER JOIN address a ON c.address_id = a.address_id
GROUP BY c.first_name, c.last_name, a.address, c.customer_id
ORDER BY DINERO_GASTADO DESC;


SELECT c.name, AVG(f.length) AS PROMEDIO_DURACION
FROM film f
         INNER JOIN film_category fc ON fc.film_id = f.film_id
         INNER JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY PROMEDIO_DURACION DESC;


SELECT f.rating, COUNT(p.payment_id) as VENTAS
FROM film f
         JOIN inventory i ON i.film_id = f.film_id
         JOIN rental r ON r.inventory_id = i.inventory_id
         JOIN payment p ON p.rental_id = r.rental_id
GROUP BY rating
ORDER BY VENTAS DESC;