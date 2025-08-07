package mapper;  // 이 파일은 'mapper' 패키지에 속해 있음. 경로 = src/mapper

import java.util.List;
import java.util.Map;

import mybatis.vo.BuyVo;  // BuyVo 객체를 반환받기 위해 import

/**
 * BuyMapper 인터페이스
 * - XML 매퍼(BuyMapper.xml)에 정의된 SQL을 Java 메서드와 연결해줌
 * - 메서드 이름 = XML에서 <select id="..."> 와 정확히 일치해야 함
 * - 파라미터와 리턴 타입도 정확히 맞아야 오류 없음
 */
public interface BuyMapper {

    // ✅ 1. 특정 고객 ID로 구매내역 전체 조회
    //    - 매개변수: 고객 ID (String)
    //    - 반환값: 해당 고객의 구매 내역 목록
    List<BuyVo> selectByCustomerId(String customerId);

    // ✅ 2. 특정 상품 코드로 구매내역 조회
    //    - 매개변수: 상품 코드 (String)
    //    - 반환값: 해당 상품에 대한 구매 내역 목록
    List<BuyVo> selectByPcode(String pcode);

    // ✅ 3. 특정 연도로 구매내역 필터링
    //    - 매개변수: 연도 (예: "2024")
    //    - 반환값: 해당 연도의 구매 내역 목록
    List<BuyVo> selectByYear(String year);

    // ✅ 4. 특정 상품 코드에 대한 전체 구매 수량 합계
    //    - 매개변수: 상품 코드 (String)
    //    - 반환값: 총 수량 (정수형)
    int selectSumByPcode(String pcode);

    // ✅ 5. 전체 구매 수량 합계 (모든 수량을 단순 합산)
    //    - 매개변수: 없음
    //    - 반환값: 전체 수량 총합 (정수형)
    int selectTotalQuantity();

    // ✅ 6. 상품코드별 수량 집계 (GROUP BY PCODE)
    //    - 매개변수: 없음
    //    - 반환값: 상품코드별 수량 Map 리스트 (key: PCODE, TOTAL)
    List<Map<String, Object>> sumByPcodeGroup();

    // ✅ 7. 고객 ID별 수량 집계 (GROUP BY CUSTOMER_ID)
    //    - 매개변수: 없음
    //    - 반환값: 고객ID별 수량 Map 리스트 (key: CUSTOMER_ID, TOTAL)
    List<Map<String, Object>> sumByCustomerGroup();

    // ✅ 8. 연도별 수량 집계 (GROUP BY TO_CHAR(BUY_DATE, 'YYYY'))
    //    - 매개변수: 없음
    //    - 반환값: 연도별 수량 Map 리스트 (key: YEAR, TOTAL)
    List<Map<String, Object>> sumByYearGroup();

    // ✅ 9. 전체 구매 내역 전체 조회
List<BuyVo> selectAll();

}
