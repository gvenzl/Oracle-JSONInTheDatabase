create table jdata (payload clob) tablespace users;

alter table jdata add constraint jcheck check (payload is json);