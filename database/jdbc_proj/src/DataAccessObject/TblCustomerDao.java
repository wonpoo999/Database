package DataAccessObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import ValueObject.CustomerVo; // 고객 정보를 저장하는 VO 클래스

/**
 * DAO 클래스 (Data Access Object)
 * - 데이터베이스 작업(SQL 실행)을 전담하는 클래스
 * - insert, update, delete, select 등 모든 쿼리 실행 로직 포함
 * - JDBC의 핵심 개념(Connection, PreparedStatement, ResultSet)을 통해 DB 연동 처리
 */
public class TblCustomerDao {

  // Oracle DB 연결 정보 (JDBC URL, 계정, 비밀번호)
  private static final String URL = "jdbc:oracle:thin:@//localhost:1521/xe";
  private static final String USERNAME = "c##idev";
  private static final String PASSWORD = "1234";

  /**
   * DB 연결 객체(Connection) 생성 메서드
   * - JDBC 드라이버는 DriverManager를 통해 자동 로드됨
   * - 매번 새로운 DB 연결 객체를 생성하고 반환
   * - 연결 후 꼭 닫아야 하며, try-with-resources 구문을 사용하면 자동으로 닫힘
   */
  private Connection getConnection() throws SQLException {
    return DriverManager.getConnection(URL, USERNAME, PASSWORD);
  }

  /**
   * [1] 고객 등록 (INSERT)
   * - 신규 고객 정보를 데이터베이스에 저장하는 메서드
   * - SQL의 ?는 바인딩 변수로, 값을 나중에 안전하게 넣기 위해 사용
   * @param vo : 고객 정보가 저장된 VO 객체
   * @return 성공 시 1, 실패 시 0
   */
  public int insert(CustomerVo vo) {
    int result = 0;
    String sql = "INSERT INTO \"tbl_customer#\" " +
                 "(customer_id, name, email, age, reg_date) " +
                 "VALUES (?, ?, ?, ?, sysdate)"; // reg_date는 현재 시간 자동 입력

    try (
      Connection conn = getConnection();
      PreparedStatement pstmt = conn.prepareStatement(sql)
    ) {
      pstmt.setString(1, vo.getCustomerId()); // 고객 ID
      pstmt.setString(2, vo.getName());       // 이름
      pstmt.setString(3, vo.getEmail());      // 이메일
      pstmt.setInt(4, vo.getAge());           // 나이

      result = pstmt.executeUpdate(); // 실행 → 성공 시 1, 실패 시 0
    } catch (Exception e) {
      System.out.println("예외 : " + e.getMessage()); // 예외 메시지 출력
    }

    return result;
  }

  /**
   * [2] 고객 이메일 수정 (UPDATE)
   * - 고객 ID 기준으로 해당 고객의 이메일만 수정
   * @param vo : 고객 ID와 수정할 이메일 정보 포함
   * @return 성공 시 1, 실패 시 0
   */
  public int update(CustomerVo vo) {
    int result = 0;
    String sql = "UPDATE \"tbl_customer#\" SET email = ? WHERE customer_id = ?";

    try (
      Connection conn = getConnection();
      PreparedStatement pstmt = conn.prepareStatement(sql)
    ) {
      pstmt.setString(1, vo.getEmail());        // 수정할 이메일
      pstmt.setString(2, vo.getCustomerId());   // 고객 식별 ID

      result = pstmt.executeUpdate(); // 실행 후 수정된 행 수 반환
    } catch (Exception e) {
      System.out.println("예외 : " + e.getMessage());
    }

    return result;
  }

  /**
   * [3] 고객 삭제 (DELETE)
   * - 고객 ID로 데이터베이스에서 해당 고객을 삭제
   * @param customerId : 삭제 대상 고객의 ID
   * @return 삭제 성공 시 1, 실패 시 0
   */
  public int delete(String customerId) {
    int result = 0;
    String sql = "DELETE FROM \"tbl_customer#\" WHERE customer_id = ?";

    try (
      Connection conn = getConnection();
      PreparedStatement pstmt = conn.prepareStatement(sql)
    ) {
      pstmt.setString(1, customerId);     // 삭제 조건 설정
      result = pstmt.executeUpdate();     // 실행 결과 반환
    } catch (Exception e) {
      System.out.println("예외 : " + e.getMessage());
    }

    return result;
  }

  /**
   * [4] 고객 단건 조회 (SELECT WHERE PK)
   * - 고객 ID로 특정 고객 정보를 조회
   * @param customerId : 조회할 고객의 ID
   * @return CustomerVo 객체 (고객 존재 X → null 반환)
   */
  public CustomerVo selectByPk(String customerId) {
    String sql = "SELECT * FROM \"tbl_customer#\" WHERE customer_id = ?";
    CustomerVo customer = null;

    try (
      Connection conn = getConnection();
      PreparedStatement pstmt = conn.prepareStatement(sql)
    ) {
      pstmt.setString(1, customerId);          // 조건 설정
      ResultSet rs = pstmt.executeQuery();     // SELECT 실행

      if (rs.next()) {
        // ResultSet에서 각 컬럼 값을 꺼내 VO 객체 생성
        customer = new CustomerVo(
          rs.getString("customer_id"),   // 고객 ID
          rs.getString("name"),          // 이름
          rs.getString("email"),         // 이메일
          rs.getInt("age"),              // 나이
          rs.getDate("reg_date")         // 가입일
        );
      }
    } catch (Exception e) {
      System.out.println("예외 : " + e.getMessage());
    }

    return customer;
  }

  /**
   * [5] 전체 고객 목록 조회 (SELECT *)
   * - 테이블의 모든 고객을 조회하여 리스트로 반환
   * - 최신 등록 순으로 정렬 (reg_date DESC)
   * @return 고객 목록 (List<CustomerVo>)
   */
  public List<CustomerVo> selectAll() {
    List<CustomerVo> list = new ArrayList<>();
    String sql = "SELECT * FROM \"tbl_customer#\" ORDER BY reg_date DESC";

    try (
      Connection conn = getConnection();
      PreparedStatement pstmt = conn.prepareStatement(sql);
      ResultSet rs = pstmt.executeQuery()
    ) {
      while (rs.next()) {
        list.add(new CustomerVo(
          rs.getString("customer_id"),
          rs.getString("name"),
          rs.getString("email"),
          rs.getInt("age"),
          rs.getDate("reg_date")
        ));
      }
    } catch (Exception e) {
      System.out.println("예외 : " + e.getMessage());
    }

    return list;
  }
}
