import cx_Oracle

# Get Oracle Database connection
dbConn = cx_Oracle.connect("test/test@//gvenzl-virtual:1521/TEST")
cur = dbConn.cursor()

# Execute select
cur.execute("SELECT j.doc.firstName, j.doc.age FROM JSON j")

# Print results
res = cur.fetchall()
for r in res:
    print (r)

cur.close()
dbConn.close()
