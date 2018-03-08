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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/Ext3/css/ext-all.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
   
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
 <title>员工列表</title>
 <style type="text/css">
.advice ul{ border-bottom:2px solid #02abee; width:860px; height:28px;}
.advice ul li{ width:85px; padding-right:10px; float:left; height:28px; line-height:30px; text-align:center; font-size:14px; font-weight:bold;}
.advice ul li.first { padding-left:0px;}
.advice ul li a{ color:#333; display:block; width:85px; height:28px; background:url(<%=path%>/images/order_bg01.png);}
.advice ul li a:hover,.headline ul li.first a{ color:#FFF; background:url(<%=path%>/images/order_bg.png);}
																				 
 </style>
 <script type="text/javascript">
 
function checkAndSave(){
if(!isCheck('name',10,'用户名',0,2)){
  return false;
}  
 if(!isCheck('nickname',20,'昵称',0,3)){
  return false;
}  
if(!isCheck('opopCode',20,'员工工号',0,4)){
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

function addCus(){
window.location.href="${pageContext.request.contextPath}/pg/member/addCustomer.jsp";
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

function showlztest(){
	if($("#showlz").is(":checked")){
		$(".lizhi").show();
	}
	else{
		$(".lizhi").hide();;
	}
}
function AddMessageRule(){
	$('#messagetab').append($("#addtr").clone().show().removeClass());

}
//新增前删除和新增后删除。
function DeleteMessageRule(){
	var checkbox  = document.getElementsByName("checkbox");	
	if(chooseOneAtLeast()){
		/*$.ajax({
		 type: "POST",
		 url: 'DeleteMessageSetting', 
		 data: $('#myform').serialize(), 
		 success: function(){
   				 alert('删除成功');
   				 }
		
		});*/
		$('#myform').attr('action','DeleteMessageSetting');
		$('#myform').submit();
	}
}
//保存新增的消息设置
function SaveMessageRule(){
	$('#myform').attr('action','AddMessageSetting');
	$('#myform').submit();
}
var flag=false;
function chooseOneAtLeast(){
		var obj = document.myform.elements;//form必须要有name
		var k=0;
		for(var i=0;i<obj.length;i++){
			if (obj[i].name == "checkbox"){
				if(obj[i].checked == true){
					k+=1;
				}		
			}
		}
		if(k==0){
			alert("请至少选择一条记录");
			return false;
		}else{
			var temp="";
			for(var i=0;i<obj.length;i++){
				if (obj[i].name == "checkbox"){
					if(obj[i].checked == true){
						temp=obj[i].value + "," + temp;
					}		
				}
			}
			var temp1=temp;
			if(flag){
				temp1="";
				var s2=temp.split(',');
				//去除重复
				var count=0;
				var del=new Array();
				for(var a=0;a<s2.length;a++){
					count=0;
					for(var b=0;b<s2.length;b++){
						if(s2[a]==s2[b]){
							count++;
						}
					}
					if(count==3){
						del.push(s2[a]);
					}
				}

				var s1=new Array();
				var f=true;
				for(var i=0;i<s2.length;i++){
					f=true;
					for(var j=0;j<s1.length;j++){
						if(s2[i]==s1[j]){
							f=false;
						}
					}
					for(var z=0;z<del.length;z++){
						if(s2[i]==del[z]){
							f=false;
						}
					}
					if(f){
						s1.push(s2[i]);	
					}
				}
				for(var k=0;k<s1.length;k++){
					if(temp1==""){
						temp1=temp1+s1[k];
					}else{
						temp1=temp1+","+s1[k];
					}
				}
			}			
		
			return true;
		}
	}



function showMessage(id,opname){

	$('#smsperson').val(opname);
	$.post("MessageSetting",{opid:id},
	function(){
	 		$('#messagetab').hide();
		}
	);
}
$(function(){
	var pagevalue = $('input[name="pagevalue"]').val();
	if(pagevalue == '0'){
		$('.center_table').show();
		$('.all_orders ul li').eq(0).addClass('first');
	}else{
		$('.advice').show();
		$('.all_orders ul li').eq(1).addClass('first');
	}

})

</script>	
</head>
<style>
.lizhi{
background:grey;
display:none;
}
a{color:#333333;text-decoration:none;}
.pageNav { text-align:right; height:26px; padding:3px 0px;color: #000000;}
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
    <div class="right" style="height: 860px;">
    <form action="" id="myform"  name="myform" method="post">
      <div class="home">
        <h3><a href="#">我的代运</a> > 我的信息 > <span>员工管理</span></h3>
      </div>
       <div class="all_orders">
          <ul>
            <li ><a href="${pageContext.request.contextPath }/queryUsersByCocode">员工管理</a></li>
            <li><a href="${pageContext.request.contextPath }/MessageSetting">消息设置</a></li>
          </ul>
          </div>
    <input id="pagevalue" name="pagevalue" type="hidden" value="${pagevalue}"/>  
  <div class="center_table" style="display: none;">
	<table width="860" border="0">
  <tr style=" background:#edf8fd;">
    <td>姓名</td>
    <td>员工帐号</td>
    <td>员工密码</td>
    <td>性别</td>
    <td>联系电话</td>
    <td>创建时间</td>
    <td>类型</td>
    <td>操作</td>
  </tr>
  <TBODY id="info">
       <s:iterator var="bean" value="#request.objWebUserList" >   
                     <!-- 离职员工 -->
						<s:if test='"DS".equals(#bean.ososcode)'>
						<TR class="lizhi" >
						<TD width=100 class="tab6"><s:property value="#bean.opopname" /></TD>			
						<TD width=80 class="tab6"><s:property value="#bean.opopcode" /></TD>
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
						<TD><a style="color:grey" href="<%=path%>/modifyCustomer?OpId=<s:property value="#bean.opopid" />">修改</a>
						<a style="color:grey" href="<%=path%>/modifyCustomerStatues?sOpid=<s:property value="#bean.opopid" />&statues=DS">离职</a>
						<s:if test='"PS".equals(#bean.ososcode)'>
						<a style="color:grey"  href="<%=path%>/modifyCustomerStatues?sOpid=<s:property value="#bean.opopid" />&statues=RS">转正</a> 		 
						</s:if>
						</TD>
						</TR>
						
						</s:if>
						<s:else>     
                        <TR >   
						<TD width=100 class="tab6"><a href="${pageContext.request.contextPath }/MessageSetting?opid=<s:property value="#bean.opOpid" />&opname=<s:property value="#bean.opopname" /> "><font color="#02ABEE"><s:property value="#bean.opopname" /></font></a></TD>			
						<TD width=80 class="tab6"><s:property value="#bean.opopcode" /></TD>
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
						<TD><a style="color:grey" href="<%=path%>/modifyCustomer?OpId=<s:property value="#bean.opopid" />">修改</a>
						<a style="color:grey" href="<%=path%>/modifyCustomerStatues?sOpid=<s:property value="#bean.opopid" />&statues=DS">离职</a>
						<s:if test='"PS".equals(#bean.ososcode)'>
						<a style="color:grey"  href="<%=path%>/modifyCustomerStatues?sOpid=<s:property value="#bean.opopid" />&statues=RS">转正</a> 		 
						</s:if>
						</TD>
						</TR>
			</s:else>  
						</s:iterator>
						</TBODY>
						</table> 
						<br/>
				<input name="showlz" id="showlz"  onchange="showlztest()" type="checkbox" value="" />显示离职员工 		<button class="pro_button" onclick="addCus();">添加新用户</button>
				  <div  class="pageNav" id= "pageNav0" > 
           		   	<p:pager url="queryUsersByCocode" />
           		   	</div> 
            </div>
            
            
     <div class="advice" style="width: 860px; border: 1px solid #bfe8f8;margin-top: 25px;display: none;" >
      		<input type="hidden" name="opopname" id="" value="${opopname}"/>
      		<input type="hidden" name="opid" id="opid" value="${opid}"/>
     	<div >
     	 	  <div id="message" class="center_table">
     		<table	id="messagetab"  width="860" border="0" style="">
     			<tr style="background:#edf8fd;">
     				<td width="43">序号</td>
				    <td width="106">消息接收人</td>
				    <td width="150">消息类型</td>
				    <td width="150">通知种类</td>
				    <td width="150">时间类型</td>
				    <td width="127">开始时间</td>
				    <td width="127">结束时间</td>
				 </tr>
     			<tbody>
     			
     				
     				
     				<s:iterator var="bean" value="#request.smslist" status="index">
     				<!--<s:set var="#index.index" value="varIndex"></s:set><s:property value="#index.index+1"/>-->
     				<tr >
     				<td><input name="checkbox" type="checkbox" value="<s:property value="#bean.smsrcomp_idSnkcode"/>"/></td>
     				<td><input disabled="disabled" name="stropname" id="stropname" value="<s:property value="#bean.srOpename"/>" style="width:100px;height:24px;"/></td>
					<td> 
		               <select  name="mnkcode" style="width:100px;height:24px;">
		               
                      
                          <option value="" >---请选择---</option>
                          <s:iterator var="bean1" value="@com.daiyun.dax.SmsnoticetimeKindDemand@getMessagenoticekind()">
                            <s:if test="(#bean1.mnkMnkcode).equals(#bean.mnkMnkcode)">
                              <option  value="<s:property value='#bean1.mnkMnkcode'/>" selected="selected">
                              <s:property value="#bean1.mnkMnkname"/>
                              </option>
                            </s:if>
                            <s:else>
                              <option  value="<s:property value='#bean1.mnkMnkcode'/>">
                              <s:property value="#bean1.mnkMnkname"/>
                              </option>
                            </s:else>
                          </s:iterator>
                   
                    </select>	 
	                </td>
	                
				    <td>
				    	<select name="snkcode" style="width:100px;height:24px;">
                        
                          <option value="" >---请选择---</option>
                          <s:iterator var="bean1" value="@com.daiyun.dax.SmsnoticetimeKindDemand@getSmsnoticekind()">
                            <s:if test="(#bean1.snkSnkcode).equals(#bean.Smsrcomp_idsnkcode)">
                              <option  value="<s:property value='#bean1.snkSnkcode'/>" selected="selected">
                              <s:property value="#bean1.snkSnkname"/>
                              </option>
                            </s:if>
                            <s:else>
                              <option  value="<s:property value='#bean1.snkSnkcode'/>">
                              <s:property value="#bean1.snkSnkname"/>
                              </option>
                            </s:else>
                          </s:iterator>
                       
                    </select>	 
				    </td>
				    
				    
				    <td>
				    <select name="snott" style="width:100px;height:24px;">
                          <option value="" >---请选择---</option>
                          <s:iterator var="bean1" value="@com.daiyun.dax.SmsnoticetimeKindDemand@getSmsnoticetimetype()">
                            <s:if test="(#bean1.Snttsnttcode).equals(#bean.Snttsnttcode)">
                              <option  value="<s:property value='#bean1.snttSnttcode'/>" selected="selected">
                              <s:property value="#bean1.snttSnttname"/>
                              </option>
                            </s:if>
                            <s:else>
                              <option  value="<s:property value='#bean1.snttSnttcode'/>">
                              <s:property value="#bean1.snttSnttname"/>
                              </option>
                            </s:else>
                          </s:iterator>
                    
                    </select>	
				   
					</td>
				    <td>
				    <input name="addstartdate" type="text" value="<s:property value="#bean.Snttsnttstarttime"/>" src="${pageContext.request.contextPath}/images/time.png" style="width:127px;height:22px;" 
               	 			class="Wdate"	id="startdate" onfocus="WdatePicker({startDate:'00:00:00',dateFmt:'HH:mm:ss',alwaysUseStartDate:true})"/>
          			</td>
				    <td> 
				    <input name="addenddate" type="text" value="<s:property value="#bean.Snttsnttendtime"/>" src="${pageContext.request.contextPath}/images/time.png" style=" width:127px;height:22px;" 
             			  	class="Wdate" id="enddate"  onfocus="WdatePicker({startDate:'00:00:00',dateFmt:'HH:mm:ss',alwaysUseStartDate:true})"	/>
                	</td>
     				</tr>
     				</s:iterator>
     		
     		<tr id="addtr"  style="display: none;">
     				<td><input name="checkbox" type="checkbox" value=""/></td>
     				<td><input disabled="disabled" name="" id="" value="${opopname}" style="width:100px;height:24px;"/></td>
					<td>    
						<select  name="mnkcode" style="width:100px;height:24px;">
                          <option value="" selected="selected" >---请选择---</option>
                          <s:iterator var="bean" value="@com.daiyun.dax.SmsnoticetimeKindDemand@getMessagenoticekind()">
                            <option value="<s:property value='#bean.mnkMnkcode'/>">
                            <s:property value="#bean.mnkMnkname"/>
                            </option>
                          </s:iterator>
                   	 </select>	 
                    </td>
				    <td>
				    <select  name="snkcode" style="width:100px;height:24px;">
                          <option value="" selected="selected" >---请选择---</option>
                          <s:iterator var="bean" value="@com.daiyun.dax.SmsnoticetimeKindDemand@getSmsnoticekind()">
                            <option value="<s:property value='#bean.snkSnkcode'/>">
                            <s:property value="#bean.snkSnkname"/>
                            </option>
                          </s:iterator>
                       
                    </select>
				    </td>
				    <td><select name="snott" style="width:100px;height:24px;">
        
                          <option value="" selected="selected" >---请选择---</option>
                          <s:iterator var="bean" value="@com.daiyun.dax.SmsnoticetimeKindDemand@getSmsnoticetimetype()">
                            <option value="<s:property value='#bean.snttSnttcode'/>">
                            <s:property value="#bean.snttSnttname"/>
                            </option>
                          </s:iterator>
                         </select>
					</td>
				    <td>  <input name="addstartdate" type="text" value="" src="${pageContext.request.contextPath}/images/time.png" style="width:127px;height:22px;" 
               	 			class="Wdate"	id="startdate" onfocus="WdatePicker({startDate:'00:00:00',dateFmt:'HH:mm:ss',alwaysUseStartDate:true})"/>
          			</td>
				    <td> <input name="addenddate" type="text" value="" src="${pageContext.request.contextPath}/images/time.png" style=" width:127px;height:22px;" 
             			  	class="Wdate" id="enddate"  onfocus="WdatePicker({startDate:'0:00:00',dateFmt:'HH:mm:ss',alwaysUseStartDate:true})"	/>
                	</td>
				    </tr>
     		
     		
     		
     			</tbody>
     		
     		</table> 	
     		<!--   <button class="buttonbg"  style="margin-top:10px; margin-left: 100px;" type="button" onclick="GotoSerachPage();">作废</button>-->
         	 <button class="buttonbg" style="margin-top:10px; margin-left: 100px;"  type="button" onclick="AddMessageRule();">新增</button>
         	  <button class="buttonbg" style="margin-top:10px; margin-left: 100px;"  type="button" onclick="SaveMessageRule();">保存</button>
         	 <button class="buttonbg" style="margin-top:10px; margin-left: 100px;"  type="button" onclick="DeleteMessageRule();">删除</button>
     		<br/><br/>
     		<span>Tips:保存通知种类不能相同，一个公司最多3种<br/>
     		</span>
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

