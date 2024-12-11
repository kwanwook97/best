<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<script src="https://kit.fontawesome.com/6282a8ba62.js"
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
:root {
	--primary-color: #30005A;
	--secondary-color: #8B6AA7;
	--accent-color: #E9396B;
	--background-color: #FFFBF2;
}

.dashboard-body {
	margin-left: 14vw;
	width: 85vw;
	margin-top: 7vh;
	flex-wrap: wrap;
	padding: 2vh;
	height: 100%;
	display: flex;
	flex-direction: column;
	align-content: center;
	align-items: flex-start;
	justify-content: center;
}

.textbox {
	position: relative;
	display: flex;
	width: 100%;
	height: 10%;
	align-items: center;
	justify-content: space-between;
}

.maintext {
	display: flex;
	margin-left: 0.625rem;
}

.document {
	color: var(--secondary-color);
	margin-right: 1.875rem;
	margin-bottom: 1.75rem;
}

.mainbox {
	display: flex;
	width: 100%;
	height: 90%;
}

.userbox {
	border: 2px solid var(--primary-color);
	width: 16%;
	height: 90%;
	border-radius: 0.625rem;
}

.contentbox {
	border: 2px solid var(--primary-color);
	width: 84%;
	height: 90%;
	border-radius: 0.625rem;
	margin-left: 0.5rem;
}

.docnav {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 0 3rem;
	padding: 0 0.3125rem;
}

.search {
	position: absolute;
	display: inline-block; right : 2%;
	top: 64%;
	right: 2%;
}

.search input {
	border-radius: 0.625rem;
	padding-left: 0.625rem;
	border: 1px solid var(--primary-color);
}

.search i {
	position: absolute;
	right: 0.625rem;
	top: 50%;
	transform: translateY(-50%);
	font-size: 1.125rem;
	pointer-events: none;
	color: var(--accent-color);
}

.fa-arrow-alt-circle-left {
	font-size: 20px;
	margin: 5px;
}

.fa-arrow-alt-circle-left:hover {
	cursor: pointer;
	font-weight: bold;
}

.subfolders {
	display: none;
	margin-left: 20px;
}

.folder {
	cursor: pointer;
	margin-bottom: 10px;
	padding: 5px;
}

.folder:hover {
	background-color: #f0f0f0;
}

/* 기존 스타일 */
#tooltipContainer {
	padding: 15px;
	background-color: #f9f9f9;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	max-width: 300px;
	margin-top: 20px;
	font-family: Arial, sans-serif;
}

.tooltip {
	background-color: #ffffff;
	padding: 12px;
	margin-bottom: 10px;
	border-left: 5px solid #ffcc00;
	border-radius: 6px;
	cursor: pointer;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease, background-color 0.3s ease;
}

.tooltip div {
	font-size: 14px;
	color: #333;
	margin: 5px 0;
	cursor: pointer;
	transition: color 0.2s ease;
}

.tooltip div:hover {
	color: #ff9900;
}

.tooltip .phone, .tooltip .email {
	font-weight: bold;
	color: #007BFF;
}

.tooltip div:active {
	color: #ff5733;
}

/* 노드 클릭 시 보여줄 정보 창 스타일 */
#infoBox {
	display: none;
	border: 1px solid #ccc;
	padding: 10px;
	margin-top: 20px;
	background-color: #f9f9f9;
}

#infoBox p {
	margin: 5px 0;
}
.google-visualization-orgchart-node-medium {
	border: none !important;
	background: var(--primary-color) !important;
	color: white;
	width: 11%;
}
.google-visualization-orgchart-linebottom {
    border-bottom: 1px solid var(--primary-color) !important;
}
.google-visualization-orgchart-lineleft {
    border-left: 1px solid var(--primary-color) !important;
}
.google-visualization-orgchart-lineright{
	border-right: 1px solid var(--primary-color) !important;
}
.emp{
	border-radius: 3px;
	color:var(--primary-color); 
	background: white;
	height: 1%;
}

@media ( max-width : 960px) {
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
		width: 40%;
	}
	.editbtn {
		width: 100%;
		margin-top: 10px;
	}
	table {
		margin: 0 10px 55px 10px;
	}
}
</style>
</head>
<body class="bg-theme bg-theme1">
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="dashboard-body">
		<div class="textbox">
			<div class="maintext">
				<h3 class="document">조직도</h3>
				<h3>>&nbsp;&nbsp;조직도</h3>
			</div>
			<div class="search">
				<input type="text" name=""> <i class="fas fa-search"></i>
			</div>
		</div>
		<div class="mainbox">
			<div class="userbox">
				<div class="folder">
					<span class="folder-icon">📁</span> 대장
					<div class="subfolders">
						<div class="folder">
							<span class="folder-icon">📂</span> 대장 밑에 1-1
							<div class="subfolders">
								<div class="folder">
									<span class="folder-icon">📂</span> 대장 밑에 아래 1-1-1
								</div>
							</div>
						</div>
						<div class="folder">
							<span class="folder-icon">📂</span> 대장 밑에 1-2
						</div>
					</div>
				</div>
				<div class="folder">
					<span class="folder-icon">📁</span> 부대장
					<div class="subfolders">
						<div class="folder">
							<span class="folder-icon">📂</span> 부대장 밑에 2-1
						</div>
						<div class="folder">
							<span class="folder-icon">📂</span> 부대장 밑에 2-2
						</div>
					</div>
				</div>
			</div>
			<div class="contentbox">
				<div id="chart_div"></div>
			</div>
		</div>
	</div>
</body>
<script>
$(document).ready(function() {
	// 폴더 클릭 시 하위 폴더 토글
	$('.folder').click(function(event) {
		event.stopPropagation(); // 부모 폴더 클릭 이벤트가 발생하지 않도록
	
		const subfolders = $(this).children('.subfolders');
	
		if (subfolders.length) {
			const isVisible = subfolders.css('display') === 'block';
			subfolders.css('display',isVisible ? 'none' : 'block');
		}
	});

	google.charts.load('current', {packages : [ "orgchart" ]	});
	google.charts.setOnLoadCallback(drawChart);

	var data;
	var nodeInfo = {};
	function drawChart() {
		data = new google.visualization.DataTable();
		data.addColumn('string', 'Node ID');
		data.addColumn('string', 'Parent Node ID');
		data.addColumn('string', 'ToolTip Info');

		// 데이터 추가
		data.addRows([[
				{v : '1', f : '대표<div class="emp">이종원</div>'}, '', '부서 : 대표' ], 
				[{v : '2', f : '운영 부서<div class="emp">이재명 부장</div>'}, '1', '부서 : 운영팀' ],
				[{v : '3', f : '인사 부서<div class="emp">허경영 부장</div>'}, '1', '부서 : 인사팀' ],
				[{v : '4', f : '차량 관리 부서<div class="emp">김정은 부장</div>'}, '1', '부서 : 차량 관리팀' ],
				[{v : '5', f : '회계팀<div class="emp">김정은 팀장</div>'}, '2', '부서 : 차량 관리팀' ],
				[{v : '6', f : '운영팀<div class="emp">종원핑 팀장</div>'}, '2', '부서 : 운영팀' ],
				[{v : '7', f : '인사팀<div class="emp">이원종 팀장</div>'}, '3', '부서 : 인사팀' ],
				[{v : '8', f : '정비팀<div class="emp">원종히메 팀장</div>'}, '4', '부서 : 차량 관리팀' ],
				[{v : '9', f : '기사팀<div class="emp">이원종 팀장</div>'}, '4', '부서 : 차량 관리팀' ]
		]);

		// 노드 정보 저장 (추가 데이터)
		nodeInfo['1'] = {
			name : '이사장',
			phone : '010-1111-1111',
			email : 'hong@gildong.com'
		};
		nodeInfo['2'] = {
			name : '부이사장',
			phone : '010-1111-0001',
			email : 'hongil@gildong.com'
		};
		nodeInfo['3'] = {
			name : '총괄팀장',
			phone : '010-1111-0003',
			email : 'hongsam@gildong.com'
		};
		nodeInfo['4'] = {
			name : '총괄본부장',
			phone : '010-1111-0002',
			email : 'hongidong@gildong.com'
		};

		// 차트 생성 및 옵션 설정
		const chart = new google.visualization.OrgChart(
				document.getElementById('chart_div'));

		// 차트 그리기
		chart.draw(data, {allowHtml : true});

		// 노드 클릭 이벤트 리스너 추가
		google.visualization.events.addListener(chart,'select',function() {
			const selection = chart.getSelection();
			if (selection.length > 0) {
				const selectedNode = selection[0];
				const nodeId = data.getValue(selectedNode.row,0);

				if (nodeInfo[nodeId]) {
					alert('이름: '+ nodeInfo[nodeId].name+ '\n'+ '전화번호: '+ nodeInfo[nodeId].phone+ '\n'+ '이메일: '+ nodeInfo[nodeId].email);
				}
			}
		});

		// 새 노드 추가
		$('#submitBtn').on('click',function() {
			const position = $('#position').val();
			const name = $('#name').val();
			const phone = $('#phone').val();
			const email = $('#email').val();
			const parentNode = $('#parentNodeSelect').val();
			const siblingNode = $('#siblingNodeSelect').val();
			const department = $('#department').val();

			if (!position || !name || !phone || !email	|| !parentNode) {
				alert('모든 필드를 입력해주세요.');
				return;
			}
			const newNodeId = String(Object.keys(nodeInfo).length + 1);
			nodeInfo[newNodeId] = {
				name : name,
				phone : phone,
				email : email
			};

			let insertionIndex = data.getNumberOfRows();
			if (siblingNode) {
				const siblingIndex = data.getFilteredRows([ 
					{column : 0,
						value : siblingNode} 
				])[0];
				insertionIndex = siblingIndex + 1; // 형제 노드의 바로 다음에 추가
			}

			// 새 노드를 추가
			data.insertRows(insertionIndex,[ 
				[{v : newNodeId, f : position+ '<div class="emp">'+ name+ '</div>'},
					parentNode,
					'부서 : '+ department+ '<br>연락처 : '+ phone+ '<br>이메일 : '+ email] 
			]);

			chart.draw(data, {allowHtml : true});

			// 새 노드가 부모로 선택될 수 있도록 부모 노드 선택 옵션 갱신
			$('#parentNodeSelect').append('<option value="' + newNodeId + '">'+ position+ '</option>');
			$('#parentNodeSelect').val(newNodeId); // 새로 추가된 노드를 부모로 설정

			// 입력 폼 초기화
			$('#addForm').hide();
			$('#addForm input').val('');
			$('#siblingNodeSelect').val('');
			$('#siblingNodeSelect').val('');

			// 부모 노드 선택 폼 업데이트
			$('#parentNodeSelect').trigger('change'); // 부모 노드를 변경하여 형제 목록 갱신
		});

		// "추가하기" 버튼 클릭 시 폼 표시 토글
		$('#showAddFormBtn').on('click', function() {
			$('#addForm').toggle(); // 버튼을 클릭하면 폼이 보이거나 숨겨집니다.
		});
	}
});
</script>
</html>
