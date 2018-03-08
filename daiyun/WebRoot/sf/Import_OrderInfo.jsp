<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@taglib uri = "/project" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>订单导入详情</title>

		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_total.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_page.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>

<script type="text/javascript">


</script>
</head>
<body>
	<div id="main">
	
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="${pageContext.request.contextPath }/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath }/op/recharge.jsp" target="_blank">充值</a></span> | <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="${pageContext.request.contextPath }/images/logo.jpg" /></div>
        <div class="right"><img src="${pageContext.request.contextPath }/images/tel.jpg" /></div>
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
        <h3>我的代运 > 我的订单 > <span>ERP接口订单</span></h3>
      </div>
      
      
        <div class="balance">
        <s:if test="#request.apiWebNotOpen == 0">
				<font size="2" color="red">该类型的网店尚未开通，敬请期待!&nbsp;</font>
				您可以&nbsp;[<a href="aliexpressImportUI?startdate=${param.startdate}&enddate=${param.enddate }&pkCode=${param.pkCode }">
				<font color="blue">重新导入</font>
				</a>]。


		</s:if>
      
        
        
        
        <div class="r_title long_title">订单导入信息</div>
        <div class="nir">
          <h3>总共有<font>（<s:if test="#request.totalSize == 0 || #request.totalSize == null"> 0</s:if>
          <s:else><s:property value="#request.totalSize" /></s:else>
         	 ）</font>条数据，已成功导入订单<font>（

          <s:if test="#request.normalSize == 0 || #request.normalSize == null">0 </s:if> 
          <s:else> <s:property value="#request.normalSize" /> </s:else>
          	）</font>条，失败订单
          <font>（

           <s:if test="#request.errorSize == 0 || #request.errorSize == null">0 </s:if> 
          <s:else>  <s:property value="#request.errorSize" /> </s:else>    
         	 ）</font>条。</h3>
          
        </div>
      </div>
      	
      
      
      <div class="button">
          <button class="buttonbg" value="" type="submit" 
          onclick="location.href='ERPImportUI?startdate=${param.startdate}&enddate=${param.enddate }&pkCode=${param.pkCode }';">继续导入</button>
          <button class="buttonbg" value="" type="submit" 
          onclick="location.href='aliImportLog';">查询记录</button>
       </div>
       
       
       
    </div>
  </div>
  
  
  
  <div class="clear"></div>
  <div id="bottom">
    <div class="copyright">
      <div class="nir">
        <div class="left"> Copyright © 2012 深圳市代运物流网络有限公司<br />
          (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号 </div>
        <div class="right"><img src="${pageContext.request.contextPath }/images/tel2.jpg" /></div>
      </div>
    </div>
    <div class="bottom_nav"> <a href="#">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
</div>	
</body>
</html>
