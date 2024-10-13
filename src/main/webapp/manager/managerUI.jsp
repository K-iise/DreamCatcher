<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="control.*"%>
<%@ page import="entity.*"%>

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
                <tr>
                    
                    <td>user123</td>
                    <td>프로젝트 A</td>
                    <td>게임</td>
                    <td><span class="active-icon">O</span></td>
                    <td>2024-10-10</td>
                    <td>
                        <div class="action-buttons">
                            <button class="delete-btn" onclick="deleteRow(0)">삭제</button>
                        </div>
                    </td>
                </tr>
                <tr>
                    
                    <td>user456</td>
                    <td>프로젝트 B</td>
                    <td>음악</td>
                    <td><span class="inactive-icon">X</span></td>
                    <td>2024-09-28</td>
                    <td>
                        <div class="action-buttons">
                            <button class="approve-btn" onclick="approveRow(1)">승인</button>
                            <button class="reject-btn" onclick="rejectRow(1)">거절</button>
                        </div>
                    </td>
                </tr>
                <tr>
                    
                    <td>user789</td>
                    <td>프로젝트 C</td>
                    <td>미술</td>
                    <td><span class="active-icon">O</span></td>
                    <td>2024-10-01</td>
                    <td>
                        <div class="action-buttons">
                            <button class="delete-btn" onclick="deleteRow(2)">삭제</button>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="pagination-container" id="pagination-container">
        <div class="pagination" id="pagination">
            <!-- 페이지네이션 버튼이 동적으로 들어갑니다. -->
            <button class="active">1</button>
            <button>2</button>
            <button>3</button>
        </div>
    </div>

    <script>
        // Select All 체크박스 동작
        function toggleSelectAll() {
            var checkboxes = document.querySelectorAll('.select-row');
            var selectAll = document.getElementById('selectAll').checked;
            checkboxes.forEach(function(checkbox) {
                checkbox.checked = selectAll;
            });
        }

        // Row 삭제 기능
        function deleteRow(index) {
            alert('Row ' + index + ' 삭제');
        }

        // Row 승인 기능
        function approveRow(index) {
            alert('Row ' + index + ' 승인');
        }

        // Row 거절 기능
        function rejectRow(index) {
            alert('Row ' + index + ' 거절');
        }
    </script>

</body>
</html>
