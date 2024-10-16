package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.buyRecordBean;

public class buyRecordMgr {
	
	private DBCMgr pool;
	
	public buyRecordMgr() {
		pool = DBCMgr.getInstance();
	}
	
	public Vector<buyRecordBean> buyRecordList(String user_id){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<buyRecordBean> vlist=null;
		try {
			con = pool.getConnection();
			sql = "select * from buy_record where buy_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				buyRecordBean bean=new buyRecordBean();
				bean.setBuy_num(rs.getInt("buy_num"));
				bean.setBuy_price_num(rs.getInt("buy_price_num"));
				bean.setBuy_user_id(user_id);
				bean.setBuy_date(rs.getString("buy_date"));
				
				vlist.addElement(bean);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
			
	}

	public void buyRecordInsert(buyRecordBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into buy_record(buy_price_num, buy_user_id, buy_date) values(?, ?, sysdate)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getBuy_price_num());
			pstmt.setString(2, bean.getBuy_user_id());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;		
	}
	
	public int buyRecordCount(String user_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count=0;
		try {
			con = pool.getConnection();
			sql = "select count(*) as buy_count from buy_record where buy_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				count=rs.getInt("buy_count");
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
		
	}
	
	public int buyRecordTotalCount(String user_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count=0;
		try {
			con = pool.getConnection();
			sql = "SELECT COUNT(*) as buy_count FROM buy_record br JOIN price p ON br.buy_price_num = p.price_num JOIN funding f ON p.price_funding_num = f.funding_num WHERE f.funding_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				count=rs.getInt("buy_count");
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
		
	}
	
	
	
}
