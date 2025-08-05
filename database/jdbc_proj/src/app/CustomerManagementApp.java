package app;

import java.util.List;
import java.util.Scanner;

import DataAccessObject.TblCustomerDao;
import DataAccessObject.TblProductDao;
import DataAccessObject.TblPurchaseDao;
import ValueObject.CustomerVo;
import ValueObject.ProductVo;
import ValueObject.PurchaseVo;

/**
 * 고객 및 상품 관리 콘솔 애플리케이션
 * - 고객 등록/조회/수정/삭제
 * - 상품 등록/삭제/목록/검색
 * - 구매 등록/고객별 구매 이력 조회
 * - ::cancel 명령으로 입력 중단 및 메뉴 복귀
 */
public class CustomerManagementApp {

  private static final Scanner sc = new Scanner(System.in);
  private static final TblCustomerDao customerDao = new TblCustomerDao();
  private static final TblPurchaseDao purchaseDao = new TblPurchaseDao();

  public static void main(String[] args) {
    System.out.println("========= 고객 관리 App ==========");

    boolean run = true;
    while (run) {
      System.out.println("\n선택 메뉴:");
      System.out.println("1. 고객 등록");
      System.out.println("2. 고객 정보 조회");
      System.out.println("3. 고객 전체 목록 조회");
      System.out.println("4. 고객 이메일 수정");
      System.out.println("5. 고객 삭제");
      System.out.println("6. 상품 관리");
      System.out.println("7. 상품 구매 등록");
      System.out.println("8. 고객별 구매 이력 조회");
      System.out.println("0. 종료");
      System.out.print("메뉴 선택 >>> ");

      String menu = sc.nextLine();

      switch (menu) {
        case "1": register(); break;
        case "2": viewCustomer(); break;
        case "3": listCustomers(); break;
        case "4": updateCustomer(); break;
        case "5": deleteCustomer(); break;
        case "6": productMenu(); break;
        case "7": registerPurchase(); break;
        case "8": viewPurchaseByCustomer(); break;
        case "0":
          System.out.println("프로그램을 종료합니다.");
          run = false;
          break;
        default:
          System.out.println("없는 메뉴입니다.");
      }
    }

    sc.close();
  }

  // 1. 고객 등록
  private static void register() {
    System.out.println("\n:: 고객 등록 ::");
    String customerId;

    while (true) {
      System.out.print("사용할 아이디 >>> ");
      customerId = sc.nextLine();
      if (checkCancel(customerId)) return;
      if (customerDao.selectByPk(customerId) != null) {
        System.out.println("이미 사용 중인 고객 아이디입니다.");
      } else break;
    }

    System.out.print("성명 >>> ");
    String name = sc.nextLine();
    if (checkCancel(name)) return;

    System.out.print("이메일 >>> ");
    String email = sc.nextLine();
    if (checkCancel(email)) return;

    int age = 0;
    while (true) {
      System.out.print("나이(미입력은 엔터) >>> ");
      String temp = sc.nextLine();
      if (checkCancel(temp)) return;
      if (temp.isEmpty()) break;

      try {
        age = Integer.parseInt(temp);
        if (age < 0 || age > 100)
          throw new Exception("나이 값은 0~100 사이여야 합니다.");
        break;
      } catch (NumberFormatException e) {
        System.out.println("나이는 숫자만 입력하세요.");
      } catch (Exception e) {
        System.out.println(e.getMessage());
      }
    }

    CustomerVo vo = new CustomerVo(customerId, name, email, age, null);
    if (customerDao.insert(vo) > 0)
      System.out.println("고객 등록 완료!");
    else
      System.out.println("고객 등록 실패!");
  }

  // 2. 고객 단건 조회
  private static void viewCustomer() {
    System.out.println("\n:: 고객 정보 조회 ::");
    System.out.print("고객 ID 입력 >>> ");
    String customerId = sc.nextLine();
    if (checkCancel(customerId)) return;

    CustomerVo vo = customerDao.selectByPk(customerId);
    if (vo == null)
      System.out.println("해당 고객이 존재하지 않습니다.");
    else
      System.out.println(vo);
  }

  // 3. 전체 고객 목록
  private static void listCustomers() {
    System.out.println("\n:: 전체 고객 목록 ::");
    List<CustomerVo> list = customerDao.selectAll();
    if (list.isEmpty())
      System.out.println("등록된 고객이 없습니다.");
    else
      list.forEach(System.out::println);
  }

  // 4. 이메일 수정
  private static void updateCustomer() {
    System.out.println("\n:: 고객 이메일 수정 ::");
    System.out.print("고객 ID 입력 >>> ");
    String customerId = sc.nextLine();
    if (checkCancel(customerId)) return;

    CustomerVo vo = customerDao.selectByPk(customerId);
    if (vo == null) {
      System.out.println("해당 고객이 존재하지 않습니다.");
      return;
    }

    System.out.print("새 이메일 >>> ");
    String email = sc.nextLine();
    if (checkCancel(email)) return;

    vo.setEmail(email);
    if (customerDao.update(vo) > 0)
      System.out.println("이메일 수정 완료!");
    else
      System.out.println("이메일 수정 실패!");
  }

  // 5. 고객 삭제
  private static void deleteCustomer() {
    System.out.println("\n:: 고객 삭제 ::");
    System.out.print("삭제할 고객 ID >>> ");
    String customerId = sc.nextLine();
    if (checkCancel(customerId)) return;

    if (customerDao.delete(customerId) > 0)
      System.out.println("고객 삭제 완료!");
    else
      System.out.println("삭제 실패! 고객이 존재하지 않습니다.");
  }

  // 6. 상품 관리 서브 메뉴
  private static void productMenu() {
    TblProductDao pdao = new TblProductDao();
    boolean run = true;

    while (run) {
      System.out.println("\n<< 상품 관리 메뉴 >>");
      System.out.println("1. 상품 등록");
      System.out.println("2. 상품 전체 목록");
      System.out.println("3. 상품 삭제");
      System.out.println("4. 키워드 검색");
      System.out.println("0. 이전 메뉴");
      System.out.print("선택 >>> ");

      String menu = sc.nextLine();
      switch (menu) {
        case "1":
          System.out.print("상품코드 >>> ");
          String pcode = sc.nextLine();
          if (checkCancel(pcode)) break;

          System.out.print("상품명 >>> ");
          String pname = sc.nextLine();
          if (checkCancel(pname)) break;

          System.out.print("카테고리 >>> ");
          String category = sc.nextLine();
          if (checkCancel(category)) break;

          System.out.print("제조사 >>> ");
          String maker = sc.nextLine();
          if (checkCancel(maker)) break;

          System.out.print("가격 >>> ");
int price = Integer.parseInt(sc.nextLine());
if (checkCancel(String.valueOf(price))) break;

          ProductVo pvo = new ProductVo(pcode, pname, category, maker, price);
          if (pdao.insert(pvo) > 0)
            System.out.println("상품 등록 완료!");
          else
            System.out.println("상품 등록 실패!");
          break;

        case "2":
          List<ProductVo> all = pdao.selectAll();
          if (all.isEmpty())
            System.out.println("등록된 상품이 없습니다.");
          else
            all.forEach(System.out::println);
          break;

        case "3":
String delCode = AppUIHelper.chooseProductCode(sc, pdao);
if (delCode == null) return;
          if (checkCancel(delCode)) break;

          if (pdao.delete(delCode) > 0)
            System.out.println("상품 삭제 완료!");
          else
            System.out.println("삭제 실패! 상품이 존재하지 않습니다.");
          break;

        case "4":
          System.out.print("검색 키워드 >>> ");
          String keyword = sc.nextLine();
          if (checkCancel(keyword)) break;

          List<ProductVo> found = pdao.searchByKeyword(keyword);
          if (found.isEmpty())
            System.out.println("검색 결과 없음");
          else
            found.forEach(System.out::println);
          break;

        case "0":
          run = false;
          break;

        default:
          System.out.println("없는 메뉴입니다.");
      }
    }
  }

  // 7. 구매 등록
private static void registerPurchase() {
  System.out.println("\n:: 상품 구매 등록 ::");

  // ✅ 고객 선택
  String customerId = AppUIHelper.chooseCustomerId(sc, customerDao);
  if (customerId == null) return;

  TblProductDao pdao = new TblProductDao();

  // ✅ 상품 선택
  String pcode = AppUIHelper.chooseProductCode(sc, pdao);
  if (pcode == null) return;

  int quantity = 0;
  while (true) {
    System.out.print("구매 수량 >>> ");
    String input = sc.nextLine();
    if (checkCancel(input)) return;

    try {
      quantity = Integer.parseInt(input);
      if (quantity <= 0)
        throw new Exception("수량은 1 이상이어야 합니다.");
      break;
    } catch (Exception e) {
      System.out.println("오류: " + e.getMessage());
    }
  }

  PurchaseVo vo = new PurchaseVo(0, customerId, pcode, null, quantity);
  if (purchaseDao.insert(vo) > 0)
    System.out.println("구매 등록 완료!");
  else
    System.out.println("구매 등록 실패!");
}


  // 8. 고객별 구매 이력 조회
  private static void viewPurchaseByCustomer() {
    System.out.println("\n:: 고객별 구매 이력 조회 ::");

   String customerId;
while (true) {
  System.out.print("고객 ID >>> ");
  customerId = sc.nextLine();
  if (checkCancel(customerId)) return;
  if (checkBack(customerId)) return; // ::back 명령 처리

  if (customerDao.selectByPk(customerId) == null) {
    System.out.println("존재하지 않는 고객 ID입니다.");
  } else break;
}


    List<PurchaseVo> list = purchaseDao.selectByCustomer(customerId);

    if (list.isEmpty()) {
      System.out.println("해당 고객의 구매 이력이 없습니다.");
    } else {
      for (PurchaseVo vo : list) {
        System.out.println(vo);
      }
    }
  }

  // 공통: 입력 취소 명령 처리
  private static boolean checkCancel(String input) {
    if (input.equalsIgnoreCase("::cancel")) {
      System.out.println("입력이 취소되었습니다. 메뉴로 돌아갑니다.");
      return true;
    }
    return false;

    
  }

  // ✅ 입력값이 "::back"이면 true 반환 → 이전 단계로 이동
private static boolean checkBack(String input) {
  return input.equalsIgnoreCase("::back");
}

}
