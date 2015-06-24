-- Create JSON table
CREATE TABLE JSON (doc CLOB CONSTRAINT valid_json CHECK (doc IS JSON));

-- Insert sample data set
INSERT INTO JSON VALUES (
'{
  "firstName": "Gerald",
  "lastName": "Venzl",
  "workAddress": [
    {
      "postCode": "EC2",
      "country": "United Kingdom",
      "countryCode": "UK"
    },
    {
      "postCode": "RG6",
      "country": "United Kingdom",
      "countryCode": "UK"
    },
    {
      "postCode": 94065,
      "country": "United States",
      "countryCode": "US",
      "stateCode": "CA"
    }
  ]
}');
COMMIT;

-- SDN-query on post code
SELECT j.doc.workAddress.postCode FROM JSON j;
