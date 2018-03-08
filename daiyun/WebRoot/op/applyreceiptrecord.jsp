<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri = "/project" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>发票申请</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
     <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>

  </head>

<script type="text/javascript">
 	function refund(){
 		if(check()){
 		
 			document.getElementById("form1").action="${pageContext.request.contextPath}/applyreceiptrecord?arscode=1";
  			document.getElementById("form1").submit();
 		}
 	}
 	
 	function submit2(){
 			document.getElementById("form1").action="${pageContext.request.contextPath}/applyreceiptrecord?arscode=2";
  			document.getElementById("form1").submit();
 	}
 	function change(){
 		 var scCode=document.getElementById("nameSelect").value
 		 if(scCode==""){
				 document.getElementById("mailName").value="";
				 document.getElementById("mailAddress").value="";
				 document.getElementById("mailTelephone").value="";
				 return false;
			}
 		 $.ajax({
      		type: "post",       
            dataType: "text",
            url:"mailQuery",    
            data:{"scCode":scCode},   
            success: doCheckSuccess });
			}
			function doCheckSuccess(data){  	  
				 var message=data.split("-");
  				 document.getElementById("mailName").value=message[2];
				 document.getElementById("mailAddress").value=message[0];
				 document.getElementById("mailTelephone").value=message[1];
    		} 
 	
	function mail(){
 		 var invoiceType=document.getElementById("invoiceType").value
 		 if(invoiceType==1){
 		 	 document.getElementById("mail1").style.display='none';
 		 	 document.getElementById("mail2").style.display='none';
 		 	 document.getElementById("mail3").style.display='none';
 		 	 document.getElementById("mail4").style.display='none';
 		 	 document.getElementById("mail5").style.display='none';
 		 }else{
 			 document.getElementById("mail1").style.display='';
 			 document.getElementById("mail2").style.display='';
 			 document.getElementById("mail3").style.display='';
 			 document.getElementById("mail4").style.display='';
 			 document.getElementById("mail5").style.display='';
 		 }
 	}
 	function check(){
			var bankName=document.getElementById("bankName").value;
			var bankAccount=document.getElementById("bankAccount").value;
		  	var companyName=document.getElementById("companyName").value;
			var payNumber=document.getElementById("payNumber").value;
			var invoiceType=document.getElementById("invoiceType").value;
			 
			if(companyName==""){
				alert("请填写开户公司");
				return false;
			}
			if(payNumber==""){
				alert("请填写纳税识别号");
				return false;
			} 
			if(bankName==""){
				alert("请填写开户银行");
				return false;
			}
			if(bankAccount==""){
				alert("请填写开户账号");
				return false;
			}
			if(invoiceType==""){
				alert("请选择领取发票类型");
				return false;
			}
			return true;
		}
</script>
<body>
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
 <form id="form1" name="form1" action="" method="post"  >
   <div class="forwarding">
	  <jsp:include page="../op/tree.jsp" />

    <div class="right">
    	<div class="home">
        <h3><a href="#">我的代运</a> >我的账户> <span>发票申请</span></h3>
        </div>
       <div class="recharge">
        <div class="r_title">发票申请</div>
        <div class="nir">
  <table width="500" border="0" class="moneyback">
   <tr>
    <td style="width:87px;">申请客户：</td>
    <td><%=session.getAttribute("Opcode")%></td>
  </tr>
   <tr>
    <td style=" width:87px;">开户公司：</td>
 	 <td> <input name="companyName"  id="companyName"  type="text"  style="width:300px;" /></td>
  </tr>
  <tr>
    <td style="width:87px;">纳税识别号：</td>
    <td> <input name="payNumber" id="payNumber" type="text"   style="width:300px;" /></td>
  </tr>
   <tr>
    <td style=" width:87px;">开户行：</td>
 	 <td> <input name="bankName"  id="bankName"  type="text"  style="width:300px;" /></td>
  </tr>
  <tr>
    <td style=" width:87px;">银行账号：</td>
 	 <td> <input name="bankAccount"  id="bankAccount"  type="text"  style="width:300px;" /></td>
  </tr>
  <tr>
    <td style="width:87px;">发票领取方式：</td>
    <td><select name="invoiceType" id="invoiceType" style="width:150px;height:27px" onchange="mail()">
                  <option value="1"   selected="selected">------自取------ </option>
                  <option value="2"  >------邮寄------ </option>
                </select></td>
  </tr>
  <tr id="mail1" style="display:none">
    <td style=" width:100px;">可选邮寄联系人：</td>
    <td>
 	   <select name="nameSelect" id="nameSelect" style="width:300px; height:27px"; onchange="change()">
                  	<option value="" selected="selected">------请选择邮寄联系人------</option>
					<s:iterator var="info" value="@com.daiyun.dax.MailDemand@query()">					
					<option value="<s:property value='#info.scSccode'/>"><s:property value="#info.scScname"/></option>
					</s:iterator>
	   </select>
	</td>
  </tr>
  <tr id="mail2"style="display:none">
    <td style=" width:87px;">邮寄联系人：</td>
 	 <td> <input name="mailName"  id="mailName"  type="text"  style="width:300px;height:26x" /></td>
  </tr>
  <tr id="mail3"style="display:none">
    <td style=" width:87px;">邮寄地址：</td>
 	 <td><input name="mailAddress"  id="mailAddress"   style="width:300px;height:26x"  /></td>
  </tr>
  <tr id="mail4" style="display:none">
    <td style=" width:87px;">邮寄电话：</td>
 	 <td> <input name="mailTelephone"  id="mailTelephone"  type="text"  style="width:300px;" /></td>
  </tr>
     <tr id="mail5" style="display:none">
      <td colspan="2" style="padding-left:100px"  > <input name="checkBox"  id="checkBox"  type="checkbox" value="change" />&nbsp;是否同步邮寄人信息</td>
  </tr>
     <tr>
    <td style="width:65px;">备         注：</td>
    <td> <textarea name="applyRemark" id="applyRemark"  cols="" rows="5" style="width:300px; border:1px solid #adaeae; padding-left:2px;"></textarea></td>
  </tr>
</table>
	<button class="pro_button" type="button" onclick="refund();" >新建保存</button>
	<button class="pro_button" type="button" onclick="submit2();" >确认提交</button>
        </div>
      </div>
    </div>
  </div>
     </form>
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
</body>
</html>
