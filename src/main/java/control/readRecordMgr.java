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
			sql = "SELECT * FROM READ_RECORD WHERE ROWNUM <= 30 AND READ_USER_ID = ? ORDER BY READ_NUM DESC";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
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
	

	public int getWishCountForFunding(int fundingNum) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int count = 0; // 개수 초기화
	    try {
	        con = pool.getConnection();
	        String sql = "SELECT COUNT(*) AS wish_count FROM READ_RECORD WHERE READ_FUNDING_NUM = ? AND READ_WISH = 1";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, fundingNum);
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	            count = rs.getInt("wish_count"); // 개수 가져오기
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return count;
	}
	
	public boolean checkIfRead(String user_id, int funding_num) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    boolean exists = false;

	    try {
	        con = pool.getConnection();
	        sql = "SELECT COUNT(*) FROM READ_RECORD WHERE READ_USER_ID = ? AND READ_FUNDING_NUM = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, user_id);
	        pstmt.setInt(2, funding_num);
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	            exists = rs.getInt(1) > 0; // count가 0보다 크면 존재함
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    
	    return exists;
	}
	
	public void updateReadWish(String user_id, int fundingNum, int newWishValue) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    String sql = null;
	    try {
	        con = pool.getConnection();
	        sql = "UPDATE READ_RECORD SET READ_WISH = ? WHERE READ_USER_ID = ? AND READ_FUNDING_NUM = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, newWishValue);
	        pstmt.setString(2, user_id);
	        pstmt.setInt(3, fundingNum);
	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt);
	    }
	}
	
	public int getUserCountForFunding(int fundingNum) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int userCount = 0; // 참여한 유저 수 초기화
	    try {
	        con = pool.getConnection();
	        String sql = "SELECT COUNT(DISTINCT buy_user_id) AS user_count " +
	                     "FROM buy_record br " +
	                     "JOIN price p ON br.buy_price_num = p.price_num " +
	                     "WHERE p.price_funding_num = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, fundingNum);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            userCount = rs.getInt("user_count");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return userCount;
	}
}
