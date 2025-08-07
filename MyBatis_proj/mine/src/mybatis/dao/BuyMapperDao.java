package mybatis.dao;

import java.util.List;
import java.util.Map;

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
    
    // SqlSessionFactory는 SqlSession을 생성하는 팩토리(공장) 역할
    private SqlSessionFactory factory = SqlSessionBean.getSessionFactory();

    /**
     * ✅ 1. 특정 고객 ID로 구매 내역 조회
     * @param customerId 고객 아이디
     * @return 해당 고객의 구매 내역 목록
     */
    public List<BuyVo> selectByCustomerId(String customerId) {
        try (SqlSession session = factory.openSession()) {  // 자동 자원 해제
            BuyMapper mapper = session.getMapper(BuyMapper.class);
            return mapper.selectByCustomerId(customerId);
        }
    }

    /**
     * ✅ 2. 특정 상품 코드로 구매 내역 조회
     * @param pcode 상품 코드
     * @return 해당 상품의 구매 내역 목록
     */
    public List<BuyVo> selectByPcode(String pcode) {
        try (SqlSession session = factory.openSession()) {
            BuyMapper mapper = session.getMapper(BuyMapper.class);
            return mapper.selectByPcode(pcode);
        }
    }

    /**
     * ✅ 3. 특정 연도 기준으로 구매 내역 조회
     * @param year 연도 (예: "2024")
     * @return 해당 연도의 구매 내역 목록
     */
    public List<BuyVo> selectByYear(String year) {
        try (SqlSession session = factory.openSession()) {
            BuyMapper mapper = session.getMapper(BuyMapper.class);
            return mapper.selectByYear(year);
        }
    }

    /**
     * ✅ 4. 특정 상품코드 기준으로 구매된 총 수량 계산
     * @param pcode 상품 코드
     * @return 해당 상품에 대한 총 구매 수량
     */
    public int selectSumByPcode(String pcode) {
        try (SqlSession session = factory.openSession()) {
            BuyMapper mapper = session.getMapper(BuyMapper.class);
            return mapper.selectSumByPcode(pcode);
        }
    }

    /**
     * ✅ 5. 전체 구매 수량 합계 (단순 SUM)
     * @return 전체 구매된 수량의 총합
     */
    public int selectTotalQuantity() {
        try (SqlSession session = factory.openSession()) {
            BuyMapper mapper = session.getMapper(BuyMapper.class);
            return mapper.selectTotalQuantity();
        }
    }

    /**
     * ✅ 6. 상품코드별 수량 집계
     * @return 각 상품코드별 수량 (Map 리스트)
     */
    public List<Map<String, Object>> sumByPcodeGroup() {
        try (SqlSession session = factory.openSession()) {
            BuyMapper mapper = session.getMapper(BuyMapper.class);
            return mapper.sumByPcodeGroup();
        }
    }

    /**
     * ✅ 7. 고객ID별 수량 집계
     * @return 각 고객ID별 수량 (Map 리스트)
     */
    public List<Map<String, Object>> sumByCustomerGroup() {
        try (SqlSession session = factory.openSession()) {
            BuyMapper mapper = session.getMapper(BuyMapper.class);
            return mapper.sumByCustomerGroup();
        }
    }

    /**
     * ✅ 8. 연도별 수량 집계
     * @return 각 연도별 수량 (Map 리스트)
     */
    public List<Map<String, Object>> sumByYearGroup() {
        try (SqlSession session = factory.openSession()) {
            BuyMapper mapper = session.getMapper(BuyMapper.class);
            return mapper.sumByYearGroup();
        }
    }

    /**
     * ✅ 9. 전체 구매 내역 전체 조회
     * @return TBL_BUY 전체 데이터 (전체 행)
     */
    public List<BuyVo> selectAll() {
        try (SqlSession session = factory.openSession()) {
            BuyMapper mapper = session.getMapper(BuyMapper.class);
            return mapper.selectAll();
        }
    }
}
