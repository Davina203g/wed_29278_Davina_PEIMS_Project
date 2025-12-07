CREATE OR REPLACE TRIGGER protect_national_id
BEFORE UPDATE ON PASSENGER
FOR EACH ROW
BEGIN
    -- Only check national_id change
    IF :OLD.national_id != :NEW.national_id THEN
        RAISE_APPLICATION_ERROR(-20004, 
            'National ID cannot be changed!');
    END IF;
END;
/