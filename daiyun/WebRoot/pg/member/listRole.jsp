<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="<%=path%>/js/PCASClass.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/style/Forwarding_total.css"/>
    <link rel="stylesheet" type="text/css" href="<%=path%>/style/Forwarding_page.css"/>    
 <title>角色列表</title>
 <script type="text/javascript">
 
	function addLink(){
		document.getElementById("userForm").action = "${pageContext.request.contextPath }/queryRoleByCode";
		document.getElementById("userForm").submit();
	};
	

 </script>
</head>
<style>
.lizhi{
background:grey;
display:none;
}
a{color:#333333;text-decoration:none;}
.pageNav { text-align:right; margin-top:10px; height:26px; padding:3px 0px;color: #000000;}
.pageNav a { display:inline; border:1px solid #ccc; height:20px; line-height:20px; margin-left:5px; padding:2px 7px;}
.pageNav a:hover { border:1px solid #3a739d; text-decoration:none; color:#3a739d; background:#f6fbff;}
</style>

<body>
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
       <div class="left">亲，<span><%=session.getAttribute("Opname")%></span>  您好！欢迎登录我的代运！</div>
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
  <div class="forwarding">
     <jsp:include page="../../op/tree.jsp"></jsp:include>	
     <input type="hidden" value="LEWFDIS" id="iskCode" name="iskCode" />
    <div class="right">
      <div class="home">
      <h3><a href="#">我的代运</a> > 我的信息 > <span>角色管理</span></h3>
      </div>
 
      
      <form action="" id="userForm" name="userForm" method="post">
      <div class="profile">
        <div id="menuTree" class="menuTree"></div>  
         <div class="center_table">
                  	<table width="860" border="0">
  <tr style=" background:#edf8fd;">
    <td>姓名</td>
    <td>员工帐号</td>
    <td>员工密码</td>
    <td>性别</td>
    <td>联系电话</td>
    <td>创建时间</td>
    <td>类型</td>s
  </tr>
  <TBODY id="info">
       <s:iterator var="bean" value="#request.objWebUserList" >               				   
                        <TR >   								
						<TD name="opopcode" id="opopcode" width=80 class="tab6"  >
						 <a style="color:666666;TEXT-DECORATION: underline;font-weight:bold;"  href="${pageContext.request.contextPath }/queryRoleByCode?opopcode=<s:property  value='#bean.opopcode'/>">
						<s:property value="#bean.opopcode" />
						</a>
						</TD>
						<TD width=100 class="tab6"><s:property value="#bean.opopname" /></TD>
						<TD width=100 class="tab6"><s:property value="#bean.word" /></TD>
						<TD width=100 class="tab6"> 
						<s:if test='"M".equals(#bean.Opopsex)'>
                                                                   男
                        </s:if>
                        <s:elseif test='"F".equals(#bean.Opopsex)'>
                                                                       女</s:elseif></TD>
						<TD width=100 class="tab6"><s:property value="#bean.opoptelephone" /></TD>
						<TD width=240 class="tab6"><s:property value="#bean.opopcreatedate" /></TD>
						<TD ><s:if test='"RS".equals(#bean.ososcode)'>
						  正式
						</s:if>
						<s:if test='"PS".equals(#bean.ososcode)'>
						  试用
						</s:if>
						<s:if test='"DS".equals(#bean.ososcode)'>
						  离职
						</s:if>
						</TD>
						</TR>
						</s:iterator>
						</TBODY>
						</table> 
       <br/>
       <button class="pro_button" onclick="addLink();">添加新角色</button>
       <div class="pageNav" id= "pageNav0"> 
           		   	<p:pager url="queryRoleByOpCode" /></div> 
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
    <div class="bottom_nav"> <a href="javaScript:void(0);" onclick="buildTree();">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
</div>
        
        
</body>
</html>