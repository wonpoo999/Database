package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class OracleConnection {
    private static final String URL = "jdbc:oracle:thin:@//localhost:1521/xe";
    private static final String USERNAME = "c##idev";
    private static final String PASSWORD = "1234";

    // Getter 메서드 (필드 직접 노출 금지 권장)
    public static String getUrl() {
        return URL;
    }

    public static String getUsername() {
        return USERNAME;
    }

    public static String getPassword() {
        return PASSWORD;
    }

    // Connection 생성 메서드
    public static Connection getConnection() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        } catch (SQLException e) {
            System.out.println("오라클 DB 연결 실패 : " + e.getMessage());
        }
        return connection;
    }

    // Connection 해제 메서드
    public static void close(Connection connection) {
        try {
            if (connection != null)
                connection.close();
        } catch (SQLException e) {
            System.out.println("오라클 DB close 실패 : " + e.getMessage());
        }
    }

    // 테스트용 메인
    public static void main(String[] args) {
        Connection conn = getConnection();
        System.out.println("Connection 객체 생성 상태 : " + conn);
        if (conn != null) {
            System.out.println("Connection 구현 클래스 : " + conn.getClass().getName());
        }
    }
}
