 -- Contributors:
-- David Corcoran – D22126022 
-- Kai Reid – C21745961 
--
--
--
-- One UPDATE or one DELETE combined with a subquery
--
-- Updates the number of people in a booking by counting the number of people
-- associated with that booking in another table
UPDATE
    BookingReceipts
SET
    BookingReceipts.num_people = (
        SELECT
            COUNT(customer_id)
        FROM
            BookingGuests
        WHERE
            BookingReceipts.id = BookingGuests.booking_id
    );

--  One selection function CASE/DECODE
--
-- Uses CASE to give a readable alias for each table size
SELECT
    id AS "Table ID",
    location,
    CASE
        WHEN seats = 2 THEN 'Small'
        WHEN seats = 4 THEN 'Medium'
        WHEN seats = 6 THEN 'Large'
        WHEN seats = 8 THEN 'Extra Large'
        ELSE 'Size not found'
    END AS "TABLE SIZE",
FROM
    DiningTables;

--  One INNER JOIN using a GROUP function
--
-- Finds the oldest staff member in each role and returns their birthday
SELECT
    staff.role,
    MIN(people.dob) AS "Oldest Birthdate"
FROM
    Staff
    INNER JOIN People ON Staff.person_id = People.id
GROUP BY
    staff.role;

--  One LEFT OUTER JOIN
--
-- Lists all people from the people table, alongside their bookings and booking size, if they have any.
SELECT
    People.person_name,
    BookingReceipts.id AS "Booking ID",
    BookingReceipts.num_people
FROM
    People
    LEFT OUTER JOIN BookingReceipts ON People.id = BookingReceipts.booking_customer_id;

--  One RIGHT OUTER JOIN
--
-- Lists all bookings and contact information for each person at that booking.
-- This could be used for contact tracing, for example.
SELECT
    BookingGuests.booking_id,
    People.person_name,
    Customers.email
FROM
    Customers
    RIGHT OUTER JOIN BookingGuests ON Customers.id = BookingGuests.customer_id
    INNER JOIN People ON BookingGuests.customer_id = People.id
ORDER BY
    BookingGuests.booking_id;

--  One UNION
-- 
-- Returns the following 4 shared attributes of all Staff and Customers
SELECT
    person_name,
    dob,
    phone_number,
    email
FROM
    People
    JOIN Staff ON People.id = Staff.person_id
UNION
SELECT
    person_name,
    dob,
    phone_number,
    email
FROM
    People
    JOIN Customers ON People.id = Customers.person_id;

--  One INTERSECT
--  One VIEW
COMMIT;
