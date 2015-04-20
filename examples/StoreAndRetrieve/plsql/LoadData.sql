SET SERVEROUTPUT ON;
DECLARE
   -- Create two anonymous types for holding the array of data
   TYPE t_stringVarray IS VARRAY(10) OF VARCHAR2(25);
   TYPE t_numberVarray IS VARRAY(7) OF NUMBER;
   -- Create 3 arrays holding the test data
   v_firstName CONSTANT t_stringVarray := t_stringVarray( 'John', 'Markus', 'Gerald', 'Adrian', 'Dominik', 'Andrew', 'David', 'Edward', 'Martin', 'Penny' );
   v_lastName  CONSTANT t_stringVarray := t_stringVarray( 'Nangle', 'Gratzer', 'Venzl', 'Richmond', 'Ashley', 'Bond', 'Smith', 'Stadler', 'Avril', 'Jones' );
   v_age       CONSTANT t_numberVarray := t_numberVarray( 29, 43, 48, 42, 21, 32, 56 );
   -- declare a CLOB holding the JSON string
   v_json      CLOB; 
BEGIN
   WHILE 1=1 LOOP
      -- Create JSON string
      v_json := TO_CLOB('{ "firstName": "' || v_firstName(TRUNC(DBMS_RANDOM.VALUE(1,v_firstName.COUNT))) || '", ' ||
                         ' "lastName": "' || v_lastName(TRUNC(DBMS_RANDOM.VALUE(1,v_lastName.COUNT))) || '", ' ||
                         ' "age": ' || v_age(TRUNC(DBMS_RANDOM.VALUE(1,v_age.COUNT))) ||
                        ' }');
      -- Insert JSON into the database
      INSERT INTO JSON VALUES (v_json);
      DBMS_OUTPUT.PUT_LINE(TO_CHAR(SQL%ROWCOUNT) || ' row(s) inserted.');
      -- Commit the inserted row
      COMMIT;
      DBMS_LOCK.SLEEP(2);
   END LOOP;
END;
/
