<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
    <script type="text/javascript" src="<%=path%>/js/PCASClass.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/style/Forwarding_total.css"/>
    <link rel="stylesheet" type="text/css" href="<%=path%>/style/Forwarding_page.css"/>    
 <title>添加新用户</title>
 <script type="text/javascript">
function checkAndSave(){

if(!isCheck('opopCode',20,'登陆账号',0,4)){
  return false;
}  
if(!isCheck('name',10,'用户名',0,2)){
  return false;
}  

if(!isCheck('pwd',30,'密码',0,5)){
  return false;
}  
if(!isCheck('checkPwd',30,'确认密码',0,6)){
  return false;
}  
if(!isCheck('email',50,'邮箱',0,7)){
  return false;
}  
if(!isCheck('mobilePhone',20,'手机号码',1,8)){
  return false;
}   

	//检查密码和确认密码是否一致



	var pwd=document.getElementById("pwd");
	var checkPwd=document.getElementById("checkPwd");
		if(pwd.value!=checkPwd.value){
			document.getElementById("checkPwdmsg").innerHTML="*确认密码与密码不一致";
			checkPwd.focus();
			return false;
	}
	
			
	if(confirm("确认提交?")){				
		document.getElementById("userForm").action="saveUser";
 		document.getElementById("userForm").submit();
	}else{
		return false;
	}
}



  	//校验文本框



 function isCheck(id,length,name,flag,index){  
  	    var str = document.getElementById(id).value;
  	    var msg = id+"msg";
  	    
  	    //中文2个字节，英文一个字节



  	    var   len   =   0;   
 		 for(i=0;i<$.trim(str).length;i++)   
  		{   
	          if(str.charCodeAt(i)>256)   
	          {   
	                  len   +=   2;   
	          }   
	          else   
	          {   
	                  len++;   
	          }   
  		}   
	  	    if(len>length){//验证长度是否合法
	  	    	 $("#"+msg).text("*长度必须小于等于"+length).attr("style", "color:red");
	  	    	 return false;
	  	  	}else{
		  	  	if(flag==1){//是否是纯数字
		  	  		if(isNaN(str)){
		  	  			$("#"+msg).text("*非法格式 ").attr("style", "color:red");
		  	  			return false;
		  	  		}
	  	  		}
	  	  	
  	  	}	
  	  	
  	  if(len==0){
  	           $("#"+msg).text("*"+name+"不能为空 ").attr("style", "color:red");
  	           return false;
  	  		}
  	   $("#"+msg).text("");
  	   return true; 
 }

</script>	
</head>

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
    <div class="right">
      <div class="home">
        <h3><a href="#">我的代运</a> > 我的信息 > <span>添加新用户</span></h3>
         
      </div>
      <form action="" id="userForm" method="post">
      <div class="profile">
        <div class="password">
          <ul class="number_change">
          <s:set var="bean" value="#request.objWebUserColumns"></s:set>
          <li><span>登录帐号：</span>
              <input name="opopCode" id="opopCode" type="text" style="width:195px;" value="<s:property value="#bean.Opopcode"/>" /><label id="opopCodemsg" style="color:red"> *必填</label>
            </li>
            <li><span>用户名：</span>
             <input type="hidden" name="opid" value="<s:property value="#bean.opopid"/>"/>
              <input name="name" id="name" type="text" style="width:195px;"  value="<s:property value="#bean.Opopname"/>"  /><label style="color:red" id="namemsg"> *必填</label>
            </li>
             <!-- <li><span>昵称：</span>
              <input  name="nickname" id="nickname" type="text" style="width:195px;" value="<s:property value="#bean.Opopsname"/>" /><label id="nicknamemsg"></label>
            </li> --> 
            
            <li><span>登录密码：</span>
              <input name="pwd" id="pwd" type="password"  value="<s:property value="#bean.word"/>" style="width:195px;"  /><label id="pwdmsg" style="color:red"> *必填</label>
            </li>
            <li><span>确认密码：</span>
              <input name="checkPwd" id="checkPwd" value="<s:property value="#bean.word"/>" type="password" style="width:195px;" /><label id="checkPwdmsg" style="color:red"> *必填</label>
            </li>
            <li><span>性别：</span>
						<s:if test='"M".equals(#bean.Opopsex)'>
						<input id="gender_0" name="opsex" value="M" checked="checked" type="radio">
                        <label for="gender_0" style="padding-right:20px;">先生</label>
                         <input id="gender_1" name="opsex" value="F" type="radio">
                         <label for="gender_1">女士</label>
						</s:if>
						<s:else>
						<input id="gender_0" name="opsex" value="M"  type="radio">
                        <label for="gender_0" style="padding-right:20px;">先生</label>
                        <input id="gender_1" name="opsex" value="F" checked="checked" type="radio">
                        <label for="gender_1">女士</label>
					   </s:else>
             <!--   <input id="gender_0" name="opsex" value="M" checked="checked" type="radio">
              <label for="gender_0" style="padding-right:20px;">先生</label>
              <input id="gender_1" name="opsex" value="F" type="radio">
              <label for="gender_1">女士</label>-->
            </li>
            <li><span>邮箱：</span>
              <input name="email" id="email" value="<s:property value="#bean.Opopemail"/>" type="text" style="width:195px;" /><label id="emailmsg" style="color:red"> *必填</label>
            </li>
            <li><span>手机号码：</span>
              <input name="mobilePhone" id="mobilePhone" value="<s:property value="#bean.Opopmobile"/>" type="text" style="width:195px;" /><label id="mobilePhonemsg" style="color:red"> *必填</label>
            </li>
           <!--   <li><span>固定电话：</span>
              <input  name="phone" id="phone" value="<s:property value="#bean.Opoptelephone"/>"  type="text" style="width:52px;" />
              
              <input name="fixed-line" type="text" style="width:120px;" />
              <label id="phonemsg"></label>
            </li>-->
            <li><span>职能：</span>
              <select style="width:200px;" name="fcCode" id="fcCode">
             <!--  <s:if test='"G".equals(#bean.Fcfccode)'> 
									<input type="hidden"  name="fcCode" value="G" />
									<input readonly="readonly" class="input_text" value="全面" style="width: 390px; background-color:#CCCCCC" />
									</s:if>
									<s:elseif test='"GOP".equals(#bean.Fcfccode)'>
									<input type="hidden"  name="fcCode" value="GOP" />
										<input readonly="readonly" class="input_text" value="操作" style="width: 390px; background-color:#CCCCCC" />
									</s:elseif>
									<s:elseif test='"GOP-TD".equals(#bean.Fcfccode)'>
									<input type="hidden"  name="fcCode" value="GOP-TD" />
										<input readonly="readonly" class="input_text" value="提货" style="width: 390px; background-color:#CCCCCC" />
									</s:elseif>
									<s:elseif test='"GOP-RD".equals(#bean.Fcfccode)'>
									<input type="hidden"  name="fcCode" value="GOP-RD" />
										<input readonly="readonly" class="input_text" value="收货" style="width: 390px; background-color:#CCCCCC" />
									</s:elseif>
									<s:elseif test='"GOP-RC".equals(#bean.Fcfccode)'>
										<input type="hidden"  name="fcCode" value="GOP-RC" />
										<input readonly="readonly" class="input_text" value="制单" style="width: 390px; background-color:#CCCCCC" />
									</s:elseif>
									<s:elseif test='"GOP-DL".equals(#bean.Fcfccode)'>
										<input type="hidden"  name="fcCode" value="GOP-DL" />
										<input readonly="readonly" class="input_text" value="出货" style="width: 390px; background-color:#CCCCCC" />
									</s:elseif>
									<s:elseif test='"GCS".equals(#bean.Fcfccode)'>
										<input type="hidden"  name="fcCode" value="GCS" />
										<input readonly="readonly" class="input_text" value="客服" style="width: 390px; background-color:#CCCCCC" />
									</s:elseif>
									<s:elseif test='"GCS-CT".equals(#bean.Fcfccode)'>
									    <input type="hidden"  name="fcCode" value="GCS-CT" />
										<input readonly="readonly" class="input_text" value="客服-代理商" style="width: 390px; background-color:#CCCCCC" />
									</s:elseif>
									<s:elseif test='"GCS-SV".equals(#bean.Fcfccode)'>
										<input type="hidden"  name="fcCode" value="GCS-SV" />
										<input readonly="readonly" class="input_text" value="客服-服务商" style="width: 390px; background-color:#CCCCCC" />
									</s:elseif>
									<s:elseif test='"GFI".equals(#bean.Fcfccode)'>
										<input type="hidden"  name="fcCode" value="GFI" />
										<input readonly="readonly" class="input_text" value="财务" style="width: 390px; background-color:#CCCCCC" />
									</s:elseif>
									<s:elseif test='"GFI-DU".equals(#bean.Fcfccode)'>
										<input type="hidden"  name="fcCode" value="GFI-DU" />
										<input readonly="readonly" class="input_text" value="催款" style="width: 390px; background-color:#CCCCCC" />
									</s:elseif>
									<s:elseif test='"GFI-ST".equals(#bean.Fcfccode)'>
										<input type="hidden"  name="fcCode" value="GFI-ST" />
										<input readonly="readonly" class="input_text" value="结算" style="width: 390px; background-color:#CCCCCC" />
									</s:elseif>
									<s:else>
										<input type="hidden"  name="fcCode" value="GSS" />
										<input readonly="readonly" class="input_text" value="销售" style="width: 390px; background-color:#CCCCCC" />	
									</s:else>
									--> 
	
	
	<s:if test='"G".equals(#bean.Fcfccode)'>  														
    <option value="G" selected="selected">全面</option>
    </s:if>
    <s:else>
    <option value="G" >全面</option>
    </s:else>
    														
	<s:if test='"GOP".equals(#bean.Fcfccode)'>  														
    <option value="GOP" selected="selected">操作</option>
    </s:if>
    <s:else>
    <option value="GOP" >操作</option>
    </s:else>
    
    <s:if test='"GOP-TD".equals(#bean.Fcfccode)'>  														
    <option value="GOP-TD" selected="selected">提货</option>
    </s:if>
    <s:else>
    <option value="GOP-TD" >提货</option>
    </s:else>
    
    <s:if test='"GOP-RD".equals(#bean.Fcfccode)'>  														
    <option value="GOP-RD" selected="selected">收货</option>
    </s:if>
    <s:else>
    <option value="GOP-RD" >收货</option>
    </s:else>
    
    <s:if test='"GOP-RC".equals(#bean.Fcfccode)'>  														
    <option value="GOP-RC" selected="selected">制单</option>
    </s:if>
    <s:else>
    <option value="GOP-RC" >制单</option>
    </s:else>
    
    <s:if test='"GOP-DL".equals(#bean.Fcfccode)'>  														
    <option value="GOP-DL" selected="selected">出货</option>
    </s:if>
    <s:else>
    <option value="GOP-DL" >出货</option>
    </s:else>
    
    <s:if test='"GCS".equals(#bean.Fcfccode)'>  														
    <option value="GCS" selected="selected">客服</option>
    </s:if>
    <s:else>
    <option value="GCS" >客服</option>
    </s:else>
    
    <s:if test='"GCS-CT".equals(#bean.Fcfccode)'>  														
    <option value="GCS-CT" selected="selected">客服-代理商</option>
    </s:if>
    <s:else>
    <option value="GCS-CT" >客服-代理商</option>
    </s:else>
    
    <s:if test='"GCS-SV".equals(#bean.Fcfccode)'>  														
    <option value="GCS-SV" selected="selected">客服-服务商</option>
    </s:if>
    <s:else>
    <option value="GCS-SV" >客服-服务商</option>
    </s:else>
    
    <s:if test='"GFI".equals(#bean.Fcfccode)'>  														
    <option value="GFI" selected="selected">财务</option>
    </s:if>
    <s:else>
    <option value="GFI" >财务</option>
    </s:else>
    
    <s:if test='"GFI-DU".equals(#bean.Fcfccode)'>  														
    <option value="GFI-DU" selected="selected">催款</option>
    </s:if>
    <s:else>
    <option value="GFI-DU" >催款</option>
    </s:else>
    
     <s:if test='"GFI-ST".equals(#bean.Fcfccode)'>  														
    <option value="GFI-ST" selected="selected">结算</option>
    </s:if>
    <s:else>
    <option value="GFI-ST" >结算</option>
    </s:else>
    
     <s:if test='"GSS".equals(#bean.Fcfccode)'>  														
    <option value="GSS" selected="selected">销售</option>
    </s:if>
    <s:else>
    <option value="GSS" >销售</option>
    </s:else>
    <!--  
    	<option value="GOP-TD">提货</option>
    	<option value="GOP-RD">收货</option>
    	<option value="GOP-RC">制单</option>
    	<option value="GOP-DL">出货</option>
    	<option value="GCS">客服</option>
    	<option value="GCS-CT">客服-代理商</option>
    	<option value="GCS-SV">客服-服务商</option>
    	<option value="GFI">财务</option>
    	<option value="GFI-DU">催款</option>
    	<option value="GFI-ST">结算</option>
    	<option value="GSS">销售</option>  --> 
    </select>
    <label></label>
            </li>
            <li><span>职位：</span>
              <select style="width:200px;" name="psCode" id="psCode">
              <s:if test='"GM".equals(#bean.Pspscode)'>
			<option value="GM" selected="selected">总经理</option>
			<option value="DM">部门经理</option>
			<option value="DR">部门主管</option>
			<option value="CL">员工</option>
			</s:if>
			<s:elseif test='"DM".equals(#bean.Pspscode)'>
			<option value="GM" >总经理</option>
			<option value="DM" selected="selected">部门经理</option>
			<option value="DR">部门主管</option>
			<option value="CL">员工</option>
			</s:elseif>
			<s:elseif test='"DR".equals(#bean.Pspscode)'>
			<option value="GM">总经理</option>
			<option value="DM">部门经理</option>
			<option value="DR" selected="selected">部门主管</option>
			<option value="CL">员工</option>
			</s:elseif>
			<s:else>
			<option value="GM">总经理</option>
			<option value="DM">部门经理</option>
			<option value="DR">部门主管</option>
			<option value="CL" selected="selected">员工</option>
			</s:else>
    <!--  	<option value="GM">总经理</option>
    	<option value="DM">部门经理</option>
    	<option value="DR">部门主管</option>
    	<option value="CL">员工</option>-->
    </select>
    <label></label>
            </li>
            <li><span>部门：</span>
              <select style="width:200px;" name="dpCode" id="dpCode">
    	<!--  <option value="FI">财务</option>
    	<option value="OP">操作</option>
    	<option value="SA">销售</option>
    	<option value="CS">客服</option> -->
    	<s:if test='"FI".equals(#bean.Dpdpcode)'>
		<option value="FI" selected="selected">财务</option>
		<option value="OP">操作</option>
		<option value="SA">销售</option>
		<option value="CS">客服</option>
		</s:if>
		<s:elseif test='"OP".equals(#bean.Dpdpcode)'>
		<option value="FI" >财务</option>
		<option value="OP" selected="selected">操作</option>
		<option value="SA">销售</option>
		<option value="CS">客服</option>
		</s:elseif>
		<s:elseif test='"SA".equals(#bean.Dpdpcode)'>
		<option value="FI">财务</option>
		<option value="OP">操作</option>
		<option value="SA" selected="selected">销售</option>
		<option value="CS">客服</option>
		</s:elseif>
		<s:else>
		<option value="FI">财务</option>
		<option value="OP">操作</option>
		<option value="SA">销售</option>
		<option value="CS" selected="selected">客服</option>
		</s:else>
    </select>
    <label></label>
            </li>
          </ul>
          <div class="add_but">
          <button class="add_button" type="button" onclick="checkAndSave();"><s:if test="#bean==null">注册</s:if><s:else>保存</s:else></button><button class="add_button" type="reset">重置</button>
          </div>
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

