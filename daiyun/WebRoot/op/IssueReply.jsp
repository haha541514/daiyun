<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="kyle.common.util.jlang.DateFormatUtility"%>

<%@ taglib prefix="s" uri="/struts-tags" %>
<%@taglib uri = "/project" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>问题件回复</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript"  src="${pageContext.request.contextPath}/js/index.js"></script>
	<script language="javascript"  src="${pageContext.request.contextPath}/js/Menus.js"></script>
  </head>

		<script type="text/javascript">
	
		 function reply(){
		var isacontent=document.getElementById("isacontent").value;
		if(isacontent==""){
			alert("回复内容不能为空");
			return false;
		}
		  var isuid=document.getElementById("isuid").value;
	      document.customerReplay.action="customerReplay?isuid="+isuid;
	      document.customerReplay.submit();
	}
	function close1(){
		window.location.href="${pageContext.request.contextPath}/op/problem.jsp";
	}
	
	function uploadFiles(){
	   var fileName=document.getElementById("fileName").value;
        fileName= fileName.substring(fileName.lastIndexOf("\\")+1);       
	   if(fileName==""){
	      alert("请选择上传文件！");
	   }else{
	   var msg="";
	      $.ajax({
		 url : 'FileIsEx',
		 type : 'post',
		 data : {fileName :fileName,path:'/download'},
		 async: false,
		 cache : false,			
		 timeout : 60000,
		 success : function(message) {
			msg = message;							
		 }
	    });
	    if(msg=="yes"){
	       alert("该文件名已经存在,请修改好文件名后再上传！");
	    }else{
	      var isuid=document.getElementById("isuid").value;
	      document.customerReplay.action="customerReplay?isuid="+isuid;
	      document.customerReplay.submit();
	      }
	   }
	}
		 
 	
		</script>

  <body>
<form action="" method="post" name="customerReplay" id="customerReplay"   enctype="multipart/form-data">
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
        <h3> 我的代运 > 订单辅助 > 问题件管理 ><span> 问题件回复</span></h3>
      </div>
      <div class="reply">
        <div class="explain">
          <h3>问题说明</h3>
          <s:set var="bean"  value="#request.issueColumns"></s:set>  
          <input type="hidden" id="isuid" value="<s:property value='#bean.Isuisuid' />" name="isuid" />
          <table width="860" border="0">
            <tr>
              <td width="20%" style="background:#edf8fd;">问题类型</td>
              <td width="30%"><s:property value="#bean.Isutisutname" /></td>
              <td width="20%" style="background:#edf8fd;">问题内容</td>
              <td width="30%"><s:property value="#bean.Isuiscontent" /></td>
            </tr>
          </table>
        </div>
        <div class="all_reply">
          <h3>所有回复<span>(点击附件名可下载附件)  *如果下载页面为空白页面则表示该附件已被删除！*</span></h3>
          <table width="860" border="0" style="word-break:break-all; word-wrap:break-all;  table-layout:fixed;">
            <tbody>
            <tr style="background:#edf8fd;">
              <td width="214px" >客户回复</td>
              <td width="215px" >我司回复</td>
              <td width="209px" >附件名</td>
              <td width="79px"  >回复用户</td>
              <td width="139px"  >回复时间</td>
            </tr>    
            </tbody>   
             <tbody>
				   		<% int i=0; %>
				   		<s:iterator var="isacontent" value="#request.isacontentlist">				   		
				   		<%i++;if(i%2==0){ %>
						<tr class="manage_form_bk">
						<%}else{ %>
						<tr class="manage_form_bk2">
						<%} %> 
						  <s:if test="(\"CWR\").equals(#isacontent.Akakcode)"> 
						    <td><s:property value="#isacontent.Isaisacontent"/></td>
						    <td>&nbsp;</td>
						    <td>&nbsp;</td>
						    </s:if>
						    <s:elseif test="(\"BWR\").equals(#isacontent.Akakcode)||(\"FWR\").equals(#isacontent.Akakcode)">
						    <td>&nbsp;</td>
						    <td><s:property value="#isacontent.Isaisacontent"/></td>
				   			<td>&nbsp;</td>
				   			</s:elseif>
						    <s:elseif test="(\"AU\").equals(#isacontent.Akakcode)">
						    <td>&nbsp;</td>
						    <td>&nbsp;</td>
				   			<td><a href="${pageContext.request.contextPath}/downloadFile?path=download&fileName=<s:property value="#isacontent.Isaisacontent"/>"><s:property value="#isacontent.Isaisacontent"/></a></td>
				   			</s:elseif>
				   			<td><s:property value="#isacontent.Copopname"/></td>
				   			<td><s:property value="#isacontent.Isaisacreatedate"/></td>			   			
				   		</tr>						   		   				
				   		</s:iterator>
				   	</tbody>
          </table>
        </div>
        <div class="add_reply">
          <h3>增加回复</h3>
          <textarea   name="isacontent" id="isacontent" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}" style="color: rgb(153, 153, 153);" placeholder="请在此输入您需要回复的内容。"></textarea>
          <div class="reply_button">
            <input class="rebutton"  type="button" value="回复" onclick="reply();" />
          </div>
          <div class="adjunct"><font>附件上传1：</font>
            <input style="border:none;" name="uploadFile" id="fileName"   type="file" accept="image/*">
          </div>
          <div class="adjunct"><font>附件上传2：</font>
            <input style="border:none;" name="uploadFileTwo" id="fileNameTwo"   type="file" accept="image/*">
          </div>
          <div class="adjunct"><font>附件上传3：</font>
            <input style="border:none;" name="uploadFileThree" id="fileNameThree"   type="file" accept="image/*">
          </div>
          <div class="line_button">
            <input  class="buttonbg"   type="button" value="上传" onclick="uploadFiles();" />
            <input  class="buttonbg"   type="button" value="返回" onclick="close1();" />
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
