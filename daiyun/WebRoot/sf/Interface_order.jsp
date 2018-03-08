<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@taglib uri = "/project" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>从接口导入订单</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/Ext3/css/ext-all.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
	
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_total.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_page.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>

<script type="text/javascript">

$(function(){
		apiwebChange();
});

function AutorDoImport(){
			var code="<%=session.getAttribute("capwtcode")%>";					
	if(code=="TT"){
		showDialog();
		document.myform.action = 'AddAutorTongTooldoImport';
		document.myform.submit();
	}else{ 
		alert("您未添加通途的店铺");
	}
}

function doImport(){
	if(importCheck()){
		var isType=document.getElementById("apiwebType").value;
		if(isType=='ERP'){
		showDialog();
		document.myform.action = 'doMabangImport';
		document.myform.submit();
		}else if(isType=='TT'){
		showDialog();
		document.myform.action = 'doTongToolImport';
		document.myform.submit();
		}else{
		showDialog();
		document.myform.action = 'doAliexpressImport';//HL华磊,ALE 速卖通,EBY易贝没有相应的导入代码


		document.myform.submit();
		}
	}
}

function importCheck(){
	if($('#store').val() == ''){
		alert('请选择店铺!');
		return false;
	}
	if($('#pkCode').val() == '') {
		alert("请选择物流渠道!");
		return false;
	}
	return true;
}

function showDialog(){
       $('#bodyHide').show();
       //显示在屏幕中
       $('#dialog').css('left', $(window).width() / 2 - $('#dialog').width() / 2);
       $('#dialog').css('top', $(window).height() / 2 - $('#dialog').height() / 2);
       $('#dialog').show();
   }

function hideDialog(){
       $('#bodyHide').hide();
       $('#dialog').hide();
}
function apiwebChange(){
	   $('#store').load('loadStores?r=' + new Date().getTime(),{apiwebType: $('#apiwebType').val()},function(){
		if($('#store').val() == ''){
			$('#noStore').show();
		} else {
				$('#noStore').hide();
		}
		});
}
function addStore(){
	location.href = "addStoreUI?apiwebType=" + $('#apiwebType').val();
}
function addStoreUI(){
	$('#myform').attr('action','addStoreUI');
	$('#myform').submit();
}
function aliImportLog(){
	$('#myform').attr('action','aliImportLog');
	$('#myform').submit();
}
</script>
	</head>

<body>
<form action="" method="post" id="myform" name="myform">
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
        <div class="nav_last">
        <a href="${pageContext.request.contextPath }/userinfo">
        <img src="${pageContext.request.contextPath }/images/my_nav.jpg"/></a>
        </div>
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
      <div class="condition">
          <table width="860" border="0">
            <tr>
              <td width="30%">网店类型：


               	<select id="apiwebType" name="apiwebType" onchange="apiwebChange();" style="width:163px;height:24px">
                      	<s:iterator var="apiwebType" value="@kyle.leis.es.company.customer.dax.CustomerApiWebDemand@query()">
                      		<option value="<s:property value="#apiwebType.capwtcapwtcode" />"><s:property value="#apiwebType.capwtcapwtname" /></option>
                      	</s:iterator>
				</select>
               </td>
               
              <td width="32%" style="padding-left:15px">店铺名称：

 				<select id="store" name="store" style="width:167px;height:24px">
                    <option value="">----暂无店铺----</option>
				 </select>
				
				 
			</td>
              <td  id="noStore" width="30%" style="padding-left:6px;">没有店铺？
              <strong><a href="javascript:void(0);" onclick="addStore();" 
              style="color:#d42c96; margin-left:10px;" >马上添加</a></strong>
              </td>
            
            </tr>
           
           
            <tr>
              <td width="30%">物流渠道：


      			 <select id="pkCode" name="pkCode" style="width:163px;height:24px">
                             	<option value="">------请选择物流渠道------</option>
                              <s:iterator var="bean" value="@com.daiyun.dax.ProductkindDemand@getAllProduct()">
                              	<s:if test="#bean.Pkcode == #request.pkCode">
                              		<option value="<s:property value='#bean.Pkcode'/>" selected="selected">
                              			<s:property value="#bean.Pkname"/>
                              		</option>
                              	</s:if>
                              	<s:else>
                              		<option value="<s:property value='#bean.Pkcode'/>">
                              			<s:property value="#bean.Pkname"/>
                              		</option>
                              	</s:else>
                              </s:iterator>
					</select>
              
              </td>
              <td width="22%" style="padding-left:15px;">开始时间：
              
                <input name="startdate" type="text" value="<s:property value='#request.startdate'/>" src="${pageContext.request.contextPath}/images/time.png" style="   width:163px;height:24px;" 
               	 class="Wdate"	id="startdate" onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>
				</td>
   				<td width="30p%" style="padding-left:5px;">结束时间：


                <input name="enddate" type="text" value="<s:property value='#request.enddate'/>" src="${pageContext.request.contextPath}/images/time.png" style=" width:163px;height:24px" 
               	class="Wdate" id="enddate"  onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"	/>
              
                </td>
            </tr>
          </table>
        </div>
        <div class="button">
          <button class="buttonbg" value="" type="submit" onclick= "doImport();">导入</button>
          <button class="buttonbg" value="" type="submit" onclick="addStoreUI();">添加店铺</button>
          <button class="buttonbg" value="" type="submit" onclick="aliImportLog();">查询记录</button>
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

		<div id="bodyHide" 
        	style="display:none;position:absolute;left:0px;top:0px;width:100%;height:100%;filter:Alpha(Opacity=30);opacity:0.3;background-color:#000000;z-index:101;">
    	</div>
    	<div id="dialog" style="text-align:center;display:none;z-index:9999;border:#000000 0px solid; width:500px; position: absolute;">
			<img src="${pageContext.request.contextPath }/images/progress.gif" style="margin: auto;"/>
    	</div>
</form>
	</body>
</html>
