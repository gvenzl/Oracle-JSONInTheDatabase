-- Create new pluggable database. You may not need that if you are running in a non-CDB environment.
CREATE PLUGGABLE DATABASE TEST ADMIN USER ADMIN IDENTIFIED BY ADMIN
FILE_NAME_CONVERT=('/opt/oracle/oradata/DEV/pdbseed', '/opt/oracle/oradata/DEV/TEST');

-- You may not need that if you are running in a non-CDB environment.
ALTER PLUGGABLE DATABASE TEST OPEN;

--You may not need that if you are running in a non-CDB environment.
ALTER SESSION SET CONTAINER=TEST;

-- Creating a scratch tablespace. You may not need that if you are running in a non-CDB environment.
CREATE BIGFILE TABLESPACE USERS DATAFILE '/opt/oracle/oradata/DEV/TEST/users.dbf' SIZE 20M;

-- Create a database users for the example and grant the right privileges.
-- Streaming user
CREATE USER STREAMER IDENTIFIED BY streamit DEFAULT TABLESPACE USERS;
GRANT CONNECT,RESOURCE TO STREAMER;
ALTER USER STREAMER QUOTA UNLIMITED ON USERS;

-- Front end user
CREATE USER BIUSER IDENTIFIED BY analyst DEFAULT TABLESPACE USERS;
GRANT CONNECT,RESOURCE TO BIUSER;
ALTER USER BIUSER QUOTA UNLIMITED ON USERS;
