<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>添加通途店铺</title>
		
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_total.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_page.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>

<script type="text/javascript">
$(function(){
				var authTempCode = $('#code').val();
				if(authTempCode != ''){
					showDialog();
					$.ajax({
						url: 'addStore?reAuth=${reAuth }',
						data: $('#myform').serialize(),
						type: 'post',
						success: function(data){
							hideDialog();
							alert(data.msg);
							if(data.status == 0){
								location.href = 'ERPImportUI';
							}
			}
		});
	}
});

function showDialog(){
       $('#bodyHide').show();
       //显示在屏幕中间



       $('#dialog').css('left', $(window).width() / 2 - $('#dialog').width() / 2);
       $('#dialog').css('top', $(window).height() / 2 - $('#dialog').height() / 2);
       $('#dialog').show();
   }

	function hideDialog(){
       $('#bodyHide').hide();
       $('#dialog').hide();
   }

function auth(){
	if(authCheck()){
		var isType=document.getElementById("apiwebType").value;
			if(isType=='ERP'){
			 document.getElementById('apiDiv').style.display = "";
			 document.getElementById('addButton').style.display = "none";
			}else{
			document.myform.action = 'getAuthorizationUrl';
			document.myform.submit();
			}
	}
}
function authCheck(){
	if($.trim($('#storeName').val()) == ''){
		alert("请输入店铺名称!");
		return false;
	}
	return true;
}
function queryApi(){
var isQuery =document.getElementById('queryDiv');
if (isQuery.style.display==""){
	isQuery.style.display="none";
         }else {
      	isQuery.style.display="";
         }
}
function addTT(){
		document.myform.action = 'saveTTStore';
		document.myform.submit();
}
function apiCheck(){
	//if($.trim($('#apiId').val()) == ''){
	//	alert("请输入通途账号!");
	//	return false;
	//}
	if($.trim($('#apiKey').val()) == ''){
		alert("请输入通途token!");
		return false;
	}
	return true;
}
function cancel(){
	 document.getElementById('apiDiv').style.display = "none";
	 document.getElementById('addButton').style.display = "";
}
</script>
	</head>

<body>
<form action="" method="post" name="myform" id="myform">
	<input type="hidden" id="tempAuthCode" name="tempAuthCode" value="${sessionScope.tempAuthCode}" />
	<input type="hidden" id="code" name="code" value="${param.code}" />
	<input type="hidden" id="cawtId" name="cawtId" value="${cawtId}"/>
	<input type="hidden" name="apiwebType" id="apiwebType" value="${apiwebType}" />
	<input type="hidden" name="storeName" id="storeName" value="${storeName}" />
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="${pageContext.request.contextPath }/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath }/op/recharge.jsp" target="_blank">充值</a></span> | <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="${pageContext.request.contextPath}/images/logo.jpg" /></div>
        <div class="right"><img src="${pageContext.request.contextPath}/images/tel.jpg" /></div>
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
        <h3>我的代运  > 我的订单 > <span>通途店铺添加</span></h3>
      </div>
      	
      <div class="admin_rit_ads" style="margin-top:7px;border:1px solid #dedede; ">
	
				<div class="admin_ads_check">
				<div id="apiDiv" style="width:280px;margin: auto;padding-top: 5px;">
			<div>
			<h2 style="font-size:16px;">添加通途店铺</h2>
			</div>
			<div style="margin-top: 25px;">
			<!--<span >通途账号:</span><input name="apiId" id="apiId"  type="text"  style="width: 150px; margin-left: 0px; padding-top: 2px;"/>
			</div>
			<div style="margin-top: 2px;">
			<span >通途token:</span><input name="apiKey" id="apiKey" type="text"  style="width: 150px; margin-left: 0px; padding-top: 2px;"/>
			</div>-->
			<br/><font color=red>(请在通途系统里的api_key填入本系统之中的账号。)</font>
			<div style="margin-top: 15px;">
			</div>
			<div style="margin-top: 10px;">
			<input type="button" onclick="addTT()"  class="buttonbg" value="添加通途" />
			<input class="buttonbg" type="button" onclick="location.href='ERPImportUI';" value="返回" />
			
			</div>
			</div>
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
        <div class="right"><img src="${pageContext.request.contextPath}/images/tel2.jpg" /></div>
      </div>
    </div>
    <div class="bottom_nav"> <a href="#">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
</div>
</form>
			
</body>
</html>
