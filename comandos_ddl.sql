--CREATE DATABASE jovemdev_tarde;

CREATE TABLE aluno (
    aluno_id SERIAL PRIMARY KEY,
    nome VARCHAR(200),
    cpf VARCHAR(11) UNIQUE NOT NULL
);

CREATE TABLE turma (
    turma_id SERIAL PRIMARY KEY ,
    nome VARCHAR(50) NOT NULL
);

ALTER TABLE aluno ADD COLUMN turma_id INTEGER;

ALTER TABLE aluno
    ADD CONSTRAINT aluno_turma_id_fkey
    FOREIGN KEY (turma_id)
REFERENCES turma(turma_id);

ALTER TABLE aluno ALTER COLUMN nome SET NOT NULL;

ALTER TABLE aluno ADD CONSTRAINT aluno_nome_check_size
CHECK (char_length(nome) > 5);

ALTER TABLE aluno ADD COLUMN data_nascimento DATE;

INSERT INTO turma (nome) VALUES ('Vespertino');
INSERT INTO turma (nome) VALUES ('Noturno');
select * from turma;

INSERT INTO aluno (nome, cpf, turma_id, data_nascimento)
VALUES ('Tiago João', '12345678911', 1, '1986-01-10');

INSERT INTO aluno (nome, cpf, turma_id, data_nascimento)
VALUES ('ROBERTO LUIS', '12345678910', 1, '1986-01-15');

select * from aluno;

----- USANDO SEQUENCIAL PARA ID
CREATE SEQUENCE aluno_id_seq;
CREATE TABLE aluno (
   aluno_id INTEGER PRIMARY KEY DEFAULT nextval('aluno_id_seq'),
   nome VARCHAR(200),
   cpf VARCHAR(11) UNIQUE NOT NULL
);

--- USANDO UUID
CREATE TABLE aluno (
   aluno_id UUID PRIMARY KEY,
   nome VARCHAR(200),
   cpf VARCHAR(11) UNIQUE NOT NULL
);

----- VIEWS
create view staff_vw as
SELECT s.staff_id,
       concat(s.first_name, ' ', s.last_name) AS nome,
       a.address,
       a.postal_code,
       a.phone,
       c.city
FROM staff s
         JOIN address a ON s.address_id = a.address_id
         JOIN city c ON a.city_id = c.city_id;

         /*
         Criar uma view sobre aluguéis (rentals), onde deverá
         trazer as informações:
         - Id do rental;
         - Nome completo do cliente;
         - Nome completo do funcionário;
         - Valor do aluguel
         - Nome do filme locado
         */

         CREATE OR REPLACE VIEW rentals_vw AS
             SELECT r.rental_id,
                    concat(c.first_name, ' ', c.last_name) as nome_cliente,
                    concat(s.first_name, ' ', s.last_name) as nome_funcionario,
                    f.rental_rate,
                    f.title
             FROM rental r
             JOIN customer c on r.customer_id = c.customer_id
             JOIN staff s ON r.staff_id = s.staff_id
             JOIN inventory i on r.inventory_id = i.inventory_id
             JOIN film f on i.film_id = f.film_id;

         select * from rentals_vw;

         CREATE MATERIALIZED VIEW rentals_mvw AS
         SELECT r.rental_id,
                concat(c.first_name, ' ', c.last_name) as nome_cliente,
                concat(s.first_name, ' ', s.last_name) as nome_funcionario,
                f.rental_rate,
                f.title
         FROM rental r
                  JOIN customer c on r.customer_id = c.customer_id
                  JOIN staff s ON r.staff_id = s.staff_id
                  JOIN inventory i on r.inventory_id = i.inventory_id
                  JOIN film f on i.film_id = f.film_id;

         select * from rentals_vw where rental_id = 3;
         select * from rentals_mvw where rental_id = 3;

         refresh materialized view rentals_mvw;

         select rental_rate, * from film where title = 'Graduate Lord';
         update film set rental_rate = 10.00 where film_id = 373;
