package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.fundingBean;

public class fundingMgr {
	
	private DBCMgr pool;
	
	public fundingMgr() {
		pool = DBCMgr.getInstance();
	}
	
	public Vector<fundingBean> fundingListForCategory(String category){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<fundingBean> vlist=null;
		try {
			con = pool.getConnection();
			sql = "select * from funding where funding_category = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, category);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				fundingBean bean=new fundingBean();
				bean.setFunding_title(rs.getString("funding_title"));
				bean.setFunding_category(category);
				bean.setFunding_con(rs.getString("funding_con"));
				bean.setFunding_tprice(rs.getInt("funding_tprice"));
				bean.setFunding_term(rs.getString("funding_term"));
				bean.setFunding_nprice(rs.getInt("funding_nprice"));
				bean.setFunding_user_id(rs.getString("funding_user_id"));
				
				vlist.addElement(bean);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
		
	}

	public Vector<fundingBean> fundingListForPercent(){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<fundingBean> vlist=null;
		try {
			con = pool.getConnection();
			sql = "select * from funding order by tprice / nprice desc";
			pstmt = con.prepareStatement(sql);
			

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				fundingBean bean=new fundingBean();
				bean.setFunding_title(rs.getString("funding_title"));
				bean.setFunding_category(rs.getString("funding_category"));
				bean.setFunding_con(rs.getString("funding_con"));
				bean.setFunding_tprice(rs.getInt("funding_tprice"));
				bean.setFunding_term(rs.getString("funding_term"));
				bean.setFunding_nprice(rs.getInt("funding_nprice"));
				bean.setFunding_user_id(rs.getString("funding_user_id"));
				
				vlist.addElement(bean);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
		
	}
	
	public Vector<fundingBean> fundingListForUserId(String user_id){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<fundingBean> vlist=null;
		try {
			con = pool.getConnection();
			sql = "select * from funding where funding_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				fundingBean bean=new fundingBean();
				bean.setFunding_title(rs.getString("funding_title"));
				bean.setFunding_category("funding_category");
				bean.setFunding_con(rs.getString("funding_con"));
				bean.setFunding_tprice(rs.getInt("funding_tprice"));
				bean.setFunding_term(rs.getString("funding_term"));
				bean.setFunding_nprice(rs.getInt("funding_nprice"));
				bean.setFunding_user_id(rs.getString(user_id));
				
				vlist.addElement(bean);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
		
	}

	public void fundingInsert(fundingBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into funding(funding_title, funding_category, funding_con, funding_tprice, funding_term, funding_nprice, funding_user_id) values(?, ?, ?, ?, ? , ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getFunding_title());
			pstmt.setString(2, bean.getFunding_category());
			pstmt.setString(3, bean.getFunding_con());
			pstmt.setInt(4, bean.getFunding_tprice());
			pstmt.setString(5, bean.getFunding_term());
			pstmt.setInt(6, bean.getFunding_nprice());
			pstmt.setString(7, bean.getFunding_user_id());
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}

	public void fundingDelete(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from funding where coupon_num = ?";
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

	public void fundingUpdate(fundingBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update funding set funding_title = ?, funding_category = ?, funding_con = ?, funding_tprice = ?, funding_term = ?, funding_nprice = ?, funding_user_id = ? where funding_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getFunding_title());
			pstmt.setString(2, bean.getFunding_category());
			pstmt.setString(3, bean.getFunding_con());
			pstmt.setInt(4, bean.getFunding_tprice());
			pstmt.setString(5, bean.getFunding_term());
			pstmt.setInt(6, bean.getFunding_nprice());
			pstmt.setString(7, bean.getFunding_user_id());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}
	
}
