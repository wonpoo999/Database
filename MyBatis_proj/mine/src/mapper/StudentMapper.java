package mapper;

import java.util.List;

import mybatis.vo.StudentVo;

// SQL 매퍼 XML 파일 내용으로 인터페이스 정의
// SqlSession 이 인터페이스의 구현 클래스와 객체를 생성.
public interface StudentMapper {
    StudentVo selectByPk(String stuno); // PK로 1명 조회

    List<StudentVo> selectAll();        // 전체 목록 조회

    List<String> selectStuno(); // 단일 컬럼을 여러 행 조회 SQL
                                        // 학번만 뽑기 (단일컬럼)

    // resultType 에는 지정 없지만 int 로 실행결과 행의 갯수 리턴 받음.
    int insert(StudentVo vo);           // 삽입 

    int update(StudentVo vo);           // 수정

    int delete(String stuno);           // 삭제
}

// XML 매퍼 파일(student-mapper.xml)의 <select>, <insert> 태그들의 ID와 동일한 메소드 이름을 사용.

// MyBatis가 자동으로 이 인터페이스를 구현해줌.