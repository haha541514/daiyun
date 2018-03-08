<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="kyle.common.util.jlang.DateFormatUtility"%>
<%@page import="kyle.common.util.jlang.StringUtility"%>
<%@page import="kyle.common.util.jlang.DateUtility"%>
<%@taglib uri = "/project" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>账户余额</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/Ext3/css/ext-all.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
		
		
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_total.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_page.css" />
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
<script type="text/javascript">
	$(function(){
		$('recharge').click(function(){
			location.href='';//充值界面


		});
		
	});
	var GotoSerachPage = function(){
	
		var startdate = $("input[name='startdate']").val();
		var enddate = $("input[name='enddate']").val();
		if(startdate != '' && enddate != ''){
			if(startdate >= enddate){
				alert("创建日期不能小于截止日期");
			}else{
				$('#myform').attr('action','queryBalance');
				$('#myform').submit();
			}
		}
	
		
	}
	
		
</script>
	</head>

<body>
<form id="myform" method="post">
<div id="main">
	
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="${pageContext.request.contextPath }/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath }/op/recharge.jsp" target="_blank">充值</a></span> | <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="${pageContext.request.contextPath}/images/logo.jpg" /></div>
        <div class="right"><img src="${pageContext.request.contextPath}/images/tel.jpg" /></div>
      </div>
      <div class="nav">
        <jsp:include page="../pg/include/main_menu.jsp"></jsp:include>
        <div class="nav_last"><a href="${pageContext.request.contextPath }/userinfo"><img src="${pageContext.request.contextPath }/images/my_nav.jpg"/></a>
        </div>
      </div>
    </div>
  </div>

  <div class="forwarding">
  
   <jsp:include page="../op/tree.jsp" />
    <jsp:include page="../sf/QQCommunicate.jsp" />
   
    <div class="right">
      <div class="home">
        <h3>我的代运  > 我的信息 > <span>账户余额</span></h3>
      </div>
 
      <div class="balance">
        <div class="r_title">账户信息</div>
        
        <div class="nir">
          <h3>总可用余额：<font>
          <s:if test="#request.companyBalance == '' || #request.companyBalance == null">
          		0.000
          </s:if>
          <s:else>
         	 <s:property value="#request.companyBalance" />
          </s:else>
          </font>RMB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>
          <h3> <a href="${pageContext.request.contextPath }/CostOFQuery?startdate=${startdate }&enddate=${enddate}">应收金额：<font>
    		<s:if test="#request.ReceivaBlance == '' || #request.ReceivaBlance == null">
        			0.000
       		 </s:if>
       		 <s:else>
       	 		<s:property value="#request.ReceivaBlance" />
       	 	</s:else>
       	 	
          </font> </a>RMB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>
           <button class="buttonbg" value="" type="button" onclick="location.href='${pageContext.request.contextPath}/op/recharge.jsp'" >充&nbsp;&nbsp;值</button>
        </div>
        <div class="nir">
        	<h3>账户押金：<font>
          <s:if test="#request.accountBalance == '' || #request.accountBalance == null">
          		0.000
          </s:if>
          <s:else>
         	 <s:property value="#request.accountBalance" />
          </s:else>
          </font>RMB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>
        
        <h3>关税押金：<font>
          <s:if test="#request.tariffBalance == '' || #request.tariffBalance == null">
          		0.000
          </s:if>
          <s:else>
         	 <s:property value="#request.tariffBalance" />
          </s:else>
          </font>RMB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3>
        
      
        </div>
        
        
      </div><br/>
      <div class="condition">
          <table width="818" border="0">
            <tr>
               <td colspan="3">创建时间：
                <input name="startdate" type="text" value="<s:property value='#request.startdate'/>" src="${pageContext.request.contextPath}/images/time.png" style="  width:170px;left:-28px;height:24px" class="Wdate" id="startdate" onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" />
                <!--<span style="padding-right:28px; font-size:18px; background:url(${pageContext.request.contextPath}/images/to.png) no-repeat left center;"></span>-->
				&nbsp;&nbsp;截止时间:
                <input name="enddate" type="text" value="<s:property value='#request.enddate'/>" src="${pageContext.request.contextPath}/images/time.png" style=" width:170px; left:-28px;height:24px" class="Wdate" id="enddate" onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" />&nbsp;&nbsp;
                <button class="buttonbg" value="" type="button" onclick="GotoSerachPage();" >查&nbsp;&nbsp;询</button>
                </td>     
               </tr>
          </table>
       </div>
      <div class="balance">
        <div class="r_title">我的账户</div>
   <div class="admin_table" style="OVERFLOW-y: auto;  WIDTH: 876px; HEIGHT: 390px;">
       
  <table width="859" border="0">
  <tr style="background:#edf8fd;font: 12px 宋体;color: #333;" >
    <td  width="79px" height="30px">序号</td>
    <td  width="200px" height="30px">日期</td>
    <td  width="200px" height="30px">备注</td>
    <td  width="90px" height="30px">应收金额</td>
    <td  width="90px" height="30px">实收金额</td>
    <td  width="100px" height="30px">结余</td>
  </tr>
  <s:if test="#request.listFRResults== null">
  <tr>
    <td>--</td>
    <td>--</td>
    <td>--</td>
    <td>--</td>
    <td>--</td>
    <td style="color:#02abee;">--</td>
  </tr>
  </s:if>
  <s:else> 
  
  	<s:iterator var="bean" value="#request.listFRResults" status="index">
  	<s:set value="#index.index" var="varIndex"></s:set>
  	<tr>
	<td height="30px"><s:property value="#index.index + 1" /></td>
	<td height="30px"><s:property value="#bean.OccurDate" /></td>
	<td height="30px"><s:property value="#bean.Remark" /></td>
    <td height="30px"><s:property value="#bean.BillTotal" /></td>
    <td height="30px"><s:property value="#bean.CashTotal" /></td>
    <td style="color:#02abee; height:30px"><s:property value="#bean.BalanceTotal" /></td>
    
    </tr>
    </s:iterator>
  </s:else>
  
</table>
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
        <div class="right"><img src="${pageContext.request.contextPath }/images/tel2.jpg" /></div>
      </div>
    </div>
    <div class="bottom_nav"> <a href="#">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
  
  
 </div>
			

</div>
</form>
</body>
</html>

