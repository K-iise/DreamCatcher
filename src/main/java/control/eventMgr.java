package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.eventBean;

public class eventMgr {
	
	private DBCMgr pool;
	
	public eventMgr() {
		pool = DBCMgr.getInstance();
	}

	public Vector<eventBean> eventList(){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<eventBean> vlist=null;
		
		try {
			con = pool.getConnection();
			sql = "select * from event";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				eventBean bean=new eventBean();
				
				bean.setEvent_num(rs.getInt("event_num"));
				bean.setEvent_title(rs.getString("event_title"));
				bean.setEvent_con(rs.getString("event_con"));
				bean.setEvent_startdate(rs.getString("event_startdate"));
				bean.setEvent_enddate(rs.getString("event_enddate"));
				
				vlist.addElement(bean);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
		
	}

	public void eventInsert(eventBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into event(event_title, event_con, event_startdate, event_enddate) values(?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getEvent_title());
			pstmt.setString(2, bean.getEvent_con());
			pstmt.setString(3, bean.getEvent_startdate());
			pstmt.setString(4, bean.getEvent_enddate());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}

	public void eventDelete(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from event where event_num = ?";
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

	public void eventUpdate(eventBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update event set event_title = ? where event_num = ? "
					+"update event set event_con = ? where event_num = ? "
					+"update event set event_startdate = ? where event_num = ? "
					+"update event set event_enddate = ? where event_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getEvent_title());
			pstmt.setInt(2, bean.getEvent_num());
			pstmt.setString(3, bean.getEvent_con());
			pstmt.setInt(4, bean.getEvent_num());
			pstmt.setString(5, bean.getEvent_startdate());
			pstmt.setInt(6, bean.getEvent_num());
			pstmt.setString(7, bean.getEvent_enddate());
			pstmt.setInt(8, bean.getEvent_num());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}
	
}
