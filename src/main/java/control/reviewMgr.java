package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.reviewBean;

public class reviewMgr {
	private DBCMgr pool;

	public reviewMgr() {
		pool = DBCMgr.getInstance();
	}

	public Vector<reviewBean> reviewList(int funding_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<reviewBean> vlist = new Vector<reviewBean>();
		try {
			con = pool.getConnection();
			sql = "select * from REVIEW where REVIEW_FUNDING_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, funding_num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				reviewBean bean = new reviewBean();
				bean.setReview_num(rs.getInt("review_num"));
				bean.setReview_funding_num(funding_num);
				bean.setReview_user_id(rs.getString("review_user_id"));
				bean.setReview_con(rs.getString("review_con"));
				bean.setReview_date(rs.getString("review_date"));
				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public void reviewInsert(reviewBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into REVIEW(REVIEW_FUNDING_NUM, REVIEW_USER_ID, REVIEW_CON, REVIEW_DATE) values(?,?,?,sysdate)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getReview_funding_num());
			pstmt.setString(2, bean.getReview_user_id());
			pstmt.setString(3, bean.getReview_con());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	public void reviewDelete(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from review where review_num = ?";
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
	
	public void reviewUpdate(reviewBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update review set REVIEW_CON = ? where REVIEW_NUM = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getReview_con());
			pstmt.setInt(2, bean.getReview_num());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
}
