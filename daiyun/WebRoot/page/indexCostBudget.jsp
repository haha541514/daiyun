<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="kyle.leis.fs.authoritys.user.da.UserColumns" %>
<%@page import="kyle.common.util.jlang.DateFormatUtility"%>
<%@page import="kyle.common.util.jlang.StringUtility"%>
<%@page import="kyle.common.util.jlang.DateUtility"%>
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
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <script type="text/javascript" src="<%=path %>/js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path %>/js/banner.js"></script>
     <link rel="stylesheet" type="text/css" href="<%=path %>/style/news_total.css"/>
    <link rel="stylesheet" type="text/css" href="<%=path %>/style/news_page.css"/>
    <title>代运物流网站</title>
  </head>
 <body onload="changeTopmenu(3)">
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left"></div>
        <div class="right"><span><a href="#">登录</a></span> | <span><a href="#">注册</a></span> | <span><a href="#">充值</a></span> | <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="<%=path%>/images/logo.jpg" /></div>
        <div class="right"><img src="<%=path%>/images/tel.jpg" /></div>
      </div>
      <div class="nav">
        <jsp:include page="/pg/include/main_menu.jsp"></jsp:include>
        <div class="nav_last"></div>
      </div>
    </div>
    <div class="banner_bg">
      <div class="banner">
        <ul class="nav_img">
          <li><a href=""><img src="<%=path%>/images/banner.jpg" alt=""></a></li>
          <li><a href=""><img src="<%=path%>/images/banner.jpg" alt=""></a></li>
          <li><a href=""><img src="<%=path%>/images/banner.jpg" alt=""></a></li>
        </ul>
        <ul class="nav_banner">
          <li ><a title="" href=""></a></li>
          <li><a title="" href=""></a></li>
          <li><a title="" href=""></a></li>
        </ul>
      </div>
    </div>
  </div>
  <center>
       <div class="long_result">
        <table id="attributeval" class="manage_form" style="margin: 0px;" width="1000px" cellspacing="1" cellpadding="0" border="0">
          <thead>
            <tr style="background:#edf8fd;">
              <td width="100px">收货产品</td>
              <td width="100px">货物重量</td>
              <td width="100px">实重</td>
              <td width="100px">体积重</td>
              <td width="100px">体积重系数</td>
              <td width="100px">运费值</td>
              <td width="100px">杂费值</td>
              <td width="100px">附加费</td>
              <td width="100px">总额</td>
              <td width="100px">运费备注</td>
            </tr>
          </thead>
         	<tbody>
				<s:if test="#request.bud.equals('bud')">
					<s:if test="#request.objSaleTrialCalculateResult.size()==0">
						<tr>
							<td colspan="11"><font color="red">请准确填写试算条件信息</font></td>
						</tr>
					</s:if>
				</s:if>
				<s:else>					
					<tr>
						<td colspan="11"><font color="red">显示试算费用结果</font></td>
					</tr>
				</s:else>
				<s:iterator var="salebean" value="#request.objSaleTrialCalculateResult">
				<tr>
					<td><s:property value="#salebean.Pkcode"/></td>			
					<td><s:property value="#salebean.Chargeweight"/></td>
					<td><s:property value="#salebean.Grossweight"/></td>
					<td><s:property value="#salebean.Volumeweight"/></td>
					<td><s:property value="#salebean.Volumerate"/></td>
					<td><s:property value="#salebean.Freightvalue"/></td>
					<td><s:property value="#salebean.Incidentalvalue"/></td>
					<td><s:property value="#salebean.Surchargevalue"/></td>
					<td><s:property value="@java.lang.String@format('%.2f',@java.lang.Double@parseDouble(#salebean.Freightvalue)+@java.lang.Double@parseDouble(#salebean.Incidentalvalue)+@java.lang.Double@parseDouble(#salebean.Surchargevalue))"/></td>
					<td><s:property value="#salebean.FreightpriceRemark"/></td>
				</tr>				
				</s:iterator>				
				</tbody>
        </table>
      </div>
      </center>
  <div class="clear"></div>
  <div id="bottom">
    <div class="copyright">
      <div class="nir">
        <div class="left"> Copyright © 2012 深圳市代运物流网络有限公司<br />
          (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号 </div>
        <div class="right"><img src="<%=path%>/images/tel2.jpg" /></div>
      </div>
    </div>
    <div class="bottom_nav"> <a href="<%=path%>/daiyun.jsp">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
</div>
</body>
</html>
