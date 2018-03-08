<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>QQ交流</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/style/member.css"/>
	<script type="text/javascript" src="../js/jquery.min.js"></script>
	<script type="text/javascript" src="../js/UpdatePass.js" charset="gb2312"></script>
<style>
*{ margin:0; padding:0; list-style:none;}
img{ border:0;}

.rides-cs {  font-size: 12px; background:#29a7e2; position: fixed; top: 250px; right: 0px; _position: absolute; z-index: 1500; border-radius:6px 0px 0 6px;}
.rides-cs a { color: #00A0E9;}
.rides-cs a:hover { color: #ff8100; text-decoration: none;}
.rides-cs .floatL { width: 36px; float:left; position: relative; z-index:1;margin-top: 21px;height: 181px;}
.rides-cs .floatL a { font-size:0; text-indent: -999em; display: block;}
.rides-cs .floatR { width: 130px; float: left; padding: 5px; overflow:hidden;}
.rides-cs .floatR .cn {background:#F7F7F7; border-radius:6px;margin-top:4px;}
.rides-cs .cn .titZx{ font-size: 14px; color: #333;font-weight:600; line-height:24px;padding:5px;text-align:center;}
.rides-cs .cn ul {padding:0px;}
.rides-cs .cn ul li { line-height: 22px; height:56px;border-bottom: solid 1px #E6E4E4;overflow: hidden;text-align:center;}
.rides-cs .cn ul li span { color: #777;}
.rides-cs .cn ul li a{color: #777;}
.rides-cs .cn ul li img { vertical-align: middle;}
.rides-cs .btnOpen, .rides-cs .btnCtn {  position: relative; z-index:9; top:25px; left: 0;  background-image: url(http://demo.lanrenzhijia.com/2014/service1031/images/lanrenzhijia.png); background-repeat: no-repeat; display:block;  height: 146px; padding: 8px;}
.rides-cs .btnOpen { background-position: 0 0;}
.rides-cs .btnCtn { background-position: -37px 0;}
.rides-cs ul li.top { border-bottom: solid #ACE5F9 1px;}
.rides-cs ul li.bot { border-bottom: none;}
</style>
<script>
</script>
</head>
<body style="">
<!--代码部分begin-->
<div id="floatTools" class="rides-cs" style="height:262px;">
  <div class="floatL">
  	<a id="aFloatTools_Show" class="btnOpen" title="查看在线客服" style="top:20px;display:block" href="javascript:void(0);">展开</a>
  	<a id="aFloatTools_Hide" class="btnCtn" title="关闭在线客服" style="top:20px;display:none" href="javascript:void(0);">收缩</a>
  </div>
  <div id="divFloatToolsView" class="floatR" style="display: none;height:238px;width: 140px;">
    <div class="cn">
      <h3 class="titZx">代运在线客服</h3>
    	
      <ul>
        <li><span>客服</span> <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=<%=session.getAttribute("GCSQQ")%>&site=qq&menu=yes">
        	<img border="0" src="${pageContext.request.contextPath }/images/qq.jpg" alt="点击这里给我发消息" title="点击这里给我发消息"/></a> 
        	<span><%=session.getAttribute("GCSmobie")%></span>
        	</li>
        <li><span>财务</span> <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=<%=session.getAttribute("GFIQQ")%>&site=qq&menu=yes">
        	<img border="0" src="${pageContext.request.contextPath }/images/qq.jpg" alt="点击这里给我发消息" title="点击这里给我发消息"/></a> 
        	<span><%=session.getAttribute("GFImobie")%></span>
        	</li>
        <li><span>销售</span> <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=<%=session.getAttribute("GSSQQ")%>&site=qq&menu=yes">
        	<img border="0" src="${pageContext.request.contextPath }/images/qq.jpg" alt="点击这里给我发消息" title="点击这里给我发消息"/></a> 
        	<span><%=session.getAttribute("GSSmobie")%></span>
        	</li>
       <!--  <li>
            <span>13638646118</span>
            <span>13638646118</span>
            <div class="div_clear"></div>
        </li> -->
        <li style="border:none;border-bottom: solid 1px #E6E4E4;overflow: hidden;text-align:center;"><span>电话：400-000-0000</span> </li>
      </ul>
    </div>
  </div>
</div>
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script>
	$(function(){
		$("#aFloatTools_Show").click(function(){
			$('#divFloatToolsView').animate({width:'show',opacity:'show'},100,function(){$('#divFloatToolsView').show();});
			$('#aFloatTools_Show').hide();
			$('#aFloatTools_Hide').show();				
		});
		$("#aFloatTools_Hide").click(function(){
			$('#divFloatToolsView').animate({width:'hide', opacity:'hide'},100,function(){$('#divFloatToolsView').hide();});
			$('#aFloatTools_Show').show();
			$('#aFloatTools_Hide').hide();	
		});
	});
</script>
<!--代码部分end-->
</body>
</html>
