package ValueObject;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;

/**
 * PurchaseVo 클래스
 * - 구매 정보(purchase 테이블)의 한 행을 저장하는 VO 클래스
 * - 복합 기본키 구성 : customer_id + pcode + purchase_date
 * - 고객의 상품 구매 기록을 저장
 */
@Getter
@Setter
@ToString
@AllArgsConstructor // 모든 필드를 초기화하는 생성자 자동 생성 (Lombok)
public class PurchaseVo {

    /**
     * 구매한 고객 ID (FK: tbl_customer#)
     */
    private String customerId;

    /**
     * 구매한 상품 코드 (FK: tbl_product)
     */
    private String pcode;

    /**
     * 구매 수량
     */
    private int quantity;

    /**
     * 구매 일자 (기본값: SYSDATE)
     */
    private Date purchaseDate;

    public PurchaseVo(int purNo, String customerId, String pcode, Date purchaseDate, int quantity) {
    // this.purNo = purNo;
    this.customerId = customerId;
    this.pcode = pcode;
    this.purchaseDate = purchaseDate;
    this.quantity = quantity;
}

}

