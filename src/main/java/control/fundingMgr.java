package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import entity.fundingBean;
import entity.readRecordBean;

public class fundingMgr {
	
	private DBCMgr pool;
	
	public fundingMgr() {
		pool = DBCMgr.getInstance();
	}
	
	public Vector<fundingBean> fundingListForCategory(int category){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<fundingBean> vlist=null;
		try {
			con = pool.getConnection();
			sql = "select * from funding where funding_category = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, category);

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
				bean.setFunding_image(rs.getString("funding_image"));
				
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
		Vector<fundingBean> vlist=new Vector<fundingBean>();
		try {
			con = pool.getConnection();
			sql = "select * from funding order by funding_tprice / funding_nprice asc";
			pstmt = con.prepareStatement(sql);
			

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				fundingBean bean=new fundingBean();
				bean.setFunding_title(rs.getString("funding_title"));
				bean.setFunding_category(rs.getInt("funding_category"));
				bean.setFunding_con(rs.getString("funding_con"));
				bean.setFunding_tprice(rs.getInt("funding_tprice"));
				bean.setFunding_term(rs.getString("funding_term"));
				bean.setFunding_nprice(rs.getInt("funding_nprice"));
				bean.setFunding_user_id(rs.getString("funding_user_id"));
				bean.setFunding_image(rs.getString("funding_image"));
				
				vlist.addElement(bean);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
		
	}
	

	public Vector<fundingBean> fundingListForNum(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<fundingBean> vlist=new Vector<fundingBean>();
		try {
			con = pool.getConnection();
			sql = "select * from funding where funding_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {				
				fundingBean bean=new fundingBean();				
				bean.setFunding_num(rs.getInt("funding_num"));
				bean.setFunding_title(rs.getString("funding_title"));			
				bean.setFunding_category(rs.getInt("funding_category"));				
				bean.setFunding_con(rs.getString("funding_con"));
				bean.setFunding_tprice(rs.getInt("funding_tprice"));
				bean.setFunding_term(rs.getString("funding_term"));
				bean.setFunding_nprice(rs.getInt("funding_nprice"));
				bean.setFunding_image(rs.getString("funding_image"));
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
		Vector<fundingBean> vlist=new Vector<fundingBean>();
		try {
			con = pool.getConnection();
			sql = "select * from funding where funding_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				fundingBean bean=new fundingBean();


				
				bean.setFunding_num(rs.getInt("funding_num"));
				bean.setFunding_title(rs.getString("funding_title"));
				bean.setFunding_category(rs.getInt("funding_category"));

				
				bean.setFunding_num(rs.getInt("funding_num"));
				bean.setFunding_title(rs.getString("funding_title"));
				
				bean.setFunding_category(rs.getInt("funding_category"));
				

				bean.setFunding_con(rs.getString("funding_con"));
				bean.setFunding_tprice(rs.getInt("funding_tprice"));
				bean.setFunding_term(rs.getString("funding_term"));
				bean.setFunding_nprice(rs.getInt("funding_nprice"));
				bean.setFunding_image(rs.getString("funding_image"));
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
	
	
	public void fundingInsert(fundingBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into funding(funding_title, funding_category, funding_con, funding_tprice, funding_term, funding_nprice, funding_user_id, funding_image) values(?, ?, ?, ?, ? , ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getFunding_title());
			pstmt.setInt(2, bean.getFunding_category());
			pstmt.setString(3, bean.getFunding_con());
			pstmt.setInt(4, bean.getFunding_tprice());
			pstmt.setString(5, bean.getFunding_term());
			pstmt.setInt(6, bean.getFunding_nprice());
			pstmt.setString(7, bean.getFunding_user_id());
			pstmt.setString(8, bean.getFunding_image());
			
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
			sql = "delete from funding where funding_num = ?";
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
			sql = "update funding set funding_title = ?, funding_category = ?, funding_con = ?, funding_tprice = ?, funding_term = ?, funding_nprice = ?, funding_user_id = ?, funding_image = ? where funding_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getFunding_title());
			pstmt.setInt(2, bean.getFunding_category());
			pstmt.setString(3, bean.getFunding_con());
			pstmt.setInt(4, bean.getFunding_tprice());
			pstmt.setString(5, bean.getFunding_term());
			pstmt.setInt(6, bean.getFunding_nprice());
			pstmt.setString(7, bean.getFunding_image());
			pstmt.setString(8, bean.getFunding_user_id());
			

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}
	
	public int fundingCount(String id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count=0;
		try {
			con = pool.getConnection();
			sql = "select count(*) as funding_count from funding where funding_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				count=rs.getInt("funding_count");
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
		
	}
	
	public int fundDate(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count=0;
		try {
			con = pool.getConnection();
			sql = "select funding_term - sysdate as days_until_fund_term from funding where funding_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				count = (int) Math.ceil(rs.getDouble("days_until_fund_term"));
			
				System.out.println(count);

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	

	public Vector<fundingBean> fundingByRecord(Vector<readRecordBean> rvlist){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<fundingBean> vlist=new Vector<fundingBean>();
		for(int i=0;i<rvlist.size();i++) {
			try {
				con = pool.getConnection();
				sql = "select * from funding where funding_num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, rvlist.get(i).getRead_funding_num());
	
				rs = pstmt.executeQuery();
				while(rs.next()) {
					
					fundingBean bean=new fundingBean();

					bean.setFunding_num(rs.getInt("funding_num"));
					bean.setFunding_title(rs.getString("funding_title"));
					bean.setFunding_category(rs.getInt("funding_category"));
					bean.setFunding_con(rs.getString("funding_con"));
					bean.setFunding_tprice(rs.getInt("funding_tprice"));
					bean.setFunding_term(rs.getString("funding_term"));
					bean.setFunding_nprice(rs.getInt("funding_nprice"));
					bean.setFunding_image(rs.getString("funding_image"));
					bean.setFunding_user_id(rs.getString("funding_user_id"));
					
					vlist.addElement(bean);
					
				}
	
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
		return vlist;
		
	}
	
	public Vector<fundingBean> fundingByRecordHigh(){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<fundingBean> vlist=new Vector<fundingBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT f.* FROM funding f JOIN (SELECT read_funding_num, COUNT(*) AS read_count FROM read_record GROUP BY read_funding_num) r ON f.funding_num = r.read_funding_num ORDER BY r.read_count DESC";

			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				fundingBean bean=new fundingBean();
				bean.setFunding_num(rs.getInt("funding_num"));
				bean.setFunding_title(rs.getString("funding_title"));
				bean.setFunding_category(rs.getInt("funding_category"));
				bean.setFunding_con(rs.getString("funding_con"));
				bean.setFunding_tprice(rs.getInt("funding_tprice"));
				bean.setFunding_term(rs.getString("funding_term"));
				bean.setFunding_nprice(rs.getInt("funding_nprice"));
				bean.setFunding_image(rs.getString("funding_image"));
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
	
	public String getCategory(int num) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String category="";
		try {
			con = pool.getConnection();
			sql = "select * from category where category_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				category=rs.getString("category_funding");
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return category;
		
	}
	
	public int getCategory(String cg) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int category=0;
		try {
			con = pool.getConnection();
			sql = "select * from category where category_funding = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, cg);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				category=rs.getInt("category_num");
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return category;
		
	}

}
