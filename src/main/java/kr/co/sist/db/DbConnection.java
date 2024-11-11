package kr.co.sist.db;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * DB와 연결된 Connection을 반환하고,
 * DB관련 객체들의 연결을 끊는 일.
 * Singleton Pattern으로 작성된 클래스.
 */
public class DbConnection {
    private static DbConnection dbCon;

    private DbConnection() {
    }

    public static DbConnection getInstance() {
        if (dbCon == null) {
            dbCon = new DbConnection();
        }

        return dbCon;
    }

    /**
     * Connection을 반환하는 일.
     *
     * @return
     * @throws SQLException
     */
    public Connection getConnection() throws SQLException {

        Connection con = null;

        try {
            // 1. JNDI 사용 객체 생성
            Context ctx = new InitialContext();

            // 2. 설정된 DBCP에서 DB연결 객체(javax.sql.DataSource) 얻기
            DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/dbcp");

            // 3. DBCP에서 가져온 연결 객체로 부터 커넥션 얻기.
            con = ds.getConnection();
        } catch (NamingException ne) {
            ne.printStackTrace();
        }

        return con;
    }

    public Connection getConnection(String jndiName) throws SQLException {

        Connection con = null;
        try {
            // 1. JNDI 사용 객체 생성
            Context ctx = new InitialContext();

            // 2. 설정된 DBCP에서 DB연결 객체(javax.sql.DataSource) 얻기
            DataSource ds = (DataSource) ctx.lookup("java:/comp/env/jdbc/"+jndiName);

            // 3. DBCP에서 가져온 연결 객체로 부터 커넥션 얻기.
            con = ds.getConnection();
        } catch (NamingException ne) {
            ne.printStackTrace();
        }

        return con;
    }

    /**
     * DB 연결객체들의 연결을 끊는 일.
     *
     * @param rs
     * @param stmt
     * @param con
     * @throws SQLException
     */
    public void dbClose(ResultSet rs, Statement stmt, Connection con) throws SQLException {

        if (rs != null) {
            rs.close();
        }
        if (stmt != null) {
            stmt.close();
        }
        if (con != null) {
            con.close();
        }
    }
}
