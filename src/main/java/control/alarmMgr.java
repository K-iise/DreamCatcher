package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.alarmBean;

public class alarmMgr {

	private DBCMgr pool;

	public alarmMgr() {
		pool = DBCMgr.getInstance();
	}

	public Vector<alarmBean> alarmList(String user_id) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<alarmBean> vlist = new Vector<alarmBean>();
		try {
			con = pool.getConnection();			
			sql = "select * from (select * from alarm where alarm_user_id = ? order by alarm_num DESC) where rownum <= 30";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				alarmBean bean = new alarmBean();
				bean.setAlarm_num(rs.getInt("alarm_num"));
				bean.setAlarm_user_id(user_id);
				bean.setAlarm_con(rs.getString("alarm_con"));
				bean.setAlarm_check(rs.getInt("alarm_check"));
				bean.setAlarm_image(rs.getString("alarm_image"));
				vlist.addElement(bean);

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	public void alarmInsert(alarmBean bean) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into alarm(alarm_user_id, alarm_con, alarm_check) values(?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getAlarm_user_id());
			pstmt.setString(2, bean.getAlarm_con());
			pstmt.setInt(3, bean.getAlarm_check());
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}

	public void alarmCheck(int num) {

		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update alarm set alarm_check = 1 where alarm_num = ?";
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
	
	public boolean alarmOnOff(String user_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "select * from alarm where alarm_check = 0 and alarm_user_id = ?";
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