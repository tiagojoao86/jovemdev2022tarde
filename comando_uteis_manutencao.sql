select * from pg_stat_activity;

select pg_cancel_backend(pid)
from pg_stat_activity where datname = 'newdvdrental';

select pg_terminate_backend(pid)
from pg_stat_activity where datname = 'newdvdrental';

drop database newdvdrental;

CREATE DATABASE newdvdrental_bkp2
    WITH TEMPLATE 'newdvdrental';

CREATE DATABASE newdvdrental
    WITH TEMPLATE 'newdvdrental_bkp2';

CREATE TABLE actor_bkp_20220707 AS
    WITH tmp AS (select * from actor)
    select * from tmp;

drop table actor_bkp_20220707;

create table film_actor_bkp_20220707 AS WITH tmp AS
(delete from film_actor where actor_id = 13 returning *)
select * from tmp;
select * from film_actor_bkp_20220707;

create table actor_bkp_20220707 AS WITH tmp AS
(delete from actor where actor_id = 13 returning *)
select * from tmp;

select * from actor_bkp_20220707;

create role tiago LOGIN NOSUPERUSER
    INHERIT NOCREATEDB NOCREATEROLE
    NOREPLICATION;

ALTER USER tiago WITH PASSWORD '123456';

GRANT SELECT ON actor TO tiago;
