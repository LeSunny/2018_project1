package customer.user.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GetConnection {
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		
		//<����̹� �ε�> Class.forName("package.ClassName"); �� �����ϴ� ��� ���ڿ��� ���޵Ǵ� Ŭ������ �޸𸮿� �ε��Ѵ�. jdbc Driver�� ��ϵǴ� �����̴�.
		Class.forName("com.mysql.jdbc.Driver"); 
		Connection c;
		//<DB ����> ����ȣ��Ʈ : ��ġ(�ڽ��� ��ǻ�Ͱ� �ƴϸ� �ٸ� �����ǰ� ��)
		c = DriverManager.getConnection("jdbc:mysql://localhost/springbook?characterEncoding=UTF-8", "spring", "book");
		return c;
	}
}
