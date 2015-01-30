// Function for generating random JSON documents

var person = {
  firstName: ["John", "Markus", "Gerald", "Adrian", "Dominik",
                   "Andrew", "David", "Edward", "Martin", "Penny"],
  lastName: ["Nangle", "Gratzer", "Venzl", "Richmond", "Ashley",
                   "Bond", "Smith", "Stadler", "Avril", "Jones"],
  age: [29, 43, 48, 42, 21, 32, 56]
}

function generateJSON() {
  //TODO: Implement random JSON generation
  return '{ "firstName": "Gerald", "lastName": "Venzl", "age": 29 }';
}

// Get the required Oracle driver module that I've built before
var oracledb = require("oracledb");

oracledb.getConnection({
    // The connection details to my database
    user : "TEST",
    password : "test",
    connectString : "localhost:1521/TEST"
  },
  function(err, connection) {
    if (err) {
      console.error(err.message);
      return;
  }

  while (true) {
    // Insert data into the database
    insert(connection);
    //TODO: Implement 2 second sleep
  }
});

function insert (connection) {
  connection.execute("INSERT INTO JSON VALUES (:jsonDoc)",
    {jsonDoc: generateJSON()},
    function(err, result) {
      if (err) {
        console.error(err.message);
        return;
      }
      // Get amount of inserted rows. This will be 1 but gives a nice example of how to use rowsAffected
      console.log(result.rowsAffected + " row inserted.");
    });

  connection.commit(function (err) {
    if (err) {
      console.error(err.message);
      return;
    }
  });
}
