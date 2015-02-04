package StoreAndRetrieve.java;

import java.sql.Clob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Random;

/**
 * This example shows how to load JSON data into the Oracle Database
 * @author gvenzl
 *
 */
public class LoadData {

  /**
   * Inner hepler class for holind some samples values for the JSON generation
   * @author gvenzl
   *
   */
  private static class Person {
  
    protected static String[] firstName = { "John", "Markus", "Gerald", "Adrian", "Dominik",
                                            "Andrew", "David", "Edward", "Martin", "Penny" };
    private static String[] lastName = { "Nangle", "Gratzer", "Venzl", "Richmond", "Ashley",
                                         "Bond", "Smith", "Stadler", "Avril", "Jones" };
    private static Integer[] age = { 29, 43, 48, 42, 21, 32, 56 };
  }
    
  public static void main(String[] args) throws SQLException, InterruptedException {
    // Connect to the database (ojdbcN.jar needs to be in the classpath)
    Connection dbConn = DriverManager.getConnection("jdbc:oracle:thin:TEST/test@//gvenzl-virtual:1521/TEST");
    // Turn auto commit off (turned on by default)
    dbConn.setAutoCommit(false);
    // Create insert statement
    PreparedStatement stmt = dbConn.prepareStatement("INSERT INTO JSON VALUES (?)");
    
    while (true) {
	    // Create a new Clob instance as I'm inserting into a CLOB data type
	    Clob clob = dbConn.createClob();
	    // Store my JSON into the CLOB
	    clob.setString(1, generateJSON());
	    // Set clob instance as input parameter for INSERT statement
	    stmt.setClob(1, clob);
	    // Execute the INSERT statement
	    stmt.execute();
	    // Free up resource
	    clob.free();
	    // Commit inserted row to the database
	    dbConn.commit();
	    Thread.sleep(2000);
    }
  }
  
  /**
   * This function creates a simple JSON document
   * @return The generated JSON document
   */
  private static String generateJSON() {
    Random gen = new Random();
    // Generate new random JSON based on static values
    return "{ " +
            " firstName: \"" + Person.firstName[gen.nextInt(Person.firstName.length)] + "\", " +
    		" lastName: \"" + Person.lastName[gen.nextInt(Person.lastName.length)] + "\", " +
    		" age: \"" + Person.age[gen.nextInt(Person.age.length)] + "\" " +
          " }";
  }
}
