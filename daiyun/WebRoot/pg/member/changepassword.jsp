<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
   <title>修改密码</title>
   
  <script type="text/javascript">
   function subCheck(){
    for(i=2;i<3;i++){
     if($("#p"+i).val()==""){
       $("#msg"+i).html("不能为空");
       $("#msg"+i).css("color","red");
       return false;
     }
   }
    for(i=2;i<3;i++){
    if($("#p"+i).val().length<6){
      $("#msg"+i).html("密码长度必须大于5");
      $("#msg"+i).css("color","red");
       return false;
         }
     }
    
 
    if(($("#p1").val()==$("#p2").val())){
      $("#msg2").html("新密码和旧密码不能相同");
      return false;
     }
   
   if(!($("#p2").val()==$("#p3").val())){
      $("#msg3").html("两次输入密码不一致");
      return false;
     }
    
   return true;
 }
 
 	//校验长度
  	function isLength(id,i){  	 
  
  	    var str = document.getElementById(id).value;     
		 if($.trim(str).length<6){
  	    	 $("#msg"+i).text("密码长度必须大于5").attr("style", "color:red");
    	       return false;
  	  	}else{
  	       $("#msg"+i).text("");
  	    }
  	}
 
 
 
   </script>
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
  <div class="forwarding">
    <jsp:include page="../../op/tree.jsp"></jsp:include>
    <div class="right">
      <div class="home">
        <h3><a href="#">我的代运</a> > 我的信息 > <span>修改密码</span></h3>
      </div>
      <form action="modifyPassword" id="modifyPasswordForm" method="post"  onsubmit="return subCheck();" >
      <div class="profile">
        <div class="password">
          <ul class="number_change">
          <!--  <li><span><font>*</font>旧密码：</span>
              <input id="p1" name="OldPassword" type="password" onblur="isLength('p1','1')" style="width:250px;" />
              <em id="msg1"></em></li> -->
            <li><span><font>*</font>新密码：</span>
              <input id="p2" name="NewPassword" type="password" onblur="isLength('p2','2')" style="width:250px;" />
              <em id="msg2">新密码，大于五个字符</em></li>
            <li><span><font>*</font>确认新密码：</span>
              <input id="p3" name="confirmPassword" type="password" onblur="isLength('p3','3')" style="width:250px;" />
              <em id="msg3">请确认新密码</em></li>
          </ul>
          <button class="pro_button" type="submit" onclick="" style="margin-left:155px;">确定修改</button>
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

