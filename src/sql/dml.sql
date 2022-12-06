 --  Include all the following statements, using comments to highlight when one is
-- being addressed and include an explanation of their implementation.
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
--  One INNER JOIN using a GROUP function
--  One LEFT OUTER JOIN
--  One RIGHT OUTER JOIN
--  One UNION
--  One INTERSECT
--  One VIEW
