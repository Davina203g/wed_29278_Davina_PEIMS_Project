-- Trigger for BUS table (EMPLOYEES ONLY - Restricted)
CREATE OR REPLACE TRIGGER trg_bus_employee_restrict
BEFORE INSERT OR UPDATE OR DELETE ON BUS
FOR EACH ROW
DECLARE
    v_result VARCHAR2(500);
    v_audit_id NUMBER;
BEGIN
    v_result := is_employee_operation_allowed();
    
    IF v_result != 'ALLOWED' THEN
        -- Log denied attempt
        v_audit_id := log_audit_event(
            'BUS',
            CASE 
                WHEN INSERTING THEN 'INSERT'
                WHEN UPDATING THEN 'UPDATE'
                WHEN DELETING THEN 'DELETE'
            END,
            NVL(:NEW.bus_id, :OLD.bus_id),
            'DENIED',
            v_result
        );
        
        -- Raise error
        RAISE_APPLICATION_ERROR(-20901, v_result);
    ELSE
        -- Log successful attempt
        v_audit_id := log_audit_event(
            'BUS',
            CASE 
                WHEN INSERTING THEN 'INSERT'
                WHEN UPDATING THEN 'UPDATE'
                WHEN DELETING THEN 'DELETE'
            END,
            NVL(:NEW.bus_id, :OLD.bus_id),
            'SUCCESS'
        );
    END IF;
END;
/

-- Trigger for TRIP table (EMPLOYEES ONLY - Restricted)
CREATE OR REPLACE TRIGGER trg_trip_employee_restrict
BEFORE INSERT OR UPDATE OR DELETE ON TRIP
FOR EACH ROW
DECLARE
    v_result VARCHAR2(500);
    v_audit_id NUMBER;
BEGIN
    v_result := is_employee_operation_allowed();
    
    IF v_result != 'ALLOWED' THEN
        -- Log denied attempt
        v_audit_id := log_audit_event(
            'TRIP',
            CASE 
                WHEN INSERTING THEN 'INSERT'
                WHEN UPDATING THEN 'UPDATE'
                WHEN DELETING THEN 'DELETE'
            END,
            NVL(:NEW.trip_id, :OLD.trip_id),
            'DENIED',
            v_result
        );
        
        -- Raise error
        RAISE_APPLICATION_ERROR(-20902, v_result);
    ELSE
        -- Log successful attempt
        v_audit_id := log_audit_event(
            'TRIP',
            CASE 
                WHEN INSERTING THEN 'INSERT'
                WHEN UPDATING THEN 'UPDATE'
                WHEN DELETING THEN 'DELETE'
            END,
            NVL(:NEW.trip_id, :OLD.trip_id),
            'SUCCESS'
        );
    END IF;
END;
/

-- Trigger for PASSENGER table (PASSENGERS ALLOWED - Not Restricted)
CREATE OR REPLACE TRIGGER trg_passenger_audit_only
BEFORE INSERT OR UPDATE OR DELETE ON PASSENGER
FOR EACH ROW
DECLARE
    v_audit_id NUMBER;
BEGIN
    -- Always allow passenger operations, but log them
    v_audit_id := log_audit_event(
        'PASSENGER',
        CASE 
            WHEN INSERTING THEN 'INSERT'
            WHEN UPDATING THEN 'UPDATE'
            WHEN DELETING THEN 'DELETE'
        END,
        NVL(:NEW.passenger_id, :OLD.passenger_id),
        'SUCCESS'
    );
END;
/

-- Trigger for BOOKING table (PASSENGERS ALLOWED - Not Restricted)
CREATE OR REPLACE TRIGGER trg_booking_audit_only
BEFORE INSERT OR UPDATE OR DELETE ON BOOKING
FOR EACH ROW
DECLARE
    v_audit_id NUMBER;
BEGIN
    -- Always allow booking operations, but log them
    v_audit_id := log_audit_event(
        'BOOKING',
        CASE 
            WHEN INSERTING THEN 'INSERT'
            WHEN UPDATING THEN 'UPDATE'
            WHEN DELETING THEN 'DELETE'
        END,
        NVL(:NEW.booking_id, :OLD.booking_id),
        'SUCCESS'
    );
END;
/

-- Trigger for EMERGENCY_CONTACT table (PASSENGERS ALLOWED - Not Restricted)
CREATE OR REPLACE TRIGGER trg_emergency_audit_only
BEFORE INSERT OR UPDATE OR DELETE ON EMERGENCY_CONTACT
FOR EACH ROW
DECLARE
    v_audit_id NUMBER;
BEGIN
    -- Always allow emergency contact operations, but log them
    v_audit_id := log_audit_event(
        'EMERGENCY_CONTACT',
        CASE 
            WHEN INSERTING THEN 'INSERT'
            WHEN UPDATING THEN 'UPDATE'
            WHEN DELETING THEN 'DELETE'
        END,
        NVL(:NEW.contact_id, :OLD.contact_id),
        'SUCCESS'
    );
END;
/