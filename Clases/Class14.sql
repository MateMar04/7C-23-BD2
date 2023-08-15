
USE SAKILA;

SELECT FIRST_NAME, LAST_NAME, A.ADDRESS, C.CITY
FROM CUSTOMER
         INNER JOIN SAKILA.ADDRESS A ON CUSTOMER.ADDRESS_ID = A.ADDRESS_ID
         INNER JOIN SAKILA.CITY C ON A.CITY_ID = C.CITY_ID
         INNER JOIN SAKILA.COUNTRY C2 ON C.COUNTRY_ID = C2.COUNTRY_ID
WHERE C2.COUNTRY = 'ARGENTINA';

SELECT F.TITLE,
       L.NAME,
       CASE
           WHEN F.RATING = 'G' THEN 'G (GENERAL AUDIENCES) – ALL AGES ADMITTED.'
           WHEN F.RATING = 'PG'
               THEN 'PG (PARENTAL GUIDANCE SUGGESTED) – SOME MATERIAL MAY NOT BE SUITABLE FOR CHILDREN.'
           WHEN F.RATING = 'PG-13'
               THEN 'PG-13 (PARENTS STRONGLY CAUTIONED) – SOME MATERIAL MAY BE INAPPROPRIATE FOR CHILDREN UNDER 13.'
           WHEN F.RATING = 'R' THEN 'R (RESTRICTED) – UNDER 17 REQUIRES ACCOMPANYING PARENT OR ADULT GUARDIAN.'
           WHEN F.RATING = 'NC-17' THEN 'NC-17 (ADULTS ONLY) – NO ONE 17 AND UNDER ADMITTED.'
           END AS 'RATING'
FROM FILM AS F
         INNER JOIN SAKILA.LANGUAGE L ON F.LANGUAGE_ID = L.LANGUAGE_ID;


SELECT F.TITLE, F.RELEASE_YEAR
FROM FILM AS F
         INNER JOIN SAKILA.FILM_ACTOR FA ON F.FILM_ID = FA.FILM_ID
         INNER JOIN SAKILA.ACTOR A ON FA.ACTOR_ID = A.ACTOR_ID
WHERE A.FIRST_NAME = UPPER('PENELOPE')
  AND A.LAST_NAME = UPPER('GUINESS');

SELECT F.TITLE,
       CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS 'CUSTOMER_NAME',
       CASE
           WHEN RETURN_DATE > NOW() THEN 'NO'
           WHEN RETURN_DATE <= NOW() THEN 'YES'
           END                                AS 'RETURNED?'
FROM RENTAL
         INNER JOIN SAKILA.CUSTOMER C ON RENTAL.CUSTOMER_ID = C.CUSTOMER_ID
         INNER JOIN SAKILA.INVENTORY I ON RENTAL.INVENTORY_ID = I.INVENTORY_ID
         INNER JOIN SAKILA.FILM F ON I.FILM_ID = F.FILM_ID
WHERE MONTH(RENTAL_DATE) = '05'
   OR '06';

/* Las funciones CAST() y CONVERT() se ysan para cambiar el tipo de dato de determinado valor
   se pueden usar indistintamente en la mayoria de los casos pero hay algunas diferencias a tener en cuenta:
   La duncion CAST() se utiliza para convertir explicitamente una expresion a un tipo de dato especifico, por ejemplo:
*/
SELECT CAST(LENGTH AS NCHAR(3)) AS DURACION
FROM FILM;
/* En este ejemplo la furacion de una pelicula se tansforma a NCHAR (National Char)

   La funcion CONVERT() se usa para cumplir el mismo proposito que CAST() pero provee funcionalidades adicionales
   para manejar estas conversiones
   Ejemplo: */
SELECT CONVERT(LAST_UPDATE, DATE) AS NOMBRE
FROM FILM;
/* En este ejemplo se CONVERT() convierte un valor de formato TIMESTAMP a DATE

   LAS PRINCIPALES DIFERENCIAS:
   CONVERSION DE CONJUNTOS DE CARACTERES: Si se necesitan realizar conversiones de conjuntos de caracteres junto con la
   conversionde tipo de datos se usa CONVERT(), ya que permite especificar el conjunto de caracteres utizando la palabra
   USING.
   COMPATIBILIDAD: CAST() es un standard SQL y ampliamente compatible en diferentes sistemas de bases de datos, mientras
   que CONVERT() es especifico de MySQL. Por temas de portabilidad se prefiere utilizar CAST() */

/* Las funciones NLV(), ISNULL(), IFNULL() y COALESCE() se utilizan en distintos motores de bases de datos para tratar
   los valores nulos o desconocidos en las consultas.

   NLV():
   Es especifica de Oracle. Se utiliza para remplazar un calor nulo por otr calor especificado. Ejemplo:
   SELECT NVL(columna, 'DESCONOCIDO') FROM tabla;

   ISNULL():
   Es especifica de Microsoft SQL Server. como NLV() se utiliza para evaluar si una expresion es nula
   y en caso afirmativo, devolver un valor alternativo. EJEMPLO:
   SELECT ISNULL(columna, 'DESCONOCIDO') FROM tabla;

   IFNULL():
   Es especifica de MySQL. Igual que las funciones anteriores, se utiliza para remplazar un valor nulo por otro valor.
   EJEMPLO: */
SELECT IFNULL(original_language_id, 'DESCONOCIDO')
FROM FILM;
/* Este ejemplo busca todos los original_langueage_id y los replaza por 'DESCONOCIDO'

   COALESCE():
   Es mas generica y compatible con mas motores de bases de datos. Se utiliza para retornar el primer valor no nulo
   en una lista de expresiones. EJEMPLO:
   */
SELECT FILM_ID, COALESCE(original_language_id, 'NO DATA') as 'ORIGINAL_LANGUAGE'
FROM FILM;
/* En este ejemplo la funcion evalua la columna title, si este valor es nulo se remplaza con 'No title'.
   Vale recalcar que en la parte del valor a replazar se puede poner otra columna para que esta se remplaze con
   el valor de la otra columna. */



