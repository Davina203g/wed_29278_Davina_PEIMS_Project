
-- Get all buses
SELECT * FROM bus ORDER BY bus_id;

-- Get all trips with assigned bus
SELECT 
    t.trip_id,
    b.plate_number,
    t.departure_place,
    t.destination_place,
    t.trip_date,
    t.departure_time
FROM trip t
JOIN bus b ON t.bus_id = b.bus_id
ORDER BY t.trip_date DESC;

-- Get all passengers
SELECT 
    passenger_id,
    full_name,
    national_id,
    phone_number
FROM passenger
ORDER BY full_name;

-- Passenger bookings with trip details
SELECT 
    p.full_name,
    b.ticket_number,
    t.departure_place,
    t.destination_place,
    t.trip_date,
    b.seat_number
FROM booking b
JOIN passenger p ON b.passenger_id = p.passenger_id
JOIN trip t ON b.trip_id = t.trip_id
ORDER BY t.trip_date DESC;
