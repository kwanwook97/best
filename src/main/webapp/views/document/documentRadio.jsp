<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/root.css" />
</head>
<style>
table.myTable label {
	font-size: medium;
	display: inline;
}
</style>
<body>
	<table class="table1 myTable">
		<thead>
			<tr>
				<th colspan="6">
	                <input type="radio" id="sentDocuments" name="documentType" value="sent" checked>
	                <label for="sentDocuments">보낸문서</label>
	
	                <input type="radio" id="receivedDocuments" name="documentType" value="received">
	                <label for="receivedDocuments">받은문서</label>
	            </th>
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
</body>
<script>

</script>
</html>