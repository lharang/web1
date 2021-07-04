package noticeBoard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class FileDAO {
	private Connection conn;
	private ResultSet rs;
	
	public FileDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/Janusdb";
			String dbID = "root";
			String dbPassword = "1234";
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int upload(String fileName, String fileRealName, int bbsId) {
		String sql = "insert into file values (?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setNString(1, fileName);
			pstmt.setNString(2, fileRealName);
			pstmt.setInt(3, bbsId);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
	//수정 메소드
	public int update(String fileName, String fileRealName, int bbsId) {
	String sql = "update file set fileName = ?, fileRealName = ? where bbsId = ?";
	try {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setNString(1, fileName);
		pstmt.setNString(2, fileRealName);
		pstmt.setInt(3, bbsId);
		return pstmt.executeUpdate();
	} catch (Exception e) {
		e.printStackTrace();
		}
		return -1;
	}
	
	
}
