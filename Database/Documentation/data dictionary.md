PEIMS Data Dictionary

This document describes all database objects used in the Passenger Emergency Information Management System.
It includes tables, columns, data types, constraints, and purpose.

Passenger Table
---------------------------------------------------------------
| Column Name       | Data Type      | Constraints            |
---------------------------------------------------------------
| passenger_id      | NUMBER         | PK, Identity           |
| full_name         | VARCHAR2(100)  | NOT NULL               |
| national_id       | VARCHAR2(30)   | UNIQUE, NOT NULL       |
| phone_number      | VARCHAR2(20)   | NOT NULL               |
| emergency_contact | VARCHAR2(100)  | NOT NULL               |
| created_at        | DATE           | DEFAULT SYSDATE        |
---------------------------------------------------------------
Purpose: Stores passenger identity and emergency contact details.

Bus Table
---------------------------------------------------------------
| Column Name   | Data Type      | Constraints               |
---------------------------------------------------------------
| bus_id        | NUMBER         | PK, Identity              |
| plate_number  | VARCHAR2(20)   | UNIQUE, NOT NULL          |
| driver_name   | VARCHAR2(100)  | NOT NULL                  |
| route         | VARCHAR2(100)  | NOT NULL                  |
---------------------------------------------------------------
Purpose: Contains buses with assigned routes and drivers.

Trip table
-------------------------------------------------------------------------
| Column Name | Data Type      | Constraints                           |
-------------------------------------------------------------------------
| trip_id     | NUMBER         | PK, Identity                          |
| bus_id      | NUMBER         | FK → BUS(bus_id), NOT NULL            |
| trip_date   | DATE           | NOT NULL                              |
| departure   | VARCHAR2(100)  | NOT NULL                              |
| destination | VARCHAR2(100)  | NOT NULL                              |
---------------------------------------------------------------------------
Purpose: Holds trip details assigned to buses.

Booking Table
-----------------------------------------------------------------------------------------
| Column Name    | Data Type      | Constraints                                        |
-----------------------------------------------------------------------------------------
| booking_id     | NUMBER         | PK, Identity                                       |
| trip_id        | NUMBER         | FK → TRIP(trip_id), NOT NULL                       |
| passenger_id   | NUMBER         | FK → PASSENGER(passenger_id), NOT NULL             |
| seat_number    | NUMBER         | NOT NULL                                           |
| ticket_number  | VARCHAR2(50)   | UNIQUE, NOT NULL                                   |
| created_at     | DATE           | DEFAULT SYSDATE                                    |
-----------------------------------------------------------------------------------------
Purpose: Stores bookings made by passengers for specific trips.

Holiday_Calender Table
---------------------------------------------------------------------------
| Column Name  | Data Type      | Constraints                           |
---------------------------------------------------------------------------
| holiday_id   | NUMBER         | PK, Identity                          |
| holiday_date | DATE           | UNIQUE, NOT NULL                      |
| description  | VARCHAR2(200)  | NOT NULL                              |
---------------------------------------------------------------------------
Purpose: List of holidays used for restriction rules.

Employee Table
---------------------------------------------------------------------------
| Column Name | Data Type      | Constraints                           |
---------------------------------------------------------------------------
| employee_id | NUMBER         | PK, Identity                           |
| username    | VARCHAR2(50)   | UNIQUE, NOT NULL                       |                            |
| role        | VARCHAR2(50)   | NOT NULL (Admin/Staff)                 |
---------------------------------------------------------------------------
Purpose: Stores system users who manage bookings.

PEIMS_Audit_log_Table
-------------------------------------------------------------------------
| Column Name  | Data Type      | Constraints                          |
-------------------------------------------------------------------------
| log_id       | NUMBER         | PK, Identity                         |
| username     | VARCHAR2(50)   | NOT NULL                             |
| action_type  | VARCHAR2(20)   | NOT NULL  (INSERT/UPDATE/DELETE)     |
| status       | VARCHAR2(20)   | NOT NULL  (ALLOWED/BLOCKED)          |
| table_name   | VARCHAR2(50)   | NOT NULL                             |
| action_date  | DATE           | DEFAULT SYSDATE                      |
| details      | VARCHAR2(500)  | Optional log message                 |
-------------------------------------------------------------------------
Purpose: Tracks all employee actions for security and compliance.
