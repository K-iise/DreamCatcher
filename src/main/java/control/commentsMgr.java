package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.commentsBean;

public class commentsMgr {

	private DBCMgr pool;

	public commentsMgr() {
		pool = DBCMgr.getInstance();
	}

	public Vector<commentsBean> commentList(int funding_num) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<commentsBean> vlist = new Vector<commentsBean>();
		try {
			con = pool.getConnection();
			sql = "select * from comments where comment_funding_num = ? ORDER BY comment_num DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, funding_num);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				commentsBean bean = new commentsBean();
				bean.setComment_num(rs.getInt("comment_num"));
				bean.setComment_funding_num(funding_num);
				bean.setComment_user_id(rs.getString("comment_user_id"));
				bean.setComment_con(rs.getString("comment_con"));
				bean.setComment_date(rs.getString("comment_date"));
				bean.setComment_ans(rs.getString("comment_ans"));

				vlist.addElement(bean);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;

	}

	public void ansInsert(String ans, int num) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update comments set comment_ans = ? where comment_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, ans);
			pstmt.setInt(2, num);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;

	}
	
	public void ansDelete(int num) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    try {
	        con = pool.getConnection();
	        // comment_num에 해당하는 행의 comment_ans 값을 null로 변경
	        sql = "UPDATE comments SET comment_ans = NULL WHERE comment_num = ?";
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

	public void commentInsert(commentsBean bean) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into comments(comment_funding_num, comment_user_id, comment_con, comment_date) values(?, ?, ?, sysdate)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getComment_funding_num());
			pstmt.setString(2, bean.getComment_user_id());
			pstmt.setString(3, bean.getComment_con());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}

	public void commentDelete(int num) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    try {
	        con = pool.getConnection();
	        sql = "DELETE FROM comments WHERE comment_num = ?";
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

	public void commentUpdate(commentsBean bean) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update comments set comment_con = ? where comment_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getComment_con());
			pstmt.setInt(2, bean.getComment_num());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;

	}
	
	public int commentDate(int num) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    int daysAgo = 0;

	    try {
	        con = pool.getConnection();
	        sql = "SELECT TRUNC(SYSDATE - comment_date) AS days_ago FROM comments WHERE comment_num = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, num);

	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            daysAgo = rs.getInt("days_ago");
	            System.out.println(daysAgo);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return daysAgo;
	}
}
