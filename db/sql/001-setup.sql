-- script voor PoC_PostgREST

create schema api;

create table api.todos (
  id serial primary key,
  done boolean not null default false,
  task text not null,
  due timestamptz
);

insert into api.todos (task, done) values
  ('Beginnen bij het begin', 'true'),
  ('doorgaan met de volgende stap', 'false'),
  ('blijven volhouden', 'false'),
  ('stoppen bij het einde', 'false');


-- maak een role voor de anonieme web-requests.
-- Als er een request gemaakt wordt, dan schakelt PostgREST naar deze rol over om de queries uit te voeren.
-- geef alle rechten (dus all in plaats van select)
create role web_anon nologin;

grant usage on schema api to web_anon;
grant all on api.todos to web_anon;
grant all on sequence api.todos_id_seq to web_anon;

-- daarnaast maken we een tweede rol aan, die rechten kan overnemen van de web_anon-rol
create role authenticator noinherit login password 'postgres';
grant web_anon to authenticator;