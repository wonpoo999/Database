package mapper;

public class StudentMapperTest {
    public static void main(String[] args) {
        StudentMapperDao dao = new StudentMapperTest();
        System.out.println("insert result : " + dao.insert(new StudentVo()));
    }
}
