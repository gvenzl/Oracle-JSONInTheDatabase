package com.gvenzl;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import org.skife.jdbi.v2.DBI;
import org.skife.jdbi.v2.Handle;

public class JDBIJSONSupport {

	public static void main(String[] args) throws Exception {
		new JDBIJSONSupport().test();
	}
	
	private String readData() throws Exception {
		Scanner scanner = new Scanner (new File("src/main/resources/data.json"));
		String content = scanner.useDelimiter("\\Z").next();
		scanner.close();
		return content;
	}

	private void test() throws Exception {
		DBI dbi = new DBI("jdbc:oracle:thin:test/test@localhost:1521/DEV");
		Handle h = dbi.open();

		h.createStatement("INSERT INTO JDATA (payload) VALUES (:json)")
		    .bind("json", readData())
		    .execute();

		List<Map<String, Object>> rs = h.select("SELECT COUNT(1) amount FROM JDATA");
		Map<String, Object> row = rs.get(0);
		System.out.println("Documents in DB: " + row.get("amount"));
		
		h.close();
	}
}
