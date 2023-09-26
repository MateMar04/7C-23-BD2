use sakila;


CREATE PROCEDURE GetCopies(IN f_id INT, IN s_id INT)
BEGIN
    SELECT f.title, count(*)
    from inventory as i
             INNER JOIN film f on i.film_id = f.film_id
    where i.film_id = f_id
      AND store_id = s_id
    group by f.title;
END;

CALL GetCopies(1, 1);




CREATE PROCEDURE getCountryCustomers(IN c_id INT, OUT customers_list TEXT)
BEGIN

    DECLARE result TEXT DEFAULT '';
    DECLARE add_sep BOOL DEFAULT FALSE;
    DECLARE c_first_name VARCHAR(255) DEFAULT '';
    DECLARE c_last_name VARCHAR(255) DEFAULT '';
    DECLARE done INT DEFAULT 0;

    DECLARE customer_cursor CURSOR FOR
        SELECT first_name, last_name
        FROM customer
                 INNER JOIN sakila.address a on customer.address_id = a.address_id
                 INNER JOIN sakila.city c on a.city_id = c.city_id
                 INNER JOIN sakila.country c2 on c.country_id = c2.country_id
        WHERE c2.country_id = c_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN customer_cursor;
    customers_loop:
    LOOP

        FETCH customer_cursor INTO c_first_name, c_last_name;
        IF done = 1 THEN
            LEAVE customers_loop;
        end if;

        IF add_sep = TRUE THEN
            SET result = CONCAT(result, ';');
        end if;

        SET add_sep = TRUE;

        SET result = CONCAT(result, c_first_name, ' ', c_last_name);

    end loop;
    CLOSE customer_cursor;

    SET customers_list = result;

END;

CALL getCountryCustomers(2, @result);
SELECT @result;



/* La funcion inventory_in_stock devuelve un tinyint(1) (Verdadero o falso). En la funcion se declaran dos variables,
   una de ellas contiene el numero de rentals de la film y la otra para todos los rentals que tengan una
   return_date faltante (solo los elementos con el id que se paso como parametro). Si hay algun item del inventario que
   cuenta con una return_date devuelve 1 si ninguno de los items tiene return_date devuelve 0 */

SET @result = inventory_in_stock(10);
SELECT @result;

SET @result = inventory_in_stock(11);
SELECT @result;

SET @result = inventory_in_stock(12);
SELECT @result;




/* El stored procedure film_in_stock devuelve la cantidad de peliculas que tengan
   el mismo id que se le pasa como parametro en la tienda que se le pasa como parametro */

CALL film_in_stock(1, 1, @result);
SELECT @result;

CALL film_in_stock(2, 2, @result);
SELECT @result;

CALL film_in_stock(2, 3, @result);
SELECT @result;