<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<canvas id="signatureCanvas" width="100" height="100" style="border:1px solid black;"></canvas>
	<button onclick="saveSignature()">서명 저장</button>
	<button onclick="clearCanvas()">다시 쓰기</button>
</body>
<script>
   var canvas = document.getElementById("signatureCanvas");
   var ctx = canvas.getContext("2d");

   let isSigning = false;

   canvas.addEventListener("mousedown", () => (isSigning = true));
   canvas.addEventListener("mousemove", (event) => {
       if (!isSigning) return;
       ctx.lineWidth = 2;
       ctx.lineCap = "round";
       ctx.strokeStyle = "black";

       ctx.lineTo(event.offsetX, event.offsetY);
       ctx.stroke();
       ctx.beginPath();
       ctx.moveTo(event.offsetX, event.offsetY);
   });
   canvas.addEventListener("mouseup", () => {
       isSigning = false;
       ctx.beginPath();
   });

   // 서명 저장
   function saveSignature() {
/* 	   const link = document.createElement("a");
	   link.download = "canvas_image.png"; // 저장될 파일 이름
	   link.href = canvas.toDataURL(); // Canvas 내용을 Base64로 변환
	   link.click(); // 다운로드 실행 */
	   
	   var base64Image = canvas.toDataURL(); // 캔버스의 내용을 Base64 이미지로 변환

	   $.ajax({
		    type: 'POST',
		    url: 'saveSignature.ajax',
		    data: {
		        sign: base64Image // 서버로 보낼 데이터
		    },
		    dataType: 'json', // 서버에서 반환할 데이터 타입
		    success: function(data) {
		    	 if (data.status === "success") {
		                alert(data.message);
		            } else {
		                alert(data.message);
		            }
		    },
		    error: function(xhr, status, error) {
		        console.error(error); // 오류 처리
		    }
		});
	}
   
   // 캔버스 초기화
   function clearCanvas() {
       ctx.clearRect(0, 0, canvas.width, canvas.height); // 캔버스 내용 삭제
   }
</script>
</html>