package ValueObject;

import java.sql.Date;                  // 날짜 타입 사용을 위해 import
import lombok.AllArgsConstructor;     // 모든 필드를 초기화하는 생성자 자동 생성
import lombok.Getter;                 // getter 메소드 자동 생성
import lombok.Setter;                 // setter 메소드 자동 생성
import lombok.ToString;               // toString() 메소드 자동 생성

// VO(Value Object) 클래스: 하나의 고객 정보를 저장하기 위한 클래스
@Getter
@Setter
@ToString
@AllArgsConstructor
public class CustomerVo {
  private String customerId;  // 고객 ID (기본키 역할, 고유 식별자)
  private String name;        // 고객 이름
  private String email;       // 고객 이메일
  private int age;            // 고객 나이
  private Date regDate;       // 고객 등록일 (자동 입력)
}
