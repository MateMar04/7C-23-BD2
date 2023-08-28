use sakila;

select *
from address

SELECT *
FROM address AS a
         INNER JOIN city c ON a.city_id = c.city_id
         INNER JOIN country co ON c.country_id = co.country_id
WHERE postal_code IN ('76022', '22870', '96584', '57380'); -- 71ms


SELECT *
FROM address AS a
         INNER JOIN city c ON a.city_id = c.city_id
         INNER JOIN country co ON c.country_id = co.country_id
WHERE postal_code NOT IN ('76022', '22870', '96584', '57380'); -- 199ms

CREATE INDEX idx_postal_code ON address (postal_code); -- 96ms

SELECT *
FROM address AS a
         INNER JOIN city c ON a.city_id = c.city_id
         INNER JOIN country co ON c.country_id = co.country_id
WHERE postal_code IN ('76022', '22870', '96584', '57380'); -- 58ms


SELECT *
FROM address AS a
         INNER JOIN city c ON a.city_id = c.city_id
         INNER JOIN country co ON c.country_id = co.country_id
WHERE postal_code NOT IN ('76022', '22870', '96584', '57380');
-- 125ms

/* Con el indice, lo que tiene que hacer el motor es encontrar esos valores en el indice
   para obtener las direcciones de las filas de la tabla que contienen las filas con el valor especificado
   en el where. El where busca en el indice, quedan las direcciones de las filas y con esas se buscan en la tabla y
   se devuelven. */

SELECT *
FROM actor
WHERE first_name = 'Tom';

SELECT *
FROM actor
WHERE last_name = 'Wood';

/* La diferencia es practicamente imperceptible en el tiempo de ejecucion pero existe un indice para el apellido */


ALTER TABLE film
    ADD FULLTEXT (description);

SELECT *
FROM film
WHERE description LIKE '%action%';


SELECT *
FROM film
WHERE MATCH(description) AGAINST('action');

/* En cuanto a terminos de performance, en esta base de datos es practicamente imperceptible.
   Un índice FULLTEXT está diseñado para manejar eficientemente consultas basadas en lenguaje natural,
   que implican buscar palabras o frases dentro de las columnas de texto de una tabla */
