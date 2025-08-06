package mybatis.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import mybatis.config.SqlSessionBean;
import mybatis.vo.CustomerVo;

public class MybatisCustomerDao {
	private SqlSessionFactory sessionFactory = SqlSessionBean.getSessionFactory();

	public CustomerVo selectByPk(String customerId) {
		SqlSession sqlSession = sessionFactory.openSession();
		// 0~1개 행 리턴하는 SQL. customerId 는 SQL 실행 매개변수 값(매퍼 parameterType="String")
		CustomerVo vo = sqlSession.selectOne("tblcustomer.selectByPk", customerId);
		sqlSession.close(); // 리팩토링: sql 실행의 오류 발생할 때 close 실행 보장 못함. try(){} 로 변경
		return vo;
	}

	public List<CustomerVo> selectAll() {
		SqlSession sqlSession = sessionFactory.openSession();
		// 0~n개 행 리턴하는 SQL. SQL 실행 매개변수 값 없습니다.(매퍼 resultType="CustomerVo")
		List<CustomerVo> list = sqlSession.selectList("tblcustomer.selectAll");
		sqlSession.close();
		return list;
	}

	public int insert(CustomerVo vo) {
		SqlSession sqlSession = sessionFactory.openSession(true);
		int result = sqlSession.insert("tblcustomer.insert", vo);
		// sqlSession.commit(); // autocommit 기본값 : false -> spring 에서 Service 클래스에서 트랜잭션 처리
		sqlSession.close();
		return result;
	}

	public int update(CustomerVo vo) {
		SqlSession sqlSession = sessionFactory.openSession();
		int result = sqlSession.update("tblcustomer.update", vo);
		// sqlSession.commit();
		sqlSession.close();
		return result;
	}

	public int delete(String customerId) {
		SqlSession sqlSession = sessionFactory.openSession();
		int result = sqlSession.delete("tblcustomer.delete", customerId);
		// sqlSession.commit();
		sqlSession.close();
		return result;
	}

}