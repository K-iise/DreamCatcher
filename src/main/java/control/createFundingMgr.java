package control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;

import entity.createFundingBean;

public class createFundingMgr {
	
private DBCMgr pool;
	
	public createFundingMgr() {
		pool = DBCMgr.getInstance();
	}
	
	public void createFunding_insert(createFundingBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into createfunding(createfunding_user_id, createfunding_category, createfunding_summary, createfunding_term) values(?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getCreatefunding_user_id());
			pstmt.setInt(2, bean.getCreatefunding_category());
			pstmt.setString(3, bean.getCreatefunding_summary());
			pstmt.setString(4, bean.getCreatefunding_term());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
	}
	
	public createFundingBean createFundingList(String user_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		createFundingBean bean=new  createFundingBean();
		try {
			con = pool.getConnection();
			sql = "select * from createfunding where createfunding_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				
				bean.setCreatefunding_user_id(user_id);
				bean.setCreatefunding_category(rs.getInt("createfunding_category"));
				bean.setCreatefunding_con_0(rs.getString("createfunding_con_0"));
				bean.setCreatefunding_con_1(rs.getString("createfunding_con_1"));
				bean.setCreatefunding_con_2(rs.getString("createfunding_con_2"));
				bean.setCreatefunding_con_3(rs.getString("createfunding_con_3"));
				bean.setCreatefunding_image(rs.getString("createfunding_image"));			
				bean.setCreatefunding_summary(rs.getString("createfunding_summary"));
				bean.setCreatefunding_term(rs.getString("createfunding_term"));
				bean.setCreatefunding_title(rs.getString("createfunding_title"));
				bean.setCreatefunding_tprice(rs.getInt("createfunding_tprice"));
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
		
	}
	
	public void createFundingUpdate(createFundingBean bean) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		System.out.println(1);
		try {
			con = pool.getConnection();
			sql = "update createfunding set createfunding_title = ?, createfunding_category = ?, "
					+ "createfunding_con_0 = ?, createfunding_con_1 = ?,createfunding_con_2 = ?,createfunding_con_3 = ?, "
					+ "createfunding_tprice = ?, createfunding_summary = ?, createfunding_term = ?, "
					+ "createfunding_image = ? where createfunding_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getCreatefunding_title());
			pstmt.setInt(2, bean.getCreatefunding_category());
			pstmt.setString(3, bean.getCreatefunding_con_0());
			pstmt.setString(4, bean.getCreatefunding_con_1());
			pstmt.setString(5, bean.getCreatefunding_con_2());
			pstmt.setString(6, bean.getCreatefunding_con_3());
			pstmt.setInt(7, bean.getCreatefunding_tprice());
			pstmt.setString(8, bean.getCreatefunding_summary());
	        // 1. 날짜 문자열 포맷 수정
			String inputDate = bean.getCreatefunding_term();  // "2024-10-05 00:00:00.0" 같은 문자열

			// 2. 시간 부분이 포함된 문자열을 Date로 변환
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = null;

			// inputDate가 null인 경우 처리
			if (inputDate == null) {
			    date = null;  // inputDate가 null일 경우 date도 null로 설정
			} else {
			    // 문자열이 시간 정보가 포함된 경우 포맷을 맞춰 변환
			    try {
			        date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(inputDate);  // "2024-10-05 00:00:00.0"
			    } catch (Exception e) {
			        date = sdf.parse(inputDate);  // "2024-10-05"
			    }
			}

	        // 3. java.sql.Date로 변환
	        java.sql.Date sqlDate = new java.sql.Date(date.getTime());
	        pstmt.setDate(9, sqlDate);  // 날짜 세팅 // 날짜 세팅
			pstmt.setString(10, bean.getCreatefunding_image());
			pstmt.setString(11, bean.getCreatefunding_user_id());
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		System.out.println(2);
		return;
		
	}
	
	public boolean createFundingCheck(String user_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "select * from createfunding where createfunding_user_id = ?";
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
	
	public void createFundingDelete(String user_id) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from createfunding where createfunding_user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_id);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
		
		
	}

}
