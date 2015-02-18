-- Close pluggable database. You may not need that if you are running in a non-CDB environment.
ALTER PLUGGABLE DATABASE TEST CLOSE;

-- Drop pluggable database. You may not need that if you are running in a non-CDB environment.
DROP PLUGGABLE DATABASE TEST INCLUDING DATAFILES;

-- Drop user TEST. You may not need that if you are running in a pluggable database environment.
DROP USER TEST CASCADE;