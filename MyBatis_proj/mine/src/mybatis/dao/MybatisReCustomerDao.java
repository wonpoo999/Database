package mybatis.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import mybatis.config.SqlSessionBean;
import mybatis.vo.CustomerVo;

public class MybatisReCustomerDao {
	private SqlSessionFactory sessionFactory = SqlSessionBean.getSessionFactory();

	public CustomerVo selectByPk(String customerId) {
		// sqlSession.close() 를 try(){} 구문으로 확실하게 실행되도록 함.
		try (SqlSession sqlSession = sessionFactory.openSession()) {
			return sqlSession.selectOne("tblcustomer.selectByPk", customerId);
		}
	}

	public List<CustomerVo> selectAll() {
		try (SqlSession sqlSession = sessionFactory.openSession()) {
			return sqlSession.selectList("tblcustomer.selectAll");
		}
	}

	public int insert(CustomerVo vo) {
		SqlSession sqlSession = sessionFactory.openSession(true);
		int result = sqlSession.insert("tblcustomer.insert", vo);
		// sqlSession.commit(); // autocommit 기본값 : false -> spring 에서 Service 클래스에서
		// 트랜잭션 처리
		sqlSession.close();
		return result;
	}

	public int update(CustomerVo vo) {
		SqlSession sqlSession = sessionFactory.openSession();
		int result = sqlSession.update("tblcustomer.update", vo);
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