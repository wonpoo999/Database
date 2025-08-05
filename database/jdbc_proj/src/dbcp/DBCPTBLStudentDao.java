package dbcp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

public class DBCPTBLStudentDao {
    // DataSource를 통해 Connection 객체 생성.
  private final DataSource dataSource = DBConnectionPool.getDataSource();

  public void updateAddress(String stuno, String address) {
    String sql = "update tbl_student set address = ? where stuno = ?";
    try ( // try with resources : 자동 close
        Connection conn = dataSource.getConnection();
        PreparedStatement pstat = conn.prepareStatement(sql);) {
      pstat.setString(1, address);
      pstat.setString(2, stuno);
      pstat.executeUpdate();
    } catch (SQLException e) {
      System.out.println("SQL 예외 : " + e.getMessage());
    } // finally 없음. 자동 close 구문

  }

  public void insert(String stuno, String name, String age, String address) {
    String sql = "insert into tbl_student(stuno,name,age,address) values (?,?,?,?)";
    try (
        Connection conn = dataSource.getConnection();
        PreparedStatement pstat = conn.prepareStatement(sql);) {
            
            System.out.println("conn autocommit:" + conn.getAutoCommit()); // 기본값은 true
      pstat.setString(1, stuno);
      pstat.setString(2, name);
      pstat.setString(3, age); // setInt(3,null) 불가. 오라클에서는 문자열을 number 타입으로 자동캐스팅
      pstat.setString(4, address);

      pstat.executeUpdate();
      System.out.println("1개 행이 저장되었습니다.");
    } catch (SQLException e) {
      System.out.println("insert 예외 : " + e.getMessage());
    }

      }
  public boolean exists(String stuno) {
    String sql = "SELECT 1 FROM tbl_student WHERE stuno = ?";
    try (
        Connection conn = dataSource.getConnection();
        PreparedStatement pstmt = conn.prepareStatement(sql)
    ) {
        pstmt.setString(1, stuno);
        return pstmt.executeQuery().next();  // 존재하면 true 반환
    } catch (SQLException e) {
        // conn.rollback(); // 롤백을 하려면 try~catch~finally 사용해야 한다.
        System.out.println("예외 : " + e.getMessage());
        return false;
    }
}

}