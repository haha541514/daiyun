<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <script type="text/javascript" src="js/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/style/Forwarding_total.css"/>
    <link rel="stylesheet" type="text/css" href="<%=path%>/style/Forwarding_page.css"/>      
    <title>添加新用户</title>
    <SCRIPT type="text/javascript">
</SCRIPT>
</head>

<body>
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="${pageContext.request.contextPath}/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath}/op/recharge.jsp" target="_blank">充值</a>| <span><a href="#">English</a></span></span>
      </div>
      </div>
      <div class="logo">
        <div class="left"><img src="images/logo.jpg" /></div>
        <div class="right"><img src="images/tel.jpg" /></div>
      </div>
      <div class="nav">
         <jsp:include page="../include/main_menu.jsp"></jsp:include>
        <div class="nav_last"></div>
      </div>
    </div>
  </div>
  </div>
  <div class="forwarding">
    <jsp:include page="../../op/tree.jsp"></jsp:include>	
    <div class="right">
      <div class="home">
        <h3><a href="#">我的代运</a> > 我的信息 > <span>公司资料</span></h3>
      </div>
      <div class="profile">
      <form action="saveCompany" method="post">
        <div class="password">
       <s:set var="bean" value="#request.objCorporationdColumns"/>
          <ul class="number_change">       
            <li><span>公司代码：</span>
            <input type="hidden" name="objSimplecustomerColumns.cmco_code" value="<s:property value='#bean.cococode'/>">
            <s:if test="#bean.cocolabelcode!=null">
              <input  value="<s:property value='#bean.cocolabelcode'/>" readonly="readonly" type="text" style="width:350px;background-color: #f1f1f1;" />
             </s:if>
             <s:else><input name="objSimplecustomerColumns.coco_sname" value="<s:property value='#bean.cocolabelcode'/>"  type="text" style="width:350px;" />
             </s:else>
              </li>
            <li><span>简称：</span>
              <input name="objSimplecustomerColumns.coco_sname"value="<s:property value='#bean.cocosname'/>"  type="text" style="width:350px;" />
              </li>
               <li><span>名称：</span>
              <input name="objSimplecustomerColumns.coco_name" value="<s:property value='#bean.coconame'/>" type="text" style="width:350px;" />
              </li>
            <li><span>公司地址：</span>
              <input name="objSimplecustomerColumns.coco_address" value="<s:property value='#bean.cocoaddress'/>" type="text" style="width:350px;" />
              </li>
              <li class="note"><span>备注：</span>
              <textarea name="objSimplecustomerColumns.coco_remark" style="font:12px '宋体';color:#555; " cols=""   rows=""><s:property value='#bean.cocoremark'/></textarea>
              </li>
          </ul>
          <button class="pro_button" type="submit" onclick="GotoSerachPage();" style="margin-left:155px;">保存</button>
        </div>
       </form>
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
</body>
</html>
