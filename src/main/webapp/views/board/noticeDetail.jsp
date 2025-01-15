<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/root.css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
  
  <style>
	.dashboard-body{
	    margin-left: 15vw;
	    margin-top: 6vh;
	    padding: 2vh;
	    color: var(--primary-color);
	    height: 92%;
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	    justify-content: flex-start;
	}
	.maintext{
	    margin-top: 13px;
	    width: 20%;
	    display: flex;
	    margin-left: -68vw;
	    margin-bottom: 1px;
	    justify-content: space-between;
	    align-items: baseline;
	}
	.maintext i,
	.maintext span{
		font-size: 32px !important;
		font-weight: bold !important;
	}
	.maintext span:first-child{
		color: var(--secondary-color);
	}
	.boxBox{
	    display: flex;
	    flex-direction: column;
	    align-items: flex-end;
	}
	.docbox{
	    border: 2px solid var(--primary-color);
	    border-radius: 15px;
	    margin-top: 10px;
	}
	table.noticeTable{
		width: 45vw;
		height: 36rem;
		border-radius: 10px;
		margin: 33px 48px 55px 48px;
		border-collapse: separate !important;
        border-spacing: 0;
	}
	table.noticeTable .trOne td{
		height: 35px;
        font-size: 21px;
    	font-weight: bold;
	}
	table.noticeTable .trTwo{
   		display: flex;
    	height: 42px;
	}
	table.noticeTable .trTwo td{
	    height: 20px;
    	font-size: medium;
	}
	table.noticeTable .trTwo td:last-child {
		color: #454545;
	    transform: scale(0.85);
   	    margin-left: -13px;
	}
	table.noticeTable .trThr{
   		padding: 20px;
		height: 490px;
	}
	table.noticeTable .trThr td{
	    padding: 15px;
		overflow: auto;
		overflow-y: hidden;
	    max-width: 45vw;
	    border-top: 1px solid var(--primary-color);
    }
	.gobtn{
        padding: 10px 1px 10px 0;
	}
	input[type="button"]{
		width: 120px;	
		color: var(--primary-color);
		border-radius: 10px;
		border: 2px solid var(--secondary-color);
		background-color: var(--background-color);
	}
	input[type="button"]:hover{
		background-color: var(--accent-color);
	}
   </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
		<div class="maintext">
			<span class="document">게시판</span>
			<i class="fa-solid fa-angle-right" style="color: #8B6AA7;"></i>
			<span>공지 게시판</span>
		</div>
		<div class="boxBox">
			<div class="docbox">
				<table class="noticeTable">
					<tbody>
						<tr class="trOne">
							<td>제목 : ${info.subject}</td>
						</tr>
						<tr class="trTwo">
							<td>작성자 : ${info.name} (${info.depart_name}/${info.rank_name})</td>
							<input type="hidden" value="${info.emp_idx}"/>
							<td>${info.date} | 👀${info.bhit}</td>
						</tr>
						<tr class="trThr">
							<td>${info.content}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="gobtn">
				<input type="button" value="☰ 목록" onclick="location.href='noticeBoard.go'"/>
				<c:if test="${sessionScope.employee.depart_idx == 2 || sessionScope.employee.depart_idx == 3 || sessionScope.employee.depart_idx == 6}">
					<input type="button" value="수정하기" onclick="location.href='noticeUpdate.go?idx=${info.board_idx}'"/>
					<input type="button" value="삭제하기" onclick="location.href='noticeDelete.do?idx=${info.board_idx}'"/>
				</c:if> 
			</div>
		</div>
 	</div>
</body>
<script>
</script>
</html>
