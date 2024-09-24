package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.couponBean;

public class couponMgr {

	private DBCMgr pool;
	
	public couponMgr() {
		pool = DBCMgr.getInstance();
	}
	
	public Vector<couponBean> couponList(){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<couponBean> vlist=null;
		
		try {
			con = pool.getConnection();
			sql = "select * from coupon";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				couponBean bean=new couponBean();
				bean.setCoupon_num(rs.getInt("coupon_num"));
				bean.setCoupon_name(rs.getString("coupon_name"));
				bean.setCoupon_dc(rs.getInt("coupon_dc"));
				bean.setCoupon_date(rs.getString("coupon_date"));
				
				vlist.addElement(bean);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
		
	}

	public void couponInsert(couponBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into coupon(coupon_name, coupon_dc, coupon_date) values(?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getCoupon_name());
			pstmt.setInt(2, bean.getCoupon_dc());
			pstmt.setString(3, bean.getCoupon_date());
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}

	public void couponDelete(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from coupon where coupon_num = ?";
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
