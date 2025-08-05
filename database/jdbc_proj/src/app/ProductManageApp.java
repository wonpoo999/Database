package app;

import java.util.List;

import DataAccessObject.TblProductDao;
import ValueObject.ProductVo;

public class ProductManageApp {

  public static void main(String[] args) {
    System.out.println("========= 상품 관리 App ==========");
    boolean run = true;
    while (run) {
      System.out.println("\n선택 메뉴 : 1.  등록   2. 조회");
      System.out.println("       3.  변경   4.  삭제   5. 검색");
      String menu = System.console().readLine("메뉴 선택 >>>> ");
      switch (menu) { // switch 문 case 의 변수 선언은 switch scope, 객체 사용은 case scope
        case "5":
          search();
          break;
        case "1":
          ProductVo vo = new ProductVo("LGLAPTop", "LG그램64GB", "C1", "LG전자", 125500); // 등록

          TblProductDao dao = new TblProductDao();
          int result = dao.insert(vo);
          break;
        case "2":
          String pcode = "LGLAPTop";
          dao = new TblProductDao();
          vo = dao.selectByPk(pcode);
          System.out.println("조회 결과 : " + vo);
          break;
        case "3":
vo = new ProductVo("LGLAPTop", "LG그램32GB", null, "LG전자", 505500); // 변경
          dao = new TblProductDao();
          result = dao.update(vo);
          break;
        case "4":
          dao = new TblProductDao();
          pcode = "LGLAPTop";
          result = dao.delete(pcode);
          System.out.println("delete result : " + result);
          break;
        default:
          System.out.println("없는 메뉴 입니다.");
          break;
      }
    }
  }

  private static void search() {
    System.out.println("\t :: 상품 검색 :: ");
    String keyword = System.console().readLine("검색어 입력 >>> ");
    TblProductDao dao = new TblProductDao();
    List<ProductVo> list = dao.searchByKeyword(keyword);
    System.out.println("\t :: 조회 결과 :: ");
    for (ProductVo vo : list) {
      System.out.println(String.format("%10s \t %2s \t %20s \t %8d",
    vo.getPcode(), vo.getCategory(), vo.getPname(), vo.getPrice()));

    }
  }
}