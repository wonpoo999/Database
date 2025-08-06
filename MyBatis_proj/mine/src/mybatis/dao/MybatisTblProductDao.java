package mybatis.dao;

import java.io.Reader;
import java.util.List;

import mybatis.vo.ProductVo;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/**
 * MyBatis를 사용하여 tbl_product 테이블과 연동되는 DAO 클래스
 * 주요 기능: 상품 전체 조회, 상품 코드/이름으로 조회, 등록, 삭제
 */
public class MybatisTblProductDao {

    // ✅ SqlSessionFactory는 MyBatis가 DB에 접근하기 위한 핵심 객체
    private static SqlSessionFactory factory;

    // ✅ 정적 초기화 블럭에서 config XML을 읽어 factory 초기화
    static {
        try {
            Reader r = Resources.getResourceAsReader("mybatis/config/mybatis-config.xml");
            factory = new SqlSessionFactoryBuilder().build(r);
            r.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ✅ 전체 상품 조회
    public List<ProductVo> selectAll() {
        SqlSession session = factory.openSession();
        List<ProductVo> list = session.selectList("tblproduct.selectAll");
        session.close();
        return list;
    }

    // ✅ 상품 코드(PK)로 한 개 상품 조회
    public ProductVo selectByPcode(String pcode) {
        SqlSession session = factory.openSession();
        ProductVo vo = session.selectOne("tblproduct.selectByPcode", pcode);
        session.close();
        return vo;
    }

// ✅ 상품명으로 검색해서 중복 확인
public List<ProductVo> selectByPname(String pname) {
    SqlSession session = factory.openSession();
    List<ProductVo> list = session.selectList("tblproduct.selectByPname", pname);
    session.close();
    return list;
}


    // ✅ 상품 등록 (insert)
    public int insert(ProductVo vo) {
        SqlSession session = factory.openSession();
        int result = session.insert("tblproduct.insert", vo);
        session.commit(); // INSERT, UPDATE, DELETE는 반드시 commit 해야 DB에 반영됨
        session.close();
        return result;
    }

    // ✅ 상품 삭제
    public int delete(String pcode) {
        SqlSession session = factory.openSession();
        int result = session.delete("tblproduct.delete", pcode);
        session.commit();
        session.close();
        return result;
    }
}
