-- Passenger volume per month
SELECT 
    TO_CHAR(trip_date, 'YYYY-MM') AS month,
    COUNT(*) AS total_passengers
FROM booking b
JOIN trip t ON b.trip_id = t.trip_id
GROUP BY TO_CHAR(trip_date, 'YYYY-MM')
ORDER BY month;

-- Busiest route
SELECT 
    t.departure_place || ' → ' || t.destination_place AS route,
    COUNT(*) AS passengers
FROM booking b
JOIN trip t ON b.trip_id = t.trip_id
GROUP BY t.departure_place, t.destination_place
ORDER BY passengers DESC;

-- Booking trends by day of week
SELECT 
    TO_CHAR(t.trip_date, 'DAY') AS day,
    COUNT(*) AS total_bookings
FROM booking b
JOIN trip t ON b.trip_id = t.trip_id
GROUP BY TO_CHAR(t.trip_date, 'DAY'), TO_CHAR(t.trip_date, 'D')
ORDER BY TO_CHAR(t.trip_date, 'D');

-- Seat utilization per trip
SELECT 
    t.trip_id,
    t.departure_place,
    t.destination_place,
    COUNT(b.booking_id) AS booked_seats
FROM trip t
LEFT JOIN booking b ON b.trip_id = t.trip_id
GROUP BY t.trip_id, t.departure_place, t.destination_place;
