package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.usersBean;

public class usersMgr {
	private DBCMgr pool;

	public usersMgr() {
		pool = DBCMgr.getInstance();
	}

	public Vector<usersBean> userList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<usersBean> vlist = new Vector<usersBean>();
		try {
			con = pool.getConnection();
			sql = "select * from USERS";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				usersBean bean = new usersBean();
				bean.setUser_id(rs.getString("user_id"));
				bean.setUser_pw(rs.getString("user_pw"));
				bean.setUser_name(rs.getString("user_name"));
				bean.setUser_resnum(rs.getString("user_resnum"));
				bean.setUser_phone(rs.getString("user_phone"));
				bean.setUser_address(rs.getString("user_address"));
				bean.setUser_master(rs.getInt("user_master"));
				bean.setUser_info(rs.getString("user_info"));
				bean.setUser_image(rs.getString("user_image"));
				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	public void userInsert(usersBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into USERS(USER_ID, USER_PW, USER_NAME, USER_RESNUM, USER_PHONE, USER_ADDRESS, USER_MASTER) values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUser_id());
			pstmt.setString(2, bean.getUser_pw());
			pstmt.setString(3, bean.getUser_name());
			pstmt.setString(4, bean.getUser_resnum());
			pstmt.setString(5, bean.getUser_phone());
			pstmt.setString(6, bean.getUser_address());
			pstmt.setInt(7, bean.getUser_master());
			pstmt.executeUpdate();
			System.out.println("성공");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}

	public void userDelete(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from USERS where USER_ID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}

	public void userUpdate(usersBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update USERS set USER_PW = ?, USER_NAME = ?, USER_RESNUM = ?, USER_PHONE = ?, USER_ADDRESS = ?, USER_INFO = ? , USER_IMAGE = ? where USER_ID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUser_pw());
			pstmt.setString(2, bean.getUser_name());
			pstmt.setString(3, bean.getUser_resnum());
			pstmt.setString(4, bean.getUser_phone());
			pstmt.setString(5, bean.getUser_address());
			pstmt.setString(6, bean.getUser_info());
			pstmt.setString(7, bean.getUser_image());
			pstmt.setString(8, bean.getUser_id());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}

	public boolean userCheck(String id, String pw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select USER_ID from USERS where USER_ID = ? and USER_PW = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	public String findUserPW(String id, String resnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String pw = null;
		try {
			con = pool.getConnection();
			sql = "select USER_PW from USERS where USER_ID = ? and USER_RESNUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, resnum);
			rs = pstmt.executeQuery();
			if(rs.next()) 
				pw = rs.getString("user_pw");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return pw;
	}
	
	public void updateUserPW(usersBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update USERS set USER_PW = ? where USER_ID = ? and USER_RESNUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUser_pw());
			pstmt.setString(2, bean.getUser_id());
			pstmt.setString(3, bean.getUser_resnum());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	public usersBean oneUserList(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		usersBean bean=new usersBean();
		try {
			con = pool.getConnection();
			sql = "select * from USERS where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				
				bean.setUser_id(rs.getString("user_id"));
				bean.setUser_pw(rs.getString("user_pw"));
				bean.setUser_name(rs.getString("user_name"));
				bean.setUser_resnum(rs.getString("user_resnum"));
				bean.setUser_phone(rs.getString("user_phone"));
				bean.setUser_address(rs.getString("user_address"));
				bean.setUser_master(rs.getInt("user_master"));
				bean.setUser_info(rs.getString("user_info"));
				bean.setUser_image(rs.getString("user_image"));
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	public static void main(String[] args) {
		usersMgr mgr=new usersMgr();
		boolean id=mgr.userCheck("123", "123");
		System.out.println(id);
	}
}