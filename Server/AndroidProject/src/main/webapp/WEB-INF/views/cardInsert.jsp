<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<html>
<head>
<title>ȸ������ ȭ��</title>
</head>
<body>
	<!-- div ����, ������ �ٱ������� auto�� �ָ� �߾����ĵȴ�.  -->
	<div id="wrap">
		<br>
		<br> <b><font size="6" color="gray">ȸ������</font></b> <br>
		<br>
		<br>


		<!-- �Է��� ���� �����ϱ� ���� form �±׸� ����Ѵ� -->
		<!-- ��(�Ķ����) ������ POST ���, ������ �������� JoinPro.jsp -->
		<form id="sign">
			ī�� ����:<input type="text" name="name" maxlength="50"> <br>
			ī�� ��ȣ:<input type="text" name="number" maxlength="50"><br>

			��ȿ�Ⱓ: <input type="text" name="validity" maxlength="50"> <br>
			CVC: <input type="text" name="cvc" maxlength="8" placeholder="0000/00/00" size="16"><br>
			��Ī:	 <input type="text" name="nickname" /><br>
			<br> 
			<input type="button" onclick="ajax()" value="���" /> 
			<input type="button" value="���" onclick="goLoginForm()">
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

