----- # COMANDOS DTL (BEGIN, COMMIT, ROLLBACK)

select * from customer;
select * from customer where customer_id = 7;
select * from rental where customer_id = 7;
select * from payment where customer_id = 7;

BEGIN;
delete from payment where customer_id = 7;
delete from rental where customer_id = 7;
delete from customer where customer_id = 7;
ROLLBACK;
COMMIT;
