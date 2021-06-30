package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

	public class UsersDAO {
		
		private Connection conn; //자바와 데이터베이스를 연결
		private PreparedStatement pstmt; //쿼리문 대기 및 설정
		private ResultSet rs; //결과값 받아오기
		
		//기본 생성자
		//UserDAO가 실행되면 자동으로 생성되는 부분
		//메소드마다 반복되는 코드를 이곳에 넣으면 코드가 간소화된다
		public UsersDAO() {
			try {
				String dbURL = "jdbc:mysql://localhost:3306/library";
				String dbID = "root";
				String dbPassword = "1234";
				Class.forName("com.mysql.jdbc.Driver");
				conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
				System.out.print("연결성공");
			}catch (Exception e) {
				e.printStackTrace();
				System.out.println("연결실패");
			}
		}
		
		public int login(String id, String password) {
			String sql = "select userPassword from user shere userID = ?";
			try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1,id);
					rs = pstmt.executeQuery();
					
					if(rs.next()) {
						if(rs.getString(1).equals(password)) {
							return 1;
						}else return 0;
					}
					return -1;
			}catch(Exception e){
				e.printStackTrace();
			}
			return -2;
		}
		
	}

