# Overview
This example creates a simple JSON table within the Oracle Database and then stores and retrieves data from it using [Python](http://www.python.org)

# Prerequisites
* Oracle Database 12.1.0.2+
* Python 3.4+
* [cx_Oracle 1.5.3+](http://cx-oracle.sourceforge.net/)

# Example structure
## setup.sql
Sets up the environment. You must run this script as privileged user, e.g. SYS, SYSTEM or another user with appropriate privileges. This example uses a pluggable database (PDB) which you do not have to license if you have just 1 PDB within your container database! If you do not wish to use a PDB for the example you can remove the appropriate commands as commented within the file itself.
## cleanup.sql
Cleans the environment up. This cleanup script assumes that you have used a pluggable database (PDB) for the example. If you do not have used a PDB for the example you have to remove the approprite commands as commented within the file itself.
## LoadData.py
This script generates and stores random JSON documents in an endless loop which a pause of 2 seconds between inserts.
## RetrieveData.py
This script retrieves certain attributes from all JSON documents stored.
