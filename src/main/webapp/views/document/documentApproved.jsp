<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <style>
	.dashboard-body{
		transform: scale(0.9);
	    margin-left: 22vw;
	    width: 70vw;
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
		height: 700px;
	    border: 2px solid var(--primary-color);
	    border-radius: 10px;
	}
	.opt div:nth-child(3){
		border-bottom: 3px solid var(--accent-color);
	}
	.opt div:nth-child(3) a{
		color: var(--primary-color) !important;
	}
	.opt div:hover{
		cursor: pointer;
		border-bottom: 3px solid var(--accent-color);
	}
	.opt div a:hover{
		color: var(--primary-color);
	}
	table.myTable{
		border-collapse: separate !important;
        border-spacing: 0;
		width: -webkit-fill-available;
		border: 1px solid var(--primary-color);
		border-radius: 10px;
		margin: 0 48px 30px 48px;
		text-align: center;
	}
	table.myTable tr:not(:last-child) td, table th {
        border-bottom: 1px solid var(--primary-color) !important;
    }
	table.myTable tr{
		border-bottom: 1px solid var(--primary-color);
		height: 35px;
	}
	table.myTable th, table.myTable td{
		padding-left: 10px;
   		text-align: inherit;
	}
	table.myTable th{
		background-color: var(--primary-color);
		border-radius: 9px 9px 0 0;
		color: white;
	    text-align: left;
	}
	table.myTable td:nth-child(1) {
       width: 3%;
    }
    table.myTable td:nth-child(2) {
        width: 3%;
    }
    table.myTable td:nth-child(3) {
        width: 15%;
    }
    table.myTable td:nth-child(4) {
        width: 5%;
    }
    table.myTable td:nth-child(5) {
        width: 5%;
    }
    table.myTable td:nth-child(6) {
        width: 3%;
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
 <jsp:include page="../main/header.jsp"/>
 	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="document">결재문서</h3>
			<h3>>&nbsp;&nbsp;승인</h3>
		</div>
		<div class="docbox">
			<jsp:include page="documentModal.jsp"/>
			<table class="table1 myTable">
				<thead>
					<tr>
						<th>NO.</th>
						<th>문서번호</th>
						<th>분류</th>
						<th>문서 제목</th>
						<th>기안일</th>
						<th>문서 상태</th>
					</tr>
				</thead>
				<tbody class="saveList">
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
			<div class="container" id="cont">
			    <nav aria-label="Page navigation">
			        <ul class="pagination" id="Pagination"></ul>
			    </nav>
			</div>
		</div>
 	</div>
</body>
<script>

</script>
</html>
