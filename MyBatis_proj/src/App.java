import mybatis.dao.MybatisReCustomerDao;
import mybatis.vo.CustomerVo;

public class App {
    public static void main(String[] args) throws Exception {
        MybatisReCustomerDao dao = new MybatisReCustomerDao();
        // int result = dao.insert(
                // new CustomerVo("hongGS", "홍길순", "hgs@a.com", 22, null));
        // System.out.println("insert result : " + result);

        System.out.println(dao.selectByPk("hongGS"));          // 있는 PK 값
        System.out.println(dao.selectByPk("hongGSasdf"));      // 없는 PK 값
        System.out.println(dao.selectByPk("guava")); // 있는 PK 값. 오늘 내가 만든 따끈따끈한 아이디다.
    }
}