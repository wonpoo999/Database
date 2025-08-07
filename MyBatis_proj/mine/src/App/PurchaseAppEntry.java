package App;  // 메인 실행 클래스는 app 패키지에 위치

import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;
import java.util.TreeSet;

import mybatis.dao.BuyMapperDao;
import mybatis.vo.BuyVo;

/**
 * AppEntry 클래스
 * - 실행 시 로그인 입력을 받고 관리자/고객 모드 분기
 * - 관리자: 전체 구매 내역 및 통계 조회
 * - 고객: 본인의 구매 내역 또는 선택 메뉴 제공
 */
public class PurchaseAppEntry {

    // 로딩 애니메이션 메서드 (0~100% + > 게이지 바)
    private static void showLoading(String message) {
        System.out.print(message + ": ");
        for (int i = 0; i <= 100; i++) {
            System.out.print("\r" + message + ": " + i + "% [" + ">".repeat(i / 2) + " ".repeat(50 - i / 2) + "]");
            try {
                Thread.sleep(10); // 부드러운 애니메이션
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
        System.out.println();
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        BuyMapperDao dao = new BuyMapperDao();

        System.out.println("===========================");
        System.out.println("  구매 시스템에 오신 것을 환영합니다");
        System.out.println("===========================");

        // ✅ 시스템 로딩 애니메이션
        showLoading("시스템 로딩 중");

        System.out.println("\n:: 로그인 시작 ::");
        System.out.print("로그인 ID를 입력하세요: ");
        String inputId = sc.nextLine().trim();

        System.out.print("비밀번호를 입력하세요: ");
        String inputPw = sc.nextLine().trim();

        if (inputId.equals("ADMIN") && inputPw.equals("ADMIN")) {
            // ✅ 관리자 모드 진입
            System.out.println("\n[ 관리자 모드 진입 성공 ]");
            System.out.println("===========================");

            // ✅ 전체 구매 내역 출력
            showLoading("전체 구매 내역 불러오는 중");
            System.out.println(":: 전체 구매 내역 ::");
            List<BuyVo> all = dao.selectAll();
            for (BuyVo vo : all) {
                System.out.printf("구매번호: %-5d   고객ID: %-10s   상품코드: %-10s   수량: %-2d   날짜: %s\n",
                    vo.getBuyIdx(), vo.getCustomerId(), vo.getPcode(), vo.getQuantity(), vo.getBuyDate());
            }

            // ✅ 상품코드별 수량 출력
            showLoading("상품코드별 수량 집계 중");
            System.out.println("\n:: 상품코드별 수량 합계 ::");
            List<Map<String, Object>> byPcode = dao.sumByPcodeGroup();
            byPcode.forEach(map ->
                System.out.printf("상품코드: %-10s → 수량: %d\n",
                    map.get("PCODE"), ((Number) map.get("TOTAL")).intValue())
            );

            // ✅ 고객 ID별 수량 출력
            showLoading("고객ID별 수량 집계 중");
            System.out.println("\n:: 고객 ID별 수량 합계 ::");
            List<Map<String, Object>> byCustomer = dao.sumByCustomerGroup();
            byCustomer.forEach(map ->
                System.out.printf("고객ID: %-10s → 수량: %d\n",
                    map.get("CUSTOMER_ID"), ((Number) map.get("TOTAL")).intValue())
            );

            // ✅ 연도별 수량 출력
            showLoading("연도별 수량 집계 중");
            System.out.println("\n:: 연도별 수량 합계 ::");
            List<Map<String, Object>> byYear = dao.sumByYearGroup();
            byYear.forEach(map ->
                System.out.printf("연도: %s → 수량: %d\n",
                    map.get("YEAR"), ((Number) map.get("TOTAL")).intValue())
            );

            // ✅ 전체 총 수량
            int total = dao.selectTotalQuantity();
            System.out.println("\n" + total);  // 마지막 줄은 수량만 출력

        } else if (inputId.equals(inputPw)) {
            // ✅ 고객 모드 진입
            System.out.println("\n[ 고객 모드로 진입합니다: ID = " + inputId + " ]");
            System.out.println("===========================");

            showLoading("고객 정보 불러오는 중");
            List<BuyVo> userList = dao.selectByCustomerId(inputId);
            Set<String> userYears = new TreeSet<>();
            for (BuyVo vo : userList) {
                userYears.add(vo.getBuyDate().toLocalDate().getYear() + "");
            }

            while (true) {
                System.out.println("\n:: 고객 기능 메뉴 ::");
                System.out.println("1. 내 전체 구매 내역 조회");
                System.out.println("2. 연도별 내 구매 내역 조회");
                System.out.println("0. 종료");
                System.out.print("선택 >> ");
                String sel = sc.nextLine().trim();

                switch (sel) {
                    case "1":
                        if (userList.isEmpty()) {
                            System.out.println("구매 내역이 존재하지 않습니다.");
                        } else {
                            showLoading("전체 구매 내역 불러오는 중");
                            System.out.println(":: 구매 내역 ::");
                            for (BuyVo vo : userList) {
                                System.out.printf("구매번호: %-5d   고객ID: %-10s   상품코드: %-10s   수량: %-2d   날짜: %s\n",
                                    vo.getBuyIdx(), vo.getCustomerId(), vo.getPcode(), vo.getQuantity(), vo.getBuyDate());
                            }
                        }
                        break;
                    case "2":
                        if (userYears.isEmpty()) {
                            System.out.println("구매 내역이 없습니다.");
                            break;
                        }
                        System.out.println("조회 가능한 연도 목록: " + userYears);
                        System.out.println("* 전체 연도 구매내역 보려면 'ALL' 입력");
                        System.out.print("조회할 연도 입력 >> ");
                        String year = sc.nextLine().trim();

                        if (year.equalsIgnoreCase("ALL")) {
                            showLoading("전체 구매 내역 불러오는 중");
                            System.out.println(":: 전체 연도 구매 내역 ::");
                            for (BuyVo vo : userList) {
                                System.out.printf("구매번호: %-5d   고객ID: %-10s   상품코드: %-10s   수량: %-2d   날짜: %s\n",
                                    vo.getBuyIdx(), vo.getCustomerId(), vo.getPcode(), vo.getQuantity(), vo.getBuyDate());
                            }
                        } else {
                            boolean found = false;
                            for (BuyVo vo : userList) {
                                if (vo.getBuyDate().toLocalDate().getYear() == Integer.parseInt(year)) {
                                    if (!found) {
                                        showLoading(year + "년 구매 내역 불러오는 중");
                                        System.out.println(":: " + year + "년 구매 내역 ::");
                                        found = true;
                                    }
                                    System.out.printf("구매번호: %-5d   고객ID: %-10s   상품코드: %-10s   수량: %-2d   날짜: %s\n",
                                        vo.getBuyIdx(), vo.getCustomerId(), vo.getPcode(), vo.getQuantity(), vo.getBuyDate());
                                }
                            }
                            if (!found) {
                                System.out.println(year + "년 구매 내역이 없습니다.");
                            }
                        }
                        break;
                    case "0":
                        System.out.println("고객 모드를 종료합니다.");
                        sc.close();
                        return;
                    default:
                        System.out.println("잘못된 입력입니다. 다시 선택하세요.");
                }
            }
        } else {
            System.out.println("\n[ 로그인 실패: 비밀번호가 일치하지 않거나 권한이 없습니다. ]");
        }
    }
}
