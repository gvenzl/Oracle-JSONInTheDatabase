# Pluggable databases
All the examples use pluggable databases to demonstrate the functionality however, pluggable databases aren't necessary to run the examples. It is just a very nice way of running the examples in complete isolation within your existing database.

## What are pluggable databases?
Pluggable databases are new in Oracle 12c and part of the multitenant architecture, which enables an Oracle database to be a multitenant container database (CDB). A CDB is a single physical database that contains zero, one, or many user-created pluggable databases. A pluggable database (PDB) is a portable collection of schemas, schema objects, and nonschema objects that appears to an Oracle Net client as a non-CDB. A non-CDB is a traditional Oracle database that cannot contain PDBs.

Starting in Oracle Database 12c, you must create a database as either a CDB or non-CDB. You can plug a non-CDB into a CDB as a PDB. To move a PDB to a non-CDB, you must use Oracle Data Pump.

By consolidating multiple physical databases on separate computers into a single database on a single computer, the multitenant architecture provides the following benefits:

* Cost reduction for hardware
* Easier and more rapid movement of data and code
* Easier management and monitoring of the physical database
* Separation of data and code
* Separation of duties between a PDB administrator, who manages only the PDBs to which she or he is granted privileges, and the CDB administrator, who manages the entire CDB

## Do I have to pay Oracle now in order to use the examples?
Pluggable databases are part of the multitenant architecture which comes as part of the Multitenant Option for Oracle Database Enterprise Edition. However, **the multitenant architecture with one user-created pluggable database (single tenant) is available in all editions without the Multitenant Option.** For further information check the [Oracle Database Licensing Guide](http://docs.oracle.com/database/121/DBLIC/options.htm#DBLIC2166).

## How do I run the examples without pluggable database?
Remove following lines in the *setup.sql* file:

    -- Create new pluggable database. You may not need that if you are running in a non-CDB environment.
    CREATE PLUGGABLE DATABASE TEST ADMIN USER ADMIN IDENTIFIED BY ADMIN
    FILE_NAME_CONVERT=('/opt/oracle/oradata/DEV/pdbseed', '/opt/oracle/oradata/DEV/TEST');
    -- You may not need that if you are running in a non-CDB environment.
    ALTER PLUGGABLE DATABASE TEST OPEN;
    --You may not need that if you are running in a non-CDB environment.
    ALTER SESSION SET CONTAINER=TEST;
    -- Creating a scratch tablespace. You may not need that if you are running in a non-CDB environment.
    CREATE BIGFILE TABLESPACE USERS DATAFILE '/opt/oracle/oradata/DEV/TEST/users.dbf' SIZE 20M;

Change your connection string in your *setup.sql* file to connect to your already existing database:

    -- Connect as test user
    conn TEST/test@//localhost:1521/TEST

Remove following lines in the *cleanup.sql* file:

    -- Close pluggable database. You may not need that if you are running in a non-CDB environment.
    ALTER PLUGGABLE DATABASE TEST CLOSE;
    -- Drop pluggable database. You may not need that if you are running in a non-CDB environment.
    DROP PLUGGABLE DATABASE TEST INCLUDING DATAFILES;