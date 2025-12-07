CREATE OR REPLACE PROCEDURE schedule_trip(
    p_bus_id IN NUMBER,
    p_departure IN VARCHAR2,
    p_destination IN VARCHAR2,
    p_trip_date IN DATE,
    p_depart_time IN VARCHAR2
)
IS
    v_trip_id NUMBER;
    v_is_employee BOOLEAN;
    v_emp_name VARCHAR2(100);
BEGIN
    -- Check if current user is employee
    v_is_employee := is_current_user_employee();
    
    IF v_is_employee THEN
        -- Get employee name for logging
        BEGIN
            SELECT username INTO v_emp_name
            FROM employees WHERE username = USER;
            DBMS_OUTPUT.PUT_LINE('Employee ' || v_emp_name || ' scheduling trip...');
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_emp_name := USER;
        END;
    END IF;
    
    -- Original logic continues
    SELECT NVL(MAX(trip_id), 0) + 1 INTO v_trip_id FROM TRIP;
    
    INSERT INTO TRIP (trip_id, bus_id, departure_place, destination_place, trip_date, departure_time)
    VALUES (v_trip_id, p_bus_id, p_departure, p_destination, p_trip_date, 
            TO_TIMESTAMP(TO_CHAR(p_trip_date, 'DD-MON-YYYY') || ' ' || p_depart_time, 'DD-MON-YYYY HH24:MI'));
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('✓ Trip scheduled successfully! Trip ID: ' || v_trip_id);
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('✗ Error scheduling trip: ' || SQLERRM);
        ROLLBACK;
END schedule_trip;
/