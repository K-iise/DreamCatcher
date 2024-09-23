package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.bannerBean;

public class bannerMgr {
	
private DBCMgr pool;
	
	public bannerMgr() {
		pool = DBCMgr.getInstance();
	}
	
	public Vector<bannerBean> bannerList(){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<bannerBean> vlist=null;
		try {
			con = pool.getConnection();
			sql = "select * from banner";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				bannerBean bean=new bannerBean();
				bean.setBanner_title(rs.getString("banner_title"));
				bean.setBanner_link(rs.getString("banner_link"));
				
				vlist.addElement(bean);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
		
	}

	public void bannerInsert(bannerBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert banner(banner_title, banner_link) values(?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getBanner_title());
			pstmt.setString(2, bean.getBanner_link());
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}

	public void banerDelete(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from banner where banner_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}
}
