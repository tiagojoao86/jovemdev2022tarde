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

/*
 1. Realizar Select na tabela “payment” somando a coluna “amount” e
agrupando pela coluna customer_id, ordene de forma a mostrar as
maiores somas primeiro
2. Realizar Select na tabela “rental” contando quanta locações foram feitas
e agrupando pela coluna customer_id, ordene de forma a mostrar as
menores contagens primeiro
3. Realizar Select na tabela “rental” de forma a descobrir qual cliente fez a
última locação;
4. Realizar Select na tabela “rental” de forma a descobrir qual cliente fez a
primeira locação;
 */

SELECT SUM(amount) as soma, customer_id
FROM payment
GROUP BY customer_id
--ORDER BY 1 desc;
--ORDER BY soma desc;
ORDER BY SUM(amount) desc;

SELECT count(rental_id) as quantidade, customer_id
FROM rental
GROUP BY customer_id
ORDER BY 1 desc;
--ORDER BY soma desc;
--ORDER BY count(rental_id) desc;

SELECT max(rental_date) maior_data, customer_id as id_cliente
FROM rental
GROUP BY customer_id
ORDER BY 1 desc
LIMIT 1;

SELECT min(rental_date) maior_data, customer_id as id_cliente
FROM rental
GROUP BY customer_id
ORDER BY 1 asc
LIMIT 1;

/*
1. Realizar Select na tabela “payment” calculando a média da coluna
“amount” e agrupando pela coluna customer_id, ordene mostrando as
maiores médias primeiro

2. Realizar Select na tabela “payment” somando a coluna “amount” e
agrupando pela coluna customer_id, mostre somente os clientes que
possuem somatório maior de 200
 */

SELECT ROUND(AVG(amount),2) as soma, customer_id
FROM payment
GROUP BY customer_id
ORDER BY 1 desc;

SELECT SUM(amount) as soma, customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 200
ORDER BY 1 desc;

---------- #JOIN, STRING_AGG e UNION ALL
select f.film_id, f.title, a.actor_id, --a.first_name || ' ' || a.last_name
concat(a.first_name, ' ', a.last_name)
from film f
right join  film_actor fa on f.film_id = fa.film_id
right join actor a on fa.actor_id = a.actor_id
where
--a.actor_id is null
f.film_id is null
;

select title, replace(title, ' ', '/')
from film;

select f.film_id, a.actor_id, fa.film_id, fa.actor_id
from film f
left join  film_actor fa on f.film_id = fa.film_id
left join actor a on fa.actor_id = a.actor_id
where
a.actor_id is null OR
f.film_id is null
;

select f.film_id, a.actor_id, fa.film_id, fa.actor_id
from film f
         full outer join  film_actor fa on f.film_id = fa.film_id
         full outer join actor a on fa.actor_id = a.actor_id
where
    a.actor_id is null OR
    f.film_id is null
;

SELECT SUM(amount) as soma, string_agg(payment_id::text, ';'), customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 200
ORDER BY 1 desc;

SELECT 'Total do Cliente: ' as info, SUM(amount) as valor, customer_id
FROM payment WHERE
customer_id in (148, 526)
GROUP BY customer_id
UNION ALL
SELECT 'Quantidade do Cliente: ' as info, count(rental_id) as qtd, customer_id
FROM rental
WHERE
customer_id in (148, 526)
GROUP BY customer_id
order by customer_id;
------------------------
