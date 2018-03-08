
<%@ page language="java" import="java.util.*"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%  
    String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
    
	String total_fee = new String(request.getParameter("total_fee").getBytes("ISO-8859-1"),"UTF-8");

	String body = new String(request.getParameter("body").getBytes("ISO-8859-1"),"UTF-8");
	
	//支付宝交易号
	String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
	//交易状态

	String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");
 %>	 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.form.js"></script>

<title>支付宝充值结果</title>
<link href="../css/master.css" type="text/css" rel="stylesheet" />
<link href="../css/admin.css" type="text/css" rel="stylesheet" />
 <script type="text/javascript">
		window.onload = function(){
		    var opid="<%=body%>";
		 	var out_trade_no="<%=out_trade_no%>";	 
		    $.ajax({
      		type: "post",       
      		data:{"opid":opid,"out_trade_no":out_trade_no},   
      		dataType:"json",  
            url:"AlipayModify" });	 
		    }
		    function pay(){
		    	location.href="${pageContext.request.contextPath}/op/recharge.jsp";
		    }
	</script>
 </head>
<body>
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="#">退出</a></span> | <span><a href="#">充值</a></span> | <span><a href="#">English</a></span></div>
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
	    <jsp:include page="${pageContext.request.contextPath}/op/tree.jsp" />
     <div class="right">
      <div class="home">
        <h3><a href="#">我的代运</a> > 我的信息 > <span>账户充值</span></h3>
      </div>
      <div class="success">
        <div class="r_title">支付宝充值结果</div>
        <div class="nir">
        <h3>恭喜您，支付已成功！</h3>
        <table id="pay_success" width="818" border="0" style="font-weight:bold; font-size:14px;">
 			 <tr>
   				 <td width="50%" align="right">支付状态：</td>
   				 <td width="50%" style="color:#02abee;"><%=trade_status %>  </td>
  			</tr>
  			<tr>
  				  <td width="50%" align="right">交易金额：</td>
    				<td width="50%" style="color:#02abee;"><%=total_fee %>元</td>
 			 </tr>
  			<tr>
  				  <td width="50%" align="right">账号：</td>
   				 <td width="50%" style="color:#02abee;"><%=session.getAttribute("Opcode")%></td>
  			</tr>
  				<tr>
   					 <td width="50%" align="right">支付宝交易号：</td>
    				<td width="50%" style="color:#02abee;"><%=trade_no %> </td>
 			 </tr>
  			<tr>
  					  <td width="50%" align="right">代运网客户单号：</td>
   					 <td width="50%" style="color:#02abee;"><%=out_trade_no%></td>
  			</tr>
  				<tr>
   			 <td width="50%" align="right">备注：</td>
    			<td width="50%" style="color:#02abee;">支付宝充值成功</td>
  				</tr>
			</table>
			<div class="pay_button">
			<button class="pro_button" type="button" onclick="pay();">继续充值</button>
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

</body>
</html>
