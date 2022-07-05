SELECT film_id id,
       title titulo,
       description descricao,
       rating classificao
FROM film
WHERE
    rating = 'NC-17'
ORDER BY title DESC, description
;

SELECT film_id id,
       title titulo,
       description descricao,
       rating classificao
FROM film
WHERE
        description ilike '%panorama%'
ORDER BY title DESC, description
;

SELECT film_id id,
       title titulo,
       description descricao,
       rating classificao
FROM film
WHERE
        film_id IN (994,993,992,991,881,884)
ORDER BY title DESC, description
;

SELECT f.film_id id,
       f.title titulo,
       f.description descricao,
       f.rating classificao
FROM film f
WHERE
        f.film_id IN (994,993,992,991,881,884)
        AND f.rating = 'PG-13'
ORDER BY f.title DESC, f.description
;

INSERT INTO film (title,
                  release_year, language_id,
                  rental_rate, length, replacement_cost, rating,
                  special_features)
VALUES ('MEU MALVADO FAVORITO', 2010, 1, 5.99, 90, 20.15, 'G', '{Bastidores}');
select * from language;

SELECT * FROM film WHERE title = 'MEU MALVADO FAVORITO';

SELECT * FROM film WHERE film_id = 1005;
UPDATE film SET description = 'A História de Gru!' WHERE film_id = 1005;

SELECT * FROM film WHERE film_id = 1005;
DELETE FROM film WHERE film_id = 1005;

# Resolução atividade #01
SELECT actor_id, first_name, last_name, last_update
FROM actor
ORDER BY first_name ASC;

INSERT INTO actor (first_name, last_name)
VALUES ('Giordana', 'Goncalves'), ('Rubens', 'Farias');

SELECT * FROM actor WHERE first_name = 'Rubens' AND last_name = 'Farias';
DELETE FROM actor WHERE actor_id = 204;

SELECT * FROM actor WHERE first_name = 'Giordana' AND last_name = 'Goncalves';
SELECT * FROM actor WHERE actor_id = 203;
UPDATE actor SET first_name = 'Geordana' WHERE actor_id = 203;

SELECT
        payment_id, customer_id, staff_id,
        rental_id, amount,
        round(amount - (amount * 0.1), 2) as total_desconto,
        payment_date
FROM payment;
-------------------------------------
--- LIMIT e OFFSET
SELECT * FROM film ORDER BY title OFFSET 10 LIMIT 10;

-- FUNÇÕES DE AGRUPAMENTO
-- MAX e MIN
SELECT * FROM film;

SELECT max(amount), customer_id
FROM payment
GROUP BY customer_id;

select amount, customer_id
from payment
where customer_id IN (184, 185)
order by customer_id, amount desc;

select max(amount), customer_id
from payment
where customer_id IN (184, 185)
group by customer_id;

select min(amount), customer_id
from payment
where customer_id IN (184, 185)
group by customer_id;

SELECT min(amount), customer_id
FROM payment
GROUP BY customer_id;

select sum(amount), customer_id
from payment
where customer_id IN (184, 185)
group by customer_id;

select avg(amount), customer_id
from payment
where customer_id IN (184, 185)
group by customer_id;

select count(amount), customer_id
from payment
where customer_id IN (184, 185)
group by customer_id;

select sum(amount), count(amount), customer_id
from payment
group by customer_id
having count(amount) > 40;
