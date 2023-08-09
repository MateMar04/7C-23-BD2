USE sakila;

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date, last_update)
VALUES (1, 'MATEO', 'MARCHISONE', 'mateo.marchisone@gmail.com',
        (SELECT MAX(A.address_id)
         FROM address AS A
                  INNER JOIN city AS CI ON A.city_id = CI.city_id
                  INNER JOIN country CO ON CI.country_id = CO.country_id
         WHERE CO.country = 'United States'), 1, CURRENT_TIME(), CURRENT_TIMESTAMP());


INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (CURRENT_DATE(), (SELECT I.inventory_id
                         FROM inventory AS I
                                  INNER JOIN film AS F on I.film_id = F.film_id
                         WHERE F.title = 'ACADEMY DINOSAUR'
                         LIMIT 1), 1, CURRENT_DATE(), (SELECT MAX(staff_id)
                                                       FROM staff
                                                       WHERE store_id = 2));


UPDATE film
SET release_year = CASE rating
                       WHEN 'G' THEN '2001'
                       WHEN 'PG' THEN '2004'
                       ELSE release_year END;


SELECT F.film_id
FROM film as F
         INNER JOIN inventory AS I on I.film_id = F.film_id
         INNER JOIN rental AS R on I.inventory_id = R.inventory_id
WHERE R.return_date > CURRENT_DATE()
ORDER BY rental_date DESC
LIMIT 1;

DELETE
FROM film
WHERE film_id = 1;
/* No se puede eliminar la pelicula ya que tiene claves foraneas que dependen del id de la clave primaria
   de la pelicula.
   El codigo necesario para poder borrar una film es el siguiente: */
START TRANSACTION;

DELETE
FROM film_actor
WHERE film_id = 1;

DELETE
FROM film_category
WHERE film_id = 1;

DELETE
FROM rental
WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 1)

DELETE
FROM inventory
WHERE film_id = 1;

DELETE
FROM film
WHERE film_id = 1;

ROLLBACK; 
/* El rolback esta puesto para poder probar que funcione sin que se borre la informacion.
Para que se borre hay que remplazarlo por COMMIT; */ 



INSERT INTO rental (rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES (CURRENT_DATE(), (SELECT I.inventory_id
                         FROM inventory AS I
                         WHERE NOT EXISTS(SELECT *
                                          FROM rental AS R
                                          WHERE R.inventory_id = I.inventory_id
                                            AND R.return_date < CURRENT_DATE())
                         LIMIT 1), 1, CURRENT_DATE(), 1);
INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (1, 1, (SELECT LAST_INSERT_ID()), 10.2, CURRENT_DATE)
