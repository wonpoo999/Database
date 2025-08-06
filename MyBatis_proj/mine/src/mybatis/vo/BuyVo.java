package mybatis.vo; // 👉 이 클래스가 mybatis.vo 패키지에 속해 있음을 나타냄

import java.sql.Date; // 👉 java.sql.Date 타입을 import (DB의 DATE 타입과 매핑될 때 사용됨)

/**
 * 📌 BuyVo 클래스 (Value Object, VO)
 * ─ 이 클래스는 TBL_BUY 테이블의 한 줄(row)을 자바 객체로 표현한 것
 * ─ 즉, DB 데이터를 자바 프로그램 내부에서 다루기 위한 그릇 역할
 */
public class BuyVo {

    // ▶▶ 멤버 필드 (DB 테이블의 각 컬럼과 1:1 매칭됨)

    private int buyIdx;         // 🟨 DB 컬럼: BUY_SEQ (구매번호 - 기본키). VO 필드는 buyIdx
    private String customerId;  // 🟨 DB 컬럼: CUSTOMER_ID (구매한 사용자 ID - 외래키). camelCase 적용됨
    private String pcode;       // 🟨 DB 컬럼: PCODE (상품 코드 - 외래키)
    private int quantity;       // 🟨 DB 컬럼: QUANTITY (구매 수량)
    private Date buyDate;       // 🟨 DB 컬럼: BUY_DATE (구매 일자). 자바에서는 java.sql.Date 사용

    // ▶▶ 생성자 (객체 생성 방식 정의)

    // ✅ 기본 생성자 - MyBatis가 내부적으로 객체를 만들 때 사용
    public BuyVo() {}

    // ✅ 전체 필드를 초기화하는 생성자
    //    → 데이터를 한 번에 담아서 객체 생성할 때 사용됨
    public BuyVo(int buyIdx, String customerId, String pcode, int quantity, Date buyDate) {
        this.buyIdx = buyIdx;           // 매개변수 → 멤버 필드에 할당
        this.customerId = customerId;
        this.pcode = pcode;
        this.quantity = quantity;
        this.buyDate = buyDate;
    }

    // ▶▶ Getter & Setter 메서드
    //     → private 필드 값을 읽고/설정하는 공식적인 통로 (Encapsulation 캡슐화)

    public int getBuyIdx() { // 구매번호 값 가져오기
        return buyIdx;
    }

    public void setBuyIdx(int buyIdx) { // 구매번호 설정하기
        this.buyIdx = buyIdx;
    }

    public String getCustomerId() { // 고객 ID 가져오기
        return customerId;
    }

    public void setCustomerId(String customerId) { // 고객 ID 설정
        this.customerId = customerId;
    }

    public String getPcode() { // 상품 코드 가져오기
        return pcode;
    }

    public void setPcode(String pcode) { // 상품 코드 설정
        this.pcode = pcode;
    }

    public int getQuantity() { // 수량 가져오기
        return quantity;
    }

    public void setQuantity(int quantity) { // 수량 설정
        this.quantity = quantity;
    }

    public Date getBuyDate() { // 구매일자 가져오기
        return buyDate;
    }

    public void setBuyDate(Date buyDate) { // 구매일자 설정
        this.buyDate = buyDate;
    }

    /**
     * 📌 toString 오버라이딩
     * ─ 객체를 콘솔에 출력할 때 사람이 읽기 쉽게 문자열 형식으로 변환해줌
     * ─ String.format() 사용해 열(column) 맞춤 처리 (정렬 보기 좋게)
     * ─ 날짜가 null인 경우 대비해 삼항연산자 사용
     */
    @Override
    public String toString() {
        return String.format(
            "구매번호: %-5d  고객ID: %-8s  상품코드: %-10s  수량: %-2d  날짜: %s",
            buyIdx,
            customerId,
            pcode,
            quantity,
            (buyDate != null ? buyDate.toString() : "없음") // 날짜가 null이면 "없음" 출력
        );
    }
}
