-- Create new pluggable database. You may not need that if you are running in a non-CDB environment.
CREATE PLUGGABLE DATABASE TEST ADMIN USER ADMIN IDENTIFIED BY ADMIN
FILE_NAME_CONVERT=('/opt/oracle/oradata/DEV/pdbseed', '/opt/oracle/oradata/DEV/TEST');

-- You may not need that if you are running in a non-CDB environment.
ALTER PLUGGABLE DATABASE TEST OPEN;

--You may not need that if you are running in a non-CDB environment.
ALTER SESSION SET CONTAINER=TEST;

-- Creating a scratch tablespace. You may not need that if you are running in a non-CDB environment.
CREATE BIGFILE TABLESPACE USERS DATAFILE '/opt/oracle/oradata/DEV/TEST/users.dbf' SIZE 20M;

-- Create a test user for the example and grant the right privileges.
CREATE USER TEST IDENTIFIED BY test DEFAULT TABLESPACE USERS;
GRANT CONNECT,RESOURCE TO TEST;
ALTER USER TEST QUOTA UNLIMITED ON USERS;

-- Connect as test user
conn TEST/test@//localhost:1521/TEST

-- Create JSON table holidng a JSON document
CREATE TABLE JSON (doc    BLOB      CONSTRAINT check_is_valid_json CHECK (doc IS JSON FORMAT JSON));