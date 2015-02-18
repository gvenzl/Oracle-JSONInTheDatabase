// Get the required Oracle driver module that I've built before
var oracledb = require("oracledb");

oracledb.getConnection({
    // The connection details to my database
    user : "TEST",
    password : "test",
    connectString : "gvenzl-virtual:1521/TEST"
  },
  function(err, connection) {
    if (err) {
      console.error(err.message);
      return;
  }

  // Retrieve data from the database
  retrieveData(connection);
});

function retrieveData (connection) {
  // Oracle allows us to use the Simple-Dot-Notation for extracting attributes from JSON documents.
  // However, to use that functionality we have to use a table identifier, in this case "j"
  connection.execute("SELECT j.doc.firstName, j.doc.age FROM JSON j",
    function(err, result) {
      if (err) {
        console.error(err.message);
        return;
      }
      // Print the result set
      console.log(result.rows);
  });
}
