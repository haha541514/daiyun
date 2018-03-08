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
    
    <title>退款申请</title>
    
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
 			document.getElementById("form1").action="${pageContext.request.contextPath}/refundApply?rscode=1&action=modify";
  			document.getElementById("form1").submit();
 		}
 	}
 	
 	function submit2(){
 		if(check()){
 			document.getElementById("form1").action="${pageContext.request.contextPath}/refundApply?rscode=2&action=modify";
  			document.getElementById("form1").submit();
 		}
 	}
 	function check(){
			var bankName=document.getElementById("bankName").value;
			var bankAccount=document.getElementById("bankAccount").value;
			var applyReason=document.getElementById("applyReason").value;
			var refundType=document.getElementById("refundType").value;
			 
			if(bankName==""){
				alert("请填写开户银行");
				return false;
			}
			if(bankAccount==""){
				alert("请填写开户账号");
				return false;
			}
			if(applyReason==""){
				alert("请填写退款原因");
				return false;
			}
			if(refundType==""){
				alert("请选择退款类型");
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
        <h3><a href="#">我的代运</a> >我的账户> <span>退款申请</span></h3>
        </div>
       <div class="recharge">
        <div class="r_title">退款申请</div>
        <div class="nir">
  <s:iterator var="bean" value="#request.RefundColumns" status="sts">
  <input name="rrcode"  id="rrcode"  type="hidden"  style="width:300px;" value="<s:property value="#bean.tfrrcode"/>"/>
  <table width="500" border="0" class="moneyback">
   <tr>
    <td style="width:65px;">退款客户：</td>
    <td><%=session.getAttribute("Opcode")%></td>
  </tr>
   <tr>
    <td style=" width:65px;">开户银行：</td>
 	 <td> <input value="<s:property value="#bean.tfRrbankname"/>" name="bankName"  id="bankName"  type="text"  style="width:300px;" /></td>
  </tr>
  <tr>
    <td style="width:65px;">银行账号：</td>
    <td> <input value="<s:property value="#bean.tfRrbankaccount"/>"  name="bankAccount" id="bankAccount" type="text"   style="width:300px;" /></td>
  </tr>
 <s:if test="#bean.tdRricode==2">
  <tr>
    <td style="width:65px;">退款类型：</td>
    <td><select name="refundType" id="refundType" style="width:170px;height:27px">
                  <option value="2" selected="selected">退款余额 </option>
                  <option value="1">退款押金 </option>
                </select></td>
  </tr>
  </s:if>
  <s:else>
  	 <tr>
    <td style="width:65px;">退款类型：</td>
    <td><select name="refundType" id="refundType" style="width:170px;height:27px">
                  <option value="2" >退款余额 </option>
                  <option value="1" selected="selected">退款押金 </option>
                </select></td>
  </tr>
  </s:else>
  <tr>
    <td style="width:65px;">退款原因：</td>
    <td> <textarea   name="applyReason" id="applyReason" cols="" rows="8" style="width:300px; border:1px solid #adaeae; padding-left:2px;"><s:property value="#bean.tfrrApplyreason"/></textarea></td>
  </tr>
   <tr>
    <td style="width:65px;">备         注：</td>
    <td> <textarea  name="applyRemark" id="applyRemark"  cols="" rows="5" style="width:300px; border:1px solid #adaeae; padding-left:2px;"><s:property value="#bean.tfRrapplyremark"/></textarea></td>
  </tr>
</table>
	<s:if test="#bean.tdRrscode==1">
	<button class="pro_button" type="button" onclick="refund();" >新建提交</button>
	<button class="pro_button" type="button" onclick="submit2();" >确认保存</button>
	</s:if>
</s:iterator>
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
