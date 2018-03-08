<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
     <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap-3.3.7-dist/css/bootstrap.min.css">
	<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
 
 	<script type="text/javascript">
 		var progress=null;
 		window.onload = function(){	 
 		  // for (var i=0;i<300;i++){
 			//document.getElementById("pro1").style.width=i;
 			//}
  			progress=setInterval("add()",3000); 
  			}
  		function add(){
  			$.ajax({
      		type: "post", 
            url:"progressBar",
            success: function (data) { 
            
            document.getElementById("pro1").style.width=data; 
            if(data==250){
              	 document.getElementById("pro1").style.width=300;
            	 document.getElementById("p1").style.display="none";
            	 document.getElementById("p2").style.display="";
            	 clearInterval(progress);
            }
            }
             });	
  		}	
 	</script>
   </head>
   
  <body style="padding:20px,0,20px,0">
    <p id="p1">正在上传订单，请稍等</p>
    <p id="p2"style="display:none">上传完成,如有疑问可点击日志查看</p>
  <div class="progress">
    <div class="progress-bar" role="progressbar" id="pro1" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="">
        <span class="sr-only"></span>
    </div>
</div>
  </body>
</html>
