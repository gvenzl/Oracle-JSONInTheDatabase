// Function for generating random JSON documents

var person = {
  firstName: ["John", "Markus", "Gerald", "Adrian", "Dominik",
                   "Andrew", "David", "Edward", "Martin", "Penny"],
  lastName: ["Nangle", "Gratzer", "Venzl", "Richmond", "Ashley",
                   "Bond", "Smith", "Stadler", "Avril", "Jones"],
  age: [29, 43, 48, 42, 21, 32, 56]
};

function generateJSON() {
  var data = {
    firstName: person.firstName[Math.floor(Math.random()*person.firstName.length)],
    lastName: person.lastName[Math.floor(Math.random()*person.lastName.length)],
    age: person.age[Math.floor(Math.random()*person.age.length)]
  };
  return JSON.stringify(data);
}

// Get the required Oracle driver module that I've built before
var oracledb = require("oracledb");

// Set interval to execute code every 2 seconds
setInterval(function () {
  // Open a connection to the database
  oracledb.getConnection({
      // The connection details to my database
      user : "TEST",
      password : "test",
      connectString : "gvenzl-virtual:1521/TEST"
    },
    // Callback function holding our connection
    function(err, connection) {
      if (err) {
        console.error(err.message);
        return;
      }
      // Execute an insert into the database
      connection.execute("INSERT INTO JSON VALUES (:jsonDoc)",
        // Bind jsonDoc to the return value of gererateJSON() function
        {jsonDoc: generateJSON()},
        // Callback function holding our result
        function(err, result) {
          if (err) {
            console.error(err.message);
            return;
          }
          // Commit data to the database
          connection.commit(function (err) {
            if (err) {
              console.error(err.message);
              return;
            }
          });
          // Get amount of inserted rows. This will be 1 but gives a nice example of how to use rowsAffected
          console.log(result.rowsAffected + " row inserted.");
      });
  });
}, 2000);
