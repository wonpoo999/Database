import java.util.List;

import mybatis.dao.MybatisReCustomerDao;
import mybatis.dao.MybatisTblProductDao;
import mybatis.vo.CustomerVo;
import mybatis.vo.ProductVo;

public class App {
    public static void main(String[] args) throws Exception {

        // ✅ 1. 고객 DAO 생성
        MybatisReCustomerDao dao = new MybatisReCustomerDao();

        // ✅ 2. 고객 조회 예시: 기존에 존재하는 고객
        System.out.println(dao.selectByPk("hongGS"));  // 결과: 존재 시 VO 출력

        // ❌ 3. 고객 조회 예시: 존재하지 않는 고객
        System.out.println(dao.selectByPk("hongGSasdf"));  // 결과: null

        // ✅ 4. 고객 조회 예시: 새로 등록한 guava 확인
        System.out.println(dao.selectByPk("guava"));

        // ✅ 5. 상품 DAO 생성
        MybatisTblProductDao pdao = new MybatisTblProductDao();

        // ✅ 6. 상품명 중복 확인 후 없으면 등록
       List<ProductVo> existingList = pdao.selectByPname("GALAXY25");
if (existingList.isEmpty()) {
    pdao.insert(new ProductVo(null, "GALAXY25", 450000, "Samsung", "스마트폰"));
} else {
    System.out.println("[!] 이미 같은 이름의 상품이 존재합니다:");
    for (ProductVo vo : existingList) {
        System.out.println(" - " + vo.getPcode());
    }
    
}


        // ✅ 7. 전체 상품 출력
        System.out.println("\n:: 전체 상품 목록 ::");
        for (ProductVo vo : pdao.selectAll()) {
            System.out.println(vo);
        }
    }
}
