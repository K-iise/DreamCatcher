package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.haveCouponBean;

public class haveCouponMgr {
	private DBCMgr pool;

	public haveCouponMgr() {
		pool = DBCMgr.getInstance();
	}

	public Vector<haveCouponBean> haveCouponList(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<haveCouponBean> vlist = new Vector<haveCouponBean>();
		try {
			con = pool.getConnection();
			sql = "select * from HAVE_COUPON where HAVE_USER_ID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				haveCouponBean bean = new haveCouponBean();
				bean.setHave_coupon_num(rs.getInt("have_coupon_num"));
				bean.setHave_user_id(user_id);

				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public void haveCouponInsert(haveCouponBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into HAVNE_COUPON(HAVE_USER_ID) values(?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getHave_user_id());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	public void haveCouponDelete(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from HAVE_COUPON where HAVE_COUPON_NUM = ?";
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
