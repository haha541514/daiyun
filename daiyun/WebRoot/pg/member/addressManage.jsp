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
    <script type="text/javascript" src="<%=path%>/js/addressmanage.js"  charset="utf-8"></script>
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
   function  checkSave(){
     for(i=0;i<4;i++){
     var index = "text"+i;
     if($("#"+index).val()=="")
       {
       alert(index);
       $("#msg_"+index).parent().parent().css("display","block");
       $("#msg_"+index).css("color","red");
       $("#msg_"+index).html("请填写信息！");
       return false;
      }   
     }
     return true;
   }
   
    function save(code){
    if(checkSave()){
     if(confirm("确认保存?")){
     document.queryShipperInfo.action="<%=path%>/saveShipperInfo";
     document.queryShipperInfo.submit();
       }
      }
     }
      function save2(code){
    if(checkSave()){
     if(confirm("确认保存?")){
     document.queryShipperInfo.action="<%=path%>/saveShipperInfo?mail=M";
     document.queryShipperInfo.submit();
       }
      }
     }
    function change(code){
      if(code==4){
      	 document.getElementById("savetd1").style.display='none';
      	 document.getElementById("savetd2").style.display='none';
     	 document.getElementById("savetd3").style.display='';
     	 document.getElementById("savetd4").style.display='';
     	 document.getElementById("address2").style.display='none';
     	 document.getElementById("address2").value=1;
     	 document.getElementById("address3").style.display='none';
     	 document.getElementById("address3").value=1;
     	 document.getElementById("companyName").style.display='none';
     	 document.getElementById("text1").value=1;
     	 document.getElementById("citycode").style.display='none';	 
     	 document.getElementById("postcode").style.display='none';	      
       }else{
       	 document.getElementById("savetd1").style.display='';
      	 document.getElementById("savetd2").style.display='';
     	 document.getElementById("savetd3").style.display='none';
     	 document.getElementById("savetd4").style.display='none';
     	  document.getElementById("address2").style.display='';
     	 document.getElementById("address3").style.display='';
     	 document.getElementById("companyName").style.display='';
     	 document.getElementById("citycode").style.display='';
     	 document.getElementById("postcode").style.display='';	
       }
  	} 
   
    function init(){
    var sign= $("#scScshipperconsigneetype").val();
    if(sign=='C'){
    $("#indexShow1").hide();
    $("#m1").hide();
     $("#m4").hide();
    $("#indexShow2").show();
    $("#indexShow3").hide();
    $("#indexShow4").hide();
    $("#m2").show();
    $("#a1").css("color","#333");
    $("#a1").css("background","url(/daiyun/images/order_bg02.png)");
    $("#a3").css("color","#333");
    $("#a3").css("background","url(/daiyun/images/order_bg02.png)");
    $("#a4").css("color","#333");
    $("#a4").css("background","url(/daiyun/images/order_bg02.png)");
    $("#a2").css("color","#FFF");
    $("#a2").css("background","url(/daiyun/images/order_bg03.png)");  	
     }
    if(sign=='S'){
    $("#indexShow1").show();
    $("#m1").show();
    $("#indexShow2").hide();
    $("#indexShow3").hide();
    $("#indexShow4").hide();
    $("#m2").hide();
    $("#m3").hide();
    $("#m4").hide();
    $("#a2").css("color","#333");
    $("#a2").css("background","url(/daiyun/images/order_bg02.png)");
    $("#a3").css("color","#333");
    $("#a3").css("background","url(/daiyun/images/order_bg02.png)");
    $("#a4").css("color","#333");
    $("#a4").css("background","url(/daiyun/images/order_bg02.png)");
    $("#a1").css("color","#FFF");
    $("#a1").css("background","url(/daiyun/images/order_bg03.png)");  	
     }
     if(sign=='T'){
    $("#indexShow1").hide();
    $("#m1").hide();
    $("#indexShow2").hide();
    $("#indexShow3").show();
    $("#indexShow4").hide();
    $("#m2").show();
    $("#m4").hide();
    $("#a1").css("color","#333");
    $("#a1").css("background","url(/daiyun/images/order_bg02.png)");
    $("#a2").css("color","#333");
    $("#a2").css("background","url(/daiyun/images/order_bg02.png)");
    $("#a3").css("color","#FFF");
    $("#a3").css("background","url(/daiyun/images/order_bg03.png)");  	
    $("#a4").css("color","#333");
    $("#a4").css("background","url(/daiyun/images/order_bg02.png)");
     }
    if(sign=='M'){
    $("#indexShow1").hide();
    $("#m1").hide();
    $("#indexShow2").hide();
    $("#indexShow3").hide();
    $("#indexShow4").show();
    $("#m2").hide();
    $("#m3").hide();
    $("#m4").show();
    $("#a1").css("color","#333");
    $("#a1").css("background","url(/daiyun/images/order_bg02.png)");
    $("#a2").css("color","#333");
    $("#a2").css("background","url(/daiyun/images/order_bg02.png)");
    $("#a3").css("color","#333");
    $("#a3").css("background","url(/daiyun/images/order_bg02.png)");  	
    $("#a4").css("color","#FFF");
    $("#a4").css("background","url(/daiyun/images/order_bg03.png)");  	
     }
   }
   </script>
</head>

<body onload="init();">
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
    <div  class="right">
      <div class="home">
        <h3><a href="#">我的代运</a> > 我的信息 > <span>收发货地址</span></h3>
      </div>
      <form action="${pageContext.request.contextPath }/page/queryShipperInfo"  onsubmit="return checkSave() " method="post" name="queryShipperInfo">
        <s:set var="bean" value="#request.objShipperconsigneeColumns"/>
        <input type="hidden" name="sccode" id="sccode">
       <!--  <input type="hidden" id="scsclabelode" name="m_objSCColumns.scsclabelcode"  value="<s:property value='#bean.scsclabelcode'/>"/>--> 
        <input type="hidden" id="scsccode" name="m_objSCColumns.scsccode"  value="<s:property value='#bean.scsccode'/>" />
        <s:if test="#bean.scscshipperconsigneetype==null">
        <input type="hidden" id="scScshipperconsigneetype" name="sign"  value="S"/>
        </s:if>
        <s:else>
        <input type="hidden" id="scScshipperconsigneetype" name="sign"  value="<s:property value='#bean.scscshipperconsigneetype'/>"/></s:else>
      <div class="profile">
        <div class="headline">
          <ul id="u_list">
            <li><a id="a1" href="javaScript:change(1);">常用发件人</a></li>
            <li><a id="a2" href="javaScript:change(2);">常用收件人</a></li>
            <li><a id="a3" href="javaScript:change(3);">常用提货地址</a></li>
            <li><a id="a4" href="javaScript:change(4);">邮寄地址资料</a></li>
          </ul>
        </div>
        <div class="address">
        <p id="indexShow1">新增发货地址<span>带<font>*</font>为必填</span></p>
        <p id="indexShow2" style="display:none">新增收货地址<span>带<font>*</font>为必填</span></p>
        <p id="indexShow3" style="display:none">新增提货地址<span>带<font>*</font>为必填</span></p>
        <p id="indexShow4" style="display:none">新增邮寄地址<span>带<font>*</font>为必填</span></p>
       <!--    <input type="hidden" id="sign" name="sign" value="C">      -->
        <table style="font:12px '宋体';" width="490" border="0">
  <tr>
    <td colspan="2"><span><font>*</font>地址1：</span><input id="text00"  name="m_objSCColumns.scscaddress1" value="<s:property value='#bean.scscaddress1'/>" type="text" style="width:394px;" />
    </td>


  </tr>
  <tr id="address2">
    <td colspan="2"><span><font>*</font>地址2：</span><input id="text01"  name="m_objSCColumns.scscaddress2" value="<s:property value='#bean.scscaddress2'/>" type="text" style="width:394px;" />
    </td>


  </tr>
  <tr id="address3">
    <td colspan="2"><span><font>*</font>地址3：</span><input id="text02"  name="m_objSCColumns.scscaddress3" value="<s:property value='#bean.scscaddress3'/>" type="text" style="width:394px;" />
    </td>


  </tr>
  <tr style="display:none"><td><span id="msg_text0"></span></td></tr>
  <tr id="companyName">
    <td colspan="2"><span><font>*</font>公司名称：</span><input id="text1"  name="m_objSCColumns.scsccompanyname" value="<s:property value='#bean.scsccompanyname'/>"  type="text" style="width:394px;" /></td>
  </tr>
  <tr  style="display:none;"><td><span id="msg_text1"></span></td></tr>
  <tr>
    <td><span><font>*</font>姓名：</span><input id="text2" name="m_objSCColumns.scscname"  type="text" value="<s:property value='#bean.scscname'/>"   style="width:150px;" /></td>
    <td><span><font>*</font>电话：</span><input id="text3" name="m_objSCColumns.scsctelephone" type="text" value="<s:property value='#bean.scsctelephone'/>"  style="width:150px;" /></td>
  </tr>
  
  <tr align="right" style="display:none;"><td><span id="msg_text2"></span></td><td ><span id="msg_text3" ></span></td></tr>
  <tr id="postcode">
 	 <td><span>编码：</span><input id="text4" name="m_objSCColumns.scsclabelcode"  type="text" value="<s:property value='#bean.scsclabelcode'/>" style="width:150px;" /></td>
    <td ><span>邮编：</span><input id="text5"  name="m_objSCColumns.scscpostcode"  type="text" value="<s:property value='#bean.scscpostcode'/>"   style="width:150px;" /></td>
  </tr>
   <tr  style="display:none;"><td><span id="msg_text4"></span></td><td><span id="msg_text5"></span></td></tr>
  <tr id="citycode">
     <td><span>城市代码：</span><input id="text6" name="m_objSCColumns.scsccitycode"  type="text" value="<s:property value='#bean.scsccitycode'/>" style="width:150px;" /></td>
    <td><span>传真：</span><input id="text7" name="m_objSCColumns.scscfax"  type="text" value="<s:property value='#bean.scscfax'/>"   style="width:150px;" /></td>
  </tr>
   <tr style="display:none"><td><span id="msg_text6"></span></td><td><span id="msg_text7"></span></td></tr>
  <tr>
    <td colspan="2" style="padding-left:23px;"><span><input type="checkbox" style="margin-right:5px; margin-top:2px;"></span>设置为默认收货地址</td>
  </tr>
   <tr>
    <td colspan="1" id="savetd1"><button class="pro_button" type="submit" onclick="save();">保存</button></td> <td colspan="1" id="savetd2"><button class="pro_button" id="re_button" type="reset" >重置</button></td>
    <td colspan="1" style='display:none' id="savetd3"><button class="pro_button" type="submit" onclick="save2();">保存</button></td > <td colspan="1" id="savetd4" style='display:none'><button class="pro_button" id="re_button" type="reset" >重置</button></td>
  </tr>
</table>
 
        </div>
        <div id="m1" class="goods">
        <table style="font:12px '宋体';" width="860" id="goods">
          <tr style="background:#edf8fd;">
            <td width="10%">发件人</td>
            <td width="25%">所在地区</td>
            <td width="25%">详细地址</td>
            <td width="10%">邮编</td>
            <td width="14%">电话/手机</td>
            <td width="16%">操作</td>
          </tr>
          <s:iterator var="bean" value="#request.listShipperInfo" >
          <tr>
            <td><s:property value="#bean.scscname" /></td>
            <td><s:property value="#bean.scscaddress1" /></td>
            <td><s:property value="#bean.scscaddress1" /></td>
            <td><s:property value="#bean.scscpostcode" /></td>
            <td><s:property value="#bean.scsctelephone" /></td>
            <td><a href="javaScript:void(0)" onclick="edit(<s:property value="#bean.scsccode"/>)"> 修改</a><a href="javaScript:void(0)" onclick="del(<s:property value="#bean.scsccode"/>)">删除</a></td>
          </tr>
          </s:iterator>
        </table>
        </div>
         <div id="m2" style="display:none" class="goods">
        <table style="font:12px '宋体';" width="860" id="goods">
          <tr style="background:#edf8fd;">
            <td width="10%">收件人</td>
            <td width="25%">所在地区</td>
            <td width="25%">详细地址</td>
            <td width="10%">邮编</td>
            <td width="14%">电话/手机</td>
            <td width="16%">操作</td>
          </tr>
          <s:iterator var="bean" value="#request.listConsignee" >
          <tr>
            <td><s:property value="#bean.scscname" /></td>
            <td><s:property value="#bean.scscaddress1" /></td>
            <td><s:property value="#bean.scscaddress1" /></td>
            <td><s:property value="#bean.scscpostcode" /></td>
            <td><s:property value="#bean.scsctelephone" /></td>
            <td><a href="javaScript:void(0)" onclick="edit(<s:property value="#bean.scsccode"/>)"> 修改</a><a href="javaScript:void(0)" onclick="del(<s:property value="#bean.scsccode"/>)">删除</a></td>
          </tr>
          </s:iterator>
        </table>
        </div>
        
        <div id="m3" style="display:none" class="goods">
        <table style="font:12px '宋体';" width="860" id="goods">
          <tr style="background:#edf8fd;">
            <td width="10%">收件人</td>
            <td width="25%">所在地区</td>
            <td width="25%">详细地址</td>
            <td width="10%">邮编</td>
            <td width="14%">电话/手机</td>
            <td width="16%">操作</td>
          </tr>
          <s:iterator var="bean" value="#request.listTinfo" >
          <tr>
            <td><s:property value="#bean.scscname" /></td>
            <td><s:property value="#bean.scscaddress1" /></td>
            <td><s:property value="#bean.scscaddress1" /></td>
            <td><s:property value="#bean.scscpostcode" /></td>
            <td><s:property value="#bean.scsctelephone" /></td>
            <td><a href="javaScript:void(0)" onclick="edit(<s:property value="#bean.scsccode"/>)"> 修改</a><a href="javaScript:void(0)" onclick="del(<s:property value="#bean.scsccode"/>)">删除</a></td>
          </tr>
          </s:iterator>
        </table>
        </div>
         <div id="m4" style="display:none" class="goods">
        <table style="font:12px '宋体';" width="860" id="goods">
          <tr style="background:#edf8fd;">
            <td width="10%">收件人</td>
            <td width="25%">所在地区</td>
            <td width="25%">详细地址</td>
            <td width="10%">邮编</td>
            <td width="14%">电话/手机</td>
            <td width="16%">操作</td>
          </tr>
          <s:iterator var="bean" value="#request.listMail" >
          <tr>
            <td><s:property value="#bean.scscname" /></td>
            <td><s:property value="#bean.scscaddress1" /></td>
            <td><s:property value="#bean.scscaddress1" /></td>
            <td><s:property value="#bean.scscpostcode" /></td>
            <td><s:property value="#bean.scsctelephone" /></td>
            <td><a href="javaScript:void(0)" onclick="edit(<s:property value="#bean.scsccode"/>)"> 修改</a><a href="javaScript:void(0)" onclick="del(<s:property value="#bean.scsccode"/>)">删除</a></td>
          </tr>
          </s:iterator>
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
