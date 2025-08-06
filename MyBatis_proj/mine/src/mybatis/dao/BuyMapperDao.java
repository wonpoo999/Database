package mybatis.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import mapper.BuyMapper;
import mybatis.config.SqlSessionBean;
import mybatis.vo.BuyVo;

/**
 * BuyMapperDao 클래스
 * - SqlSession을 통해 mapper.BuyMapper 인터페이스의 메서드를 실행
 * - 실제 SQL 처리는 BuyMapper.xml에 정의되어 있음
 * - DB 연결은 SqlSessionBean 클래스가 관리
 */
public class BuyMapperDao {
    // SqlSessionFactory는 SqlSession을 생성하는 공장 역할
    private SqlSessionFactory factory = SqlSessionBean.getSessionFactory();

    /**
     * 특정 고객 ID로 구매 내역 조회
     * @param customerId 고객 아이디
     * @return 구매 내역 목록(List<BuyVo>)
     */
    public List<BuyVo> selectByCustomerId(String customerId) {
        try (SqlSession session = factory.openSession()) {
            BuyMapper mapper = session.getMapper(BuyMapper.class);
            return mapper.selectByCustomerId(customerId);
        }
    }

    /**
     * 특정 상품 코드로 구매 내역 조회
     * @param pcode 상품코드
     * @return 구매 내역 목록(List<BuyVo>)
     */
    public List<BuyVo> selectByPcode(String pcode) {
        try (SqlSession session = factory.openSession()) {
            BuyMapper mapper = session.getMapper(BuyMapper.class);
            return mapper.selectByPcode(pcode);
        }
    }

    /**
     * 특정 연도 기준으로 구매 내역 조회
     * @param year 연도 (예: "2024")
     * @return 구매 내역 목록(List<BuyVo>)
     */
    public List<BuyVo> selectByYear(String year) {
        try (SqlSession session = factory.openSession()) {
            BuyMapper mapper = session.getMapper(BuyMapper.class);
            return mapper.selectByYear(year);
        }
    }

    /**
     * 특정 상품코드 기준으로 구매된 총 수량 계산
     * @param pcode 상품코드
     * @return 총 수량(int)
     */
    public int selectSumByPcode(String pcode) {
        try (SqlSession session = factory.openSession()) {
            BuyMapper mapper = session.getMapper(BuyMapper.class);
            return mapper.selectSumByPcode(pcode);
        }
    }
}
