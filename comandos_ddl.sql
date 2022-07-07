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
