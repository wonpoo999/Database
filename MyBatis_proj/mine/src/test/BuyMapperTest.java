package test;  // 이 클래스는 test 패키지 안에 있음

import java.util.List;

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

        // ✅ 1. 특정 고객의 구매 내역 조회 (고객 ID: mina012)
        List<BuyVo> list1 = dao.selectByCustomerId("mina012");
        list1.forEach(System.out::println); // 목록 출력

        // ✅ 2. 특정 상품 코드 기준으로 구매 내역 조회
        List<BuyVo> list2 = dao.selectByPcode("JINRMn5");
        list2.forEach(System.out::println);

        // ✅ 3. 특정 연도의 구매 내역 조회 (예: 2024년)
        List<BuyVo> list3 = dao.selectByYear("2024");
        list3.forEach(System.out::println);

        // ✅ 4. 특정 상품 코드의 전체 구매 수량 합계
        int total = dao.selectSumByPcode("JINRMn5");
        System.out.println("총 수량: " + total);
    }
}
