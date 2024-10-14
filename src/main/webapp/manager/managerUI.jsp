<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>
<%

request.setCharacterEncoding("UTF-8");
fundingMgr fdMgr=new fundingMgr();

String action = request.getParameter("Action");
System.out.println("action: " + action); // 디버깅 로그
String type = request.getParameter("type");
System.out.println("type: " + type); // 디버깅 로그
String dataStr = request.getParameter("Data");
int data = 0;

if (dataStr != null && !dataStr.isEmpty()) {
    try {
        data = Integer.parseInt(dataStr);  // 문자열을 int로 변환
    } catch (NumberFormatException e) {
        e.printStackTrace();  // 예외 처리: 변환 실패 시 처리
    }
}
System.out.println("Data: " + data); // 디버깅 로그

if ("submit".equals(action)) {
	
	if("delete1".equals(type)||"reject".equals(type)){
		
		fdMgr.fundingDelete(data);
		
	}else if("approve".equals(type)){
		
		fdMgr.fundingApprove(data);
		
	}


    // 저장이 성공하면 전송된 페이지로 이동

    response.sendRedirect("managerUI.jsp");
    
}

%>

<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dream Catcher - 프로젝트 관리</title>
    <style>
        /* 기존 스타일 유지 */
        body, html {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            box-sizing: border-box;
            overflow-x: hidden;
            height: 100%;
        }

        .header {
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }

        .header-left {
            position: absolute;
            left: 20px;
            display: flex;
            align-items: center;
            font-size: 16px;
        }

        .header-left .back-arrow {
            margin-right: 10px;
            cursor: pointer;
        }

        .header h1 {
            margin: 0;
            font-size: 24px;
            font-weight: bold;
            text-align: center;
        }

        .content {
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 70vh;
        }

        table {
            width: 80%;
            max-width: 1000px;
            border-collapse: collapse;
            margin-top: 10px;
            table-layout: fixed;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
            word-wrap: break-word;
        }

        th {
            background-color: #f4f4f4;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .delete-btn {
            background-color: #d9534f;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
        }

        .approve-btn {
            background-color: #5cb85c;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
        }

        .reject-btn {
            background-color: #d9534f;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
        }

        .delete-btn:hover, .approve-btn:hover, .reject-btn:hover {
            opacity: 0.8;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .active-icon {
            color: green;
        }

        .inactive-icon {
            color: red;
        }

        .checkbox {
            margin: 0;
        }

        .pagination-container {
            position: fixed;
            bottom: 0;
            width: 100%;
            display: flex;
            justify-content: center;
            background-color: white;
            padding: 10px 0;
            box-shadow: 0 -2px 5px rgba(0,0,0,0.1);
        }

        .pagination button {
            padding: 5px 10px;
            margin: 0 5px;
            border: 2px solid black;
            background-color: white;
            color: black;
            cursor: pointer;
        }

        .pagination button.active {
            background-color: black;
            color: white;
            border: 2px solid black;
        }

        .pagination button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }

        .no-data-message {
            text-align: center;
            color: #777;
            margin-top: 20px;
            font-size: 18px;
        }
    </style>


</head>
<body>

    <div class="header">
        <div class="header-left">
            <span class="back-arrow">←</span>
            <span>뒤로 가기</span>
        </div>
        <h1>Dream Catcher</h1> 
    </div>
	
    <div class="content">
        <table>
            <thead>
                <tr>
                    
                    <th>아이디</th>
                    <th>프로젝트 이름</th>
                    <th>카테고리</th>
                    <th>활성화</th>
                    <th>등록일자</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody id="table-body">
            <%
            
            Vector<fundingBean> fdvlist = fdMgr.fundingList();
            

            %>
            <%for(int i=0; i<fdvlist.size();i++){ %>
            <%
            
            String fundingTerm = fdvlist.get(i).getFunding_write_date();

	         // 문자열을 Date로 변환
	         java.text.SimpleDateFormat inputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
	         java.text.SimpleDateFormat outputFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
	         java.util.Date date = null;
	
	         // fundingTerm이 null인 경우 현재 날짜로 설정
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
	         // 변환된 Date를 "yyyy-MM-dd" 형식으로 출력
	         String formattedDate = (date != null) ? outputFormat.format(date) : "";
	         String formId = "projectForm" + i;
            
            %>
	            <% if (fdvlist.get(i).getFunding_agree() == 1) { %>
			        <form id="<%=formId%>" method="post">
			            <input type="hidden" name="Action" value="submit">
			            <tr>
			                <td><%=fdvlist.get(i).getFunding_user_id() %></td>
			                <td><%=fdvlist.get(i).getFunding_title() %></td>
			                <td><%=fdMgr.getCategory(fdvlist.get(i).getFunding_category())%></td>
			                <td><span class="active-icon">O</span></td>
			                <td><%=formattedDate %></td>
			                <td>
			                    <div class="action-buttons">
			                        <button class="delete-btn" onclick="delete1('<%=fdvlist.get(i).getFunding_num()%>', '<%=formId%>'); return false;">삭제</button>
			                    </div>
			                </td>
			            </tr>
			        </form>
			    <% } else { %>
			        <form id="<%=formId%>" method="post">
			            <input type="hidden" name="Action" value="submit">
			            <tr>
			                <td><%=fdvlist.get(i).getFunding_user_id() %></td>
			                <td><%=fdvlist.get(i).getFunding_title() %></td>
			                <td><%=fdMgr.getCategory(fdvlist.get(i).getFunding_category())%></td>
			                <td><span class="inactive-icon">X</span></td>
			                <td><%=formattedDate %></td>
			                <td>
			                    <div class="action-buttons">
			                        <button class="approve-btn" onclick="approve('<%=fdvlist.get(i).getFunding_num()%>', '<%=formId%>'); return false;">승인</button>
			                        <button class="reject-btn" onclick="reject('<%=fdvlist.get(i).getFunding_num()%>', '<%=formId%>'); return false;">거절</button>
			                    </div>
			                </td>
			            </tr>
			        </form>
			    <% } %>
                <%} %>

            </tbody>
        </table>
    </div>



    <script>


    function delete1(Data, formId) {
        var form = document.getElementById(formId);  // 전달된 formId로 폼 타겟팅
        var actionInput = document.createElement("input");
        actionInput.type = "hidden";
        actionInput.name = "type";
        actionInput.value = "delete1";  

        var actionInput2 = document.createElement("input");
        actionInput2.type = "hidden";
        actionInput2.name = "Data";
        actionInput2.value = Data;

        form.appendChild(actionInput);
        form.appendChild(actionInput2);
        form.submit();  // 폼 제출
    }

    function approve(Data, formId) {
        var form = document.getElementById(formId);  // 전달된 formId로 폼 타겟팅
        var actionInput = document.createElement("input");
        actionInput.type = "hidden";
        actionInput.name = "type";
        actionInput.value = "approve";  

        var actionInput2 = document.createElement("input");
        actionInput2.type = "hidden";
        actionInput2.name = "Data";
        actionInput2.value = Data;

        form.appendChild(actionInput);
        form.appendChild(actionInput2);
        form.submit();  // 폼 제출
    }

    function reject(Data, formId) {
        var form = document.getElementById(formId);  // 전달된 formId로 폼 타겟팅
        var actionInput = document.createElement("input");
        actionInput.type = "hidden";
        actionInput.name = "type";
        actionInput.value = "reject";  

        var actionInput2 = document.createElement("input");
        actionInput2.type = "hidden";
        actionInput2.name = "Data";
        actionInput2.value = Data;

        form.appendChild(actionInput);
        form.appendChild(actionInput2);
        form.submit();  // 폼 제출
    }

    </script>

</body>
</html>
