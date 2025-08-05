package DataAccessObject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import ValueObject.ProductVo;

/**
 * TblProductDao 클래스
 * - tbl_product 테이블과 연동되는 DAO 클래스
 * - 상품 등록/조회/삭제 등의 SQL 실행 담당
 */
public class TblProductDao {

    // ✅ 데이터베이스 연결 정보 (Oracle XE 기준)
    private static final String URL = "jdbc:oracle:thin:@//localhost:1521/xe";
    private static final String USERNAME = "c##idev";
    private static final String PASSWORD = "1234";

    /**
     * 데이터베이스 연결을 생성하는 메서드
     */
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    // ----------------------------------------------
    // [1] 상품 등록 (INSERT)
    // @param vo : ProductVo 객체 (상품 정보)
    // @return 1: 등록 성공 / 0: 실패
    // ----------------------------------------------
    public int insert(ProductVo vo) {
        String sql = "INSERT INTO tbl_product (pcode, pname, category, maker, price) VALUES (?, ?, ?, ?, ?)";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setString(1, vo.getPcode());
            pstmt.setString(2, vo.getPname());
            pstmt.setString(3, vo.getCategory());
            pstmt.setString(4, vo.getMaker());
            pstmt.setInt(5, vo.getPrice());

            return pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("상품 등록 예외 : " + e.getMessage());
            return 0;
        }
    }

    // ----------------------------------------------
    // [2] 상품 전체 목록 조회
    // @return 상품 목록 (List<ProductVo>)
    // ----------------------------------------------
    public List<ProductVo> selectAll() {
        List<ProductVo> list = new ArrayList<>();
        String sql = "SELECT * FROM tbl_product ORDER BY pcode";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery()
        ) {
            while (rs.next()) {
                list.add(new ProductVo(
                    rs.getString("pcode"),
                    rs.getString("pname"),
                    rs.getString("category"),
                    rs.getString("maker"),
                    rs.getInt("price")
                ));
            }
        } catch (Exception e) {
            System.out.println("상품 전체 조회 예외 : " + e.getMessage());
        }

        return list;
    }

    // ----------------------------------------------
    // [3] 상품 검색 (상품명에 키워드 포함)
    // @param keyword : 검색할 문자열
    // @return 해당 상품 리스트
    // ----------------------------------------------
    public List<ProductVo> searchByKeyword(String keyword) {
        List<ProductVo> list = new ArrayList<>();
        String sql = "SELECT * FROM tbl_product WHERE pname LIKE '%' || ? || '%'";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setString(1, keyword);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                list.add(new ProductVo(
                    rs.getString("pcode"),
                    rs.getString("pname"),
                    rs.getString("category"),
                    rs.getString("maker"),
                    rs.getInt("Price")
                ));
            }
        } catch (Exception e) {
            System.out.println("상품 검색 예외 : " + e.getMessage());
        }

        return list;
    }

    // ----------------------------------------------
    // [4] 상품 삭제
    // @param pcode : 삭제할 상품 코드
    // @return 1: 성공 / 0: 실패
    // ----------------------------------------------
    public int delete(String pcode) {
        String sql = "DELETE FROM tbl_product WHERE pcode = ?";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setString(1, pcode);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("상품 삭제 예외 : " + e.getMessage());
            return 0;
        }
    }

    // ----------------------------------------------
    // [5] 상품 단건 조회 (PK 기준)
    // @param pcode : 조회할 상품 코드
    // @return ProductVo 객체 / 없으면 null
    // ----------------------------------------------
    public ProductVo selectByPk(String pcode) {
        String sql = "SELECT * FROM tbl_product WHERE pcode = ?";

        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setString(1, pcode);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return new ProductVo(
                    rs.getString("pcode"),
                    rs.getString("pname"),
                    rs.getString("category"),
                    rs.getString("maker"),
                    rs.getInt("Price")
                );
            }
        } catch (Exception e) {
            System.out.println("상품 단건 조회 예외 : " + e.getMessage());
        }

        return null;
    }
    // [6] 상품 정보 수정
public int update(ProductVo vo) {
    String sql = "UPDATE tbl_product SET pname=?, category=?, maker=?, price=? WHERE pcode=?";

    try (
        Connection conn = getConnection();
        PreparedStatement pstmt = conn.prepareStatement(sql)
    ) {
        pstmt.setString(1, vo.getPname());
        pstmt.setString(2, vo.getCategory());
        pstmt.setString(3, vo.getMaker());
        pstmt.setInt(4, vo.getPrice());
        pstmt.setString(5, vo.getPcode());

        return pstmt.executeUpdate();
    } catch (Exception e) {
        System.out.println("상품 수정 예외 : " + e.getMessage());
        return 0;
    }
}

}
