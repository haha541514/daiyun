<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>添加商店</title>
		
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_total.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_page.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>

<script type="text/javascript">
$(function(){
	apiwebChange();
	// 速卖通授权回调

	var authTempCode = $('#tempAuthCode').val();
	if(authTempCode != ''){
		addStore();
	}
});

function addStore(){
	showDialog('dialog');
	$.ajax({
		url: 'addStore?reAuth=${reAuth }',//添加快递

		data: $('#myform'),
		type: 'post',
		success: function(data){
			hideDialog('dialog');
			alert(data.msg);
			if(data.status == 0){
				location.href = 'aliexpressImportUI';
			}
		}
	});
}

function showDialog(id){
       $('#bodyHide').show();
       //显示在屏幕中间



       $('#' + id).css('left', $(window).width() / 2 - $('#dialog').width() / 2);
       $('#' + id).css('top', $(window).height() / 2 - $('#dialog').height() / 2);
       $('#' + id).show();
   }

	function hideDialog(id){
       $('#bodyHide').hide();
       $('#' + id).hide();
   }

function auth(){
	if(authCheck()){
		var isType=document.getElementById("apiwebType").value;
			if(isType=='ERP'){
			 document.getElementById('apiDiv').style.display = "";
			 document.getElementById('addButton').style.display = "none";
			}else if(isType=='TT'){
			document.myform.action = 'addTongtool';
			document.myform.submit();
			}else if(isType=='HL'){
			$.ajax({
				url: 'getAuthorizationUrlHL',
				data: $('#myform').serialize(),
				type: 'post',
				success: function(msg){
					if(msg == 0){
						alert("店铺名保存成功");
					}else{
						alert("店铺名相同");
					}
				}
			});
			
			}else{
			if(isType == 'EBY'){
				showDialog('ebayTip');
				document.myform.target = "_blank";
			} else {
				document.myform.target = "_self";
			}
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
	if($('#apiwebType').val() == 'ALE'){
		if($.trim($('input[name="clientID"]').val()) == ''){
			alert("请输入key!");
			return false;
		}
		if($.trim($('input[name="appSecret"]').val()) == ''){
			alert("请输入签名串!");
			return false;
		}
		
	}
	
	if($('#apiwebType').val() == 'EBY'){
		if($.trim($('input[name="passwordHL"]').val()) == ''){
			alert("请输入密码!");
			return false;
		}
		
	}
	return true;
}

function apiwebChange(){
	cancel();
	if($('#apiwebType').val() == 'ALE'){
		$('#aliexpressDiv').show();
	} else {
		$('#aliexpressDiv').hide();
	}
	if($('#apiwebType').val() == 'HL' || $('#apiwebType').val() == 'EBY'){//如果是华磊

		$('#hualeiDiv').show();
	} else {
		$('#hualeiDiv').hide();
	}
}

function queryApi(){
var isQuery =document.getElementById('queryDiv');
if (isQuery.style.display==""){
	isQuery.style.display="none";
         }else {
      	isQuery.style.display="";
         }
}
function addERP(){
	if(authCheck()){
		var isType=document.getElementById("apiwebType").value;
			if(isType=='ERP'){
					document.myform.action = 'getERPStoreName';
					document.myform.submit();
			}else{
			alert("网店类型请选择马帮！");
			}
	}
}
function apiCheck(){
	if($.trim($('#apiId').val()) == ''){
		alert("请输入用户标识!");
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
        <h3>我的代运  > 我的订单 > <span>ERP接口订单</span></h3>
      </div>
      <div class="recycle">
      <div class="r_title">添加店铺</div>
      <div class="condition">
          <table width="818" border="0">
            <tr>
              <td width="30%">网店类型：

              
            <select id="apiwebType" name="apiwebType" onchange="apiwebChange();" style="width:163px;">
              	<s:iterator var="apiwebType" value="@kyle.leis.es.company.customer.dax.CustomerApiWebDemand@query()">
              		<s:if test="#apiwebType.capwtcapwtcode.equals(#request.apiwebType)">
              			<option value="<s:property value="#apiwebType.capwtcapwtcode" />" selected="selected"><s:property value="#apiwebType.capwtcapwtname" /></option>
              		</s:if>
              		<s:else>
              			<option value="<s:property value="#apiwebType.capwtcapwtcode" />"><s:property value="#apiwebType.capwtcapwtname" /></option>
              		</s:else>
              	</s:iterator>
			</select>
			
			
			</td>
              <td width="40%" align="center">店铺名称：

              </td>
              <td width="171x">
				   <input type="hidden" name="cawtId" value="${cawtId }"/>
                   <input type="text" id="storeName" name="storeName" value="${storeName }" style="width: 154px;"/>
			</td>
			
              <td width="30%">&nbsp;</td>
            </tr>
            
          </table>   
        </div>
        			<!-- 速卖通 -->
					<div id="aliexpressDiv" style="width:350px; height:200px; padding-top: 5px; display:none;">
						<div style="margin-top: 20px;">
						<span >密&nbsp;&nbsp;&nbsp;码:</span><input name="clientID" value="${clientID }" type="text" style="width: 250px; margin-left:5px; padding-top: 2px;"/>
						</div>
						<div style="margin-top: 5px;">
						<span >签名串:</span><input name="appSecret" value="${appSecret }" type="text" style="width: 250px; margin-left:5px; padding-top: 2px;"/>
						</div>
					</div>
					
					<!--华磊&易贝-->
					<div id="hualeiDiv" style="width:350px; height:200px; padding-top: 5px; display:none;">
						<div style="margin-top: 5px;">
						<span >密&nbsp;&nbsp;&nbsp;码:</span><input name="passwordHL" value="${passwordHL }" type="text" style="width: 250px; margin-left:5px; padding-top: 2px;"/>
						</div>
						<div style="margin-top: 5px;">
						<span ><p><%request.getSession().getAttribute("messageHLStore");%>
								<% //request.getSession().removeAttribute("messageHLStore");%>
									</p></span>
						</div>
					</div>
					
					
					
					<!-- 马帮 -->
					<div id="apiDiv" style="width:350px;height:200px;margin: auto;padding-top: 5px;display:none;">
					<div >
					<h2 style="font-size:16px;">添加马帮商铺</h2>
					</div>
					<div style="margin-top: 25px;">
					<br/><br/><font color=red>(请在马帮系统里的api_key填入本系统之中的账号。)</font>
					</div>
					<div style="margin-top: 10px;">
					<input type="button" onclick="addERP()" class="buttonbg" value="确定添加马帮" />
					<input type="button" onclick="cancel()" class="buttonbg" value="取消" />
					</div>
					
					</div >	
					
					
					
        <div class="button">
          <button id="addButton" class="buttonbg" value="" type="button" onclick="auth();">添加</button>
          <button  class="buttonbg" value="" onclick="location.href='ERPImportUI';" type="button">返回</button>
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
			

		<div id="bodyHide" 
        	style="display:none;position:absolute;left:0px;top:0px;width:100%;height:100%;filter:Alpha(Opacity=30);opacity:0.3;background-color:#000000;z-index:101;">
    	</div>
    	<div id="dialog" style="background-color: #ffffff;text-align:center;display:none;z-index:9999;border:#000000 0px solid;height: 100px; width:200px; position: absolute;">
			<img src="${pageContext.request.contextPath }/images/progress.gif" style="margin: auto; margin-top: 5px;"/>
			<p>正在${"0" eq reAuth ? '重新授权' : '添加店铺' }......</p>
    	</div>
    	<div id="ebayTip" style="background-color: #ffffff;text-align:left;display:none;z-index:9999;border:#000000 0px solid;height: 200px; width:300px; position: absolute;">
			<div id="title" style="height: 25px; width: 300px; text-align: left; background-color: gray; padding-top: 5px;">
				<font size="4" color="white">添加店铺</font>
			</div><br/><br/>
			<div style="width: 300px; text-align: center;">
				<input type="button" value="添加" onclick="hideDialog('ebayTip');addStore();"/>
				<input type="button" value="取消" onclick="hideDialog('ebayTip');"/><br/><br/>
				<h1>温馨提示:</h1>
				<font color="blue">添加店铺之前请先确认授权成功!</font>
			</div>
    	</div>
</body>
</html>
