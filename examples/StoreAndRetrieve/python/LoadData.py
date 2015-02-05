import json
import random
import time
import cx_Oracle

# Helper variables holding some example data to generate JSON from
firstName = [ "John", "Markus", "Gerald", "Adrian", "Dominik", "Andrew", "David", "Edward", "Martin", "Penny" ]
lastName = [ "Nangle", "Gratzer", "Venzl", "Richmond", "Ashley", "Bond", "Smith", "Stadler", "Avril", "Jones" ]
age = [ 29, 43, 48, 42, 21, 32, 56 ]

def generateJSON():
    """Generate random JSON document"""
    return json.dumps({ "firstName": firstName[random.randint(0, len(firstName)-1)],  
                        "lastName": lastName[random.randint(0, len(lastName)-1)],
                        "age": age[random.randint(0,len(age)-1)] })

# Main try clause (to gracefully catch Ctrl+C and close DB connection)
try:
    # Open Oracle Database connection
    dbConn = cx_Oracle.connect('test/test@//gvenzl-virtual:1521/TEST')
    
    # Open and prepare cursor
    cur = dbConn.cursor()
    cur.prepare("INSERT INTO JSON VALUES (:input)")
 
    # Endless loop until user hits Ctrl+C
    while True:
        # Set "input" directory bind variable to generated JSON
        input = [ (generateJSON()) ]
        # Execute the statement. The cx_Oracle documentation says that it won't re-prepare the statement if it is the same as before. So technically I could just post the insert statement directly and don't prepare the cursor at all. However, for educational purposes it is better to show how to prepare a cursor and use None to make use of the prepared cursor.
        cur.execute(None, input)
        # Commit changes to the database
        dbConn.commit()
        print (str(cur.rowcount) + " row(s) inserted")

        # Sleep for 2 seconds
        time.sleep(2)
# Capture Ctrl+C and SystemExit and close the dataase connection
except (KeyboardInterrupt, SystemExit):
    print ("Closing Database connection")
    cur.close()
    dbConn.close()
    print ("Stopping program")
