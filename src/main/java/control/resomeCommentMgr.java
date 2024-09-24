package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class resomeCommentMgr {
	
	private DBCMgr pool;
	
	public resomeCommentMgr() {
		pool = DBCMgr.getInstance();
	}

	public int recomeCount(int comment_num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count=0;
		try {
			con = pool.getConnection();
			sql = "select count(*) as recome_count from recome_comment where recome_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, comment_num);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				count=rs.getInt("recome_count");
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
		
		
	}
	
}
