package app;

import java.util.List;
import java.util.Scanner;

import DataAccessObject.TblProductDao;
import DataAccessObject.TblCustomerDao;
import ValueObject.ProductVo;
import ValueObject.CustomerVo;

/**
 * AppUIHelper
 * - 공통 선택 UI 도우미 클래스
 * - 상품 및 고객 정보를 목록으로 출력하고 번호 선택 방식으로 ID/PCode를 반환
 */
public class AppUIHelper {

  /**
   * 상품 목록을 출력하고 번호 선택으로 상품 코드(pcode)를 반환
   * 
   * @param sc   Scanner 객체
   * @param dao  상품 DAO
   * @return 선택된 상품의 pcode (또는 null: 취소)
   */
  public static String chooseProductCode(Scanner sc, TblProductDao dao) {
    List<ProductVo> list = dao.selectAll();
    if (list.isEmpty()) {
      System.out.println("등록된 상품이 없습니다.");
      return null;
    }

    System.out.println("\n:: 상품 목록 ::");
    for (int i = 0; i < list.size(); i++) {
      ProductVo vo = list.get(i);
      System.out.printf("%2d. [%s] %s - %,d원 (%s)\n",
          i + 1, vo.getPcode(), vo.getPname(), vo.getPrice(), vo.getMaker());
    }

    while (true) {
      System.out.print("선택할 상품 번호 (0: 취소) >>> ");
      String input = sc.nextLine();
      if (input.equals("0") || input.equalsIgnoreCase("::cancel")) return null;

      try {
        int choice = Integer.parseInt(input);
        if (choice >= 1 && choice <= list.size()) {
          return list.get(choice - 1).getPcode();
        } else {
          System.out.println("번호 범위를 벗어났습니다.");
        }
      } catch (NumberFormatException e) {
        System.out.println("숫자만 입력하세요.");
      }
    }
  }

  /**
   * 고객 목록을 출력하고 번호 선택으로 고객 ID를 반환
   * 
   * @param sc   Scanner 객체
   * @param dao  고객 DAO
   * @return 선택된 고객의 customerId (또는 null: 취소)
   */
  public static String chooseCustomerId(Scanner sc, TblCustomerDao dao) {
    List<CustomerVo> list = dao.selectAll();
    if (list.isEmpty()) {
      System.out.println("등록된 고객이 없습니다.");
      return null;
    }

    System.out.println("\n:: 고객 목록 ::");
    for (int i = 0; i < list.size(); i++) {
      CustomerVo vo = list.get(i);
      System.out.printf("%2d. [%s] %s (%s, %d세)\n",
          i + 1, vo.getCustomerId(), vo.getName(), vo.getEmail(), vo.getAge());
    }

    while (true) {
      System.out.print("선택할 고객 번호 (0: 취소) >>> ");
      String input = sc.nextLine();
      if (input.equals("0") || input.equalsIgnoreCase("::cancel")) return null;

      try {
        int choice = Integer.parseInt(input);
        if (choice >= 1 && choice <= list.size()) {
          return list.get(choice - 1).getCustomerId();
        } else {
          System.out.println("번호 범위를 벗어났습니다.");
        }
      } catch (NumberFormatException e) {
        System.out.println("숫자만 입력하세요.");
      }
    }
  }
}
