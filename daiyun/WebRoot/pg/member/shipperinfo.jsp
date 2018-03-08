<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="kyle.leis.fs.authoritys.user.da.UserColumns" %>
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
   <title>收发货地址</title>
   <script type="text/javascript">
   
   function edit(code){
     $("#sccode").val(code);
     document.queryShipperInfo.action="<%=path%>/loadShipperInfo";
     document.queryShipperInfo.submit();
     
   }
   
    function del(code){
     if(confirm("确认删除？")){
     $("#sccode").val(code);
     document.queryShipperInfo.action="<%=path%>/deleteShipperInfo";
     document.queryShipperInfo.submit();
     }
     
   }
    function save(code){
     if(confirm("确认保存?")){
     document.queryShipperInfo.action="<%=path%>/saveShipperInfo";
     document.queryShipperInfo.submit();
     }
     }
   </script>
</head>
<body>
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
       <div class="left">亲，<span><%=session.getAttribute("Opname")%></span>  您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="${pageContext.request.contextPath}/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath}/op/recharge.jsp" target="_blank">充值</a></span>
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
  <div class="forwarding">
   <jsp:include page="../../op/tree.jsp"></jsp:include>
    <div  class="right">
      <div class="home">
        <h3><a href="#">我的代运</a> > 我的信息 > <span>收发货地址</span></h3>
      </div>
      <form action="${pageContext.request.contextPath }/page/queryShipperInfo" method="post" name="queryShipperInfo">
        <input type="hidden" name="sccode" id="sccode">
        <input type="hidden" id="scsclabelode" name="shipperInfoColumns.scsclabelcode"  value="${scsclabelcode}"/>
        <input type="hidden" id="scsccode" name="shipperInfoColumns.scsccode"  value="${scsccode}" />
      <div class="profile">
        <div class="headline">
          <ul>
            <li class="first"><a href="#">收货地址</a></li>
            <li><a href="#">发货地址</a></li>
            <li><a href="#">提货地址</a></li>
          </ul>
        </div>
        <div class="address">
        <p>新增收货地址<span>带<font>*</font>为必填</span></p>
        <table style="font:12px '宋体';" width="490" border="0">
  <tr>
    <td colspan="2"><span><font>*</font>所在地：</span><select name="province" style="width:129px;">
                  <option value="">--请选择省份--</option>
                  <option value="ahs"> 安徽省 </option>
                  <option value="am"> 澳门特别行政去 </option>
                  <option value="bjs"> 北京市 </option>
                  <option value="cqs"> 重庆市 </option>
                  
                </select>
                <select name="city" style="width:129px;">
                  <option value="">--请选择城市--</option>
                </select>
                <select name="area" style="width:129px;">
                  <option value="">--请选择区--</option>
                </select></td>
  </tr>
  <tr>
    <td colspan="2"><span><font>*</font>详细地址：</span><input   value="${shipperInfoColumns. scscaddress2}" type="text" style="width:394px;" /></td>
    
  </tr>
  <tr>
    <td colspan="2"><span><font>*</font>公司名称：</span><input  value="${shipperInfoColumns.scsccompanyname}"  type="text" style="width:394px;" /></td>
  </tr>
  <tr>
    <td><span><font>*</font>姓名：</span><input   type="text" value="${shipperInfoColumns.scscname}"  style="width:150px;" /></td>
    <td><span><font>*</font>电话：</span><input type="text" value="${shipperInfoColumns.scsctelephone}" style="width:150px;" /></td>
  </tr>
  <tr>
     <td><span>手机：</span><input  type="text" value="${shipperInfoColumns.scsctelephone}"  style="width:150px;" /></td>
    <td><span>邮编：</span><input  type="text"  value="${shipperInfoColumns.scscpostcode}" style="width:150px;" /></td>
  </tr>
  <tr>
    <td colspan="2" style="padding-left:23px;"><span><input type="checkbox" style="margin-right:5px; margin-top:2px;"></span>设置为默认收货地址</td>
  </tr>
   <tr>
    <td colspan="2"><button class="pro_button" type="submit" onclick="save();">保存</button></td>
  </tr>
</table>
        </div>
      </div>
      </form>
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
