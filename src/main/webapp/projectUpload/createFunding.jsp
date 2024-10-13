<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.Vector"%>
<%@page import="java.time.LocalDate"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>
<%

request.setCharacterEncoding("UTF-8");
String user_id = (String) session.getAttribute("idKey");

usersMgr uMgr = new usersMgr();
usersBean mybean = new usersBean();
mybean=uMgr.oneUserList(user_id);
fundingMgr fdMgr=new fundingMgr();
fundingBean fdbean=new fundingBean();
createFundingMgr cfMgr=new createFundingMgr();
createFundingBean cfbean=cfMgr.createFundingList(mybean.getUser_id());



String fundingTerm = cfbean.getCreatefunding_term();

//문자열을 Date로 변환
java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.util.Date date = null;

//fundingTerm이 null인 경우 현재 날짜로 설정
if (fundingTerm == null || fundingTerm.isEmpty()) {
date = new java.util.Date(); // 기본값을 현재 날짜로 설정
} else {
try {
   date = inputFormat.parse(fundingTerm); // "yyyy-MM-dd HH:mm:ss.S" 형식으로 파싱
} catch (java.text.ParseException e) {
   e.printStackTrace();
}
}

if (date == null) {
date = new java.util.Date(); // 기본값을 현재 날짜로 설정
}
//변환된 Date를 "yyyy-MM-dd" 형식으로 출력
String formattedDate = (date != null) ? outputFormat.format(date) : "";

fdbean.setFunding_category(cfbean.getCreatefunding_category());
fdbean.setFunding_con1(cfbean.getCreatefunding_con_0());
fdbean.setFunding_con2(cfbean.getCreatefunding_con_1());
fdbean.setFunding_con3(cfbean.getCreatefunding_con_2());
fdbean.setFunding_con4(cfbean.getCreatefunding_con_3());
fdbean.setFunding_term(formattedDate);
fdbean.setFunding_user_id(cfbean.getCreatefunding_user_id());

String fundingImage = cfbean.getCreatefunding_image();
String fundingTitle = cfbean.getCreatefunding_title();
int fundingTprice = cfbean.getCreatefunding_tprice();

if (fundingImage == null || fundingTitle == null || fundingTprice == 0) {
    response.setContentType("text/html; charset=UTF-8");
    out.println("<script type='text/javascript'>");

    if (fundingImage == null) {
        out.println("alert('이미지 정보가 누락되었습니다.');");
    } else if (fundingTitle == null) {
        out.println("alert('제목 정보가 누락되었습니다.');");
    } else if (fundingTprice == 0) {
        out.println("alert('목표 금액 정보가 누락되었습니다.');");
    }

    out.println("history.back();");  // 이전 페이지로 이동
    out.println("</script>");
    out.flush();
    return;  // 에러가 있으면 이 이후 코드는 실행되지 않도록 종료
}

fdbean.setFunding_image(cfbean.getCreatefunding_image());
fdbean.setFunding_title(cfbean.getCreatefunding_title());
fdbean.setFunding_tprice(cfbean.getCreatefunding_tprice());

LocalDate currentDate = LocalDate.now();

// 날짜를 문자열로 포맷팅하기
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
String dateString = currentDate.format(formatter);
fdbean.setFunding_write_date(dateString);

createpriceMgr cpMgr=new createpriceMgr();
createpriceBean cpbean=new createpriceBean();
cpbean.setCreateprice_funding_user_id(mybean.getUser_id());
priceMgr pMgr=new priceMgr();
Vector<createpriceBean> cpvlist= cpMgr.priceList(mybean.getUser_id());


int num = fdMgr.fundingInsert(fdbean); // 자동으로 생성된 funding_num을 num에 저장
if (num > 0) {
    System.out.println("새로운 funding_num이 생성되었습니다: " + num);
} else {
    System.out.println("funding 생성 실패");
}
for(int i=0;i<cpvlist.size();i++){
	
	priceBean pbean=new priceBean();
	pbean.setPrice_funding_num(num);
	pbean.setPrice_comp(cpvlist.get(i).getCreateprice_comp());
	pbean.setPrice(cpvlist.get(i).getCreateprice());
	pbean.setPrice_count(cpvlist.get(i).getCreateprice_count());
	
	pMgr.priceInsert(pbean);
	cpMgr.createpriceDelete(cpvlist.get(i).getCreateprice_num());
	
	
	
}
cfMgr.createFundingDelete(cfbean.getCreatefunding_user_id());

response.sendRedirect("../home/home.jsp");

%>
