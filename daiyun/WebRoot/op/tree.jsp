<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>菜单栏</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_total.css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_page.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/order.js"></script>
	<SCRIPT type="text/javascript">
		function remind(){
			alert("功能正在完善中，敬请期待");
			 return false;
		}
	</SCRIPT>

</head>

<body>
   <div class="forwarding">
    <div class="left">
      <div class="title"><a href="${pageContext.request.contextPath}/userinfo">我的代运</a></div>
      <div class="list" id="guide">
          <div class="title01 tit" >我的订单<span class="icon"></span></div>
          <ul  id="title01">
            <li><a href="${pageContext.request.contextPath}/userinfo">个人中心</a></li>
            <li><a href="${pageContext.request.contextPath}/pg/member/newOrder.jsp">单票下单</a></li>
            <li><a href="${pageContext.request.contextPath}/op/upload.jsp">批量上传</a></li>
            <li><a href="${pageContext.request.contextPath }/order/ERPImportUI">ERP接口订单</a></li>
            <li><a href="${pageContext.request.contextPath }/order/queryTransientOrders?link=transient">订单管理</a></li>
			<li><a href="${pageContext.request.contextPath }/order/queryRecycleOrders?link=recycle">订单回收站</a></li>
			          
          </ul>
          <div class="title02 tit"  >订单辅助<span class="icon"></span></div>
          <ul  id="title02" >
            <li><a href="${pageContext.request.contextPath }/order/BillLoading">提货单管理</a></li>
            <li><a href="${pageContext.request.contextPath}/op/problem.jsp">问题件管理</a></li>
            <li><a href="${pageContext.request.contextPath}/queryShipperInfo">地址管理</a></li> 
            <li><a href="${pageContext.request.contextPath}/costBudget?op=Budget">运费测算</a></li>
            <li><a href="${pageContext.request.contextPath}/op/dyqueryTrack.jsp">轨迹追踪</a></li>
          </ul>
          <div class="title03 tit" >我的账户<span class="icon"></span></div>
          <ul id="title03"  >
            <li><a href="${pageContext.request.contextPath}/order/queryBalance">账户余额</a></li>
            <li><a href="${pageContext.request.contextPath}/op/recharge.jsp" target="_blank">账户充值</a></li>
            <li><a href="${pageContext.request.contextPath}/order/queryBillRecord">账单查询</a></li>
            <li><a href="${pageContext.request.contextPath}/sf/CostOFQuery">费用查询</a></li>
            <li><a href="${pageContext.request.contextPath}/op/refundQuery">退款申请</a></li>
            <li><a href="${pageContext.request.contextPath}/op/applyreceiptrecordQuery">发票申请</a></li>
            <li><a href="${pageContext.request.contextPath}/Price_Query">价格查询</a></li>
          </ul>
          <div class="title04 tit"  >我的信息<span class="icon"></span></div>
          <ul id="title04" >
            <li><a href="${pageContext.request.contextPath}/queryByOpId">我的资料</a></li>
            <li><a href="${pageContext.request.contextPath}/queryCompanyByOpId">公司资料</a></li>
            <li><a href="${pageContext.request.contextPath}/queryRoleByOpCode">权限分配</a></li>
               <li><a href="${pageContext.request.contextPath}/pg/member/RoleMenu.jsp">角色配置</a></li> 
            <li><a href="${pageContext.request.contextPath}/queryUsersByCocode">员工管理</a></li>
      
            <li><a href="${pageContext.request.contextPath}/pg/member/changepassword.jsp">修改密码</a></li>
            <li><a href="${pageContext.request.contextPath}/order/loginout">退出系统</a></li>
         
          </ul>
        </div>
    </div>
    </div>
</body>
</html>			