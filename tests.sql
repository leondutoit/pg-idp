
-- tests pg-idp
-- TODOs:
-- immutability
-- end dates on persons, usesrs, groups
-- non-cyclicality enforcement
-- audit?
-- additional fields on persons, users
-- capability generation and validation
-- rpc API?
-- RLS access control

create or replace function test()
    returns boolean as $$
    declare pid uuid;
    begin
        insert into persons (given_names, surname) values ('Sarah', 'Conner');
        select person_id from persons where surname = 'Conner' into pid;
        insert into users (person_id, user_name)
            values (pid, 'p11-sconne');
    return true;
    end;
$$ language plpgsql;

select test();
select * from persons;
select * from users;
select * from groups;
update persons set person_activated = 'f';
select * from persons;
select * from users;
select * from groups;
update persons set person_id = 'e14c538a-4b8b-4393-9fb2-056e363899e1';
update persons set person_group = 'e14c538a-4b8b-4393-9fb2-056e363899e1-group';
update users set user_id = 'a3981c7f-8e41-4222-9183-1815b6ec9c3b';
update users set user_name = 'p11-scnr';
update users set user_group = 'p11-s-group';
delete from persons;
select * from users;
select * from groups;
