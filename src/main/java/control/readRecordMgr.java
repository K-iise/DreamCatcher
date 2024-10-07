package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.alarmBean;
import entity.readRecordBean;

public class readRecordMgr {
	private DBCMgr pool;

	public readRecordMgr() {
		pool = DBCMgr.getInstance();
	}

	public Vector<readRecordBean> readList30(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<readRecordBean> vlist = new Vector<readRecordBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM READ_RECORD ORDER BY num DESC WHERE ROWNUM <= 30";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				readRecordBean bean = new readRecordBean();
				bean.setRead_num(rs.getInt("read_num"));
				bean.setRead_funding_num(rs.getInt("read_funding_num"));
				bean.setRead_user_id(user_id);
				bean.setRead_wish(rs.getInt("read_wish"));
				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	public Vector<readRecordBean> readListWish(String user_id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<readRecordBean> vlist = new Vector<readRecordBean>();
		try {
			con = pool.getConnection();
			// user_id가 일치하는 레코드만 가져오도록 쿼리 수정
			sql = "SELECT * FROM READ_RECORD WHERE READ_WISH = 1 AND READ_USER_ID = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id); // user_id 값을 쿼리에 바인딩
			rs = pstmt.executeQuery();
			while (rs.next()) {
				readRecordBean bean = new readRecordBean();
				bean.setRead_num(rs.getInt("read_num"));
				bean.setRead_funding_num(rs.getInt("read_funding_num"));
				bean.setRead_user_id(user_id);
				bean.setRead_wish(rs.getInt("read_wish"));
				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	public void readInsert(readRecordBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into READ_RECORD(READ_FUNDING_NUM, READ_USER_ID, READ_WISH) values(?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getRead_funding_num());
			pstmt.setString(2, bean.getRead_user_id());
			pstmt.setInt(3, bean.getRead_wish());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
}
