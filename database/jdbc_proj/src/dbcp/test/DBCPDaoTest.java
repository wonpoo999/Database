package dbcp.test;

import dbcp.DBCPTBLStudentDao;

public class DBCPDaoTest {

    public static void main(String[] args) {
        DBCPTBLStudentDao dao = new DBCPTBLStudentDao();
        if(!dao.exists("2025999")) {
        dao.insert("2025999", "김구구", "22", "서울시 구로구");
        } else {
            System.out.println("이미 존재하는 학번이니라.");
        }
    }
}
