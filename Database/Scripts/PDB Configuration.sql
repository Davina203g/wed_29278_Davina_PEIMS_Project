CREATE PLUGGABLE DATABASE wed_29278_davina_PEIMS_DB
ADMIN USER davina IDENTIFIED BY auca2025
FILE_NAME_CONVERT = (
    '/opt/oracle/oradata/XE/pdbseed/',
    '/opt/oracle/oradata/XE/wed_29278_davina_PEIMS_DB/'
);
SQL> Exit;
Disconnected from Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0
bash-4.2$ sqlplus / as sysdba

SQL*Plus: Release 21.0.0.0.0 - Production on Tue Dec 2 08:59:30 2025
Version 21.3.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.


Connected to:
Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0

SQL> ALTER session SET CONTAINER = wed_29278_davina_PEIMS_db;

Session altered.

SQL> SHOW CON_NAME;

CON_NAME
------------------------------
WED_29278_DAVINA_PEIMS_DB
SQL> GRANT CREATE SESSION TO davina;

Grant succeeded.

SQL> GRANT CREATE TABLE TO davina;

Grant succeeded.

SQL> GRANT CREATE VIEW to davina;

Grant succeeded.

SQL> GRANT CREATE PROCEDURE TO davina;

Grant succeeded.

SQL> GRANT CREATE TRIGGER  TO davina;

Grant succeeded.

SQL> GRANT CREATE SEQUENCE TO davina;

Grant succeeded.

SQL> GRANT UNLIMITED TABLESPACE TO davina;

Grant succeeded.

SQL> Exit;
Disconnected from Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0
bash-4.2$ exit
(base) davina@T327-IVM-001s-MacBook-Air ~ % docker ps
CONTAINER ID   IMAGE                                                      COMMAND                  CREATED       STATUS                  PORTS                                                                                      NAMES
ee15e2da5de1   container-registry.oracle.com/database/express:21.3.0-xe   "/bin/bash -c $ORACL…"   8 weeks ago   Up 19 hours (healthy)   0.0.0.0:1521->1521/tcp, [::]:1521->1521/tcp, 0.0.0.0:5500->5500/tcp, [::]:5500->5500/tcp   oracle21c
(base) davina@T327-IVM-001s-MacBook-Air ~ % docker exec -it oracle21c bash 

bash-4.2$ sqlplus / as sysdba

SQL*Plus: Release 21.0.0.0.0 - Production on Tue Dec 2 10:51:57 2025
Version 21.3.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.


Connected to:
Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0

SQL> CONNECT PEIMS AS SYSDBA;                                
Enter password: 
Connected.
SQL>  ALTER PLUGGABLE DATABASE wed_29278_davina_PEIMS_DB OPEN;

Pluggable database altered.

SQL> CONNECT davina/auca2025@localhost:1521/wed_29278_davina_PEIMS_DB;
Connected.
SQL> show con_name;

CON_NAME
------------------------------
WED_29278_DAVINA_PEIMS_DB
SQL> alter session set container =WED_29278_DAVINA_PEIMS_DB;

Session altered.

SQL> show user;
USER is "DAVINA"