package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.createpriceBean;
import entity.priceBean;

public class createpriceMgr {

private DBCMgr pool;
	
	public createpriceMgr() {
		pool = DBCMgr.getInstance();
	}
	
	public Vector<createpriceBean> priceList(String user_id){
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<createpriceBean> vlist=new Vector<createpriceBean>();
			try {
				con = pool.getConnection();
				sql = "select * from createprice where createprice_funding_user_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, user_id);
	
				rs = pstmt.executeQuery();
				while(rs.next()) {
					
					createpriceBean bean=new createpriceBean();
					bean.setCreateprice_num(rs.getInt("createprice_num"));
					bean.setCreateprice_funding_user_id(user_id);
					bean.setCreateprice_comp(rs.getString("createprice_comp"));
					bean.setCreateprice(rs.getInt("createprice"));
					bean.setCreateprice_count(rs.getInt("createprice_count"));
					
					vlist.addElement(bean);
					
				}
		
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
	}
	
	public void createpriceInsert(createpriceBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into createprice(createprice_funding_user_id, createprice_comp, createprice, createprice_count) values(?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getCreateprice_funding_user_id());
			pstmt.setString(2, bean.getCreateprice_comp());
			pstmt.setInt(3, bean.getCreateprice());
			pstmt.setInt(4, bean.getCreateprice_count());
			

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}
	
	public void createpriceDelete(createpriceBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from createprice where createprice_funding_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getCreateprice_funding_user_id());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}


}

