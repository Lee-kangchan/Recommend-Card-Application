<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
<head>
<title>회원가입 화면</title>
</head>
<body>
	<!-- div 왼쪽, 오른쪽 바깥여백을 auto로 주면 중앙정렬된다.  -->
	<div id="wrap">
		<br>
		<br> <b><font size="6" color="gray">회원가입</font></b> <br>
		<br>
		<br>


		<!-- 입력한 값을 전송하기 위해 form 태그를 사용한다 -->
		<!-- 값(파라미터) 전송은 POST 방식, 전송할 페이지는 JoinPro.jsp -->
		<form id="sign">
			카드 종류:<input type="text" name="name" maxlength="50"> <br>
			카드 번호:<input type="text" name="number" maxlength="50"><br>

			유효기간: <input type="text" name="validity" maxlength="50"> <br>
			CVC: <input type="text" name="cvc" maxlength="8" placeholder="0000/00/00" size="16"><br>
			별칭:	 <input type="text" name="nickname" /><br>
			<br> 
			<input type="button" onclick="ajax()" value="등록" /> 
			<input type="button" value="취소" onclick="goLoginForm()">
		</form>
		
	</div>
</body>
<script src="http://code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script>
<!--  <script src="http://code.jquery.com/jquery.serializeObject.js" type="text/javascript"></script> -->
<script type="text/javascript">
	jQuery.fn.serializeObject = function() {
	    var obj = null;
	    try {
	        if(this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) {
	            var arr = this.serializeArray();
	            if(arr){ obj = {};
	                jQuery.each(arr, function() {
	                    obj[this.name] = this.value; });
	            }
	        }
	    }catch(e) {
	        alert(e.message);
	    }finally {}
	    return obj;
	}

	function ajax(){
		var formData = $("#sign").serializeObject();
		 console.log(JSON.stringify(formData));
		$.ajax({
			url:"/app/card",
			type:"POST",
			contentType:"application/json",
			data:JSON.stringify(formData),
			success:function(data){
				location.href = "/home";
			},error:function(xhr,status,error){
				
			}
		})
	}
	function goLoginForm() {
		location.href = "/app/home";
	}
</script>

</html>

