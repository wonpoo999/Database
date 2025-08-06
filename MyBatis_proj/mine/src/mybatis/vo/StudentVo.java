package mybatis.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@ToString
public class StudentVo {
  private String stuno;
  private String name;
  private Integer age;      // Wrapper 클래스 타입일 때만 null 값을 갖을 수 있습니다.
  private String address;

}
