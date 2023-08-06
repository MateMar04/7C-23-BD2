use sakila;

CREATE OR REPLACE VIEW list_of_customers AS
SELECT C.customer_id,
       CONCAT(C.first_name,
              C.last_name) AS 'FULLNAME',
       A.postal_code,
       A.phone,
       CI.city,
       CO.country,
       C.active,
       S.store_id
FROM customer AS C
         INNER JOIN address AS A ON C.address_id = A.address_id
         INNER JOIN city AS CI ON A.city_id = CI.city_id
         INNER JOIN country AS CO ON CI.country_id = CO.country_id
         INNER JOIN store S on A.address_id = S.address_id;


CREATE OR REPLACE VIEW list_of_customers AS
SELECT C.customer_id,
       CONCAT(C.first_name, ' ', C.last_name) AS 'FULLNAME',
       A.address,
       A.postal_code,
       A.phone,
       CI.city,
       COUN.country,
       CASE
           WHEN C.active = 1 THEN 'ACTIVE'
           WHEN C.active = 0 THEN 'INACTIVE'
           END                                AS 'is_active',
       C.store_id
FROM customer AS C
         INNER JOIN address AS A ON C.address_id = a.address_id
         INNER JOIN city AS CI ON A.city_id = CI.city_id
         INNER JOIN country AS COUN ON CI.country_id = COUN.country_id;

SELECT *
FROM list_of_customers;

CREATE OR REPLACE VIEW film_details AS
SELECT F.film_id,
       F.title,
       F.description,
       C.name,
       F.replacement_cost,
       F.length,
       F.rating,
       GROUP_CONCAT(A.first_name, ' ', A.last_name)
FROM film as F
         INNER JOIN film_category AS FC ON F.film_id = FC.film_id
         INNER JOIN category AS C ON FC.category_id = C.category_id
         INNER JOIN film_actor AS FA ON F.film_id = FA.film_id
         INNER JOIN actor as A ON FA.actor_id = A.actor_id
GROUP BY F.film_id, F.title, F.description, C.name, F.replacement_cost, F.length, F.rating;

SELECT *
FROM film_details;

CREATE OR REPLACE VIEW sales_by_film_category AS
SELECT C.name,
       COUNT(R.rental_id) AS 'total_rental'
FROM category AS C
         INNER JOIN film_category AS FC ON C.category_id = FC.category_id
         INNER JOIN film AS F ON FC.film_id = F.film_id
         INNER JOIN inventory AS I ON F.film_id = I.film_id
         INNER JOIN rental AS R ON I.inventory_id = R.inventory_id
GROUP BY C.name;


SELECT *
FROM sales_by_film_category;

CREATE OR REPLACE VIEW actor_information AS
SELECT A.actor_id,
       A.first_name,
       A.last_name,
       COUNT(DISTINCT FA.film_id) AS count_of_films
FROM actor AS A
         LEFT JOIN film_actor AS FA ON A.actor_id = FA.actor_id
GROUP BY A.actor_id, A.first_name, A.last_name;

/*
SELECT A.actor_id,
       A.first_name,
       A.last_name,
       (SELECT COUNT(DISTINCT FA.film_id) FROM film_actor AS FA WHERE A.actor_id = FA.actor_id) AS count_of_films
FROM actor AS A;
 */

SELECT *
FROM actor_information;

/* No lo hice con una subquery, ya que la manera mas facil de pensarla resulto ser un GROUP BY.
   Selecciono los valores pedidos por la consigna (actor_id, first_name y last_name),
   luego hago un LEFT JOIN Para "unir" todos los actores por mas de que no no hayan actuado
   en ninguna pelicula (deberia devolver 0 como count_of_films), y luego hago un COUNT(DISTINCT film_id)
   para que cuente todos los IDs distintos de peliculas en las que aparece el ID del actor.
   Finalmente el GROUP BY agrupa los valores (actor_id, first_name y last_name) para que no aparezca una fila
   con los mismos valores por cada pelicula actuada por ese actor. De todas formas dejo la query hecha con subquery
   comentada */

/* Una MATERIALIZED VIEW es un objeto de bases de datos que almacena los resultados de una consulta a una tabla.
   Estas vistas se ejecutan al arrancar la base de datos, por lo que ofrece ventajas
   en terminos de velocidad y eficiencia, ya que si se necesita acceder frecuentemente a esos datos, estos ya
   estan precargados desde el arranque de la base de datos. Tambien es reutillizable por lo que tambien ahorra tiempo
   a la hora de armar una consultas, tambien se actualizan si los datos de la tabla consultada cambian.
   Las alternativas a usarse pueden ser indices (estructuras de datos optimizadas),
   tablas de resumen (cuando se neecesitan generar estadisticas, promedios, etc), particionamiento de tablas,
   materializacion del sistema en general
   Algunos motores de bases de datos que admiten vistas materializadas son: Oracle Database, PostgreSQL, 
   Microsoft SQL Server, IBM Db2, MySQL, Amazon Redshift, Snowflake, Cassandra, entre otros */
