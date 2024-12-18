<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  <script src="https://kit.fontawesome.com/6282a8ba62.js" crossorigin="anonymous"></script>
  <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" rel="stylesheet">
  <link href="resources/css/app-style.css" rel="stylesheet"/>
  <style>
    .body {
	height: auto;
	width: 83%;
    }

    .bus-info-card {
      border: 2px solid #30005A;
      border-radius:  0 0 10px 10px;
      padding: 3px;
      height: auto;
      width: 100%;
    margin-top: 6vh;
      
    }

    .bus-number {
      font-size: 48px;
      font-weight: bold;
      color: #1DD20C;
      margin-right: 20px;
      flex: 0 0 10%;
    }
	span{
		width: 50%;
	}
    .purple {
      color: #30005A; /* 보라색 */
    }
    .green{
		color: #1DD20C;
	}
	.blue{
		color: #2A33DD;
	}
	select{
	    width: 26.1vw;
	    border-radius: 10px;
   	    padding: 3 10px;
   	    color: #30005A;
	}

    .bus-details {
      font-size: 16px;
      color: #8B6AA7; /* 연보라색 */
      margin: auto 0;
      margin-right: 15%;
      width: 100%;
      display: flex;
   	  justify-content: center;
    }

    .bus-details p {
      display: flex;
      align-items: center;
      margin: 0;
    }

    .bus-details p strong {
      min-width: 100px; /* 제목 너비 고정 */
      margin-right: 10px; /* 제목과 내용 사이 간격 */
      text-align: left; /* 제목 왼쪽 정렬 */
      color: #8B6AA7; /* 연한 보라색 */
      font-weight: bold; /* Bold 효과 추가 */
    }

.bus-drive-info {
	color: #30005A;
}
.lPurple {
	color: #8B6AA7;
}
.tm2 {
	margin-top: 2%;
	width: 82%;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 1.5rem;
}
.f32 {
	font-size: 32px;
}
.bold {
	font-weight: bold;
}
.content {
	width: 100%;
    height: 80%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-evenly;
}
.docnav{
	    width: 100%;
	    display: flex;
	    justify-content: flex-end;
	        margin-bottom: 0.5rem;
	}
	.searchbox{
		width: 24%;
		display: flex;
		align-items: center;
		justify-content: space-evenly;
	}
	.drop{
	    font-size: 14px;
	    border: 1px solid #30005A;
	    border-radius: 4px;
	    color: #30005A;
	}
	select option{
		background-color: white !important;
		border-radius: 5px;
		color: #30005A;
	}
	.search{
		position: relative;
    	display: inline-block;
	}
	.search input{
		border-radius: 10px;
		padding-left: 10px;
		border: 1px solid #30005A;
	}
	.search i{
		position: absolute;
		right: 10px;
		top: 50%;
		transform: translateY(-50%);
		font-size: 18px;
		pointer-events: none;
		color: #E9396B;
	}
	.editbtn{
		color: #FFFBF2;
		background-color: #E9396B;
		border-radius: 5px;
		width: 100%;
	    height: 9vh;
	}
	.bus-info-subject{
		background-color: #30005A;
		color: #FFFBF2;
	    margin-bottom:-6vh;
   	    width: 100%;
    	font-size: 24px;
    	margin-top: 1vh;
    	border-radius: 10px 10px 0 0;
   	    padding: 4px;
   	    text-align: center;
    }
    .bus-insert-btn{
        margin-top: 1vh;
        width: 100%;
    	display: flex;
    	flex-direction: column;
    	align-items: center;
    }
    .bus-details ul{
    	width: 80%;
   	    display: flex;
    	flex-direction: column;
    	align-items: center;
    	margin: 0px;
    	padding: 0px;
    }
    .bus-details li{
    	list-style: none;
    	width: 80%;
    	display: flex;
    	justify-content: space-between;
    	align-items: center;
    	margin: 4px;
    	border-bottom: 1px solid #8B6AA7;
   	    padding-bottom: 5px;
    }
    .bus-details input{
   	    width: 100%;
   	    border-radius: 10px;
   	    padding: 3 10px;
   	    color: #30005A;
    }
    .naviPath i{
    	margin-right: 2vw;
    }
    input[readonly] {
    border: none; /* 테두리 제거 */
    background: transparent; /* 배경 투명 */
    pointer-events: none; /* 마우스 클릭 막기 */
}
form{
    display: flex;
    flex-direction: column;
    align-items: center;
}
  </style>
</head>
<body class="bg-theme bg-theme1">
  <form action="dispatchInsert.do">
  <div class="body">
    <div class="content">
      <div class="bus-info-subject bold purple"><span>배차 등록</span></div>
      <div class="bus-info-card">
       	<div class="bus-details">
       	<input type="hidden" name="bus_idx" value="" />
       		<ul>
       			<li><strong>노선 번호:</strong> 
       			<span><input type="text" name="bus_route_name" value=""/></span></li>
       			<li><strong>차량 번호:</strong> 
       			<span><input type="text" name="bus_license_plate" value="" readonly/></span></li>
       			<li><strong>운행 기사:</strong> 
       			<span><input type="text" name="bus_fuel_efficiency" value=""/></span></li>
       			<li><strong>운행 시간:</strong> 
       			<span>
        				<select name="shift">
        					<option value="정상"></option>
        					<option value="정비 중"></option>
        				</select>
        			</span>
       		</ul>
        </div>
       </div>
			<div class="bus-insert-btn">
				<button class="editbtn" type="submit"><i class="far fa-edit"></i>&nbsp;등록</button>
				<button class="editbtn" style="background-color:#8B6AA7;" type="button">
				<i class="bi bi-x-square"></i>&nbsp;취소</button>
			</div>
    </div>
  </div>
</form>
</body>
<script>

</script>
</html>
