SET SERVEROUTPUT ON;
BEGIN 
   -- Select every json document and print the result in a cursor loop
   FOR cur IN (SELECT j.doc.firstName, j.doc.age FROM JSON j) LOOP
      DBMS_OUTPUT.PUT_LINE(cur.firstName || ', ' || cur.age);
   END LOOP;
END;
/
