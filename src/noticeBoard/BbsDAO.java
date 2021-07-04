package noticeBoard;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class BbsDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	//생성자
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/Janusdb";
			String dbID = "root";
			String dbPassword = "1234";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);

		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//작성일자 메소드
	public String getDate() {
		String sql = "select now()"; 
				//"select to_char(sysdate,'yy-mm-dd')from dual";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	//게시글 번호 부여 메소드
	public int getNext(){
		String sql = "select bbsId from bbs order by bbsId desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//글쓰기 메소드
	public int write(String bbsTitle, String id, String bbsContent) {
		
		String sql = "insert into bbs values(?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setNString(2, bbsTitle);
			pstmt.setNString(3, id);
			pstmt.setNString(4, getDate());
			pstmt.setNString(5, bbsContent);
			pstmt.setInt(6, 1);
			pstmt.setInt(7, 0);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	
	//조회수 증가
	public int bbsCnt(int count,int bbsId) {
		try {
			String sql = "update bbs set bbsCnt = ? where bbsId = ?";
			System.out.println(sql);
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,count);
			pstmt.setInt(2, bbsId);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
	}
		return -1;
	}
	
	
	//게시글 리스트
	public ArrayList<Bbs> getList(int pageNumber){
		String sql = "select * from bbs where bbsId < ? and bbsAvailable = 1 order by bbsId desc limit 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsId(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setId(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	//다음 페이지
		public boolean nextPage(int pageNumber) {
			String sql = "select * from bbs where bbsId < ? and bbsAvailable = 1";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return true;
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return false;
			
		}
		
    //하나의 게시글보기
		public Bbs getBbs(int bbsId) {
			String sql = "select * from bbs where bbsId = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bbsId);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					Bbs bbs = new Bbs();
					bbs.setBbsId(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setId(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					bbs.setBbsCnt(rs.getInt(7));
					return bbs;
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}
		
		
	//게시글 수정 메소드
		public int update(int bbsId, String bbsTitle, String bbsContent) {
			String sql = "update bbs set bbsTitle = ?, bbsContent = ? where bbsId = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setNString(1, bbsTitle);
				pstmt.setNString(2, bbsContent);
				pstmt.setInt(3, bbsId);
				return pstmt.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
	
	//게시글 삭제 메소드
		public int delete(int bbsId) {
			String sql = "update bbs set bbsAvailable = 0 where bbsId = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, bbsId);
				return pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		
		
		//게시글 검색
		public ArrayList<Bbs> getSearchedList(int pageNumber, String searchWord){
			
			int no2=0;
			
			if(getNext()>pageNumber*10) {
				no2 = pageNumber*10;
			} else {
			  no2 = getNext();
			}
			
			int no1=(pageNumber -1)*10+1;
			
			String SQL = "select * from (select row_number() over (order by bbsDate desc) NUM, A.* from bbs A where bbsAvailable=1 and bbsTitle like'%"
					+ searchWord
					+ "%' order by bbsDate desc) where NUM between "
					+ no1
					+ " and "
					+ no2;
					
			ArrayList<Bbs> list = new ArrayList<Bbs>();
			try {

				System.out.println("sql statement : "+SQL);
				Statement stmt = conn.createStatement();
				rs = stmt.executeQuery(SQL);
				
				while(rs.next()) {
					Bbs bbs = new Bbs();
					bbs.setBbsId(rs.getInt(1));
					bbs.setBbsTitle(rs.getString(2));
					bbs.setId(rs.getString(3));
					bbs.setBbsDate(rs.getString(4));
					bbs.setBbsContent(rs.getString(5));
					bbs.setBbsAvailable(rs.getInt(6));
					bbs.setBbsCnt(rs.getInt(7));
					list.add(bbs);
				}
			}catch(Exception e) {
				System.out.println("Exception:search");
				e.printStackTrace();
			}
			System.out.println(" resultset_return list:search");
			return list;
		}
		
		
		
		//검색시 다음페이지
		public int getSearchedNext(String searchWord) {
			String SQL = "select NUM from (select row_number() over (order by bbsDate desc) NUM, A.* from bbs A where bbsAvailable=1 and bbsTitle like '%"+searchWord+"%' order by NUM desc)";
			try {
				//PreparedStatement pstmt = conn.prepareStatement(SQL);
				//rs = pstmt.executeQuery();
				System.out.println("query for searched NEXT : "+SQL);
				Statement stmt = conn.createStatement();
				rs = stmt.executeQuery(SQL);
				if(rs.next()) {
					return rs.getInt(1)+1;
				}
				return 1;
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;
		}
		//검색시 다음버튼
		public boolean searchedNextPage(int pageNumber,String searchWord) {
			
			try {
				if(getSearchedNext(searchWord)>(pageNumber)*10) {
					return true;
				} else {
					return false;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return false;
		}

}
