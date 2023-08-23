INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, jobTitle)
VALUES (1037, 'Marchisone', 'Mateo', 'x7357', NULL, '1', 'CEO');
/* No se puede ingresar un valor nulo en el campo de email */

UPDATE employees
SET employeeNumber = employeeNumber - 20;
/* Le resta 20 a todos los IDs */

UPDATE employees
SET employeeNumber = employeeNumber + 20;
/* Intenta sumarle 20 a todos los ids pero se encuentra que si le
   suma 20 a uno termina teniendo el mismo valor que el otro
   (no puede haber dos filas con la misma primary key) */

ALTER TABLE employees
    ADD age INT CHECK ( age BETWEEN 16 AND 70);

/* La tabla films tiene peliculas, y la tabla film_actor es una tabla intermedia que
   contiene la relacion entre la pelicula y los actores que actuaron en esa determinada pelicula.
   Esta relacion es asi ya que es una relacion de muchos a muchos (una pelicula puede tener
   muchos actores, y un actor puede tener muchas peliculas). El caracter de esta realcion
   no permite que sea solamente una clave foranea en otra tabla, ya que habria que concatenar o
   poner muchos valores en un campo o poner un valor nulo (malas practicas) */


ALTER TABLE employees
    ADD lastUpdate datetime;
ALTER TABLE employees
    ADD lastUpdateUser VARCHAR(100);

CREATE TRIGGER employees_before_update
    BEFORE UPDATE
    ON employees
    FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = NOW(),
        NEW.lastUpdateUser = USER();
END;

CREATE TRIGGER employees_before_insert
    BEFORE INSERT
    ON employees
    FOR EACH ROW
BEGIN
    SET NEW.lastUpdate = NOW(),
    NEW.lastUpdateUser = USER();
END;

INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, jobTitle)
VALUES (1073, 'Marchisone', 'Elvio', 'x7357', 'e.march@gmail.com', '1', 'CTO')


/* create trigger customer_create_date
    before insert
    on customer
    for each row
    SET NEW.create_date = NOW();

   Este trigger setea el valor NOW() a el campo create_date. Se ejecuta al insertar un nuevo customer

create trigger del_film
    after delete
    on film
    for each row
BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
END;

   Este trigger  se ejecuta despues de la eliminacion de una pelicula. Borra de la tabla film_text
   las filas que contengan el id de la pelicula eliminada.



create trigger ins_film
    after insert
    on film
    for each row
BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
END;

   Este trigger se ejecuta despues de una insercion en la tabla film. Inserta en la tabla fil_text
   el nuevo valor del id, titulo y descripcion de la pelicula insertada.



create trigger upd_film
    after update
    on film
    for each row
BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END;

   Este trigger se ejecuta despues de una actualizacion en la tabla film.
   Comprueba si el titulo anterior o la descripcion, o el id son distintos a los valores anteriores.
   Si alguna de estas evaluaciones da true se actualizan los campos con los valores nuevos.



create trigger payment_date
    before insert
    on payment
    for each row
    SET NEW.payment_date = NOW();

   Este trigger se ejecuta antes de una insercion a la tabla payment.
   Setea el valor que devuelva la funcion NOW() al campo payment_date

   */