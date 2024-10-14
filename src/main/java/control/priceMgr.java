package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.priceBean;

public class priceMgr {

	private DBCMgr pool;
	
	public priceMgr() {
		pool = DBCMgr.getInstance();
	}
	
	public Vector<priceBean> priceList(int funding_num){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<priceBean> vlist= new Vector<priceBean>();
		try {
			con = pool.getConnection();
			sql = "select * from price where price_funding_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, funding_num);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				priceBean bean=new priceBean();
				bean.setPrice_num(rs.getInt("price_num"));
				bean.setPrice_funding_num(funding_num);
				bean.setPrice_comp(rs.getString("price_comp"));
				bean.setPrice(rs.getInt("price"));
				bean.setPrice_count(rs.getInt("price_count"));
				
				vlist.addElement(bean);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
		
	}
	
	public void priceInsert(priceBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into price(price_funding_num, price_comp, price, price_count) values(?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getPrice_funding_num());
			pstmt.setString(2, bean.getPrice_comp());
			pstmt.setInt(3, bean.getPrice());
			pstmt.setInt(4, bean.getPrice_count());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}

	public void priceDelete(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from price where event_num = ?";
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

	public void priceUpdate(priceBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update price set price_funding_num = ?, price_comp = ?, price = ?, price_count = ? where price_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getPrice_funding_num());
			pstmt.setString(2, bean.getPrice_comp());
			pstmt.setInt(3, bean.getPrice());		
			pstmt.setInt(4, bean.getPrice_count());
			pstmt.setInt(5, bean.getPrice_num());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}
	
	public void priceCountDown(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update price set price_count = price_count - 1 where price_num = ?";
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
	public priceBean getPrice(int funding_num) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    priceBean bean = null; // 가격 정보를 담을 bean 초기화
	    try {
	        con = pool.getConnection();
	        String sql = "SELECT * FROM price WHERE price_funding_num = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, funding_num);
	        rs = pstmt.executeQuery();

	        // 첫 번째 결과만 가져오도록 수정
	        if (rs.next()) {
	            bean = new priceBean();
	            bean.setPrice_num(rs.getInt("price_num"));
	            bean.setPrice_funding_num(funding_num);
	            bean.setPrice_comp(rs.getString("price_comp"));
	            bean.setPrice(rs.getInt("price"));
	            bean.setPrice_count(rs.getInt("price_count"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return bean; // 단일 가격 정보 반환
	}
	
	public priceBean getPriceByNum(int price_num) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    priceBean bean = null; // 가격 정보를 담을 bean 초기화
	    try {
	        con = pool.getConnection();
	        String sql = "SELECT * FROM price WHERE price_num = ?";
	        pstmt = con.prepareStatement(sql);
	        pstmt.setInt(1, price_num);
	        rs = pstmt.executeQuery();

	        // 첫 번째 결과만 가져오도록 수정
	        if (rs.next()) {
	            bean = new priceBean();
	            bean.setPrice_num(rs.getInt("price_num"));
	            bean.setPrice_funding_num(rs.getInt("price_funding_num"));
	            bean.setPrice_comp(rs.getString("price_comp"));
	            bean.setPrice(rs.getInt("price"));
	            bean.setPrice_count(rs.getInt("price_count"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        pool.freeConnection(con, pstmt, rs);
	    }
	    return bean; // 단일 가격 정보 반환
	}
}
