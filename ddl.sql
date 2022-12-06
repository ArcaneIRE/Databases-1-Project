DROP TABLE
    BookingGuests;

DROP TABLE
    BookingReceipts;

DROP TABLE
    Customers;

DROP TABLE
    Staff;

DROP TABLE
    DiningTables;

DROP TABLE
    Restaurants;

DROP TABLE
    People;

DROP TABLE
    Addresses;

CREATE TABLE
    Addresses (
        id INTEGER PRIMARY KEY,
        line1 VARCHAR2(20 CHAR) NOT NULL,
        line2 VARCHAR2(20 CHAR),
        line3 VARCHAR2(20 CHAR),
        locality VARCHAR2(20 CHAR),
        region VARCHAR2(20 CHAR) NOT NULL,
        postcode VARCHAR2(20 CHAR),
        country VARCHAR2(20 CHAR) NOT NULL
    );

CREATE TABLE
    People (
        id INTEGER PRIMARY KEY,
        person_name VARCHAR2(20 CHAR) NOT NULL,
        dob DATE NOT NULL,
        phone_number VARCHAR2(15 CHAR) NOT NULL,
        address_id INTEGER NOT NULL,
        CONSTRAINT people_address_fk FOREIGN KEY (address_id) REFERENCES Addresses (id)
    );

CREATE TABLE
    Restaurants (
        id INTEGER PRIMARY KEY,
        phone_number VARCHAR2(15 CHAR) NOT NULL,
        address_id INTEGER NOT NULL,
        CONSTRAINT restaurant_address_fk FOREIGN KEY (address_id) REFERENCES Addresses (id)
    );

CREATE TABLE
    DiningTables (
        id INTEGER PRIMARY KEY,
        seats INTEGER NOT NULL,
        location VARCHAR2(20 CHAR) NOT NULL,
        restaurant_id INTEGER NOT NULL,
        CONSTRAINT diningtable_restaurant_fk FOREIGN KEY (restaurant_id) REFERENCES Restaurants (id)
    );

CREATE TABLE
    Staff (
        id INTEGER PRIMARY KEY,
        person_id INTEGER NOT NULL,
        role VARCHAR2(20 CHAR) NOT NULL CHECK (role IN ('waiter', 'manager')),
        start_date DATE NOT NULL,
        branch VARCHAR2(20 CHAR) NOT NULL,
        email VARCHAR2(255 CHAR) NOT NULL CHECK (email LIKE '%@burgershack.com'),
        restaurant_id INTEGER NOT NULL,
        CONSTRAINT staff_person_fk FOREIGN KEY (person_id) REFERENCES People (id),
        CONSTRAINT staff_restaurants_fk FOREIGN KEY (restaurant_id) REFERENCES Restaurants (id)
    );

CREATE TABLE
    Customers (
        id INTEGER PRIMARY KEY,
        person_id INTEGER,
        CONSTRAINT customer_person_fk FOREIGN KEY (person_id) REFERENCES People (id)
    );

CREATE TABLE
    BookingReceipts (
        id INTEGER PRIMARY KEY,
        timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        num_people INTEGER NOT NULL,
        booking_method VARCHAR2(20 CHAR) NOT NULL,
        dining_table_id INTEGER NOT NULL,
        booking_customer_id INTEGER NOT NULL,
        age INTEGER NOT NULL,
        waiter_id INTEGER NOT NULL,
        manager_id INTEGER NOT NULL,
        CONSTRAINT bookingreceipt_waiter_fk FOREIGN KEY (waiter_id) REFERENCES Staff (id),
        CONSTRAINT bookingreceipt_manager_fk FOREIGN KEY (manager_id) REFERENCES Staff (id),
        CONSTRAINT bookingreceipt_diningtable_fk FOREIGN KEY (dining_table_id) REFERENCES DiningTables (id),
        CONSTRAINT bookingreceipt_bookingcustomer_fk FOREIGN KEY (booking_customer_id) REFERENCES Customers (id)
    );

CREATE TABLE
    BookingGuests (
        booking_id INTEGER NOT NULL,
        customer_id INTEGER NOT NULL,
        CONSTRAINT bc_booking_fk FOREIGN KEY (booking_id) REFERENCES BookingReceipts (id),
        CONSTRAINT bc_customer_fk FOREIGN KEY (customer_id) REFERENCES Customers (id),
        PRIMARY KEY (booking_id, customer_id)
    );

CREATE
OR REPLACE TRIGGER check_customer_age BEFORE
INSERT
    ON BookingReceipts FOR EACH ROW
DECLARE
    customer_age NUMBER;

BEGIN
    -- Calculate the age of the customer based on their DOB
SELECT
    FLOOR(MONTHS_BETWEEN(SYSDATE, p.dob) / 12) INTO customer_age
FROM
    People p
WHERE
    p.id = :NEW.booking_customer_id;

-- Check if the customer's age is over 18
IF customer_age < 18 THEN RAISE_APPLICATION_ERROR (
    -20001,
    'Customer must be over 18 to create a BookingReceipt'
);

END IF;

END;
