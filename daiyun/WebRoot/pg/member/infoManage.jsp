<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="kyle.leis.fs.authoritys.user.da.UserColumns" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
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
    <script type="text/javascript" src="<%=path%>/js/infomanage.js"  charset="utf-8"></script>
    <SCRIPT type="text/javascript">
    jQuery.fn.extend({
    uploadPreview: function (opts) {
        var _self = this,
            _this = $(this);
        opts = jQuery.extend({
            Img: "ImgPr1",
            Width: 100,
            Height: 100,
            ImgType: ["gif", "jpeg", "jpg", "bmp", "png"],
            Callback: function () {}
        }, opts || {});
        _self.getObjectURL = function (file) {
            var url = null;
            if (window.createObjectURL != undefined) {
                url = window.createObjectURL(file)
            } else if (window.URL != undefined) {
                url = window.URL.createObjectURL(file)
            } else if (window.webkitURL != undefined) {
                url = window.webkitURL.createObjectURL(file)
            }
            return url
        };
        _this.change(function () {
            if (this.value) {
                if (!RegExp("\.(" + opts.ImgType.join("|") + ")$", "i").test(this.value.toLowerCase())) {
                    alert("选择文件错误,图片类型必须是" + opts.ImgType.join("，") + "中的一种");
                    this.value = "";
                    return false
                }
                if ($.support.msie) {
                    try {
                        $("#" + opts.Img).attr('src', _self.getObjectURL(this.files[0]))
                    } catch (e) {
                        var src = "";
                        var obj = $("#" + opts.Img);
                        var div = obj.parent("td")[0];
                        _self.select();
                        if (top != self) {
                            window.parent.document.body.focus()
                        } else {
                            _self.blur()
                        }
                        src = document.selection.createRange().text;
                        document.selection.empty();
                        obj.hide();
                        obj.parent("td").css({
                            'filter': 'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)',
                            'width': opts.Width + 'px',
                            'height': opts.Height + 'px'
                        });
                        div.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = src
                    }
                } else {
                    $("#" + opts.Img).attr('src', _self.getObjectURL(this.files[0]))
                }
                opts.Callback()
            }
        })
    }
});
    
 $(function () {
$("#fileName1").uploadPreview({ Img: "ImgPr1", Width: 120, Height: 120 });
});
 $(function () {
$("#fileName2").uploadPreview({ Img: "ImgPr2", Width: 120, Height: 120 });
}); 

 $(function () {
$("#fileName3").uploadPreview({ Img: "ImgPr3", Width: 120, Height: 120 });
}); 
  function save(){
	        initSex();
			if(confirm("确认提交？")){
				document.getElementById("userForm").action="saveUserInfo";
				document.getElementById("userForm").submit();
			
		}
	}
function sendMsg(){
var number = $("#number_03").val();
if(number==""){
 $("#t3").html("手机号码不能为空!");
 return false;
}
	$("#obtain").html("验证码发送中");
	  $.ajax({
	     type:"post",
	     url: "util/sendMobileValidateCode",
	     contentType:"application/x-www-form-urlencoded;charset=utf-8",
	     data:{tel:$("#number_03").val()},
	     success:function(data){
	     $("#obtain").html(data);   
	     setTimeout("$('#obtain').html('没收到?,点我重新发送。')",30000);
	   }
	  });
	}
	
function sendEmailVode(){
var epath=$("#epath").val();
var eemail=$("#email").val();
$.ajax({
type:"post",
url:"sendmodifyEmail",
data:{path:epath,email:eemail},
success:function(data){
   if(data=='1'){
   $("#msg_email").html("验证邮件已发送");
   }
   else{
    $("#msg_email").html("发送失败,请核对信息");
   }
 }
});
}	
	
function initSex(){
var attr=$("#sex_li input:radio:checked").val();
$("#sex").val(attr);
}	
	
//验证码校验


function checkVlidateCode(){
var bool = true;
if($("#validateCode").val()==""){
  return false;
}
 $.ajax({     
          type: "Post",     
          url: "util/checkMobileValiteCode",  
          async: false,
          data:{mobileValidateCode:$("#validateCode").val()},     
          success: function(data) {   
              if(data=='N'){
                  bool = false;
            }
            if(data=='Y'){
            }
          }    
         });
        return bool;
     }
function TelCheck(){
  var t1= $("#number_01").val();
  var t2= $("#validateCode").val();
  var t3= $("#number_03").val();
  if(t1===""){
  $("#t1").html("原手机号不能为空");
  return false;
  }
  if(t2==""){
  $("#t2").html("验证码不能为空");
   return false;
  }
  if(t3==""){
   $("#t3").html("请输入新手机号");
   return false;
   }
   if(!checkVlidateCode()){
   return false;
   } 
   return true;
  }

 
 
//手机号码修改     
function subTelPhoneSave(){
  if(!check()){
    return false;
  }
  if(!TelCheck()){
  return false;
  }
  if(confirm("确认提交")){
  $("#userForm").attr("action","modifyTelphone");
  $("#userForm").submit();
  }

}     
  function check(){
  if($("#validateCode").val()==""){
    alert("请输入验证码!!");
    return false;
   }
  if(checkVlidateCode()){
    return  true;
    }
    else{
    alert("验证码错误");
    return false;
    }
  }
  
  function doUpload() {
     var idnumber = $("#idnumber").val();  
     var realName = $("#realName").val(); 
     if(realName==""){
     $("#ds1").html("请填写真实姓名");
     return ;
     } 
     if(idnumber==""){
     $("#ds2").html("请填写身份证号");
     return ;
     } 
     $("#pro_button4").html("提交中..");
     var formData = new FormData($( "#userForm" )[0]);  
     $.ajax({  
          url: '<%=path%>/uploadIdMemberPic' ,  
          type: 'POST',  
          data: formData,  
          async: true,  
          cache: false,  
          contentType: false,  
          processData: false,  
          success: function (returndata) {  
          if(returndata=='101'){
              alert("信息提交成功");
              window.location.reload();
             }
             else{
             alert("上传信息有误");
             $("#pro_button4").html("确认提交");
             }
          }, 
          error: function (returndata) {  
              alert("上传信息有误");
             $("#pro_button4").html("确认提交");
          }  
     });  
}  
//营业执照提交
var SubBusinessLisenece = function(){
	var CompanyName = $('#CompanyName').val();
	var cocobpicconfirmsign = $('#cocobpicconfirmsign').val();
	if(CompanyName == ""){
		alert("请输入营业公司");
		return ;
	}
	if(cocobpicconfirmsign == "Y"){
		alert("已认证，不能提交");
		return;
	}
	$("#pro_button4").html("提交中..");
   var formData = new FormData($( "#userForm" )[0]);
	$.ajax({  
          url: '<%=path%>/BusinessLicenseValidate' ,  
          type: 'POST',  
          data: formData,  
          async: true,  
          cache: false,  
          contentType: false,  
          processData: false,  
          success: function (returndata) {  
          if(returndata != ''){
              alert("信息提交成功");
             var  jsonObj = JSON.parse(returndata);
             $('#ImgPr3' ).val(jsonObj.coName);
             $('#ImgPr3').val(jsonObj.Cocobusinesspicurl);
              //window.location.reload();
              $("#pro_button4").html("确定提交");
              window.location.reload();
             }
             else{
             alert("上传信息有误");
             $("#pro_button4").html("确认提交");
             }
          }, 
          error: function (returndata) {  
              alert("上传信息有误");
             $("#pro_button4").html("确认提交");
          }  
     });  
	
	
	
}
</SCRIPT>
  <title>我的资料</title>
</head>
<body>
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">pert亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="${pageContext.request.contextPath}/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath}/op/recharge.jsp" target="_blank">充值</a></span>| <span><a href="#">English</a></span>
        </div>
      </div>
      <div class="logo">
        <div class="left"><img src="<%=path%>/images/logo.jpg" /></div>
        <div class="right"><img src="<%=path%>/images/tel.jpg" /></div>
      </div>
      <div class="nav">
        <jsp:include page="../include/main_menu.jsp"></jsp:include>
        <div class="nav_last"></div>
      </div>
    </div>
  </div>
  <div class="forwarding">
      <jsp:include page="../../op/tree.jsp"></jsp:include>
    <form id="userForm" enctype="multipart/form-data" name="userForm" action="saveUser" method="post">
    <div class="right" id="d1">
      <div class="home">
        <h3><a href="#">我的代运</a> > 我的信息 > <span>我的资料</span></h3>
      </div>
      <s:set var="bean" value="#request.objWebUserColumns"></s:set>
      <div class="profile">
        <div class="headline">
          <ul id="u_list">
            <li class="first"><a id="a1" href="javaScript:void(0);">基本信息</a></li>
            <li><a id="a2" href="javaScript:void(0);">手机号修改</a></li>
            <li><a id="a3" href="javaScript:void(0);">邮箱认证</a></li>
            <li><a id="a4" href="javaScript:void(0);">实名认证</a></li>
            <li><a id="a5" href="javaScript:void(0);">营业执照认证</a></li>
          </ul>
        </div>
        <div id="m1" class="matter">
        <div class="left"><img src="<%=path%>/order_images/m_head.png" />
      <!--<span><a href="#">修改头像</a></span> -->
        </div>
        <div class="right">
        <ul>
        <li><span>用户名：</span>
        <input type="hidden" name="objWebUserColumns.word" value='<s:property value="#bean.Word"/>'  />
        <input type="hidden" name="objWebUserColumns.cococode" value='<s:property value="#bean.Cococode"/>'/>
        <input type="hidden" name="objWebUserColumns.opopcode" value="<s:property value="#bean.Opopcode"/>"> 
        <input type="hidden" name="objWebUserColumns.opopsname" value="<s:property value="#bean.Opopsname"/>"> 
        <input type="hidden" name="objWebUserColumns.opopcreatedate" value="<s:property value="#bean.Opopcreatedate"/>"> 
        <input type="hidden" name="objWebUserColumns.opopmodifydate" value="<s:property value="#bean.Opopmodifydate"/>"> 
        <input type="hidden" name="objWebUserColumns.coconame" value="<s:property value="#bean.Coconame"/>">   
        <input type="hidden" name="objWebUserColumns.dpdpcode" value="<s:property value="#bean.Dpdpcode"/>">   
        <input type="hidden" name="objWebUserColumns.pspscode" value="<s:property value="#bean.Pspscode"/>"> 
        <input type="hidden" name="objWebUserColumns.fcfccode" value="<s:property value="#bean.Fcfccode"/>"> 
        <input type="hidden" name="objWebUserColumns.opopconfirmdate" value="<s:property value="#bean.Opopconfirmdate"/>"> 
        <input type="hidden" name="objWebUserColumns.eeeename" value="<s:property value="#bean.Eeeename"/>"> 
        <input name="objWebUserColumns.opopname" value="<s:property value="#bean.Opopname"/>" type="text" style="width:150px;" /></li>
        <li id="sex_li"><span>性别：


        <input id="sex" type="hidden" name="objWebUserColumns.opopsex" >
        </span>
		        <s:if test='"M".equals(#bean.Opopsex)'>
                <input id="gender_0" name="gender" value="M" checked="checked" type="radio">
                <label for="gender_0" style="padding-right:20px;">先生</label>
                <input id="gender_1" name="gender" value="F" type="radio">
                <label for="gender_1">女士</label>
                </s:if>
                <s:else>
                <input id="gender_0" name="gender" value="M"  type="radio">
                <label for="gender_0" style="padding-right:20px;">先生</label>
                <input id="gender_1" name="gender" value="F" checked="checked" type="radio">
                <label for="gender_1">女士</label>
                </s:else>
                 </li>        
        <li><span>手机号码：</span><input name="objWebUserColumns.opopmobile" id="mol" type="text" readonly="readonly" value="<s:property value="#bean.Opopmobile"/>" style="width:150px;background-color: #f1f1f1;" /></li>
        <li><span>固定电话：</span><input name="fixed-line" type="text" style="width:50px;" /> - <input  type="text"  value="<s:property value="#bean.Opoptelephone"/>" style="width:120px;" /></li>
        <li><span>所在地：</span>
        
               <select id="province" name="province">                      
               </select>
               <select id="city" name="city" >              
               </select>
               <select id="area" name="area" >
               </select>
        </li>
        <li><span>详细地址：</span><input name="objWebUserColumns.opopaddress" value="<s:property value="#bean.Opopaddress"/>" type="text" style="width:250px;" /></li>
        <li><span>生日：</span><select name="years" style="width:64px;">
                  <option value="">1980</option>
                  <option value="">1981</option>
                  <option value="">1982</option>
                  <option value="">1983</option>
                  <option value="">1984</option>
                  <option value="">1985</option>
                  <option value="">1986</option>
                  <option value="">1987</option>
                  <option value="">1988</option>
                  <option value="">1989</option>
                </select> 年 <select name="month" style="width:45px;">
                  <option value="">1</option>
                  <option value="">2</option>
                  <option value="">3</option>
                  <option value="">4</option>
                  <option value="">5</option>
                  <option value="">6</option>
                  <option value="">7</option>
                  <option value="">8</option>
                  <option value="">9</option>
                  <option value="">10</option>
                  <option value="">11</option>
                  <option value="">12</option>
                </select> 月 <select name="month" style="width:45px;">
                  <option value="">1</option>
                  <option value="">2</option>
                  <option value="">3</option>
                  <option value="">4</option>
                  <option value="">5</option>
                  <option value="">6</option>
                  <option value="">7</option>
                  <option value="">8</option>
                  <option value="">9</option>
                  <option value="">10</option>
                  <option value="">11</option>
                  <option value="">12</option>
                  <option value="">13</option>
                  <option value="">14</option>
                  <option value="">15</option>
                  <option value="">16</option>
                  <option value="">17</option>
                  <option value="">18</option>
                  <option value="">19</option>
                  <option value="">20</option>
                  <option value="">21</option>
                  <option value="">22</option>
                  <option value="">23</option>
                  <option value="">24</option>
                  <option value="">25</option>
                  <option value="">26</option>
                  <option value="">27</option>
                  <option value="">28</option>
                  <option value="">29</option>
                  <option value="">30</option>
                </select> 日</li>
        </ul>
       <button class="pro_button" type="button" onclick="save();">保存</button>
       </div>
<script language="javascript" defer>
new PCAS("province","city","area","广东省","深圳市","宝安区");
</script>
        <div class="clear"></div>
        </div>
         <div id="m2" style="display:none;" class="matter">
        <ul class="number_change">
        <!--  <li><span><font>*</font>输入原手机号码：</span><input id="number_01" name="number_01" type="text" style="width:185px;" /><label id="t1" style="color:red"></label></li>-->
        <li><span><font>*</font>输入新手机号码：</span><input  id="number_03" name="number_03" type="text" style="width:185px;" /><label id="t3" style="color:red"></label></li>
        <li><span><font>*</font>输入手机验证码：</span><input id="validateCode" name="number_02" type="text" style="width:80px;" /><button id="obtain" class="obtain" type="button" style=" width:100px;height:25px;" onclick="sendMsg()">获取短信验证码</button><!-- <button  style=" width:50px;height:25px;" class="obtain" type="button" onclick="check()">验证</button> --><label id="t2" style="color:red"></label></li>
        </ul>
        <button class="pro_button" type="button" onclick="subTelPhoneSave();" style="margin-left:155px;">保存</button>
        </div>    
         <div id="m3" style="display:none;" class="matter">
         <s:if test='#bean.opopemailconfirmsign==null'>
        <ul class="number_change">
        <li><span><font>*</font>输入邮箱地址：</span><input name="number_02" id="email" value="<s:property value="#bean.Opopemail"/>" type="text" style="width:250px;" /><label id="msg_email" ></label></li> 
        </ul>
         <button class="pro_button" type="button" onclick="sendEmailVode();" style="margin-left:155px;">去邮箱认证</button>
        </s:if>
        <s:elseif test='"Y".equals(#bean.opopemailconfirmsign)'>
        <div class="state">邮箱已经认证</div>
        </s:elseif> 
        </div>
        <input type="hidden" id="epath" value="<%=basePath%>"/>
        
        
        
        
        <div id="m4" style="display:none;" class="matter">
        <div class="prompt">用于提升账号的安全性和信任级别，认证后不可修改!</div>
        <s:if test='#bean.opopidnumberconfirmsign==null'>
        <div class="state">认证状态：未认证</div>
        <div class="message">
        <h3>身份证信息</h3>
        <ul class="number_change">
        <li><span><font>*</font>真实姓名：</span><input id="realName" name="realName"  value="<s:property value="#bean.opopname"/>" type="text" style="width:185px;" /></li>
        <li><span>证件类型：</span>
                <input id="Id_card_type_0" name="Id_card_type" value="0" checked="checked" type="radio">
                <label for="Id_card_type_0" style="padding-right:20px;">二代身份证</label>
                <input id="Id_card_type_1" name="Id_card_type" value="1" type="radio">
                <label for="Id_card_type_1">临时身份证</label></li>
         <li><span><font>*</font>身份证号码：</span><input name="objWebUserColumns.opopidnumber" type="text"  value="<s:property value="#bean.opopidnumber"/>" style="width:185px;" /></li>
         <li><span><font>*</font>证件图片：</span>（请上传本人身份证件，确保图标清晰，四角完整；照片支持jpg、gif、bmp、png格式，图片最大不要超过2M。）</li>
        </ul>
        <table width="300" border="0">
  <tr>
    <td> 
    <input name="path" type="hidden" value="<%=basePath%>"/>
    <img id="img_upload" onclick="upload_a();" src="<%=path %>/order_images/upload.jpg" >  <input style="opacity:0;width:114px;height: 47px;margin: -55px -3px;" name="uploadFile1" id="fileName1" type="file">
    </td>
    <td><img src="<%=path %>/order_images/upload.jpg" />
    <input style="opacity:0;width:114px;height: 47px;margin: -55px -3px;" name="uploadFile2"  id="fileName2" type="file">
    </td>
  </tr>
  <tr>
    <td><img id="ImgPr1" style="width:116px;height:73px" src="<s:property value="#bean.opopidnumberpicurl"/>" /></td>
    <td><img id="ImgPr2" style="width:116px;height:73px" src="<s:property value="#bean.opopidnumberrpicurl"/>" /></td>
  </tr>
</table>
<button class="pro_button" id="pro_button4" type="button" onclick="doUpload()" style="margin-left:155px;">确定提交</button>
        </div>
         </s:if>
                 <s:if test='"N".equals(#bean.opopidnumberconfirmsign)'>
        <div class="state">认证状态：认证未通过,请重新提交信息!!!</div>
        <div class="message">
        <h3>身份证信息</h3>
        <ul class="number_change">
        <li><span><font>*</font>真实姓名：</span><input id="realName" name="realName" value="<s:property value="#bean.opopname"/>" type="text" style="width:185px;" /><label id="ds1" style="color:red"></label></li>
        <li><span>证件类型：</span>
                <input id="Id_card_type_0" name="Id_card_type" value="0" checked="checked" type="radio">
                <label for="Id_card_type_0" style="padding-right:20px;">二代身份证</label>
                <input id="Id_card_type_1" name="Id_card_type" value="1" type="radio">
                <label for="Id_card_type_1">临时身份证</label></li>
         <li><span><font>*</font>身份证号码：</span><input id="idnumber" name="objWebUserColumns.opopidnumber" type="text"  value="<s:property value="#bean.opopidnumber"/>" style="width:185px;" /><label id="ds2" style="color:red"></label></li>
         <li><span><font>*</font>证件图片：</span>（请上传本人身份证件，确保图标清晰，四角完整；照片支持jpg、gif、bmp、png格式，图片最大不要超过2M。）</li>
        </ul>
        <table width="300" border="0">
  <tr>
    <td> 
    <input name="path" type="hidden" value="<%=basePath%>"/>
    <img id="img_upload" onclick="upload_a();" src="<%=path %>/order_images/upload.jpg" >  <input style="opacity:0;width:114px;height: 47px;margin: -55px -3px;" name="uploadFile1" id="fileName1" type="file">
    </td>
    <td><img src="<%=path %>/order_images/upload.jpg" />
    <input style="opacity:0;width:114px;height: 47px;margin: -55px -3px;" name="uploadFile2"  id="fileName2" type="file">
    </td>
  </tr>
  <tr>
    <td><img id="ImgPr1" style="width:116px;height:73px" src="<s:property value="#bean.opopidnumberpicurl"/>" /></td>
    <td><img id="ImgPr2" style="width:116px;height:73px" src="<s:property value="#bean.opopidnumberrpicurl"/>" /></td>
  </tr>
</table>
<button class="pro_button" id="pro_button4" type="button" onclick="doUpload()" style="margin-left:155px;">确定提交</button>
        </div>
         </s:if>
          <s:if test='"Z".equals(#bean.opopidnumberconfirmsign)'>
       <div class="state">认证状态：工作人员认证中,请耐心等待</div>
       </s:if>
         <s:if test='"Y".equals(#bean.opopidnumberconfirmsign)'>
       <div class="state">认证状态：已认证</div>
       </s:if>
        <div class="real_name"></div>
        </div> 
            
     
     
        
        
        
        
 <div id="m5" style="display:none;" class="matter">
 		
      	<div class="prompt">用于提升账号的安全性和信任级别，认证后不可修改!</div> 
		
        <s:set var="beanco" value="#request.objCorporationdColumns"></s:set>
        
        <!--  <div class="state">认证状态：未认证</div>-->
        <div class="message">
        <h3>营业执照信息</h3>
        <ul class="number_change">
        <li><span><font>*</font>营业公司：</span><input id="CompanyName" name="CompanyName"  value="<s:property value="#beanco.coConame"/>" type="text" style="width:185px;" /></li>
        <li><span>证件类型：</span>
                <input  checked="checked" value="1" type="radio" >
                
                <label for="Id_card_type_1">营业执照</label></li>
                
         <li><span><font>*</font>证件图片：</span>（请上传营业执照证件，确保图标清晰，四角完整；照片支持jpg、gif、bmp、png格式，图片最大不要超过2M。）</li>
        </ul>
    
      <table width="300" border="0">
      
  <s:if test='#beanco.Cocobpicconfirmsign =="" || #beanco.Cocobpicconfirmsign == null'>
  <tr>
    <td> 
    <input name="path" type="hidden" value="<%=basePath%>"/>
    <img id="img_upload"  src="<%=path %>/order_images/upload.jpg" ><input style="opacity:0;width:114px;height: 47px;margin: -55px -121px;" name="uploadFile1" id="fileName3" type="file">
    </td>

  </tr>
  </s:if>
  <tr style="width: 396px;height: 306px;">
    <td><img id="ImgPr3" style="width:380px;height:290px" src="<s:property value="#beanco.Cocobusinesspicurl"/>" /></td>
   <!--  <td><input value="<s:property value="#beanco.Cocoremark"/>"/></td> -->
  </tr>
</table>
 	<input type="hidden" name="cocobpicconfirmsign" value="<s:property value="#beanco.Cocobpicconfirmsign"/>"/>
	<button class="pro_button" id="pro_button4" type="button" onclick="SubBusinessLisenece()" style="margin-left:155px;">确定提交</button>

  </div>
  <s:if test='(#beanco.Cocobpicconfirmsign).equals("N")'>
		      <div class="state" >认证状态：工作人员认证中,请耐心等待
		      </div>
	</s:if>
	<s:if test='("Y").equals(#beanco.Cocobpicconfirmsign)'>
		      <div class="state" >认证状态：已认证</div>
	</s:if>
     <div class="real_name"></div>
     
     
     
     
  </div> 
  
  
  
<!--  <div class="state">认证状态：认证未通过,请重新提交信息!!!</div>
        <div class="message">
        <h3>营业执照信息</h3>
        <ul class="number_change">
        <li><span><font>*</font>营业公司：</span><input id="realName" name="realName" value="<s:property value="#bean.opopname"/>" type="text" style="width:185px;" /><label id="ds1" style="color:red"></label></li>
        <li><span>证件类型：</span>
                <input  checked="checked"  value="1" type="radio" >
                <label for="Id_card_type_1">营业执照</label></li>
         <li><span><font>*</font>营业执照：</span><input id="idnumber" name="objWebUserColumns.opopidnumber" type="text"  value="<s:property value="#bean.opopidnumber"/>" style="width:185px;" /><label id="ds2" style="color:red"></label></li>
         <li><span><font>*</font>证件图片：</span>（请上传本人身份证件，确保图标清晰，四角完整；照片支持jpg、gif、bmp、png格式，图片最大不要超过2M。）</li>
        </ul>
  <table width="300" border="0">
  <tr>
    <td> 
    <input name="path" type="hidden" value="<%=basePath%>"/>
    <img id="img_upload" onclick="upload_a();" src="<%=path %>/order_images/upload.jpg" >  
    <input style="opacity:0;width:114px;height: 47px;margin: -55px -3px;" name="uploadFile1" id="fileName1" type="file">
    </td>
  </tr>
  <tr>
    <td><img id="ImgPr1" style="width:116px;height:73px" src="<s:property value="#bean.opopidnumberpicurl"/>" /></td>
 
  </tr>
</table>
<button class="pro_button" id="pro_button4" type="button" onclick="SubBusinessLisenece()" style="margin-left:155px;">确定提交</button>
</div> -->  
   
        
        
      </div>
    </div>
    </form>

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
