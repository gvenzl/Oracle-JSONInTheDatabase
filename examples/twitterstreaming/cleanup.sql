ALTER PLUGGABLE DATABASE TEST CLOSE;

-- Drop pluggable database. You may not need that if you are running in a non-CDB environment.
DROP PLUGGABLE DATABASE TEST INCLUDING DATAFILES;

-- Drop user STREAMER. You may not need that if you are running in a pluggable database environment.
DROP USER STREAMER CASCADE;
