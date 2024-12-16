<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <style>
	.dashboard-body{
		transform: scale(0.9);
	    margin-left: 14vw;
	    width: 85vw;
	    margin-top: 7vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    color: var(--primary-color);
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: flex-start;
	    justify-content: center;
	}
	.maintext{
		display: flex;
		margin-left: 10px;
	}
	.document{
		color: var(--secondary-color);
		margin-right: 30px;
	    margin-bottom: 40px;
	}
	.docbox{
		border: 2px solid var(--primary-color);
	    width: -webkit-fill-available;
		height: 80%;
	    border: 2px solid var(--primary-color);
	    border-radius: 10px;
	}
	.opt div:nth-child(2){
		border-bottom: 3px solid var(--accent-color);
	}
	.opt div:hover:not(nth-child(2)){
		cursor: pointer;
		border-bottom: 3px solid var(--accent-color);
	}
	table{
		border-collapse: separate !important;
        border-spacing: 0;
		width: -webkit-fill-available;
		border: 1px solid var(--primary-color);
		border-radius: 10px;
		margin: 0 48px 30px 48px;
	}
	table tr:not(:last-child) td, table th {
        border-bottom: 1px solid var(--primary-color) !important;
    }
	tr{
		border-bottom: 1px solid var(--primary-color);
		height: 35px;
	}
	th, td{
		padding-left: 10px;
   		text-align: inherit;
	}
	th{
		background-color: var(--primary-color);
		border-radius: 9px 0;
		color: white;
	}
	.fa-arrow-alt-circle-left{
		font-size: 20px;
	    margin: 5px;
	}
	.fa-arrow-alt-circle-left:hover{
		cursor: pointer;
		font-weight: bold;
	}
	hr {
	  border-top: 1px solid rgba(0, 0, 0, .1) !important;
	  margin: 10px 0;
	}
   </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../main/header.jsp"></jsp:include>
 	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="document">결재문서</h3>
			<h3>>&nbsp;&nbsp;완료</h3>
		</div>
		<div class="docbox">
			<jsp:include page="documentModal.jsp"></jsp:include>
			<table class="table1">
				<thead>
					<tr>
						<th colspan="4">승인된 문서</th>
					</tr>
				</thead>
				<tbody>
					<!-- 읽지 않은 메일 -->
					<tr class="unread">
						<td>example1@example.com</td>
						<td>읽지 않은 메일 제목</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-07 10:30</td>
					</tr>
					<!-- 읽은 메일 -->
					<tr>
						<td>example2@example.com</td>
						<td>읽은 메일 제목</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-06 18:45</td>
					</tr>
					<tr>
						<td>example3@example.com</td>
						<td>광고 메일</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-05 14:20</td>
					</tr>
					<tr>
						<td>example3@example.com</td>
						<td>광고 메일</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-05 14:20</td>
					</tr>
					<tr>
						<td>example3@example.com</td>
						<td>광고 메일</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-05 14:20</td>
					</tr>
					<tr>
						<td>example3@example.com</td>
						<td>광고 메일</td>
						<td>이메일 내용 미리보기...</td>
						<td>2024-12-05 14:20</td>
					</tr>
				</tbody>
			</table>
		</div>
 	</div>
</body>
<script>

</script>
</html>
