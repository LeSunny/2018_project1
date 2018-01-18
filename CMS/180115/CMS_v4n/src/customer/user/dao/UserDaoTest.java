package customer.user.dao;

import java.sql.SQLException;

import customer.user.domain.User;

public class UserDaoTest {
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		
		MySQLConnectionMakerForK mySQLCM = new MySQLConnectionMakerForK();
		UserDao mySQLDao = new UserDao(mySQLCM);

		OracleConnectionMakerForL oracleCM = new OracleConnectionMakerForL();
		UserDao oracleDao = new UserDao(oracleCM);

		User user = new User();
		user.setId("whiteship");
		user.setName("��⼱");
		user.setPassword("married");

		mySQLDao.add(user);
		oracleDao.add(user);
			
		System.out.println(user.getId() + " -->  MySQL & Oracle ��� ����");
		
		User user2 = mySQLDao.get(user.getId());
		User user3 = oracleDao.get(user.getId());
		
		System.out.println("(MySQL) " + user2.getName() + ", " + "(Oracle) " + user3.getName());
		System.out.println("(MySQL) " + user2.getPassword() + ", " + "(Oracle) " + user3.getPassword());
			
		System.out.println(user2.getId() + " MySQL ��ȸ ����");
		System.out.println(user3.getId() + " Oracle ��ȸ ����");
	}

}
