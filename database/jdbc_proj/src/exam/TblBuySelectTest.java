package exam;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

import util.OracleConnection;

public class TblBuySelectTest {
    public static void main(String[] args) {
        selectByCustomer();
    }

    public static void selectByCustomer() {
        Scanner scanner = new Scanner(System.in);
        System.out.print("구매 내역 조회 고객ID 입력 >>>> ");
        String customerid = scanner.nextLine();

        String sql = "SELECT buy_seq, customer_id, pcode, quantity, buy_date FROM tbl_buy WHERE customer_id = ?";

        Connection connection = OracleConnection.getConnection();

        try (PreparedStatement pStatement = connection.prepareStatement(sql)) {
            pStatement.setString(1, customerid);

            ResultSet rs = pStatement.executeQuery();

            System.out.println("구매번호 | 고객ID | 상품코드 | 수량 | 구매날짜");
            System.out.println("------------------------------------------------------");

            while (rs.next()) {
                int buySeq = rs.getInt("buy_seq");
                String custId = rs.getString("customer_id");
                String pcode = rs.getString("pcode");
                int quantity = rs.getInt("quantity");
                java.sql.Timestamp buyDate = rs.getTimestamp("buy_date");

                System.out.printf("%7d | %6s | %7s | %3d | %s\n",
                        buySeq, custId, pcode, quantity, buyDate.toString());
            }
            rs.close();
        } catch (SQLException e) {
            System.out.println("selectByCustomer 예외 : " + e.getMessage());
        } finally {
            OracleConnection.close(connection);
            scanner.close();
        }
    }
}
