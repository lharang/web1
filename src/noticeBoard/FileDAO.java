package noticeBoard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class FileDAO {
	private Connection conn;
	private ResultSet rs;

	
	//생성자
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
	
	//업로드 메소드
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
	
	
	//첨부파일
	public FileDTO getFile(int bbsId){
		try {
		String sql = "select * from file where bbsId = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, bbsId);
		rs = pstmt.executeQuery();
			if(rs.next()) {
				FileDTO fileDTO = new FileDTO();
				fileDTO.setFileName(rs.getString(1));
				fileDTO.setFileRealName(rs.getNString(2));
				fileDTO.setBbsId(rs.getInt(3));
				return fileDTO;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
}
