package DataAccessObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import ValueObject.PurchaseVo;

/**
 * TblPurchaseDao
 * - 구매 내역을 관리하는 DAO 클래스
 * - purchase 테이블과 연결되어 SQL 실행 담당
 */
public class TblPurchaseDao {

    // DB 연결 정보 (Oracle 기준)
    private static final String URL = "jdbc:oracle:thin:@//localhost:1521/xe";
    private static final String USERNAME = "c##idev";
    private static final String PASSWORD = "1234";

    /**
     * DB 연결 객체(Connection)를 반환하는 내부 메서드
     * - try-with-resources 문으로 자동 close 처리 가능
     */
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    /**
     * [1] 구매 등록 (INSERT)
     * - 하나의 고객이 특정 상품을 구매한 내용을 저장
     * - 동일 고객/상품이라도 날짜가 다르면 다른 행으로 인정됨
     */
    public int insert(PurchaseVo vo) {
        String sql = "INSERT INTO purchase (customer_id, pcode, quantity, purchase_date) " +
                     "VALUES (?, ?, ?, sysdate)";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setString(1, vo.getCustomerId());
            pstmt.setString(2, vo.getPcode());
            pstmt.setInt(3, vo.getQuantity());
            return pstmt.executeUpdate();  // 성공 시 1 리턴
        } catch (Exception e) {
            System.out.println("구매 등록 예외: " + e.getMessage());
            return 0;
        }
    }

    /**
     * [2] 특정 고객의 구매 내역 조회 (customer_id로 검색)
     * - 고객이 구매한 모든 상품들을 조회하여 리스트로 반환
     */
    public List<PurchaseVo> selectByCustomer(String customerId) {
        List<PurchaseVo> list = new ArrayList<>();
        String sql = "SELECT pur_no, customer_id, pcode, purchase_date, quantity " +
                     "FROM purchase WHERE customer_id = ? ORDER BY purchase_date DESC";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setString(1, customerId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                list.add(new PurchaseVo(
                    rs.getInt("pur_no"),
                    rs.getString("customer_id"),
                    rs.getString("pcode"),
                    rs.getDate("purchase_date"),
                    rs.getInt("quantity")
                ));
            }
        } catch (Exception e) {
            System.out.println("구매 내역 조회 예외: " + e.getMessage());
        }

        return list;
    }

    /**
     * [3] 전체 구매 내역 조회
     * - 모든 고객, 모든 상품의 구매 기록을 반환
     */
    public List<PurchaseVo> selectAll() {
        List<PurchaseVo> list = new ArrayList<>();
        String sql = "SELECT pur_no, customer_id, pcode, purchase_date, quantity " +
                     "FROM purchase ORDER BY purchase_date DESC";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery()
        ) {
            while (rs.next()) {
                list.add(new PurchaseVo(
                    rs.getInt("pur_no"),
                    rs.getString("customer_id"),
                    rs.getString("pcode"),
                    rs.getDate("purchase_date"),
                    rs.getInt("quantity")
                ));
            }
        } catch (Exception e) {
            System.out.println("전체 구매 내역 조회 예외: " + e.getMessage());
        }

        return list;
    }
}
