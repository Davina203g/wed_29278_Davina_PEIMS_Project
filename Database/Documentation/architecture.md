Passenger Emergency Information Management System (PEIMS)

1. System Overview
   
The Passenger Emergency Information Management System (PEIMS) is a secure database-driven solution used by bus companies to manage passengers, bookings, emergency contacts, trip manifests, employee operations, and emergency response workflows.
The system enforces strict security and auditing rules to ensure data integrity and compliance.

3. High-Level Architecture Diagram (Text Form)
   
+----------------------------+
|        User Layer          |
|----------------------------|
| Passengers | Employees     |
| Admins     | Responders    |
+----------------------------+
             |
             v
+-------------------------------------------+
|            Application Layer              |
|-------------------------------------------|
| PL/SQL Packages | Triggers | Functions    |
| Validation Logic | Security Enforcement   |
+-------------------------------------------+
             |
             v
+-------------------------------------------+
|              Database Layer               |
|-------------------------------------------|
| Tables: Passenger, Booking, Trip, Bus     |
| Emergency_Contact, Employee, Holiday      |
| Audit_Log                                 |
|-------------------------------------------|
| Constraints | Views | Indexes | Sequences |
+-------------------------------------------+
             |
             v
+-------------------+
| Oracle Listener   |
+-------------------+
             |
             v
+---------------------------+
| Storage/Backup Layer      |
+---------------------------+


3. Components Description
   
3.1 User Layer
   
User Type
Responsibilities
Passenger
Provides personal & emergency details; books trips
Employee (Lana)
Handles registrations, bookings (restricted by business rules)
Admin (Davina)
Full system access, schema owner
Emergency Responder
Accesses passenger information during emergencies


3.2 Application Layer

Includes all logic stored in the database:
- Validation functions (ID checks, phone validation)
- Restriction function (weekday/holiday block logic)
- Audit logging function
- Triggers (simple + compound)

This layer ensures:
- Data consistency
- Security compliance
- Real-time auditing

3.3 Database Layer

The core entities include:
- Passenger & Emergency Contact
- Booking & Trip
- Bus
- Holiday Calendar
- Employee
- Audit Log

Database is implemented using:
- Primary/Foreign keys
- Indexes
- PL/SQL stored programs
- DDL + DML triggers



3.4 Security Layer

Enforced through:

- Role-based access
- Object-level grants
- Trigger-based business rules
- Mandatory audit logging
- Restriction checks (weekday/holiday)



4. External Dependencies
   
- Oracle 21c XE
- Docker container (oracle21c)
- SQL Developer UI

5. Deployment Architecture
   
- Single-instance Oracle XE running inside Docker
- SQL*Plus and SQL Developer used as client interfaces
- Database scripts stored in GitHub repository
