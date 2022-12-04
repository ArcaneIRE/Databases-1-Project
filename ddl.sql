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
