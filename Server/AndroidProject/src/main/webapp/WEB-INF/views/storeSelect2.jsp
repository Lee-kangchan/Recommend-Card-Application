<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<a href="/app/home">�ڷΰ���</a>
</body>
<script src="http://code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script>
<script type="text/javascript">
		$.ajax({
			url:this.location ,
			type:"POST",
			contentType:"application/json",
			success:function(data){
				for (i=0;i<data.length;i++){
					var t;
					if(data[i].store_CARD_PERSENT_SALE!=0) {t = data[i].store_CARD_PERSENT_SALE ;} else {t = data[i].store_CARD_CASH_SALE ;}
						document.write("<p>ī���̸�: "+ data[i].card_NAME+ "</p>");
						document.write("<p>ī�庰Ī: "+ data[i].card_NICKNAME+ "</p>");
						document.write("<p>ī������: "+ t + "</p>");
				}
			},error:function(xhr,status,error){
				
			}
		})
	function goLoginForm() {
		location.href = "/app/home"; 
	}
	function ajax(data){
		location.href = "/app/store/"+ data +"";
	}
</script>
</html>