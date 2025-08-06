package mybatis.vo;

/**
 * 상품 정보를 저장하는 VO(Value Object) 클래스
 * - tbl_product 테이블의 한 레코드(Row)를 표현
 */
public class ProductVo {
    private String pcode;    // 상품 코드 (기본키, 시퀀스 자동 생성)
    private String pname;    // 상품 이름
    private int price;       // 가격
    private String maker;    // 제조사
    private String category; // 카테고리

    // 기본 생성자 (MyBatis는 반드시 필요로 함)
    public ProductVo() {}

    // 필드 일부만 사용하는 생성자 (필요 시)
    public ProductVo(String pcode, String pname, int price, String maker) {
        this.pcode = pcode;
        this.pname = pname;
        this.price = price;
        this.maker = maker;
    }

    // 전체 필드를 다 받는 생성자
    public ProductVo(String pcode, String pname, int price, String maker, String category) {
        this.pcode = pcode;
        this.pname = pname;
        this.price = price;
        this.maker = maker;
        this.category = category;
    }

    // Getter & Setter
    public String getPcode() { return pcode; }
    public void setPcode(String pcode) { this.pcode = pcode; }

    public String getPname() { return pname; }
    public void setPname(String pname) { this.pname = pname; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public String getMaker() { return maker; }
    public void setMaker(String maker) { this.maker = maker; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    @Override
    public String toString() {
        return String.format("[상품코드: %s, 이름: %s, 가격: %,d원, 제조사: %s]",
                             pcode, pname, price, maker);
    }
}
