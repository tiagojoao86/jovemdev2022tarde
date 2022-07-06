-------------- #PL/SQL
DO $$
    declare
        lista_atores record;
    begin
        for lista_atores in (select actor_id, first_name, last_name from actor) loop
            if (lista_atores.first_name = 'Sandra') then
                update actor set last_update = now()
                where actor_id = lista_atores.actor_id;
                RAISE NOTICE 'Id: %', lista_atores.actor_id;
            else
                RAISE NOTICE 'Não é Sandra';
            end if;
        end loop;
    end;
$$ language plpgsql;

select * from actor where actor_id in (30, 23, 100);

CREATE FUNCTION busca_total_aluguel_cliente_fc(customer_id_p INTEGER) RETURNS NUMERIC AS $$
    DECLARE
        resultado numeric;
    BEGIN
        SELECT SUM(amount) INTO resultado
        FROM payment
        WHERE customer_id = customer_id_p;

        RETURN resultado;
    END;
$$ language plpgsql;

select busca_total_aluguel_cliente_fc(30);

CREATE FUNCTION atualiza_data_customer_fc(first_name_p VARCHAR) RETURNS void AS $$
    declare
        lista_atores record;
    begin
        for lista_atores in (select actor_id, first_name, last_name from actor) loop
                if (lista_atores.first_name = first_name_p) then
                    update actor set last_update = now()
                    where actor_id = lista_atores.actor_id;
                    RAISE NOTICE 'Id: %', lista_atores.actor_id;
                else
                    RAISE NOTICE 'Não é %', first_name_p;
                end if;
            end loop;
    end;
$$ language plpgsql;

select atualiza_data_customer_fc('Ben');

/*
1 - Crie uma function para retornar o nome completo do ator
(nome sobrenome), recebendo por parâmetro o actor_id;
2 - Crie uma procedure que cria uma coluna na tabela actor,
chamada full_name varchar(200), depois preencha essa
coluna com o nome completo de cada ator (nome sobrenome);
*/

CREATE FUNCTION busca_nome_completo_ator_fc(actor_id_p INTEGER) RETURNS VARCHAR AS $$
    DECLARE
        nome_completo varchar;
    BEGIN
        SELECT concat(first_name, ' ', last_name) INTO nome_completo
        FROM actor WHERE actor_id = actor_id_p;

        return nome_completo;
    end;
$$ LANGUAGE plpgsql;

select busca_nome_completo_ator_fc(3);


CREATE OR REPLACE FUNCTION seta_nome_completo_todos_atores() RETURNS VOID AS $$
    DECLARE
        ator RECORD;
    BEGIN
        ALTER TABLE actor ADD COLUMN IF NOT EXISTS full_name varchar(200);
        /*UPDATE actor SET full_name = busca_nome_completo_ator_fc(actor_id)
        WHERE actor_id = actor_id;*/
        FOR ator IN (SELECT actor_id, first_name FROM actor) LOOP
            UPDATE actor SET full_name =
                busca_nome_completo_ator_fc(actor_id)
            WHERE actor_id = ator.actor_id;
        end loop;
    end;
$$ LANGUAGE plpgsql;

SELECT seta_nome_completo_todos_atores();
SELECT * FROM actor;
