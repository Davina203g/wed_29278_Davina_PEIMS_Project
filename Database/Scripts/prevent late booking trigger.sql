CREATE OR REPLACE TRIGGER prevent_late_booking
BEFORE INSERT ON BOOKING
FOR EACH ROW
DECLARE
    v_departure_time TIMESTAMP;
BEGIN
    -- Get trip departure time
    SELECT departure_time INTO v_departure_time
    FROM TRIP WHERE trip_id = :NEW.trip_id;
    
    -- Check if trying to book after departure
    IF SYSDATE > v_departure_time THEN
        RAISE_APPLICATION_ERROR(-20002, 
            'Cannot book ticket. Trip has already departed!');
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20003, 'Trip not found!');
END;
/