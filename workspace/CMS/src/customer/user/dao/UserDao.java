package customer.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import customer.user.domain.User;

public class UserDao { //���̺� �ϳ� �� Ŭ���� �ϳ�. user ���̺� ���.
	
	public void add(User user) throws ClassNotFoundException, SQLException {
		//ClassNotFoundException : Ŭ������ ���ǵǾ� ���� �ʰų� �߸� �����Ǿ� ã�� �� ���� �� ȣ��ȴ�
		//SQLException : SQL Server���� ��� �Ǵ� ������ ��ȯ�� �� throw�Ǵ� ����
		
		GetConnection G = new GetConnection();
		Connection c = G.getConnection(); 
		
		/* ����Ÿ �����ϴ� ���� */
		PreparedStatement ps = c.prepareStatement("insert into users(id, name, password) values(?,?,?)");
		//PreparedStatement : DB�� ���� ������ ���� �ʿ� ��ü statement���� �ݺ����� ������ �� ���� �� �� �ִ�.
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());

		ps.executeUpdate(); //����, ����, ������ ���õ� SQL���� ������ �� ���.

		ps.close();
		c.close();
		// close()�� ����� �� �� ���, ������ �ٿ�� Ȯ���� �ö󰣴�. �޸𸮰� �Ҹ�Ǳ� ����
	}


	public User get(String id) throws ClassNotFoundException, SQLException {
		GetConnection G = new GetConnection();
		Connection c = G.getConnection(); 
		
		PreparedStatement ps = c
				.prepareStatement("select * from users where id = ?");
		ps.setString(1, id);

		ResultSet rs = ps.executeQuery();
		rs.next();
		User user = new User();
		user.setId(rs.getString("id"));
		user.setName(rs.getString("name"));
		user.setPassword(rs.getString("password"));

		rs.close();
		ps.close();
		c.close();

		return user;
	}

}
