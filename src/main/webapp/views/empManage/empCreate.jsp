<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="ko">
<head>
  <meta charset="utf-8"/>
  <script src="https://kit.fontawesome.com/0e9db4cdc9.js" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link href="resources/css/empManage/empCreate.css" rel="stylesheet"/>
  <style>

  </style>
</head>
<body class="bg-theme bg-theme1">
  <!-- IP 가져오기 -->
  <%
    String clientIp = request.getHeader("X-Forwarded-For"); // 프록시를 거친 경우
    if (clientIp == null || clientIp.isEmpty()) {
        clientIp = request.getHeader("X-Real-IP"); // 일부 프록시 서버에서 사용하는 헤더
    }
    if (clientIp == null || clientIp.isEmpty()) {
        clientIp = request.getRemoteAddr(); // 기본 IP
    }
    request.setAttribute("clientIp", clientIp); // JSP 변수 설정
	%>

  <c:set var="emp_idx" value="${param.emp_idx}"/>

  <jsp:include page="../main/header.jsp"></jsp:include>
  <jsp:include page="../modal/modal.jsp"></jsp:include>
  <div class="body">
    <div class="naviPath">
      <span class="lPurple">사원관리</span> <span class="cPurple">&gt; 사원등록</span>
    </div>

	<form action="empCreate.do" method="post" enctype="multipart/form-data">
	    <div class="btn_area">
	      <button class="registerBtn">등록 하기</button>
	    </div>
	
	    <div class="content">
	      <div class="top-section">
	      	<div class="photo-container">
			    <div class="photo">
			        <img id="profilePreview" src="#" alt="프로필 사진" style="display: none;" />
			        <span class="photo_add" id="photoText">
			            <i class="bi bi-plus-square"></i>
			            <p>프로필 사진을 등록하세요.</p>
			        </span>
			    </div>
			    <input type="file" id="profileUpload" name="photoFile" accept="image/*" style="display: none;" />
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
	              <td>
	              	<input type="text" class="input_field" name="name" value="" placeholder="이름을 입력하세요." />
	              </td>
	              <th>이메일</th>
	              <td>
	              	<input type="text" class="input_field" name="email" value="" placeholder="이메일을 입력하세요." />
	              </td>
	            </tr>
	            <tr>
	              <th>주민번호</th>
	              <td>
	              	<input type="text" class="input_field" name="resident_number" value="" placeholder="주민번호를 입력하세요." />
	              </td>
	              <th>계좌번호</th>
	              <td>
	              	<input type="text" class="input_field" name="account_number" value="" placeholder="계좌번호를 입력하세요." />
	              </td>
	            </tr>
	            <tr>
	              <th>성별</th>
	              <td class="gender">
	              	<label class="gender_label">
				      <input type="radio" name="gender" value="남" checked /> 남
				    </label>
				    <label class="gender_label">
				      <input type="radio" name="gender" value="여" /> 여
				    </label>
	              </td>
	              <th>전화번호</th>
	              <td>
	              	<input type="text" class="input_field" name="phone" value="" placeholder="전화번호를 입력하세요." />
	              </td>
	            </tr>
	            <tr>
	              <th>입사일</th>
	              <td>
	              	<input type="date" class="input_field" id="new" class="input_field" name="start_date">
	              </td>
	              <th>휴대폰번호</th>
	              <td>
	              	<input type="text" class="input_field" name="mobile" value="" placeholder="휴대폰번호를 입력하세요." />
	              </td>
	            </tr>
	            <tr>
	              <th>주소</th>
	              <td>
	              	<input type="text" class="input_field" name="address" value="" placeholder="주소를 입력하세요." />
	              </td>
	              <th>IP주소</th>
	              <td>
	              	<!-- <input type="text" class="input_field" name="ip" placeholder="IPv4주소를 입력하세요." /> -->
	              	<input type="text" class="input_field" name="ip" value="${clientIp}" placeholder="IPv4주소를 입력하세요." />
	              </td>
	            </tr>
	          </table>
	        </div>
	      </div>
	
	      <div class="bottom-section">
	        <div class="attachment-info">
			  <h2>첨부 파일</h2>
		      <table id="fileTable">
		          <tr>
		              <th>파일명</th>
		              <th>업로드 날짜</th>
		          </tr>
		          <!-- 5개의 빈 행 -->
		          <c:forEach begin="1" end="5">
		              <tr>
		                  <td></td>
		                  <td></td>
		              </tr>
		          </c:forEach>
		          <tr class="file-upload">
		              <td colspan="3">
		                  <input type="file" id="fileUpload" name="files" multiple />
		              </td>
		          </tr>
		      </table>
			</div>
			
		    <!-- 소속 및 직책 -->
		    <div class="personal-info">
		      <h2>소속 및 직책</h2>
		      <table>
		        <colgroup>
		          <col style="width: 30%">
		          <col style="width: 70%">
		        </colgroup>
		        <tr>
		          <th>부서</th>
		          <td id="depart">
		          	<input type="text" value="미발령" readonly/>
		          	<input type="hidden" name="depart_name" value="1"/>
		          </td>
		        </tr>
		        <tr>
		          <th>직급</th>
		          <td id="rank">
		          </td>
		        </tr>
		        <tr>
		          <th>연봉</th>
		          <td>
		          	<input type="text" class="input_field" name="salary" value="" placeholder="연봉을 입력하세요." />
		          </td>
		        </tr>
		      </table>
		    </div>
		
		    <!-- 계정 정보 -->
		    <div class="personal-info">
		      <h2>계정 정보</h2>
		      <table>
		        <colgroup>
		          <col style="width: 30%">
		          <col style="width: 70%">
		        </colgroup>
		        <tr>
		          <th>비밀번호</th>
		          <td>
		            <input type="password" class="input_field pwCheck1" value="" placeholder="비밀번호를 입력하세요."/>
		          </td>
		        </tr>
		        <tr>
		          <th>비밀번호 확인</th>
		          <td>
		            <input type="password" class="input_field pwCheck2" name="password" value="" placeholder="비밀번호를 입력하세요."/>
		          </td>
		        </tr>
		      </table>
		    </div>
	      </div>
	    </div>
    </form>
  </div>
</body>

<script>
	/* 전역변수 */
	var tableCol = '';           // 테이블&컬럼 명
	var table = 'rank_emp';      // 드롭다운 가져올 테이블
	var fileCnt = 0;             // 현재 첨부파일 개수
	
	// 직급 드롭다운 정보 가져오기
	dropDown();
	
	/* 드롭다운 정보 함수 */
	function dropDown(){
		$.ajax({
			method: 'POST',
			url: 'empDrop.ajax',
			data: {
				'table': table
			},
			dataType: 'JSON',
			success: function(list){
				// select 태그 동적 생성
	            var dropdown = $('<select id="new" class="input_field" name="rank_idx"></select>');
				
	            $.each(list, function (index, item) {
	                var value = item.rank_name;
	                var idx = item.rank_idx;
	                // 직급 기본값은 사원
	                if(idx == 8){
	                	dropdown.append('<option value="' + idx + '" selected>' + value + '</option>');	
	                }else{
	                	dropdown.append('<option value="' + idx + '">' + value + '</option>');
	                }
	            });
	            
	            // dropdown 삽입
            	$('#rank').html(dropdown); // 변경할 값 부분을 교체
				
			},
			error: function(e){
				modal.showAlert('잠시 후 다시 시도해주세요.');
			}
		});	    	
	}
	
	/* 프로필사진 추가 기능 */
	$(".photo").on("click", function () {
	    $("#profileUpload").click(); // 파일업로드 input 클릭
	});

	$("#profileUpload").on("change", function () {
	    var file = this.files[0]; // 선택된 파일

	    if (file) {
	        var reader = new FileReader();
	        
	        reader.onload = function (e) {
	            // 미리보기 이미지에 읽은 데이터 URL 설정
	            $("#profilePreview").attr("src", e.target.result).show();
	            $("#photoText").hide(); // 기존디자인 숨기기
	        };

	        reader.readAsDataURL(file); // 파일을 데이터 URL로 읽기
	    }
	});



	/* 파일 관련 기능 */
    // 파일 추가 함수
    function addFiles(files) {
        var today = new Date().toISOString().split("T")[0]; // 오늘 날짜
        var newFilesCnt = files.length;

        // 기존 파일 목록 초기화
        $("#fileTable tr").each(function (index) {
            if (index === 0 || index === 6) return; // 헤더와 파일 선택 행 제외
            var tds = $(this).find("td");
            tds.eq(0).text(""); // 파일명 삭제
            tds.eq(1).text(""); // 날짜 삭제
        });

        fileCount = 0;

        // 새로운 파일 추가
        $("#fileTable tr").each(function (index) {
            if (index === 0 || index === 6) return; // 헤더와 파일 선택 행 제외

            var tds = $(this).find("td");

            if (newFilesCnt > 0) {
                tds.eq(0).text(files[newFilesCnt - 1].name); // 파일명
                tds.eq(1).text(today); // 업로드 날짜
                newFilesCnt--;
                fileCnt++;
            }
        });
    }

    // 파일 선택 이벤트
    $("#fileUpload").on("change", function () {
        var files = this.files;
        var newFilesCnt = files.length;

        // 파일 개수 초과 여부 확인
        if (newFilesCnt > 5) {
        	modal.showAlert("파일은 최대 5개까지 업로드 가능합니다.");
            $(this).val(""); // 선택된 파일 초기화
            return;
        }

        // 파일 추가 (재업로드)
        addFiles(files);

        $(this).val(""); // 파일 입력 초기화
    });
    
    
    
    
    /* 모든 값이 입력되지 않았을 때 폼제출 방지. */
    $("form").on("submit", function (event) {
        // 기본 제출 동작 중지
        event.preventDefault();

        // 필드 값 가져오기
        var name = $("[name='name']").val().trim();
        var email = $("[name='email']").val().trim();
        var residentNumber = $("[name='resident_number']").val().trim();
        var accountNumber = $("[name='account_number']").val().trim();
        var phone = $("[name='phone']").val().trim();
        var mobile = $("[name='mobile']").val().trim();
        var address = $("[name='address']").val().trim();
		var ip = $("[name='ip']").val().trim();
        var startDate = $("[name='start_date']").val().trim();
        var depart = $("[name='depart_name']").val().trim();
        var salary = $("[name='salary']").val().trim();
        var rank = $("[name='rank_idx']").val().trim();
        var password = $(".pwCheck1").val().trim();
        var confirmPw = $(".pwCheck2").val().trim();
        
        // 필드 중 하나라도 비어 있으면 모달 표시
        // 필드 중 하나라도 비어 있으면 알림 모달 표시
        if (
            !name ||
            !email ||
            !residentNumber ||
            !accountNumber ||
            !phone ||
            !mobile ||
            !address ||
            !startDate ||
            !depart ||
            !salary ||
            !rank ||
            !password ||
            !confirmPw ||
            !ip
        ) {
            showAlertModal("모든 필드를 채워주세요.");
            return; // 제출 중단
        }
        
     // 비밀번호와 확인 비밀번호가 일치하지 않는 경우
        if (password !== confirmPw) {
            showAlertModal("2개의 비밀번호가 서로 일치하지 않습니다.");
            return; // 제출 중단
        }
        

        // 모든 필드가 채워졌으면 폼 제출
        this.submit();
    });
	
</script>

</html>
