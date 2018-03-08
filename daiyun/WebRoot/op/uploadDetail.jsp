<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>查询详情</title>

		<link rel="stylesheet" type="text/css" href="style/Forwarding_total.css"/>
		<link rel="stylesheet" type="text/css" href="style/Forwarding_page.css"/>
<script type="text/javascript">


</script>
</head>
<body>

	<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="${pageContext.request.contextPath }/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath }/op/recharge.jsp" target="_blank">充值</a></span> | <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="${pageContext.request.contextPath }/images/logo.jpg" /></div>
        <div class="right"><img src="${pageContext.request.contextPath }/images/tel.jpg" /></div>
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
        <h3>我的代运 > 我的订单 > <span>日志详情</span></h3>
      </div>
      <div class="balance">
        <div class="r_title">查询详情</div>
        <div class="nir2">
        <p>日志编号：${importLog.toccwlid }，录入时间：${importLog.toccwlcreatedate }</p><br />
        <p><font color="" size="2">${importLog.toccwlremark }</font>
		</p><br />
          <h3>总共有<font>${importLog.toccwltotalrecords } </font>条数据，
          	成功导入<font>${importLog.toccwltotalrecords - importLog.toccwlunsuccessfulrecords }</font>条，
          	失败订单<font>${importLog.toccwlunsuccessfulrecords }</font>条。</h3>
          
        <div class="clear"></div>
        </div>
      </div>
      <div class="button">
          <button class="buttonbg" value="" type="button" onclick="location.href='LogI'">返回</button>
        </div>
        <div class="center_table">
        <table width="860" border="0">
          <thead style="background:#edf8fd;">	
                   		<tr>	 
							<td width="30" class="tab4"><strong>编号</strong></td>							
							<td width="30" class="tab4"><strong>是否成功</strong></td>
							<td width="180" class="tab4"><strong>备注</strong></td>
						</tr>													
			</thead>
			<tbody id="info">
					<tr>	
						<s:if test="#request.results.size == 0">
							<tr class="manage_form_bk"><td colspan="3">抱歉，没有查询到数据!</td></tr>
						</s:if>
						<s:iterator var="bean" value="#request.results" status="stat">		
							<tr>		
								<td width="30" ><s:property value="#bean.Cwbrcomp_idcwbrid" /></td>									
								<td width="30" >
									<s:if test='"C".equals(#bean.Cwbrcwbrsuccesssign)'>导入成功</s:if>
									<s:else><font color="N">导入失败</font></s:else>
								</td>													
								<td width="180" ><s:property value="#bean.Cwbrcwbrremark" /></td>
							</tr>
						</s:iterator>
							</tr>
					</tbody>
			
           
          </table>
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


</body>
</html>
