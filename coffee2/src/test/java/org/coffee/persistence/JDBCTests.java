package org.coffee.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {

	static {
		try {
			//Class.forName("com.mysql.jdbc.Driver");
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testConnection() {

		//try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "book_ex","book_ex")) {
		try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@192.168.56.73:1521:xe", "coffee","1234")) {
			log.info(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}

}
