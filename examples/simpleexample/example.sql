-- Create JSON table
CREATE TABLE JSON (doc CLOB CONSTRAINT valid_json CHECK (doc IS JSON));

-- Insert a record
INSERT INTO JSON VALUES (
'{
  "firstName": "Gerald",
  "lastName": "Venzl",
  "location": {
    "country": "UK",
    "city": "London",
    "postCode": "EC2M"
  }
}');

COMMIT;

-- Retrieve record using Simple-Dot-Notation
SELECT j.doc.firstName, j.doc.location.city FROM JSON j;

-- Insert second record
INSERT INTO JSON VALUES (
'{
  "firstName": "Dominic",
  "middleName": "Patrick",
  "lastName": "Giles",
  "location": {
    "country": "UK",
    "city": "London"
  }
}');

COMMIT;

-- Retrieve first, middle and last name (middle name does not exist in first document)
SELECT j.doc.firstName, j.doc.middleName, j.doc.lastName
  FROM JSON j;

-- Retrieve last name, city and post code (post code does not exist in second document)
SELECT j.doc.lastName, j.doc.location.city as "CITY", j.doc.location.postCode as "POST CODE"
  FROM JSON j;
