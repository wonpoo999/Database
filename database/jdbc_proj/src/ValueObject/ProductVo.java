package ValueObject;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * ProductVo 클래스
 * - tbl_product 테이블의 한 행(row)을 담기 위한 VO 클래스
 * - 순수 데이터 저장 목적의 객체 (Value Object)
 * - 등록, 검색, 수정, 삭제 등 모든 기능에서 사용됨
 */
@Getter
@Setter
@ToString
@AllArgsConstructor // 모든 필드를 초기화하는 생성자 자동 생성 (Lombok)
public class ProductVo {

    /**
     * 상품 코드 (Primary Key)
     * 예: "P1001", "CHOC123"
     */
    private String pcode;

    /**
     * 상품명
     * 예: "초콜릿바", "우유"
     */
    private String pname;

    /**
     * 상품 카테고리
     * 예: "식품", "생활용품", "전자기기"
     */
    private String category;

    /**
     * 제조사
     * 예: "롯데제과", "삼성전자"
     */
    private String maker;
    
    private int price; // 추가: 상품가격

    // lombok이 자동으로 getPrice() 등 생성
}
