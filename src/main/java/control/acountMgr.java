package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import entity.acountBean;

public class acountMgr {
	
	private DBCMgr pool;

	public acountMgr() {
		pool = DBCMgr.getInstance();
	}

	public acountBean acountList(String user_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		acountBean bean=new acountBean();
		try {
			con = pool.getConnection();
			sql = "select * from acount where acount_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				bean.setAcount_bank(rs.getString("acount_bank"));
				bean.setAcount_num(rs.getInt("acount_num"));
				bean.setAcount_type(rs.getInt("acount_type"));
				bean.setAcount_name(rs.getString("acount_name"));
				bean.setAcount_user_id(user_id);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
		
	}
	
	public void acountInsert(String user_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into acount(acount_user_id) values(?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}
	
	public void acountUpdate(acountBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update acount set acount_num = ?, acount_type = ?, acount_bank = ?, acount_name = ? where acount_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getAcount_num());
			pstmt.setInt(2, bean.getAcount_type());
			pstmt.setString(3, bean.getAcount_bank());
			pstmt.setString(4, bean.getAcount_name());
			pstmt.setString(5, bean.getAcount_user_id());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}
	
	public boolean acountCheck(String user_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "select * from acount where acount_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();
			flag=rs.next();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
		
	}
	
}
