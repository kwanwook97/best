<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <style>
	:root{
		--primary-color: #30005A;
		--secondary-color: #8B6AA7;
		--accent-color: #E9396B;
		--background-color: #FFFBF2;
	}
	.dashboard-body{
	    margin-left: 14vw;
	    width: 85vw;
	    margin-top: 7vh;
	    flex-wrap: wrap;
	    padding: 2vh;
	    color: var(--primary-color);
	    height: 92%;
	    display: flex;
	    flex-direction: column;
	    align-content: center;
	    align-items: flex-start;
	    justify-content: center;
	}
	.maintext{
		display: flex;
		margin-left: 10px;
		margin-bottom: 47px;
	}
	.document{
		color: var(--secondary-color);
		margin-right: 30px !important;
	}
	.midle-subject{
		color: var(--secondary-color);
	}
	.last-lastsubject{
		color: var(--primary-color);
	}
	
	.docbox{
		border: 2px solid var(--primary-color);
	    width: -webkit-fill-available;
		height: 80%;
	    border: 2px solid var(--primary-color);
	    border-radius: 10px;
	}


	.drop{
	    font-size: 14px;
	    border: 1px solid var(--primary-color);
	    border-radius: 4px;
	    color: var(--primary-color);
	}
	select option{
		background-color: white !important;
		border-radius: 5px;
	}

	.search input{
		border-radius: 10px;
		padding-left: 10px;
		border: 1px solid var(--primary-color);
	}
	.search i{
		position: absolute;
		right: 190px;
		font-size: 18px;
		pointer-events: none;
		color: var(--accent-color);
	}

	@media (max-width: 960px) {
    .dashboard-body {
      transform: scale(0.8);
      margin-left: 17vw;
      width: 93vw;
    }
    .opt {
      width: 60%;
      flex-wrap: wrap;
    }
    .searchbox {
      width: 42%;
    }

  }
  /*  */
/* 상위 컨테이너를 Flexbox로 설정 */
	.docbox-header {
	    display: flex;
	    justify-content: space-between; /* 좌우로 정렬 */
	    align-items: center; /* 세로 중앙 정렬 */
	    margin: 20px 4% 0 0;
	}
	
	/* 왼쪽 텍스트 스타일 */
	.docbox-subject {
	    margin: 0 0 0 20%; /* 기본 마진 제거 */
	    font-weight: bold;
	}
	
	/* 오른쪽 정렬 */
	.docnav {
	    display: flex;
	    align-items: center; /* 세로 중앙 정렬 */
	    gap: 10px; /* 요소 간 간격 */
	}
	
	.searchbox {
	    display: flex;
	    align-items: center; /* 세로 중앙 정렬 */
	    gap: 10px;
	}
	
	.searchbox .search {
	    display: flex;
	    align-items: center;
	    gap: 5px;
	}
	
	.searchbox input {
	    padding: 0px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	}
	
	.editbtn {
	    padding: 2px 0px;
	   	background-color: var(--accent-color);
	    color: white;
	    border: none;
	   	border-radius: 10px;
	    cursor: pointer;
	    width: 70px;
	}
	
	.editbtn i {
	    margin-right: 5px;
	}
	
	.editbtn:hover {
	    background-color: #0056b3;
	}
	/* 차트 */
	.year-graph {
	    width: 40vw; /* 원래 834px */
	    height: 40vh; /* 원래 360px */
	    border-radius: 10px;
	    margin-bottom: 2vh;
	    border: 2px solid #30005A;
	    position: absolute;
	    right: 260px;
	    bottom: 179px;
	}
	.year-graph span{
		font-size: 24px;
		font-weight: 700;
	}
	.year-graph > div:first-child{
	    margin-left: 1vw;
	    margin-top: 1vw;
	}
	.year-graph2{
		display: flex;
		margin-top: 8vw;
		width: 100%;
		height: auto;
	    flex-direction: row;
	    justify-content: center;
	}
	.year-graph3{
		width: 7.5vh;
		height: 9vw;
		background-color: #30005A;
		border-top-left-radius: 10px;
	    border-top-right-radius: 10px;
	    margin: 0.3vw;
	}
	.year-graph2 > div {
	    text-align: center;
	}
  
   </style>
</head>
<body class="bg-theme bg-theme1">
 <jsp:include page="../header.jsp"></jsp:include>
 	<div class="dashboard-body">
		<div class="maintext">
			<h3 class="document">매출현황</h3>
			<h3 class="midle-subject">>&nbsp;&nbsp;월별 현황&nbsp;&nbsp;</h3>
			<h3 class="last-subject">>&nbsp;&nbsp;2024-12월</h3>
		</div>

		<div class="docbox">
		    <div class="docbox-header">
		        <h3 class="docbox-subject">&lt;&lt; &nbsp;&nbsp;&lt;&nbsp;&nbsp; 2024-12 &nbsp;&nbsp; &gt;&nbsp;&nbsp;&gt;&gt;</h3>
		        <div class="docnav">
		            <div class="searchbox">
		                <select class="drop">
		                    <option value="subject">카드사</option>
		                    <option value="content">이름</option>
		                </select>
		                <div class="search">
		                    <input type="text" name="">
		                    <i class="fas fa-search"></i>
		                </div>
		                <button class="editbtn"><i class="far fa-edit"></i>등록</button>
		            </div>
		        </div>
		    </div>
		    
		 	<div class="year-graph">
		 		<div><span>연간 매출</span></div>
		 		<div class="year-graph2">
		 			<div>
		 				<div class="year-graph3"></div><span>1월</span>
		 			</div>
		 			<div>
		 				<div class="year-graph3"></div><span>2월</span>
		 			</div>
		 			<div>
		 				<div class="year-graph3"></div><span>3월</span>
		 			</div>
		 			<div>
		 				<div class="year-graph3"></div><span>4월</span>
		 			</div>
		 			<div>
		 				<div class="year-graph3"></div><span>5월</span>
		 			</div>
		 			<div>
		 				<div class="year-graph3"></div><span>6월</span>
		 			</div>
		 			<div>
		 				<div class="year-graph3"></div><span>7월</span>
		 			</div>
		 			<div>
		 				<div class="year-graph3"></div><span>8월</span>
		 			</div>
		 			<div>
		 				<div class="year-graph3"></div><span>9월</span>
		 			</div>
		 			<div>
		 				<div class="year-graph3"></div><span>10월</span>
		 			</div>
		 			<div>
		 				<div class="year-graph3"></div><span>11월</span>
		 			</div>
		 			<div>
		 				<div class="year-graph3"></div><span>12월</span>
		 			</div>
		 		</div>
		 	</div>
		    
		    
		    
		</div>
	</div>
</body>
<script>

</script>
</html>
