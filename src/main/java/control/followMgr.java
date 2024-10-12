package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.followBean;

public class followMgr {
	
	private DBCMgr pool;
	
	public followMgr() {
		pool = DBCMgr.getInstance();
	}
	
	public Vector<followBean> followingList(String user_id){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<followBean> vlist=new Vector<followBean>();
		
		try {
			con = pool.getConnection();
			sql = "select * from follow where follow_set_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				followBean bean=new followBean();
				bean.setFollow_num(rs.getInt("follow_num"));
				bean.setFollow_get_user_id(rs.getString("follow_get_user_id"));
				bean.setFollow_set_user_id(user_id);
				
				vlist.addElement(bean);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
		
	}
	
public Vector<followBean> followerList(String user_id){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<followBean> vlist=new Vector<followBean>();
		
		try {
			con = pool.getConnection();
			sql = "select * from follow where follow_get_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				followBean bean=new followBean();
				bean.setFollow_num(rs.getInt("follow_num"));
				bean.setFollow_set_user_id(rs.getString("follow_set_user_id"));
				bean.setFollow_get_user_id(user_id);
				
				vlist.addElement(bean);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
		
	}

	public int getFollowerCount(String user_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count=0;
		try {
			con = pool.getConnection();
			sql = "select count(*) as follower_count from follow where follow_get_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				count=rs.getInt("follower_count");
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
		
	}
	
	public int getFollowingCount(String user_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count=0;
		try {
			con = pool.getConnection();
			sql = "select count(*) as following_count from follow where follow_set_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				count=rs.getInt("following_count");
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
		
	}
	
	public void followInsert(followBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into follow(follow_set_user_id, follow_get_user_id) values(?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getFollow_set_user_id());
			pstmt.setString(2, bean.getFollow_get_user_id());
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}

	public void followDelete(followBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from follow where follow_set_user_id = ? and follow_get_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getFollow_set_user_id());
			pstmt.setString(2, bean.getFollow_get_user_id());
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}
	
	public boolean followCheck(String set_user_id, String get_user_id) {
		
		Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    boolean isFollowing = false;
	    try {
	        con = pool.getConnection();
	        String sql = "SELECT COUNT(*) FROM follow WHERE follow_set_user_id = ? AND follow_get_user_id = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setString(1, set_user_id);
	        pstmt.setString(2, get_user_id);
	        rs = pstmt.executeQuery();
	        if (rs.next() && rs.getInt(1) > 0) {
	            isFollowing = true;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return isFollowing;
	}
	
}
