<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link href="resources/css/empManage/empDetail.css" rel="stylesheet"/>
  <style>

  </style>
</head>
<body class="bg-theme bg-theme1">
  <c:set var="emp_idx" value="${param.emp_idx}" />
  <c:set var="emp_name" value="${sessionScope.employee.name}" />

  <sec:authorize access="!hasAuthority('ROLE_ADMIN')">
  	<jsp:include page="../main/header.jsp"></jsp:include>
  </sec:authorize>
  <sec:authorize access="hasAuthority('ROLE_ADMIN')">
  	<jsp:include page="../main/adminHeader.jsp"></jsp:include>
  </sec:authorize>
  <!-- 기본 모달, 사원정보 변경 모달 -->
  <jsp:include page="../modal/modal.jsp"></jsp:include>
  <!-- 기사정보 관리 모달 -->
	<div class="driver_modal modal_change">
	  <div class="driver_modal_container">
	    <!-- 제목을 동적으로 설정할 부분 -->
	    <h2 id="modalTitle" class="driver_modal_title">기사 정보 관리</h2>
	    <table class="modal_table">
	      <tr>
	        <th>면허번호</th>
	        <td>
	          <input type="text" id="license" class="input_field" placeholder="면허번호를 입력하세요.">
	        </td>
	      </tr>
	      <tr>
	        <th>면허유효기간</th>
	        <td>
	          <input type="date" id="license_period" class="input_field">
	        </td>
	      </tr>
	      <tr>
	        <th>자격증번호</th>
	        <td>
	          <input type="text" id="certificate" class="input_field" placeholder="자격증번호를 입력하세요.">
	        </td>
	      </tr>
	    </table>
	    <div class="driver_modal_footer">
	      <button class="full_btn_regist">등록 하기</button>
	      <button class="full_btn_cancel">취소</button>
	    </div>
	  </div>
	</div>
  
  
  
  <div class="body">
    <div class="naviPath">
      <span class="lPurple" onclick="location.href='empList.go'">사원관리</span>
      <i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
      <span class="lPurple">사원목록</span>
      <i class="fa-solid fa-angle-right" style="color:#8B6AA7;"></i>
      <span class="cPurple">사원상세</span>
    </div>
    <div class="content">
      <div class="top-section">
      	<div class="photo-container">
		    <div class="photo" id="photoSection">
		        <img alt="Profile Photo" src="/photo/${detail.photo}"/>
		        <input type="file" id="profileUpload" name="photoFile" accept="image/*" style="display: none;" />
		    </div>
		    <div class="photo-bottom">
		    	<div class="state">
			    	<c:choose>
					    <c:when test="${detail.state == true}">
					        <span style="color: #00FF11;">●</span>&nbsp;&nbsp;근무 중
					    </c:when>
					    <c:when test="${detail.state == false}">
					        <span style="color: red;">●</span>&nbsp;&nbsp;부재 중
					    </c:when>
					</c:choose>
		            
		        </div>
		        <div>
		        	<c:choose>
					    <c:when test="${detail.enable == true}">
					    	<span class="enable lPurple">로그인 제한</span>
					        <span class="enable cPurple">정상</span>
					    </c:when>
					    <c:when test="${detail.enable == false}">
					        <span class="enable cPurple">로그인 제한</span>
					        <span class="enable lPurple">정상</span>
					    </c:when>
					</c:choose>
		        </div>
		    </div>
		</div>
        <div class="personal-info">
          <h2>개인 정보</h2>
          <table>
            <colgroup>
              <col>
              <col>
              <col>
              <col>
            </colgroup>
            <tr>
              <th>이름</th>
              <td>${detail.name}</td>
              <th>부서</th>
              <td>${detail.depart_name}<div class="btn_area"><button class="normalBtn" id="depart_idx">변경하기</button></div></td>
            </tr>
            <tr>
              <th>사원번호</th>
              <td>${detail.emp_idx}</td>
              <th>직급</th>
              <td>${detail.rank_name}<div class="btn_area"><button class="normalBtn" id="rank_idx">변경하기</button></div></td>
            </tr>
            <tr>
              <th>주민번호</th>
              <td>${detail.resident_number}</td>
              <th>연봉</th>
              <td>${detail.salary}<div class="btn_area"><button class="normalBtn" id="salary">변경하기</button></div></td>
            </tr>
            <tr>
              <th>성별</th>
              <td>${detail.gender}</td>
              <th>계좌번호</th>
              <td>${detail.account_number}<div class="btn_area"><button class="normalBtn" id="account_number">변경하기</button></div></td>
            </tr>
            <tr>
              <th>이메일</th>
              <td>${detail.email}</td>
              <th>전화번호</th>
              <td>${detail.phone}<div class="btn_area"><button class="normalBtn" id="phone">변경하기</button></div></td>
            </tr>
            <tr>
              <th>주소</th>
              <td>${detail.address}<div class="btn_area"><button class="normalBtn" id="address">변경하기</button></div></td>
              <th>핸드폰번호</th>
              <td>${detail.mobile}<div class="btn_area"><button class="normalBtn" id="mobile">변경하기</button></div></td>
            </tr>
            <tr>
              <th>입사일</th>
              <td>${detail.start_date}</td>
              <th>퇴사일</th>
              <td>${detail.end_date}<div class="btn_area"><button class="normalBtn" id="end_date">변경하기</button></div></td>
            </tr>
            <tr>
              <th>IP주소</th>
              <td>${detail.ip}<div class="btn_area"><button class="normalBtn" id="ip">변경하기</button></div></td>
              <c:choose>
	              <c:when test="${detail.depart_idx != 4}">
				  	<!-- 기사 부서가 아닐 경우, 버튼 숨기기 -->
				  </c:when>
	              <c:otherwise>
	              	<td colspan="2"><div class="driver_area"><button class="notbtn" id="driver_manage">기사정보 관리하기</button></div></td>
	              </c:otherwise>
              </c:choose>
            </tr>
          </table>
        </div>
      </div>

      <div class="bottom-section">
        <div class="status-info">
          <h2>근무 상태 및 연차</h2>
          <table>
            <colgroup>
              <col>
              <col>
            </colgroup>
            <tr>
            	<th>근무상태</th>
            	<td>
            		<c:choose>
					    <c:when test="${detail.state == true}">
					        근무 중
					    </c:when>
					    <c:when test="${detail.state == false}">
					        부재 중
					    </c:when>
					</c:choose>
            	</td>
           	</tr>
            <tr><th>총 연차</th><td>${detail.total_leave}</td></tr>
            <tr><th>잔여 연차</th><td>${detail.remain_leave}</td></tr>
            <tr><th>연차 시작일</th><td>${detail.lv_start_date}</td></tr>
            <tr><th>연차 종료일</th><td>${detail.lv_end_date}</td></tr>
            <tr><th>이번 달 근무일수</th><td>${attendance.workDays}&nbsp;일</td></tr>
            <tr><th>이번 달 연장근로 시간</th><td>${attendance.totalOverTime} &nbsp;시간</td></tr>
          </table>
        </div>
                <div class="history-info">
          <h2>인사 변경 내역</h2>
          <table>
		  <thead>
            <tr class="infoTitle-tr"><th class="infoTitle-th">
            	<select class="infoTitle">
					<option>전체</option>
					<option>부서</option>
					<option>직급</option>
					<option>연봉</option>
					<option>계좌번호</option>
					<option>전화번호</option>
					<option>핸드폰번호</option>
					<option>퇴사일</option>
					<option>주소</option>
					<option>IP주소</option>
				</select>
            </th><th>변경전</th><th>변경후</th><th>변경 일시</th><th>변경자</th></tr>
            </thead>
            <tbody class="addTbody">

            </tbody>
          </table>
        </div>
        <div class="attachment-info">
        	
		  <h2>첨부 파일</h2>
		  <table>
		    <tr><th>파일명</th><th>업로드 날짜</th><th>삭제</th></tr>
			
			<c:set var="index" value="0" />
			<c:set var="maxRows" value="5" />
			
			<c:forEach items="${detail.fileList}" var="file">
			    <tr>
			        <td>
			            <a href="fileDownload.do?file_name=${fn:escapeXml(file.file_name)}">
			                <i class="fas fa-download" style="color: #8B6AA7;"></i>
			                ${file.file_name}
			            </a>
			        </td>
			        <td>${file.date}</td>
			        <td>
			            <button onclick="delFile(this)" class="deleteFileBtn">
			                <i class="bi bi-trash-fill"></i>
			            </button>
			        </td>
			    </tr>
			</c:forEach>
			
			<!-- 부족한 행만큼 빈 행 추가 -->
			<c:forEach begin="${fn:length(detail.fileList)}" end="${maxRows - 1}" var="i">
			    <tr>
			        <td></td>
			        <td></td>
			        <td></td>
			    </tr>
			</c:forEach>
			   
		    <tr class="file-upload">
		      <form action="fileUpload.do" method="POST" enctype="multipart/form-data">
			      <td colspan="2"><input type="file" id="fileUpload" name="files" multiple/></td>
			      <td>
					<input type="text" name="emp_idx" value="${emp_idx}" hidden/>
					<button type="submit" class="saveFileBtn">저장</button>
			      </td>
		      </form>
		    </tr>
		  </table>
		</div>
      </div>
    </div>
  </div>
</body>

<script>
	/* 전역변수 */
	var col = '';              // 변경할 컬럼
	var empIdx = '${emp_idx}';   // 사번
	var empName = '${emp_name}'; // 사원명
	var currentVal = '';    // 현재 값
	var newVal = '';        // 변경 값
	var newText = '';        // 변경 값(부서, 직급 Text)
	var fileName = '';      // 삭제할 파일이름
	var fileCnt = ${index};    // 첨부파일 개수
	var license = '${detail.license}';         // 면허번호
    var license_period = '${detail.license_period}';  // 면허유효기간
    var certificate = '${detail.certificate}';     // 자격증번호
    
    
 	// 이미 업로드된 파일 목록 가져오기 (JSP에서 서버에서 전달받은 데이터 활용)
    var uploadedFiles = [];
    <c:forEach items="${detail.fileList}" var="file">
        uploadedFiles.push("${file.file_name}");
    </c:forEach>;
    
	
    // 인사변경 내역 가져오기
    infoHistoryCheck();
    
	/* 직원정보 변경 모달창 관련 기능 */
	// 1. 모달 띄우기
	$('.normalBtn').on('click', function() {
	    // 클릭한 버튼의 컬럼 값 가져오기
	    col = $(this).attr('id');
	    // 변경할 항목 이름 가져오기
	    var changeName = $(this).closest('td').prev('th').text();
	    // 현재 값 (버튼태그 값 제거)
	    currentVal = $(this).closest('td').clone().children().remove().end().text().trim();
	    
	 	// 날짜수정인 경우(퇴사일, 면허유효기간)
	    if (changeName == '퇴사일' || changeName == '면허유효기간') {
	        // date선택 기능
	        var dateInput = $('<input type="date" id="new" class="input_field" value="' + currentVal + '">');
	        $('#newVal').html(dateInput);
	    }
	    // 부서나 직급인 경우 DROPDOWN 추가
	    else if(changeName == '부서' || changeName == '직급'){
	    	var table = changeName == '부서' ? 'department' : 'rank_emp'; 
	    	
			$.ajax({
				method: 'POST',
				url: 'empDrop.ajax',
				data: {
					'table': table
				},
				dataType: 'JSON',
				success: function(list){
					
					// select 태그 동적 생성
		            var dropdown = $('<select id="new" class="input_field"></select>');
					
		            $.each(list, function (index, item) {
		                var value = changeName === '부서' ? item.depart_name : item.rank_name;
		                var idx = changeName === '부서' ? item.depart_idx : item.rank_idx;
		                if(currentVal == value){
		                	dropdown.append('<option value="' + idx + '" selected>' + value + '</option>');	
		                }else{
		                	dropdown.append('<option value="' + idx + '">' + value + '</option>');
		                }
		                
		            });

		
		            // 모달에 dropdown 삽입
		            $('#newVal').html(dropdown); // 변경할 값 부분을 교체
					
				},
				error: function(e){
					modal.showAlert('잠시 후 다시 시도해주세요.');
				}
			});	    	
	    }else{
	    	// 모달에 input태그 삽입
	    	var inputTag = $('<input type="text" id="new" class="input_field" value=""/>');
	        $('#newVal').html(inputTag); // 변경할 값 부분을 교체
	    }
	    	
	    // 모달 타이틀과 현재 값 설정
	    showChangeModal(changeName + ' 변경', currentVal, empName);
	});
	
	// 2. 직원정보 값 변경
	$('.full_btn_change').on('click', function() {
	    // 변경할 값 저장
	    newVal = $('#new').val();
	    newText = $('#new option:selected').text();
	    
	    // 확인 모달 띄우기
	    modal.showConfirm('정말로 수정하시겠습니까?', function () {
	        empUpdate(); // 확인 버튼 클릭 시 수정 함수 실행
	    });
	});
	
	// 3. 모달창 닫기
	$('.full_btn_cancel').on('click', function() {
	    hideChangeModal();
	    hideDriverModal();
	});
	
	
	
	// 직원정보 수정 함수
	function empUpdate() {
		
		// 상급자 정보를 찾기 위한 변수
		var parentFind = ''; 
		
		if(col == 'depart_idx'){
			parentFind = '${detail.depart_idx}';
		}else if(col == 'rank_idx'){
			parentFind = '${detail.rank_idx}';
		}
		
	    $.ajax({
	        method: 'POST',
	        url: 'empUpdate.ajax',
	        data: {
	            'emp_idx': empIdx,           // 사번
	            'col': col,                  // 컬럼 값
	            'currentVal': currentVal,    // 현재 값
	            'newVal': newVal,            // 변경할 값
	            'newText': newText,          // 부서,직급 Text값
	            'parentFind': parentFind     // 상급자정보를 찾기위한 값
	        },
	        dataType: 'JSON',
	        success: function(data) {
	        	if(data.success == '성공'){
	        	    modal.showConfirm('정보수정에 성공했습니다.', function () {
	        	    	location.reload(); // 페이지 새로고침
	        	    });
	        		
	        	}else{
	        		modal.showAlert('정보수정에 실패했습니다.');
	        	}
	            
	        },
	        error: function(e) {
	            modal.showAlert('잠시 후 다시 시도해주세요.');
	        }
	    });
	}
	
	
	/* 기사정보 관리 */
	// 'driver_manage' 버튼 클릭 시 모달창 띄우기
	$('#driver_manage').on('click', function() {
		// 모달 표시
	    document.querySelector('.driver_modal.modal_change').style.display = 'flex';
		
		// 기사정보 가져오기
		$('#license').val(license);                 // 면허번호
        $('#license_period').val(license_period); // 면허유효기간
        $('#certificate').val(certificate);       // 자격증번호
	    	
	});

	// 기사정보 관리 모달창 닫기	
	function hideDriverModal() {
    	document.querySelector('.driver_modal.modal_change').style.display = 'none';
	}

	
	// 기사정보 수정하기
	$('.full_btn_regist').on('click', function() {
	    // 변경할 값 저장
	    license = $('#license').val();               // 면허번호
        license_period = $('#license_period').val(); // 면허유효기간
        certificate = $('#certificate').val();       // 자격증번호
	    
     	// 입력값 검증
        if (!license || !license_period || !certificate) {
            modal.showAlert('모든 항목을 입력해주세요.'); // 경고창 표시
            return;
        }
        
	    // 확인 모달 띄우기
	    modal.showConfirm('정말로 수정하시겠습니까?', function () {
	    	driverUpsert(); 
	    });
	});
	
	
	// 기사정보 수정 함수
	function driverUpsert(){
		$.ajax({
			method: 'POST',
			url: 'driverUpsert.ajax',
			data: {
				'emp_idx': empIdx,
				'license': license,
				'license_period': license_period,
				'certificate': certificate
			},
			dataType: 'JSON',
			success: function(data){
				if(data.success == '성공'){
	        	    modal.showConfirm('기사정보가 등록되었습니다.', function () {
        	    		location.reload(); // 페이지 새로고침 
	        	    });
	        		
	        	}else{
	        		modal.showAlert('정보수정에 실패했습니다.');
	        	}
			},
			error: function(e){
				modal.showAlert('잠시 후 다시 시도해주세요.');
			}
		});
	}
	
	
	/* 파일 관련 기능 */
    // 파일 선택 이벤트에서 중복 파일 체크 및 업로드 제한
	$('#fileUpload').on('change', function () {
	    var selectedFiles = this.files; // 새로 선택된 파일 목록
	    var totalFiles = fileCnt + selectedFiles.length; // 총 파일 개수 계산
	
	    // 파일 개수 초과 여부 확인
	    if (totalFiles > 5) {
	        modal.showAlert("파일은 최대 5개까지 업로드 가능합니다.");
	        $(this).val(''); // 선택된 파일 초기화
	        return;
	    }
	
	    // 중복 파일 확인
	    for (var i = 0; i < selectedFiles.length; i++) {
	        if (uploadedFiles.includes(selectedFiles[i].name)) {
	            modal.showAlert(`이미 업로드된 파일입니다: ${selectedFiles[i].name}`);
	            $(this).val(''); // 선택된 파일 초기화
	            return;
	        }
	    }
	});
	
	
	// 파일삭제 함수
	function delFile(button) {
	    // 삭제할 파일 이름 설정
	    fileName = $(button).closest('tr').find('td').eq(0).text();
	
	    // Ajax 요청으로 파일 삭제 처리
	    $.ajax({
	        method: 'POST',
	        url: 'fileDel.ajax',
	        data: {
	            'idx_num': empIdx,    // 사번
	            'file_name': fileName // 파일 이름
	        },
	        dataType: 'JSON',
	        success: function(data) {
	            if (data.success === '성공') {
	                modal.showConfirm('파일 삭제에 성공했습니다.', function () {
	                    location.reload(); // 페이지 새로고침
	                });
	            } else {
	                modal.showAlert('파일 삭제에 실패했습니다.');
	            }
	        },
	        error: function(e) {
	            modal.showAlert('잠시 후 다시 시도해주세요.');
	        }
	    });
	}


	
	// 클릭 이벤트 등록
	$("#photoSection").on("click", function () {
	    // 직접 클릭 이벤트 발생시키기 (중복 호출 방지)
	    if (!$("#profileUpload").data("triggered")) {
	        $("#profileUpload").data("triggered", true); // 상태 플래그 설정
	        $("#profileUpload").click();
	    }
	});

	// 파일 선택 이벤트 처리
	$("#profileUpload").on("change", function () {
	    var file = this.files[0]; // 선택된 파일

	    if (file) {
	        // 확인 모달 띄우기
	        modal.showConfirm("정말 변경하시겠습니까?", function () {
	            var reader = new FileReader();

	            reader.onload = function (e) {
	                // 미리보기 이미지 설정
	                $("#photoSection img").attr("src", e.target.result);
	            };

	            reader.readAsDataURL(file); // 파일을 데이터 URL로 읽기

	            // 서버로 파일 전송
	            uploadProfilePhoto(file);

	            // 플래그 초기화
	            $("#profileUpload").data("triggered", false);
	        });
	    }
	});

	
	// 클릭 이벤트 등록
	$("#photoSection").on("click", function () {
	    // 직접 클릭 이벤트 발생시키기 (중복 호출 방지)
	    if (!$("#profileUpload").data("triggered")) {
	        $("#profileUpload").data("triggered", true); // 상태 플래그 설정
	        $("#profileUpload").click();
	    }
	});

	// 파일 선택 이벤트 처리
	$("#profileUpload").on("change", function () {
	    var file = this.files[0]; // 선택된 파일

	    if (file) {
	        // 확인 모달 띄우기
	        modal.showConfirm("정말 변경하시겠습니까?", function () {
	            var reader = new FileReader();

	            reader.onload = function (e) {
	                // 미리보기 이미지 설정
	                $("#photoSection img").attr("src", e.target.result);
	            };

	            reader.readAsDataURL(file); // 파일을 데이터 URL로 읽기

	            // 서버로 파일 전송
	            uploadProfilePhoto(file);

	            // 플래그 초기화
	            $("#profileUpload").data("triggered", false);
	        });
	    }
	});

	// 프로필 사진 업로드 함수
	function uploadProfilePhoto(file) {
	    if (!file) {
	        modal.showAlert("파일이 선택되지 않았습니다.");
	        return;
	    }

	    var formData = new FormData();
	    formData.append("emp_idx", "${detail.emp_idx}");
	    formData.append("photoFile", file);

	    $.ajax({
	        url: "profilePhotoUpload.do",
	        type: "POST",
	        data: formData,
	        contentType: false,
	        processData: false,
	        success: function (response) {
	            if (response.success === "성공") {
	                modal.showAlert("프로필 사진이 성공적으로 변경되었습니다.");
	            } else {
	                modal.showAlert("사진 변경에 실패했습니다. 다시 시도해주세요.");
	            }
	        },
	        error: function () {
	            modal.showAlert("오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
	        },
	    });
	}


	
	
	
	// 인사변경내역 정보 가져오기
	function infoHistoryCheck() {
	    $.ajax({
	        type: 'POST',
	        url: 'infoHistoryCheck.ajax',
	        data: {
	            "emp_idx": empIdx,
	        },
	        dataType: 'json',
	        success: function(response) {
	            $('.addTbody').empty();
	            if (response.msg === '성공') {
	                let fixedList = Array.from({ length: 7 }, (_, i) => response.list[i] || {
	                    category: '*',
	                    before_update: '*',
	                    after_update: '*',
	                    date: '*',
	                    name: '*',
	                    emp_manage_idx: null
	                });

	                fixedList.forEach(function(item) {
	                    let categoryDisplay = "";
	                    switch (item.category) {
	                        case "depart_idx": categoryDisplay = "부서"; break;
	                        case "rank_idx": categoryDisplay = "직급"; break;
	                        case "salary": categoryDisplay = "연봉"; break;
	                        case "account_number": categoryDisplay = "계좌번호"; break;
	                        case "phone": categoryDisplay = "전화번호"; break;
	                        case "mobile": categoryDisplay = "핸드폰번호"; break;
	                        case "end_date": categoryDisplay = "퇴사일"; break;
	                        case "address": categoryDisplay = "주소"; break;
	                        case "ip": categoryDisplay = "IP주소"; break;
	                        default: categoryDisplay = "*";
	                    }
	                    
	                    const row = 
	                        '<tr class="infoTbody-tr">' +
	                            '<td>' + categoryDisplay + '</td>' +
	                            '<td>' + (item.before_update || '*')+ '</td>' +
	                            '<td>' + (item.after_update || '*')+ '</td>' +
	                            '<td>' + (item.date || '*')+ '</td>' +
	                            '<td>' + (empIdx ===  item.emp_manage_idx ? '본인' : (item.name || '*')) + '</td>' +
	                        '</tr>';
	                    $('.addTbody').append(row);
	                });
	            } else {
	                for (let i = 0; i < 7; i++) {
	                    const row =
	                        '<tr>' +
	                        '<td>*</td>' +
	                        '<td>*</td>' +
	                        '<td>*</td>' +
	                        '<td>*</td>' +
	                        '<td>*</td>' +
	                        '</tr>';
	                    $('.addTbody').append(row);
	                }
	            }
	        },
	        error: function() {
	            alert('에러');
	        }
	    });
	}
	
	
	
	// 인사변경 내역 필터링
	$('.infoTitle').on('change', function () {
	    const selectedCategory = $(this).val(); 
	    console.log("Selected Category:", selectedCategory);
	    $('.addTbody .empty-row').remove();
	    $('.addTbody tr').hide();
	    let filteredRows = [];
	    if (selectedCategory === '전체') {
	        filteredRows = $('.addTbody tr').toArray();
	    } else {
	        $('.addTbody tr').each(function () {
	            const categoryText = $(this).find('td:first').text();
	            if (categoryText === selectedCategory) {
	                filteredRows.push(this);
	            }
	        });
	    }
	    const totalRows = filteredRows.length;

	    if (totalRows < 7) {
	        for (let i = totalRows; i < 7; i++) {
	            const emptyRow = 
	                '<tr class="empty-row">'+
	                    '<td>*</td>'+
	                    '<td>*</td>'+
	                    '<td>*</td>'+
	                    '<td>*</td>'+
	                    '<td>*</td>'+
	                '</tr>';
	            $('.addTbody').append(emptyRow);
	        }
	    }
	    $(filteredRows).show();
	});

</script>

</html>
