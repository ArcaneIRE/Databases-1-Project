CREATE TABLE
    Addresses (
        id INTEGER PRIMARY KEY,
        line1 VARCHAR2(20 CHAR) NOT NULL,
        line2 VARCHAR2(20 CHAR) NOT NULL,
        line3 VARCHAR2(20 CHAR) NOT NULL,
        locality VARCHAR2(20 CHAR) NOT NULL,
        region VARCHAR2(20 CHAR) NOT NULL,
        postcode VARCHAR2(20 CHAR) NOT NULL,
        country VARCHAR2(20 CHAR) NOT NULL,
    );

CREATE TABLE
    People (
        id INTEGER PRIMARY KEY,
        person_name VARCHAR2(20 CHAR) NOT NULL,
        dob DATE NOT NULL,
        email VARCHAR2(255 CHAR) NOT NULL,
        phone_number VARCHAR2(15 CHAR) NOT NULL,
        address_id INTEGER NOT NULL,
        CONSTRAINT people_address_fk FOREIGN KEY (address_id) REFERENCES Addresses (id)
    );

CREATE TABLE
    Restaurants (
        restaurant_id INTEGER PRIMARY KEY,
        phone_number VARCHAR2(15 CHAR) NOT NULL,
        address_id INTEGER NOT NULL,
        CONSTRAINT restauraunt_address_fk FOREIGN KEY (address_id) REFERENCES Addresses (id)
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
        id INTEGER NOT NULL,
        person_id INTEGER NOT NULL,
        role VARCHAR2(20 CHAR) NOT NULL CHECK (role IN ('waiter', 'manager')),
        start_date DATE NOT NULL,
        restaurant_id INTEGER NOT NULL,
        CONSTRAINT staff_person_fk FOREIGN KEY (person_id) REFERENCES People (id),
        CONSTRAINT staff_restaurants_fk FOREIGN KEY (restaurant_id) REFERENCES Restaurants (id)
    );

CREATE TABLE
    Customers (
        id INTEGER PRIMARY KEY,
        person_id INTEGER,
        CONSTRAINT customer_person_fk FOREIGN KEY (person_id) REFERENCES People (id),
    );

CREATE TABLE
    BookingReceipts (
        id INTEGER PRIMARY KEY,
        timestamp TIMESTAMP default CURRENT_TIMESTAMP,
        num_people INTEGER NOT NULL,
        booking_method VARCHAR2(20 CHAR) NOT NULL,
        dining_table_id INTEGER NOT NULL,
        booking_customer_id INTEGER NOT NULL,
        waiter_id INTEGER NOT NULL,
        manager_id INTEGER NOT NULL,
        CONSTRAINT bookingreceipt_waiter_fk FOREIGN KEY (waiter_id) REFERENCES People (id),
        CONSTRAINT bookingreceipt_manager_fk FOREIGN KEY (waiter_id) REFERENCES People (id),
        CONSTRAINT bookingreceipt_diningtable_fk FOREIGN KEY (dining_table_id) DiningTables (id),
        CONSTRAINT bookingreceipt_bookingcustomer_fk FOREIGN KEY (booking_customer_id) Customers (id)
    );

CREATE
OR REPLACE FUNCTION is_customer_over_18 (customer_id NUMBER) RETURN NUMBER AS v_dob DATE;

v_age NUMBER;

BEGIN
    -- Query the dob from the Person table using the customer id
SELECT
    dob INTO v_dob
FROM
    Person
WHERE
    id = customer_id;

-- Calculate the age from the dob
v_age := trunc(months_between(sysdate, v_dob) / 12);

-- Return 1 if the age is over 18, 0 otherwise
RETURN CASE
    WHEN v_age >= 18 THEN 1
    ELSE 0
END;

END;

-- Create a constraint on the BookingReceipts table that uses the is_customer_over_18 UDF
ALTER TABLE
    BookingReceipts
ADD
    CONSTRAINT customer_over_18_ck CHECK (is_customer_over_18 (customer_id) = 1);
