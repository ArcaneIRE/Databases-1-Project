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
        CONSTRAINT fk_address_id FOREIGN KEY (address_id) REFERENCES Addresses (id)
    );
