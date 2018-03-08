<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="kyle.common.util.jlang.DateFormatUtility"%>
<%@page import="kyle.common.util.jlang.StringUtility"%>
<%@page import="kyle.common.util.jlang.DateUtility"%>
<%@taglib uri = "/project" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>个人中心</title>
		<link rel="stylesheet" type="text/css" href="../style/Forwarding_total.css"/>
		<link rel="stylesheet" type="text/css" href="../style/Forwarding_page.css"/>
		<script type="text/javascript" src="../js/jquery-1.4.2.js"></script>
<script >
	/*function loginout(){
		if(confirm("确认退出当前用户")){
			document.getElementById("myform").action="/daiyun/order/loginout";
			document.getElementById("myform").target="";
			document.getElementById("myform").submit();	
		}	
		return false;
	}*/
	function checkCertification(){
		//认证了的是蓝色，未认证的是灰色


			
	}
	var chongzhi = function (){//充值


		var location = (window.location+'').split('/');
		var basePath = location[0]+'//'+location[2]+'/'+location[3];
		setTimeout("window.open('${pageContext.request.contextPath}/op/recharge.jsp')",1000);
	}

</script>

<style type="text/css">
a{color:#333333;text-decoration:none;}
.pageNav { text-align:right; margin-top:10px; height:26px; padding:3px 0px;color: #000000;}
.pageNav a { display:inline; border:1px solid #ccc; height:20px; line-height:20px; margin-left:5px; padding:2px 7px;}
.pageNav a:hover { border:1px solid #3a739d; text-decoration:none; color:#3a739d; background:#f6fbff;}
</style>

	</head>
<body style="">
<form action="" method="post" name="myform" id="myform" style="">
	<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="${pageContext.request.contextPath}/order/loginout" >退出</a></span> | <span><a href="${pageContext.request.contextPath}/op/recharge.jsp" target="_blank">充值</a></span> | <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="${pageContext.request.contextPath}/images/logo.jpg" /></div>
        <div class="right"><img src="${pageContext.request.contextPath}/images/tel.jpg" /></div>
      </div>
      <div class="nav">
      	<jsp:include page="../pg/include/main_menu.jsp"></jsp:include>
        <div class="nav_last"><a href="${pageContext.request.contextPath }/userinfo"><img src="${pageContext.request.contextPath }/images/my_nav.jpg"></a></div>
      </div>
    </div>
  </div>
  <div class="forwarding">
     <jsp:include page="../op/tree.jsp" />
      <jsp:include page="../sf/QQCommunicate.jsp" />
    <div class="right">
          <div class="home">
        	<h3><a >我的代运</a> > 我的订单 > <span>个人中心</span>  </h3>
        	</div>
    
      <div class="member">
        <div class="member_nir">
          <div class="left">
            <div class="personal">
              <div class="portrait"><img src="/daiyun/images/m_head.png" /></div>
              <p><strong style="color:#d42c96; padding-right:15px;"><%=session.getAttribute("Opname")%></strong>欢迎回来！<span class="exit"><a href="${pageContext.request.contextPath}/order/loginout" >退出登录</a></span></p>
              <p>上次登录时间：<s:property value="#request.currentTime"/></p>
              <ul>
                <li class="m_phone"><a href="${pageContext.request.contextPath }/queryByOpId">手机认证</a></li>
                <li class="m_phone"><a href="${pageContext.request.contextPath}/queryByOpId">邮箱认证</a></li>
                <li class="m_personal"><a href="${pageContext.request.contextPath }/queryByOpId">实名认证</a></li>
              </ul>
              <!-- <div class="unread"><span>优惠券 <a href="#">(0)</a></span>|<span>未读消息 <a href="#">(3)</a></span></div> -->
              <div class="clear"></div>
              <div class="sum">
                <p></p>
                <table width="478" border="0">
                
                  <tr>
                    <td width="20%"></td>
                    <td width="80%">账户余额：<span style=" color:#d42c96;"></span><s:property value="#request.balance"/>元 (两个月内)</td>
                    <td width="20%"></td>
                  </tr>
                  <!-- <tr>
                    <td width="20%"></td>
                    <td width="80%">未出账费用：<span style=" color:#d42c96;"></span><s:property value="#request.total"/>元 (两个月内)</td>
                    <td width="20%"></td>
                  </tr> -->
                  <tr>
                    <td width="20%">&nbsp;</td>
                    <td width="40%"><button class="up" type="button" onclick="chongzhi();" style="background:url(/daiyun/images/top_up.png) no-repeat; border:none; width:101px; height:37px;"></button></td>
                    <!-- <td width="40%"><button class="up" type="button" onclick="tixian();" style="background:url(/daiyun/images/withdrawal.png) no-repeat; border:none; width:101px; height:37px;"></button></td> -->
                    <td width="20%">&nbsp;</td>
                  </tr>			
                </table>
              </div>
            </div>
          </div>
          <div class="right">
            <div class="process">
              <table width="322" border="0">
  <tr>
    <td align="center" width="77px;"><a href="${pageContext.request.contextPath }/pg/member/newOrder.jsp">单票下单</a></td>
    <td align="center"><a href="${pageContext.request.contextPath }/order/ERPImportUI">从ERP导入</a></td>
    <td align="center" width="77px;"><a href="${pageContext.request.contextPath }/op/upload.jsp">批量上传</a></td>
  </tr>
  <tr>
    <td width="77px;"></td>
    <td align="center"><a href="${pageContext.request.contextPath }/order/queryTransientOrders?link=transient">新建状态</a></td>
    <td align="center" width="77px;"><a href="${pageContext.request.contextPath }/order/queryRecycleOrders?link=recycle">订单回收站</a></td>
  </tr>
  <tr>
    <td></td>
    <td align="center"><a href="${pageContext.request.contextPath }/order/queryDeclaredOrders?link=declared">确认状态</a></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td align="center"><a href="${pageContext.request.contextPath }/order/queryPrintedOrders?link=printed">已打印</a></td>
    <td></td>
  </tr>
  <tr>
    <td></td>
    <td align="center"><a href="${pageContext.request.contextPath }/order/queryAllocateOrders?link=allocate">已配货</a></td>
    <td></td>
  </tr>
</table>

            </div>
          </div>
          <div class="clear"></div>
        </div>
        <div class="recent_order">
        <div class="r_title">一周内订单</div>
        <table width="860" border="0" style=" text-align:center; line-height:24px; border-collapse:collapse;">
  <tr style="background:#edf8fd;">
    <td>类别</td>
    <td>新建</td>
    <td>已申报</td>
    <td>已打印</td>
    <td>已收货</td>
  </tr>
  <tr>
    <td>快递</td>
     <s:if test="#request.express==null">
	    <td>0</td>
	    <td>0</td>
	    <td>0</td>
	    <td>0</td>
      </s:if>
      <s:else>
      	<s:set var="bean" value="#request.express"/>
        <td><s:property value="#bean.Newcreate"/></td>
	    <td><s:property value="#bean.Trans"/></td>
	    <td><s:property value="#bean.Print"/></td>
	    <td><s:property value="#bean.Recevie"/></td>
        
      </s:else>
    
  </tr>
  <tr>
    <td>小包</td>
      <s:if test="#request.xiaobao==null">
	    <td>0</td>
	    <td>0</td>
	    <td>0</td>
	    <td>0</td>
      </s:if>
      <s:else>
      	<s:set var="bean" value="#request.xiaobao"/>
        <td><s:property value="#bean.Newcreate"/></td>
	    <td><s:property value="#bean.Trans"/></td>
	    <td><s:property value="#bean.Print"/></td>
	    <td><s:property value="#bean.Recevie"/></td>
      </s:else> 
      
  </tr>
  <tr>
    <td>专线</td>
   
     <s:if test="#request.zhuanxian==null">
	    <td>0</td>
	    <td>0</td>
	    <td>0</td>
	    <td>0</td>
      </s:if>
      <s:else>
      	<s:set var="bean" value="#request.zhuanxian"/>
      	<s:set var="startdate" value="@com.daiyun.util.TimeUtil@getWeekStartTime()"/>
      	<s:set var="enddate" value="@com.daiyun.util.TimeUtil@getWeekEndTime()"/>
        <td><a href="${pageContext.request.contextPath }/order/queryTransientOrders?link=transient&startdate=<s:property value='#startdate'/>&enddate=<s:property value='#enddate'/>"><s:property value="#bean.Newcreate"/></a></td>
	    <td><a href="${pageContext.request.contextPath }/order/queryDeclaredOrders?link=declared&startdate=<s:property value='#startdate'/>&enddate=<s:property value='#enddate'/>"><s:property value="#bean.Trans"/></a></td>
	    <td><a href="${pageContext.request.contextPath }/order/queryPrintedOrders?link=printed&startdate=<s:property value='#startdate'/>&enddate=<s:property value='#enddate'/>"><s:property value="#bean.Print"/></a></td>
	    <td><a href="${pageContext.request.contextPath }/order/queryReceivedOrders?link=received&startdate=<s:property value='#startdate'/>&enddate=<s:property value='#enddate'/>"><s:property value="#bean.Recevie"/></a></td>
      </s:else> 
    
  </tr>
</table>

        </div>
        <div class="recent_order">
        <div class="r_title">当天订单</div>
        <table width="860" border="0" style=" text-align:center; line-height:24px; border-collapse:collapse;">
  <tr style="background:#edf8fd;">
    <td>客户单号</td>
    <td>服务商单号</td>
    <td>运输方式</td>
    <td>起运城市</td>
    <td>重量</td>
    <td>订单状态</td>
    <td>收件人</td>
    <td>目的国家</td>
  </tr>
  <s:if test="#request.currentList == null || #request.currentList.size()==0">
  <tr>
    <td>--</td>
    <td>--</td>
    <td>--</td>
    <td>--</td>
    <td>--</td>
    <td>--</td>
    <td>--</td>
    <td>--</td>
  </tr>
  </s:if>
  <s:else>
  	<s:iterator var="bean"  value="#request.currentList">
  	<tr>
	 	<td width=125 class="tab6">
			<s:if test="#bean.Originorderid==null">
 			<s:property value="#bean.Cwcw_customerewbcode" /></s:if><s:else>
 			<s:property value="#bean.Cwcw_customerewbcode" />&nbsp;<s:property value="#bean.Originorderid" /></s:else></a>
 		</td>
   		<td><!-- 服务商 -->
			<s:if test="#bean.Pkpk_showserverewbcode == null || #bean.Pkpk_showserverewbcode.equals(\"Y\")">
			<s:property value="#bean.Cwcw_serverewbcode" />
			</s:if>
			<s:else>
			<s:property value="#bean.Cwcw_ewbcode" /></p>
			</s:else>							
		</td>
	    <td><s:property value="#bean.Pkpk_sename" /></td><!-- 运输方式 -->
	    <td><s:property value="#" /></td><!--Cwdt_code_signin是起运城市id -->
	  
	    <td><s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_customerchargeweight)" /></td>
	    <td><s:property value="#bean.Cwscws_name" /></td>
	    
	    <td><s:property value="#bean.Hwhw_consigneename" /></td>
	    <td><s:property value="#bean.Dtdt_name" /></td>
  	</tr>
  	</s:iterator>
  </s:else>
  <!-- 分页  -->
</table>
		<div>
			<div style="float: right;" class="pageNav" style="margin-right: 10px">
				<p:pager url="userinfo" />
			</div>	
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
        <div class="right"><img src="/daiyun/images/tel2.jpg" /></div>
      </div>
    </div>
    <div class="bottom_nav"> <a href="#">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
</div>
	
	
	
	
	</form>
	</body>
</html>
