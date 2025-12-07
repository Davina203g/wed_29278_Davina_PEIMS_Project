create or replace PROCEDURE simple_book_ticket(
    p_trip_id IN NUMBER,
    p_passenger_id IN NUMBER,
    p_seat_number IN VARCHAR2
)
IS
    v_ticket_number VARCHAR2(20);
    v_max_id NUMBER;
BEGIN
    -- Generate ticket number
    v_ticket_number := 'TKT-' || p_trip_id || '-' || p_seat_number || '-' || 
                      TO_CHAR(SYSDATE, 'DDMMHH24MI');

    -- Find max booking_id and add 1
    SELECT NVL(MAX(booking_id), 0) + 1 
    INTO v_max_id 
    FROM BOOKING;

    -- Insert booking
    INSERT INTO BOOKING (booking_id, trip_id, passenger_id, seat_number, ticket_number)
    VALUES (v_max_id, p_trip_id, p_passenger_id, p_seat_number, v_ticket_number);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Ticket booked! ID: ' || v_max_id || ', Ticket: ' || v_ticket_number);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END simple_book_ticket;