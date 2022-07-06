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
