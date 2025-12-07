Passenger Emergency Information Management System (PEIMS)

1. Purpose of Design Decisions
This document records the major decisions made during the planning and implementation of the PEIMS project.
 Each decision is justified based on:
- Performance
- Security
- Maintainability
- Simplicity

2. Major Design Decisions
   
2.1 Use of Oracle XE + Docker
Decision: Host database inside an Oracle 21c XE Docker container.
 Reason:
- Easy setup and reset
- Reliable environment for PL/SQL and triggers
- Lightweight but fully functional for academic projects

2.2 Star-Like Relational Schema
Decision: Use normalized, relational structure with clear foreign keys.
Reason:
- Ensures data consistency
- Simplifies joins for analytics
- Supports auditing and reporting

2.3 Separate EMPLOYEE user
Decision: Employee performs operations separately from schema owner.
 Reason:
- Enables accurate audit trail
- Demonstrates role-based access
- Required for Phase VII business rule enforcement

2.4 Use of COMPOUND TRIGGER
Decision: Replace multiple triggers with a single compound trigger.
 Reason:
- Prevents mutating-table errors
- Ensures unified restriction logic
- Allows pre-check + row-level + audit in one block

2.5 HOLIDAY_CALENDAR Table
Decision: Implement a dedicated holiday table.
Reason:
- Enables easy business rule extension
- Maintains clean, reusable logic for restriction checking

2.6 Audit Log Table
Decision: Store every operation in PEIMS_AUDIT_LOG.
Reason:
- Required for security compliance
- Provides traceability
- Enables BI dashboard metrics

2.7 Restriction Function
Decision: Centralize weekday/holiday validation inside one function.
Reason:
- Reusability across triggers
- Consistent behavior
- Simplified maintenance

2.8 Use of Surrogate Keys (Number Sequences)
Decision: Use numeric primary keys for all tables.
Reason:
- Fast indexing
- Predictable joins
- Avoids natural key conflicts

2.9 Emergency Workflow Access
Decision: Emergency responders access data read-only.
Reason:
- Protects data integrity
- Matches real-world emergency procedures
