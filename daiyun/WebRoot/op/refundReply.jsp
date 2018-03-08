<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="kyle.common.util.jlang.*"%>
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
    
    <title>退款详情</title>
    
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
  </head>

<script type="text/javascript">
 	function queryDate(){
 		document.getElementById("form1").action="${pageContext.request.contextPath}/refundQuery";
  		document.getElementById("form1").submit();
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
<form id="form1" name="form1" action="" method="post" enctype="multipart/form-data">
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
          <div class="right"><span><a href="${pageContext.request.contextPath}/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath}/op/recharge.jsp" target="_blank">充值</a></span> | <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="images/logo.jpg" /></div>
        <div class="right"><img src="images/tel.jpg" /></div>
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
        <h3><a href="#">我的代运</a> >我的账户> <span>退款申请</span></h3>
        </div>
       <div class="recharge">
        <div class="r_title">退款详情</div>
        <div class="nir">
   <div class="center_table">
    <div style="border:1px dashed #0072E3； ">
               	  <p style=" color:#0072E3;font-size:14px;padding:10px 10px 10px 10px">
               	     状态说明：<br/>
               	  1、新建表示客户提交成功，等待客户确认，此时可以修改。<br/>
               	  2、确认表示客户已经确定，不可再修改申请资料。 <br/>
               	  3、审核表示我司对该票申请开始审查。<br/>
               	  4、完成代表申请通过。<br/>
               	  5、我司只审核确认状态的申请。<br/>
               	  </p>	
               </div>
    <a href="${pageContext.request.contextPath}/op/refund.jsp"  style="font-size: 15px;color:#0072E3;font-weight: bold">新建申请</a> 
<table style="width:830 border:0">
		<tr>
    <td style="border:0">开始时间：
                <input onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
									name="startdate" id="startdate" type="text" style="width: 170px; height:24px; "  class="Wdate" value="<%=startdate%>" />
    </td>
  <td style=" border:0">&nbsp;&nbsp;&nbsp;结束时间：
	 <input onfocus="WdatePicker({startDate:'%y-%M-01 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
									name="enddate" id="enddate" type="text" style="width: 170px;height:24px ; "	value="<%=enddate %>" class="Wdate"/>
    </td>
    <td  style=" border:0;padding-left:30px;">
   		 <button class="pro_button22" type="button" onclick="queryDate();" >查询</button>
   	  </td>
    </tr>
</table>
<table width="830" border="0" id="isutable"> 

  <tr style=" background:#edf8fd;">
    <td style="width:60px">序号</td>
    <td style="width:60px">退款号</td>
    <td style="width:60px">退款状态</td>
    <td style="width:60px">退款类型</td>
    <td style="width:130px">申请时间</td>
    <td style="width:80x">退款申请人</td>
    <td style="width:160px">退款账号</td>
    <td style="width:160px">退款银行</td>
  </tr>
  <TBODY id="info">
  		<% int number=0; %>
       <s:iterator var="bean" value="#request.listRefund" status="sts">
       			<% number++; %>
                <s:if test="#sts.index % 2 == 0">
                   <tr>
                        </s:if>
                        <s:else>
                    <tr>
                        </s:else>
                        <TR>
                        	<TD class="tab6"><%=number%></TD>	
							<TD  class="tab6"><s:property value="#bean.Tfrrcode"/></TD>
							<TD class="tab6"><a href="${pageContext.request.contextPath}/op/refundModifyQuery?rrcode=<s:property value="#bean.Tfrrcode"/>"  style=";color:#0072E3;"><s:property value="#bean.Tdrrsname"/></a></TD>
							<TD  class="tab6"><s:property value="#bean.Trrriname"/></TD>
							<TD  class="tab6"><s:property value="#bean.TfRrcreatedate"/></TD>
							<TD class="tab6"><s:property value="#bean.opOpname"/></TD>
 							<TD  class="tab6"><s:property value="#bean.tfRrbankaccount"/></TD>
 							<TD  class="tab6"><s:property value="#bean.tfRrbankname"/></TD>
						</TR>
						</s:iterator>
						</TBODY>
						<!-- 判断定制块的值是否为空 -->
						<s:set var="queryAccount" value="#request.listRefund" />
						<s:if test="#queryAccount.size()==0">
							<tr class="manage_form_bk2">
								<td colspan="10"><h3 style="color: red;">没有查询到相关退款记录!</h3></td>
							</tr>
							
  					</s:if>			
  					<TBODY id="info">       
					</TBODY>
					</table>
							 <s:if test="#queryAccount!=null">			 
                    <div class="page" style="padding-top:15px;padding-left:600px;" >
						<p:pager url="refundQuery"  />
					</div>
					</s:if>
		  </div>
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
