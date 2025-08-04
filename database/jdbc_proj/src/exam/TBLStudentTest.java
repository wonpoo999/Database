package exam;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

import util.OracleConnection;

public class TBLStudentTest {

  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);

    addStudent(sc);

    sc.close();
  }

  public static void addStudent(Scanner sc) {
    System.out.print("학번 >>> ");
    String stuno = sc.nextLine().trim();

    System.out.print("이름 >>> ");
    String name = sc.nextLine().trim();

    System.out.print("나이 >>> ");
    String age = sc.nextLine().trim();

    System.out.print("주소 >>> ");
    String address = sc.nextLine().trim();

    if (stuno.isEmpty() || name.isEmpty()) {
      System.out.println("필수 입력입니다.");
      return;
    }

    if (age.isEmpty())
      age = null;
    if (address.isEmpty())
      address = null;

    insert(stuno, name, age, address);
  }

  private static void insert(String stuno, String name, String age, String address) {
    Connection conn = null;
    PreparedStatement pstat = null;
    String sql = "INSERT INTO tbl_student(stuno, name, age, address) VALUES (?, ?, ?, ?)";
    try {
      conn = OracleConnection.getConnection();
      conn.setAutoCommit(false);

      pstat = conn.prepareStatement(sql);
      pstat.setString(1, stuno);
      pstat.setString(2, name);

      if (age != null) {
        pstat.setInt(3, Integer.parseInt(age));
      } else {
        pstat.setNull(3, java.sql.Types.INTEGER);
      }

      pstat.setString(4, address);

      pstat.executeUpdate();
      conn.commit();

      System.out.println("1개 행이 저장되었습니다.");
    } catch (SQLException | NumberFormatException e) {
      try {
        if (conn != null)
          conn.rollback();
        System.out.println("롤백 했습니다.");
      } catch (SQLException ex) {
        System.out.println("롤백 실패: " + ex.getMessage());
      }
      System.out.println("예외 발생: " + e.getMessage());
    } finally {
      try {
        if (pstat != null)
          pstat.close();
        if (conn != null)
          OracleConnection.close(conn);
      } catch (SQLException e) {
        System.out.println("리소스 해제 오류: " + e.getMessage());
      }
    }
  }
}
