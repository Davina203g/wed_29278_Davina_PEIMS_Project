CREATE OR REPLACE TRIGGER prevent_double_booking
BEFORE INSERT ON BOOKING
FOR EACH ROW
DECLARE
    v_exists NUMBER;
BEGIN
    -- Check if seat already booked for this trip
    SELECT COUNT(*)
    INTO v_exists
    FROM BOOKING
    WHERE trip_id = :NEW.trip_id
    AND seat_number = :NEW.seat_number;
    
    IF v_exists > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 
            'Seat ' || :NEW.seat_number || ' is already booked for this trip!');
    END IF;
END;
/