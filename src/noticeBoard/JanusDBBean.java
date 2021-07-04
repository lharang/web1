  package noticeBoard;

import java.sql.*;
import javax.naming.*;
import javax.sql.*;

public class JanusDBBean{
   private static JanusDBBean instance = new JanusDBBean();

   public static JanusDBBean getInstance() {
      return instance;
   }

   public JanusDBBean() {}
      
   
 private Connection getConnection() throws Exception {
    Connection conn = null;

    String url = "jdbc:mysql://localhost:3306/Janusdb";
    String user = "root";
    String password = "1234";

    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(url, user, password);
     return conn;
}
 
    public int insertMember(JanusBean member) //회원가입
           throws Exception {
              Connection conn = null;
               PreparedStatement pstmt = null;
             int x = -1;
              
               try {
                   conn = getConnection();
                   
                   pstmt = conn.prepareStatement(
                      "insert into users values (?,?,?,?,?,?,?,?,'Bronze')");
                   pstmt.setString(1, member.getName());
                   pstmt.setString(2, member.getId());
                   pstmt.setString(3, member.getPasswd());
                   pstmt.setString(4, member.getGender());
                   pstmt.setString(5, member.getAddress());
                   pstmt.setString(6, member.getPhone());
                   pstmt.setString(7, member.getEmail());
                   pstmt.setString(8, member.getPin_num());
                
                   pstmt.executeUpdate();
                x = 1; //회원가입 성공
               }catch(Exception ex) {
                System.out.println("SQLException: " + ex.getMessage());
               } finally {
                   if (pstmt != null) 
                      try { pstmt.close(); } catch(SQLException ex) {}
                   if (conn != null) 
                      try { conn.close(); } catch(SQLException ex) {}
               }
             return x;
           }

           public int userCheck(String id, String passwd) //사용자 인증처리
           throws Exception {
              Connection conn = null;
                PreparedStatement pstmt = null;
              ResultSet rs= null;
                String dbpasswd="";
              int x=-1;
              
              try {
                conn = getConnection();
                  
                   pstmt = conn.prepareStatement(
                      "select passwd from users where id = ?");
                   pstmt.setString(1, id);
                   rs= pstmt.executeQuery();

                if(rs.next()){
                   dbpasswd= rs.getString("passwd"); 
                   if(dbpasswd.equals(passwd))
                      x= 1; //인증 성공
                   else
                      x= 0; //비밀번호 틀림
                }else
                   x= -1;//해당 아이디 없음
                }catch(Exception ex) {
                 System.out.println("SQLException: " + ex.getMessage());
                } finally {
                 if (rs != null) 
                    try { rs.close(); } catch(SQLException ex) {}
                    if (pstmt != null) 
                       try { pstmt.close(); } catch(SQLException ex) {}
                    if (conn != null) 
                       try { conn.close(); } catch(SQLException ex) {}
                }
              return x;
           }

           //회원정보를 수정하기 위해 기존의 정보를 표시
            public JanusBean getMember(String id) 
            throws Exception {
               Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                JanusBean member=null;
                
                try {
                   conn = getConnection();
                  
                    pstmt = conn.prepareStatement(
                          "select * from users where id = ?");
                    pstmt.setString(1, id);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                       member = new JanusBean();
                       
                        member.setName(rs.getString("name"));
                        member.setId(rs.getString("id"));
                        member.setPasswd(rs.getString("passwd"));
                        member.setGender(rs.getString("gender")); 
                        member.setAddress(rs.getString("address"));
                        member.setPhone(rs.getString("phone")); 
                        member.setEmail(rs.getString("email")); 
                        member.setPin_num(rs.getString("pin_num")); 
                        member.setUserGrade(rs.getString("UserGrade")); 
                 }
                }catch(Exception ex) {
                 System.out.println("SQLException: " + ex.getMessage());
                }finally {
                    if (rs != null) 
                       try { rs.close(); } catch(SQLException ex) {}
                    if (pstmt != null) 
                       try { pstmt.close(); } catch(SQLException ex) {}
                    if (conn != null) 
                       try { conn.close(); } catch(SQLException ex) {}
                }
              return member;
            }
          
            public int updateMember(JanusBean member) //회원의 정보수정
            throws Exception {
               Connection conn = null;
               PreparedStatement pstmt = null;
               
              int x=-1;
              
                try {
                   conn = getConnection();
                  
                    pstmt = conn.prepareStatement(
                      "update users set name=?,id=?, passwd=?, gender=?, phone=?, email=?, address=?"+"where id=?");
                     pstmt.setString(1, member.getName());
                     pstmt.setString(2, member.getId());
                     pstmt.setString(3, member.getPasswd());
                     pstmt.setString(4, member.getGender());
                     pstmt.setString(5, member.getPhone());
                     pstmt.setString(6, member.getEmail());
                     pstmt.setString(7, member.getAddress());
                     pstmt.setString(8, member.getOriId());
                  
                    pstmt.executeUpdate();
                    x = 1; //성공
                }catch(Exception ex) {
                 System.out.println("SQLException: " + ex.getMessage());
                }finally {
                    if (pstmt != null) 
                       try { pstmt.close(); } catch(SQLException ex) {}
                    if (conn != null) 
                       try { conn.close(); } catch(SQLException ex) {}
                }
                return x;
            }
           
            public int deleteMember(String id, String passwd) //회원탈퇴
            throws Exception {
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs= null;
                int x=-1;
                
                try {
                 conn = getConnection();

                 if(confirmPasswd(id,passwd)==1){
                    pstmt = conn.prepareStatement("delete from member where id = ?");
                        pstmt.setString(1, id);
                        pstmt.executeUpdate();
                       x= 1; //회원탈퇴 성공
                    }else
                       x= 0; //비밀번호 틀림
                }catch(Exception ex) {
                 System.out.println("SQLException: " + ex.getMessage());
                }finally {
                    if (rs != null) 
                       try { rs.close(); } catch(SQLException ex) {}
                    if (pstmt != null) 
                       try { pstmt.close(); } catch(SQLException ex) {}
                    if (conn != null) 
                       try { conn.close(); } catch(SQLException ex) {}
                }
              return x;
            }


           public int confirmPasswd(String id, String passwd) //삭제시 비밀번호 체크
           throws Exception {
              Connection conn = null;
                PreparedStatement pstmt = null;
              ResultSet rs= null;
                String dbpasswd="";
              int x=-1;
              
              try {
                 conn = getConnection();
                  
                    pstmt = conn.prepareStatement(
                       "select passwd from member where id = ?");
                    pstmt.setString(1, id);
                    rs= pstmt.executeQuery();

                 if(rs.next()){
                    dbpasswd= rs.getString("passwd"); 
                    if(dbpasswd.equals(passwd))
                          x= 1; //비밀번호 일치
                       else
                          x= -1;//비밀번호 불일치      
                 }
                }catch(Exception ex) {
                 System.out.println("SQLException: " + ex.getMessage());
                } finally {
                 if (rs != null) 
                    try { rs.close(); } catch(SQLException ex) {}
                    if (pstmt != null) 
                       try { pstmt.close(); } catch(SQLException ex) {}
                    if (conn != null) 
                       try { conn.close(); } catch(SQLException ex) {}
                }
              return x;
           }
           
           public int confirmId(String id) //중복아이디 체크
           throws Exception {

              int x=-1;
       /*       
              try {
          
                }catch(Exception ex) {
                 System.out.println("SQLException: " + ex.getMessage());
                } finally {
                 if (rs != null) 
                    try { rs.close(); } catch(SQLException ex) {}
                    if (pstmt != null) 
                       try { pstmt.close(); } catch(SQLException ex) {}
                    if (conn != null) 
                       try { conn.close(); } catch(SQLException ex) {}
                }
       */
              return x;
           }
            
       }