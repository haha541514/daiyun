<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>批量上传</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>

  </head>
 <script type="text/javascript">
 	   function getpath(){
	   var obj = document.getElementById("fileName");
	   if (obj){  
           if (window.navigator.userAgent.indexOf("MSIE")>=1){  
               obj.select();  
               return document.selection.createRange().text;  
           }else if(window.navigator.userAgent.indexOf("Firefox")>=1){  
           if (obj.files){  
              // return obj.files.item(0).getAsDataURL(); //火狐7.0以上不支持

              var objectURL = window.URL.createObjectURL(obj.files[0]);
              return objectURL;  
           }  
           return obj.value;  
       }  
       return obj.value;  
       }  
   	 }
 	
    /*	function template() {
		var str ='<p align="right"><a href = "javascript:divClose()">关闭</a></p><br/><br/>';
        str = str + '选择文件：<input type="file" name="templateFile" style="width: 400px;" id="templateName"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/><br/><input type="button" style="width: 30px" value="确定" onclick="templateExcel()"/>';
		$("#light").empty();
		$("#light").append(str);
		letDivCenter("#light");
		document.getElementById("light").style.display = "block";	
		} */
		function divClose() {
		document.getElementById("light").style.display = "none";
		}	
        function templateExcel() {
		var templateName = document.getElementById("templateName").value;
		if (templateName == "") {
			alert("请选择上传文件！");
			return false;
			 
		}
		
		var strFile = templateName.substring(templateName.length - 3,
				templateName.length);
		if (strFile != "xls") {
			alert("只能选择Excel格式的上传文件");
			return false;
		}
	 
		document.form1.action ="templateExcel";
		document.form1.submit();
	    }
       
        function upload(){
       
        var fileName = document.getElementById("fileName").value;
		if (fileName == "") {
			alert("请选择上传文件！");
			return false;
		}
		//var strFile = fileName.substring(fileName.length - 3, fileName.length);
		var strFile = fileName.substring(fileName.lastIndexOf(".")+1);
		if (strFile != "xls" && strFile != "xlsx") {
			alert("只能选择Excel格式的上传文件");
			return false;
		}
		var select=document.getElementById("templeName");
		var index=select.selectedIndex ;    
		var templeName =select.options[index].value;

		if(templeName==""){
			alert("请选择要上传文件的模板");
			return false;
		}
		//Ext.MessageBox.wait("上传中...", "请稍候");
		fileName = getpath();
		fileName = fileName.replace(/\\/g,"\\\\")
		document.getElementById("path").value=fileName
		
		
		$("#form1").ajaxSubmit();
		 window.open ("${pageContext.request.contextPath}/op/progressBar.jsp", "progressBar", "height=100px, width=300px, top=200px, left=700px, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no") 

 		/*
     $.ajax({  
          url: 'uploadExcel' ,  
          type: 'POST',  
          data:  $( '#form1').serialize(),  
          async: false,  
          cache: false,   
         
          processData: false,  
          success: function (returndata) {  alert(returndata+"456"); }
     });  */
      
	}
	 function letDivCenter(divName){   
        var top = ($(window).height() - $(divName).height())/2;   
        var left = ($(window).width() - $(divName).width())/2;   
        var scrollTop = $(document).scrollTop();   
        var scrollLeft = $(document).scrollLeft();   
        $(divName).css( { position : 'absolute', 'top' : top + scrollTop, left : left + scrollLeft } ).show();  
    }  
    function LogI(){
    	document.form1.action ="LogI"
    	document.form1.submit();
    }
       
 </script>
  <body>
  <form id="form1" name="form1" action="uploadExcel" method="post" enctype="multipart/form-data">
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
         <div class="right"><span><a href="${pageContext.request.contextPath}/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath}/op/recharge.jsp" target="_blank">充值</a></span> | <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="images/logo.jpg" /></div>
        <div class="right"><img src="images/tel.jpg" /></div>
      </div>
     <div class="nav">
  	<jsp:include page="../pg/include/main_menu.jsp"></jsp:include>
        <div class="nav_last"></div>
      </div>
    </div>
  </div>
 
   <div class="forwarding">
	  <jsp:include page="../op/tree.jsp" />
    <div class="right">
    	<div class="home">
        <h3>我的代运  > 我的订单 > <span>批量上传</span></h3>
        </div>
        <div class="batch">
        	<div class="download">
            <h3>模板下载<span>（请勿修改模板表头）</span></h3>
            <ul>
            <li><a href="${pageContext.request.contextPath}/download/daiyunsimple.xls"/>1、代运标准格式</a></li>
            <li><a href="${pageContext.request.contextPath}/download/PayPal.xls"/>2、Paypal格式</a></li>
            <div class="clear"></div>
            </ul>
            </div>
            <div class="upload">
            <h3>文件上传<span>（带“*”为必填写）</span></h3>
            <ul>
            <li class="type"><span>*</span>模板类型：<select name="templeName" id="templeName">
	<option value="">---请选择---</option>
	<option value="284" selected="selected">代运标准格式</option>
	<option value="1">Paypal格式</option>

</select></li>
<li><input type="checkbox" name="checkFalg" value="falg" style=" vertical-align:-3px;margin-right:5px;">允许出现重复订单号，上传时将自动合并</li>
<li><input type="checkbox"  name="allowrepeataddress" value="falg" style=" vertical-align:-3px;margin-right:5px;">自动合并重复地址的订单</li>

            </ul>
            <div class="custom">
          <!--  <p><span>没有找到您想要上传文件的模板？</span><a href="javascript:template()">我要自定义模板格式</a></p> --> 
            <font>请选择你要上传的文件：</font><input style="border:none;"  name="uploadFile"  id="fileName" type="file" accept="application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" />
            <input type="hidden" id="path" name="path"/>
            </div>
            <button class="up" type="button" onclick="upload();"></button>&nbsp&nbsp&nbsp&nbsp&nbsp
            <button onclick="LogI()" style="width:103px; height:27px; line-height:25px; font-size:14px; color:#FFF; font-weight:bold; text-align:center; background:url(${pageContext.request.contextPath}/images/profile_button.png); border:none;" type="button" >查看日志</button>
            </div>
        </div>
    </div>
  </div>
  
  <div class="clear"></div>
  <div id="bottom">
    <div class="copyright">
      <div class="nir">
        <div class="left"> Copyright © 2012 深圳市代运物流网络有限公司<br />
          (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号 </div>
        <div class="right"><img src="images/tel2.jpg" /></div>
      </div>
    </div>
    <div class="bottom_nav"> <a href="#">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
</div>
<div id="light" class="white_content"></div> 
</form>
</body>
</html>
