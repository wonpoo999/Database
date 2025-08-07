package test;  // 이 클래스는 test 패키지 안에 있음

import java.util.List;
import java.util.Map;

import mybatis.dao.BuyMapperDao;   // DAO 클래스 import
import mybatis.vo.BuyVo;           // 결과로 받을 VO 클래스 import

/**
 * BuyMapperTest 클래스
 * - BuyMapperDao의 메서드를 호출해서 DB와의 연동 결과를 확인하는 테스트 클래스
 * - 콘솔에 결과 출력으로 실제 SQL 동작을 검증할 수 있음
 */
public class BuyMapperTest {
    public static void main(String[] args) {
        // ✅ DAO 객체 생성 - SQL 실행은 모두 이 객체가 담당
        BuyMapperDao dao = new BuyMapperDao();

        // ✅ 1. 전체 구매 내역 출력 (구매번호 / 고객 ID / 상품코드 / 수량 / 날짜)
        System.out.println(":: 전체 구매 내역 ::");
        List<BuyVo> allList = dao.selectAll();
        allList.forEach(System.out::println);

        // ✅ 2. 상품코드별 수량 출력 (GROUP BY PCODE)
        System.out.println("\n:: 상품코드별 수량 합계 ::");
        List<Map<String, Object>> byPcode = dao.sumByPcodeGroup();
        byPcode.forEach(map ->
            System.out.printf("상품코드: %-10s → 수량: %d\n",
                map.get("PCODE"),
                ((Number) map.get("TOTAL")).intValue())
        );

        // ✅ 3. 고객 ID별 수량 출력 (GROUP BY CUSTOMER_ID)
        System.out.println("\n:: 고객 ID별 수량 합계 ::");
        List<Map<String, Object>> byCustomer = dao.sumByCustomerGroup();
        byCustomer.forEach(map ->
            System.out.printf("고객ID: %-10s → 수량: %d\n",
                map.get("CUSTOMER_ID"),
                ((Number) map.get("TOTAL")).intValue())
        );

        // ✅ 4. 연도별 수량 출력 (GROUP BY TO_CHAR(BUY_DATE, 'YYYY'))
        System.out.println("\n:: 연도별 수량 합계 ::");
        List<Map<String, Object>> byYear = dao.sumByYearGroup();
        byYear.forEach(map ->
            System.out.printf("연도: %s → 수량: %d\n",
                map.get("YEAR"),
                ((Number) map.get("TOTAL")).intValue())
        );

        // ✅ 5. 전체 총 구매 수량 출력 (마지막 줄에 숫자만 출력)
        int grandTotal = dao.selectTotalQuantity();
        System.out.println("\n" + grandTotal);
    }
}
