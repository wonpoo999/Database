package mapper;  // 이 파일은 'mapper' 패키지에 속해 있음. 경로 = src/mapper

import java.util.List;

import mybatis.vo.BuyVo;  // BuyVo 객체를 반환받기 위해 import

/**
 * BuyMapper 인터페이스
 * - XML 매퍼(BuyMapper.xml)에 정의된 SQL을 Java 메서드와 연결해줌
 * - 메서드 이름 = XML에서 <select id="..."> 와 정확히 일치해야 함
 * - 파라미터와 리턴 타입도 정확히 맞아야 오류 없음
 */
public interface BuyMapper {

    // ✅ 특정 고객 ID로 구매내역 전체 조회 (리스트로 반환)
    List<BuyVo> selectByCustomerId(String customerId);

    // ✅ 특정 상품 코드로 구매내역 조회
    List<BuyVo> selectByPcode(String pcode);

    // ✅ 특정 연도로 구매내역 필터링
    List<BuyVo> selectByYear(String year);

    // ✅ 특정 상품 코드에 대한 전체 구매 수량 합계 (숫자 하나만 반환)
    int selectSumByPcode(String pcode);
}
