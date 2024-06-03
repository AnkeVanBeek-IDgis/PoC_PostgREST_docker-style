-- script voor PoC_PostgREST

create schema api;

create table api.todos (
  id serial primary key,
  done boolean not null default false,
  task text not null,
  due timestamptz
);

insert into api.todos (task) values
  ('finish tutorial 0'), ('pat self on back');
 
create role web_anon nologin;

grant usage on schema api to web_anon;
-- geef alle rechten (dus all in plaats van select)
grant all on api.todos to web_anon;
grant all on sequence api.todos_id_seq to web_anon;

create role authenticator noinherit login password 'postgres';
grant web_anon to authenticator;