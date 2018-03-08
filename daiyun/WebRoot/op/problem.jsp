<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="kyle.common.util.jlang.DateFormatUtility"%>

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
    
    <title>问题件查询</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript"  src="${pageContext.request.contextPath}/js/index.js"></script>
	<script language="javascript"  src="${pageContext.request.contextPath}/js/Menus.js"></script>
  </head>

		<script type="text/javascript">
	
		  	function doSubmit2(currentpage_value){
		  		 
		  		 	var select=document.getElementById("type");
					var index=select.selectedIndex ;    
					var goodstype =select.options[index].value;

					//if(goodstype==""||goodstype==null){
					//alert("请选择货物类型");
				//	return false;
					//}
					//var sel =document.getElementById("isutcode");
					//var ind =sel.selectedIndex ;    
					///var problem =sel.options[ind].value;
		  		//	if(problem==""||problem==null){
				//	alert("请选择问题类型");
				//	return false;
				//	}
				
				var currentpage = currentpage_value;
				document.queryForm.action = "queryIssue";
				document.queryForm.submit();
			}

		
			function setPageCount(){
				if(checkPageCount()){
					document.getElementById("queryForm").action= "queryIssue";
					document.getElementById("queryForm").submit();
				}
			}	
			//检查是否选中
			function chooseOneAtLeast(){
				var temp="";
				var obj = document.queryForm.elements;
				
				var k=0;
				for(var i=0;i<obj.length;i++){
					if (obj[i].name == "checkbox" && obj[i].checked == true){
						k+=1;
					}
				}
				if(k == 0){
					alert("请选择一条问题进行操作");
					return false;
				}
				return true;
			}
	
			//回复
			function selReplay(){
				if(chooseOneAtLeast()){
			    	var obj = document.queryForm.elements;
					var isuid;
					var Isuisuid
					for(var i=0;i<obj.length;i++){
						if (obj[i].name == "checkbox" && obj[i].checked == true){
							isuid=obj[i].value;
						}
					}
					Isuisuid= isuid.split("+");
					document.getElementById("queryForm").action="queryIssueAllReplay?isuid="+Isuisuid[1];
					document.getElementById("queryForm").submit();
				}
			}
			 	function doSubmit3(){
				if(chooseOneAtLeast()){
					var obj = document.queryForm.elements;
					var cwcode;
					var cw_code;
					for(var i=0;i<obj.length;i++){
						if (obj[i].name == "checkbox" && obj[i].checked == true){
							cwcode=obj[i].value;
						}
					}
					cw_code=cwcode.split("+");
					document.getElementById("queryForm").action="queryOrders?cw_code="+cw_code[0]+"&link=received";
					document.getElementById("queryForm").submit();
				}
			}
 var exportIssue = function(){
 	if(chooseOneAtLeast()){//得到被选择的问题件的Isuisuid
		//var table = document.getElementById('isutable');
		var checkbox = document.getElementsByName('checkbox');
		var isucode  = "";
		var Isuisuid = $("input[name='Isuisuid']");
		for(var index = 0 ; index < checkbox.length ; index ++){
			if(checkbox[index].checked == true){
				//var row = checkbox[i].parentElement.parentElement.rowIndex;
				isucode += Isuisuid[index].value+",";
			}
		}
		
	}
	$.post("exportIssue",{isucode:isucode,strAkcode:"CWR"},
		function(message){
			if(message!=null){ 
					var url="${pageContext.request.contextPath }/export_excel/"+message;
					window.open(url,"_blank");
						
			}
	});
 
 }
			
</script>

<%
	String startdate = (String) request.getAttribute("startdate");
	String enddate = (String) request.getAttribute("enddate");
	String nowdate = DateFormatUtility.getStandardSysdate().substring(0, 10)+ " 23:59:59";
	if (StringUtility.isNull(startdate))
		startdate = DateUtility.getMoveDate(nowdate, -3).substring(0,10)+ " 00:00:00";
	if (StringUtility.isNull(enddate))
		enddate = nowdate;
%>	
  <body>
<form action="$queryIssue" method="post" name="queryForm" id="queryForm">
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
       <div class="right"><span><a href="${pageContext.request.contextPath}/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath}/op/recharge.jsp" target="_blank">充值</a></span>| <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="${pageContext.request.contextPath}/images/logo.jpg" /></div>
        <div class="right"><img src="${pageContext.request.contextPath}/images/tel.jpg" /></div>
      </div>
     <div class="nav">
  	<jsp:include page="../pg/include/main_menu.jsp"></jsp:include>
        <div class="nav_last"></div>
      </div>
    </div>
  </div>
 
   <div class="forwarding">
	  <jsp:include page="../op/tree.jsp" />
    <div class="right">
     	<div class="home">
        <h3>我的代运 > 订单辅助 > <span>问题件管理</span></h3>
        </div>
        <div class="problem">
        	<div class="condition">
            <div class="left">
            <h3>客户单号：</h3><textarea name="customerewbcode"  placeholder="输入多个订单号，请用“,”分隔 。" class="order_box" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}" style="color: rgb(153, 153, 153);"></textarea>
            </div>
            <table width="520" border="0">
  <tr>
    <td align="left" style="padding-bottom:15px;">货物类型：
 
                <select name="ctcode" id="type" style="width:170px;height:24px">
                  <option value="">------请选择货物类型------</option>
                  <option value="A">所有</option>
                  <option value="AWPX">包裹</option> 
                  <option value="ADOX">文件</option>
                 </select></td>
    <td align="right" style="padding-bottom:15px;">问题分类：




                 <select   name="isutcode"  id="isutcode" style="width:170px;height: 24px;" class="input_text" >
                      <option selected="selected" value="" >-----请选择问题类型 -----</option>
                      <s:iterator var="problem" value="@com.daiyun.dax.IuessDemand@query()">           
                          <option value="<s:property value='#problem.Isutisutcode'/>" ">
                          <s:property value="#problem.Isutisutname" />
                          </option>
                      </s:iterator>
                    </select>
                    </td>
  </tr>
  <tr>
    <td align="left">开始时间：
                <input onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
									name="startdate" id="startdate" type="text" style="width: 170px; height:24px; "  class="Wdate" value="<%=startdate%>" />
  	  
    </td>
  <td align="right">&nbsp;&nbsp;&nbsp;结束时间：




                <input onfocus="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
									name="enddate" id="enddate" type="text" style="width: 170px;height:24px ; "	value="<%=enddate %>" class="Wdate"/>
  
    </td>
    </tr>
  <tr>
    <td style="position:relative;  top:10px;">扣件状态：
                <input type="radio" id="Fasteners_0" name="ihscode" id="RH" value="RH"" checked="checked" >
                <label for="Fasteners_0" style="padding-right:35px;">解除扣件</label>
                <input type="radio" id="Fasteners_1" name="ihscode" id="CH" value="CH"  checked="checked" >
                <label for="Fasteners_1">确定扣件</label>
                </td>
    <td style="position:relative;  top:10px;"><input type="checkbox"  name="noReplay"  id="noReplay" value="Y"  style="  margin-right:5px; line-height:20px; height:20px; margin-left:30px;">仅显示未回复</td>
     
  </tr>
  <tr>
    <td colspan="2" style="padding-top:25px;">
              <button class="buttonbg" value="" type="reset"  style="margin-right:10px;">刷新</button>

              <button class="buttonbg" value="" type="button" onclick="doSubmit2();" style="margin-right:10px;">查询</button>

              <button class="buttonbg" value="" type="button" onclick="doSubmit3();" style="margin-right:10px;">订单详情</button>
              <button class="buttonbg" value="" type="button" onclick="selReplay();" style="margin-right:10px;">回复</button>
             
              <button class="buttonbg" value="" type="button" onclick="exportIssue();">导出</button>
</td>
  </tr>
</table>
<div class="clear"></div>
            </div>
            <div class="center_table">
            	<table width="860" border="0" id="isutable">
  <tr style=" background:#edf8fd;">
    <td>序号</td>
    <td>操作</td>
    <td>订单号</td>
    <td>扣件状态</td>
    <td>问题分类</td>
    <td>问题描述</td>
    <td>创建时间</td>
    <td>回复情况</td>
    <td>客户回复</td>
    <td>我司回复</td>
  </tr>
  <TBODY id="info">
  		<% int number=0; %>
       <s:iterator var="bean" value="#request.listIssueColumns" status="sts">
       	
       			<% number++; %>
       			 <input type="hidden" id="<%=number%>" name="Isuisuid" value="<s:property value='#bean.Isuisuid'/> "/>
                <s:if test="#sts.index % 2 == 0">
                   <tr>
                        </s:if>
                        <s:else>
                    <tr>
                        </s:else>
                        <TR>
                        	<TD width=30 class="tab6"><%=number%><input type="hidden" id="number" value="<%=number%>"/></TD>
							<TD width=50 class="tab6"><input type="checkbox" name="checkbox" value="<s:property value='#bean.Cwcwcode'/>+<s:property value='#bean.Isuisuid'/>" /></TD>							<TD width=100 class="tab6"><s:property value="#bean.Cwcwcustomerewbcode"/></TD>			
							<TD width=80 class="tab6"><s:property value="#bean.Ihsihsname"/></TD>
							<TD width=100 class="tab6"><s:property value="#bean.Isutisutname"/></TD>
							<TD width=240 class="tab6"><s:property value="#bean.Isuiscontent"/></TD>
							<TD width=200 class="tab6"><s:property value="#bean.Isuisucreatedate"/></TD>
							<s:if test="#bean.Isuisucustomerreplysign.equals(\"Y\")">
								<TD width=100 class="tab6"><s:property value=""/>已回复</TD>
							</s:if>
							<s:else>
								<TD width=100 class="tab6"><s:property value=""/>未回复</TD>
							</s:else>
							<s:set var="list" value="@com.daiyun.dax.IuessDemand@queryContent(#bean.Isuisuid)" /> 
							<TD width=150 class="tab6"><s:property value="#list.content"/></TD>
							<TD width=150 class="tab6"><s:property value="#list.bwr"/></TD>
						</TR>
						</s:iterator>
						</TBODY>
						<!-- 判断定制块的值是否为空 -->
						<s:set var="queryAccount" value="#request.listIssueColumns" />
						<s:if test="#queryAccount.size()==0">
							<tr class="manage_form_bk2">
								<td colspan="10"><h3 style="color: red;">没有查询到相关数据,请选择时间段再次查询!</h3></td>
							</tr>
						</s:if>
						<s:if test="#queryAccount==null">
							<tr class="manage_form_bk2">
								<td colspan="10"><h3 style="color: red;">请选择上面条件进行查询！</h3></td>
							</tr>
						</s:if>
						
  						<TBODY id="info">       
						</TBODY>
						<!-- 判断定制块的值是否为空 -->
						</table>
						 
					 <s:if test="#queryAccount!=null">			 
                    <div class="page"  >
						<p:pager url="queryIssue"  />
					</div>
					</s:if>
					 
            </div>
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
<div id="light" class="white_content"></div> 
</form>
</body>
</html>
