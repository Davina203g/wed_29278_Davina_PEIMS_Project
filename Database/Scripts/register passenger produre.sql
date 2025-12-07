create or replace PROCEDURE register_passenger(
    p_full_name IN VARCHAR2,
    p_national_id IN VARCHAR2,
    p_phone IN VARCHAR2,
    p_emergency_name IN VARCHAR2,
    p_emergency_relation IN VARCHAR2,
    p_emergency_phone IN VARCHAR2
)
IS
    v_passenger_id NUMBER;
    v_contact_id NUMBER;
BEGIN
    -- Generate new passenger ID (max + 1)
    SELECT NVL(MAX(passenger_id), 0) + 1 
    INTO v_passenger_id 
    FROM PASSENGER;

    -- Generate new contact ID
    SELECT NVL(MAX(contact_id), 0) + 1 
    INTO v_contact_id 
    FROM EMERGENCY_CONTACT;

    -- Insert passenger
    INSERT INTO PASSENGER (passenger_id, full_name, national_id, phone_number)
    VALUES (v_passenger_id, p_full_name, p_national_id, p_phone);

    -- Insert emergency contact
    INSERT INTO EMERGENCY_CONTACT (contact_id, passenger_id, contact_name, relationship, contact_phone)
    VALUES (v_contact_id, v_passenger_id, p_emergency_name, p_emergency_relation, p_emergency_phone);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Registration successful! Passenger ID: ' || v_passenger_id);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END register_passenger;
