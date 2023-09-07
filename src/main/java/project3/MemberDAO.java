package project3;

import common.JDBConnect;
import jakarta.servlet.ServletContext;
 
public class MemberDAO extends JDBConnect{
	
	public int registinsert(MemberDTO dto) {
		int result = 0;
		String query = "INSERT INTO regist_member VALUES ( "
				+ "    ?,?,?,?,?,?,?,"
				+ "    ?,?,?)";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getTel());
			psmt.setString(5, dto.getMobile());
			psmt.setString(6, dto.getEmail());
			psmt.setString(7, dto.getEmail_check());
			psmt.setString(8, dto.getZipcode());
			psmt.setString(9, dto.getAddr1());
			psmt.setString(10, dto.getAddr2());
		
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("");
			e.printStackTrace();
		}
		return result;
	}
	//회원아이디 중복
	public boolean idCheck(String id) {
		
		boolean overlap = true;
		
		String query = " SELECT COUNT(*) FROM regist_member WHERE id=? ";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			rs= psmt.executeQuery();
			
			rs.next();
			int result = rs.getInt(1);
			if(result == 1) {
				overlap = false;
			}
				
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return overlap;
	}
	//회원인증 
	public MemberDTO getMemberDTO(String id, String pass) {
		MemberDTO dto = new MemberDTO();
		
		String query = "SELECT * FROM regist_member WHERE id=? AND pass=?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, pass);
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));				
						
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	//아이디찾기
	public String findId(String name, String email) {
		String mid = null;
		
		try {
			String sql = " SELECT id FROM regist_member WHERE name=? AND email=?";
					
					psmt = con.prepareStatement(sql);
					psmt.setString(1, name);
					psmt.setString(2, email);
					
					rs = psmt.executeQuery();
					
					if(rs.next()) {
						mid = rs.getString("id");
					}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return mid;
	}
	
	//비밀번호 찾기
	public String findId(String id, String name, String email) {
		String mid = null;
		
		try {
			String sql = " SELECT * FROM regist_member WHERE id=?, name=? AND email=?";
					
					psmt = con.prepareStatement(sql);
					psmt.setString(1, id);
					psmt.setString(2, name);
					psmt.setString(3, email);
					
					rs = psmt.executeQuery();
					
					if(rs.next()) {
						mid = rs.getString("member_mid");
					}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return mid;
	}
}
