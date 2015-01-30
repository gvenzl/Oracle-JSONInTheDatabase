package StoreAndRetrieve.java;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * This example shows how to retrieve JSON attributes from the Oracle Database
 * @author gvenzl
 *
 */
public class RetrieveData {

	public static void main(String[] args) throws SQLException {
	    // Connect to the database (ojdbcN.jar needs to be in the classpath)
	    Connection dbConn = DriverManager.getConnection("jdbc:oracle:thin:TEST/test@//gvenzl-virtual:1521/TEST");
	    // Create SELECT statement, retrieve first name and age
	    // Oracle allows me to use the Simple-Dot-Notation to directly extract attributes from the JSON
	    // In order to do so I have to specify an identifier for the table, in this case "j"
	    PreparedStatement stmt = dbConn.prepareStatement("SELECT j.doc.firstName, j.doc.age FROM JSON j");
	    // Run the query
	    ResultSet result = stmt.executeQuery();
	    
	    // loop over results and print the to the console
	    while (result.next()) {
	    	System.out.println(result.getString(1) + ", " + result.getString(2));
	    }
	}

}
