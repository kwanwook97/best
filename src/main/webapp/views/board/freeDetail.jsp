<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
	<meta charset="utf-8"/>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="resources/css/root.css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/js/bootstrap.min.js"></script>
	<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
  
  <style>
	.dashboard-body{
	    margin-left: 15vw;
	    margin-top: 7vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    color: var(--primary-color);
	    height: 92%;
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: center;
	    justify-content: center;
	}
	.maintext{
		display: flex;
		margin-left: -28vw;
	}
	.document{
		color: var(--secondary-color);
		margin-right: 30px !important;
	}
	.docbox{
	    position: relative;
	}
	table{
		width: 45vw;
		height: 36rem;
		border-radius: 10px;
		margin: 33px 48px 55px 48px;
		border: 2px solid var(--primary-color);
		border-collapse: separate !important;
        border-spacing: 0;
	}
	table tr{
		height: 35px;
	}
	table tr:last-child{
   		padding: 20px;
		position: absolute;
		height: 490px;
	}
	table tr:not(:last-child) td{
		padding-left: 20px;
        border-bottom: 1px solid var(--primary-color) !important;
    }
	table tr:nth-child(3) td{
		overflow: auto;
		overflow-y: hidden;
	    max-width: 45vw;
    }
	td{
	    font-size: small;
	}
	.gobtn{
		position: absolute;
	    right: 50px;
	    bottom: 0;
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
			<h3 class="document">게시판</h3>
			<h3>>&nbsp;&nbsp;공지사항</h3>
		</div>
		<div class="docbox">
			<table>
				<tbody>
					<tr>
						<td>제목 : ${info.subject}</td>
					</tr>
					<tr>
						<td>${info.content}</td>
					</tr>
				</tbody>
			</table>
			<div class="gobtn">
				<input type="button" value="리스트" onclick="location.href='freeBoard.go'"/>
				<input type="button" value="수정하기" onclick="location.href='freeUpdate.go?idx=${info.board_idx}'"/>
			</div>
		</div>
 	</div>
</body>
<script>

</script>
</html>
