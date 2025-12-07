create or replace PROCEDURE show_empty_seats(p_trip_id IN NUMBER) IS
    -- All possible seats
    TYPE seat_array IS VARRAY(50) OF VARCHAR2(3);
    v_all_seats seat_array := seat_array('A1','A2','A3','A4','A5',
                                        'B1','B2','B3','B4','B5',
                                        'C1','C2','C3','C4','C5',
                                        'D1','D2','D3','D4','D5',
                                        'E1','E2','E3','E4','E5',
                                        'F1','F2','F3','F4','F5',
                                        'G1','G2','G3','G4','G5',
                                        'H1','H2','H3','H4','H5',
                                        'I1','I2','I3','I4','I5',
                                        'J1','J2','J3','J4','J5');

    CURSOR booked_seats_cursor IS
        SELECT seat_number
        FROM BOOKING
        WHERE trip_id = p_trip_id;

    v_seat BOOKING.seat_number%TYPE;
    v_count NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Empty seats for Trip ' || p_trip_id || ':');

    -- Check each seat
    FOR i IN 1..v_all_seats.COUNT LOOP
        BEGIN
            -- Try to find if seat is booked
            SELECT seat_number INTO v_seat
            FROM BOOKING
            WHERE trip_id = p_trip_id AND seat_number = v_all_seats(i);

            -- Seat is booked, do nothing
            NULL;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Seat is empty
                DBMS_OUTPUT.PUT(v_all_seats(i) || ' ');
                v_count := v_count + 1;

                -- New line every 10 seats
                IF MOD(v_count, 10) = 0 THEN
                    DBMS_OUTPUT.NEW_LINE;
                END IF;
        END;
    END LOOP;

    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT_LINE('Total empty seats: ' || v_count);
END show_empty_seats;
