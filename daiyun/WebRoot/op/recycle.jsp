<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>订单回收站</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_total.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_page.css"/>
 	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>

  </head>
 <script type="text/javascript">
 	 
       
 </script>
  <body>
  <form id="form1" name="form1" action="" method="post" enctype="multipart/form-data">
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span>13688888888</span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="#">退出</a></span> | <span><a href="#">充值</a></span> | <span><a href="#">English</a></span></div>
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
        <h3><a href="#">我的代运</a> > 我的订单 > <span>订单回收站</span></h3>
        </div>
        <div class="recycle">
      <div class="condition">
          <table width="818" border="0">
            <tr>
              <td width="30%">物流渠道：

                <select name="channel" style="width:170px;">
                  <option value="">----请选择物流渠道----</option>
                  <option value="Y003100"> 澳洲独轮车专线 </option>
                  <option value="Y003140"> 欧洲独轮车专线 </option>
                  <option value="Y003160"> 美国平衡车专线 </option>
                  <option value="A1340"> 全球入口易 </option>
                  <option value="A1614"> HKDGM平邮-P </option>
                  <option value="A1615"> HKDGM挂号-P </option>
                  <option value="H0143"> 自提-预付 </option>
                  <option value="Y0085"> 美国专线 </option>
                  <option value="D0108"> CND大货-P </option>
                  <option value="Y0002"> 欧洲专线 </option>
                  <option value="H0155"> 派件-预付 </option>
                  <option value="D0113"> CND小货-P </option>
                </select></td>
              <td width="40%" align="center">买家 ID ：

                <input name="order" type="text" style="width:165px;" /></td>
              <td width="30%" align="right">卖家 ID ：

                <input name="order" type="text" style="width:165px;" /></td>
            </tr>
            <tr>
              <td width="30%">客户单号：

                <input name="order" type="text" placeholder="输入多个订单号，请用“,”分隔 。" style="width:165px;" /></td>
              <td width="40%" align="center" style="padding-left:43px;">开始时间：
                <input id="starttime" name="time" type="text" style="width:165px;" />
                <input name="time" type="image" src="images/time.png" style=" border:none; width:16px; height:16px; position:relative; left:-30px; overflow:hidden;" /><input name="time" type="image" value="" src="images/time.png" style=" border:none; width:16px; height:16px; position:relative; left:242px;" /></td>
    <td width="30p%" align="right">结束时间：

                <input id="endtime" name="time" type="text" style="width:165px;" />
                
                </td>
            </tr>
           <tr>
              <td width="30%">收货人名字：
                <input name="name" type="text" style="width:153px;" /></td>
               <td width="40%" align="center" style="padding-right:6px;">收货人公司：
                <input name="name" type="text" style="width:160px;" /></td>
                 <td width="30%">服务商单号：
                <input name="name" type="text" style="width:159px;" /></td>
            </tr>
          </table>
        </div>
        <div class="button">
          <button class="buttonbg" value="" type="submit" onclick="GotoSerachPage();">刷新</button>
          <button class="buttonbg" value="" type="submit" onclick="GotoSerachPage();">查询</button>
          <button class="buttonbg" value="" type="submit" onclick="GotoSerachPage();">还原</button>
          <button class="buttonbg" value="" type="submit" onclick="GotoSerachPage();">彻底删除</button>
          <button class="buttonbg" value="" type="submit" onclick="GotoSerachPage();">全部删除</button>
        </div>
        <div class="result">
<table id="attributeval" class="manage_form" style="margin: 0px;" width="1844" cellspacing="1" cellpadding="0" border="0">
						
									<thead>
									<tr style="background:#edf8fd;">
										<td style="text-align: center;" width="72px">
											全选<label>
												<input name="recycleBox" style="width: 20px" onclick="changeCheckBox();" type="checkbox">
											</label>
										</td>
										<td width="150">客户单号</td>
										<td width="118">服务商运单号</td>
										<td width="150">百千诚单号</td>
										<td width="100">运输方式</td>
										<td width="150">目的国家</td>
										<td width="200">收件人</td>										
										<td width="140">上传时间</td>
										<td width="140">申报时间</td>
										<td width="140">打印时间</td>
										<td width="140">收货时间</td>
										<td width="350">收件人公司</td>
										<td width="60">客户重量</td>
										<td width="60">计费重</td>
									</tr>
									</thead>
									<tbody>
									
									
									
										<tr>
									
											<td style="text-align: center;" height="16px">
												<input name="checkbox" value="4763177" id="checkbox" type="checkbox">
											</td>
											<td width="150"><p><a href="#">
											
									 	  DGMGH001</a></p></td>
											<td width="118"><!-- 服务商 -->
												
												RX614675517DE
												
																			
											</td>
											<td width="150">RX614675517DE</td>
											<td width="100">HKDGM挂号-P</td>
											<td width="150">澳大利亚</td>
											<td width="200">Lindsey Mathis</td>											
											<td width="140">2015-03-03 14:35:18.0</td>
											<td width="140"></td>
											<td width="140"></td>
											<td width="140">2015-03-03 14:35:16.0</td>
											<td width="350">.</td>
											<td width="60" align="right">0.369</td>
											<td width="60" align="right">0.369</td>
										</tr>
									
									
										<tr class="manage_form_bk">
									
											<td style="text-align: center;" height="16px">
												<input name="checkbox" value="4763172" id="checkbox" type="checkbox">
											</td>
											<td width="150"><p><a href="/order/queryOrdersDetail?cw_code=4763172&amp;link=recycle">
											
											 	DGMGH004</a></p></td>
											<td width="118"><!-- 服务商 -->
												
												DGMGH004
												
																			
											</td>
											<td width="150">150303550440</td>
											<td width="100">HKDGM挂号-P</td>
											<td width="150">泰国</td>
											<td width="200">Michelle Colna</td>											
											<td width="140">2015-03-03 14:35:10.0</td>
											<td width="140"></td>
											<td width="140"></td>
											<td width="140">2015-03-03 14:35:09.0</td>
											<td width="350">.</td>
											<td width="60" align="right">1.975</td>
											<td width="60" align="right">2.0</td>
										</tr>
									
									
										<tr>
									
											<td style="text-align: center;" height="16px">
												<input name="checkbox" value="7890473" id="checkbox" type="checkbox">
											</td>
											<td width="150"><p><a href="#">
											
									 	  20161011002</a></p></td>
											<td width="118"><!-- 服务商 -->
												
												20161011002
												
																			
											</td>
											<td width="150">161011869298</td>
											<td width="100">SGDHL小货</td>
											<td width="150">加拿大</td>
											<td width="200">t</td>											
											<td width="140">2016-10-11 15:37:12.0</td>
											<td width="140">2016-10-11 15:47:48.0</td>
											<td width="140"></td>
											<td width="140">2016-10-11 15:37:10.0</td>
											<td width="350">xinshou</td>
											<td width="60" align="right">0.5</td>
											<td width="60" align="right">0.5</td>
										</tr>
									
									
										<tr>
									
											<td style="text-align: center;" height="16px">
												<input name="checkbox" value="7901496" id="checkbox" type="checkbox">
											</td>
											<td width="150"><p><a href="#">
											
									 	  20161012008TEST</a></p></td>
											<td width="118"><!-- 服务商 -->
												
												20161012008TEST
												
																			
											</td>
											<td width="150">161012884888</td>
											<td width="100">DHL测试产品</td>
											<td width="150">英国</td>
											<td width="200">test</td>											
											<td width="140">2016-10-12 17:02:50.0</td>
											<td width="140"></td>
											<td width="140"></td>
											<td width="140">2016-10-12 17:02:49.0</td>
											<td width="350">test</td>
											<td width="60" align="right">2.0</td>
											<td width="60" align="right">2.0</td>
										</tr>
									
									
										<tr class="manage_form_bk2">
									
											<td style="text-align: center;" height="16px">
												<input name="checkbox" value="7901471" id="checkbox" type="checkbox">
											</td>
											<td width="150"><p><a href="#">
											
									 	  2016101207TEST</a></p></td>
											<td width="118"><!-- 服务商 -->
												
												2016101207TEST
												
																			
											</td>
											<td width="150">161012884786</td>
											<td width="100">DHL测试产品</td>
											<td width="150">英国</td>
											<td width="200">test</td>											
											<td width="140">2016-10-12 16:54:04.0</td>
											<td width="140"></td>
											<td width="140"></td>
											<td width="140">2016-10-12 16:54:04.0</td>
											<td width="350">test</td>
											<td width="60" align="right">2.0</td>
											<td width="60" align="right">2.0</td>
										</tr>
									
									
										<tr class="manage_form_bk">
									
											<td style="text-align: center;" height="16px">
												<input name="checkbox" value="7901456" id="checkbox" type="checkbox">
											</td>
											<td width="150"><p><a href="#">
											
									 	  20161012006TEST</a></p></td>
											<td width="118"><!-- 服务商 -->
												
												20161012006TEST
												
																			
											</td>
											<td width="150">161012884769</td>
											<td width="100">DHL测试产品</td>
											<td width="150">英国</td>
											<td width="200">test</td>											
											<td width="140">2016-10-12 16:50:26.0</td>
											<td width="140"></td>
											<td width="140"></td>
											<td width="140">2016-10-12 16:50:24.0</td>
											<td width="350">test</td>
											<td width="60" align="right">2.0</td>
											<td width="60" align="right">2.0</td>
										</tr>
									
									
										<tr class="manage_form_bk2">
									
											<td style="text-align: center;" height="16px">
												<input name="checkbox" value="7995765" id="checkbox" type="checkbox">
											</td>
											<td width="150"><p><a href="#">
											
									 	  129-4407093-7023429</a></p></td>
											<td width="118"><!-- 服务商 -->
												
												129-4407093-7023429
												
																			
											</td>
											<td width="150">161025024839</td>
											<td width="100">CND特惠-D</td>
											<td width="150">加拿大</td>
											<td width="200">E Tzxcaugh</td>											
											<td width="140">2016-10-25 10:10:16.0</td>
											<td width="140"></td>
											<td width="140"></td>
											<td width="140">2016-10-25 10:10:15.0</td>
											<td width="350">A etst</td>
											<td width="60" align="right">0.5</td>
											<td width="60" align="right">0.5</td>
										</tr>
									
									
										<tr class="manage_form_bk">
									
											<td style="text-align: center;" height="16px">
												<input name="checkbox" value="7995767" id="checkbox" type="checkbox">
											</td>
											<td width="150"><p><a href="#">
											
									 	  129-4407093-7023428</a></p></td>
											<td width="118"><!-- 服务商 -->
												
												129-4407093-7023428
												
																			
											</td>
											<td width="150">161025024840</td>
											<td width="100">CND特惠-D</td>
											<td width="150">加拿大</td>
											<td width="200">asadtas A</td>											
											<td width="140">2016-10-25 10:10:18.0</td>
											<td width="140"></td>
											<td width="140"></td>
											<td width="140">2016-10-25 10:10:17.0</td>
											<td width="350">E test</td>
											<td width="60" align="right">0.5</td>
											<td width="60" align="right">0.5</td>
										</tr>
									
									
										<tr class="manage_form_bk2">
									
											<td style="text-align: center;" height="16px">
												<input name="checkbox" value="7995768" id="checkbox" type="checkbox">
											</td>
											<td width="150"><p><a href="#">
											
									 	  1334-3837409-1203448</a></p></td>
											<td width="118"><!-- 服务商 -->
												
												1334-3837409-1203448
												
																			
											</td>
											<td width="150">161025024841</td>
											<td width="100">CND特惠-D</td>
											<td width="150">美国</td>
											<td width="200">JEAN</td>											
											<td width="140">2016-10-25 10:10:20.0</td>
											<td width="140"></td>
											<td width="140"></td>
											<td width="140">2016-10-25 10:10:19.0</td>
											<td width="350">.</td>
											<td width="60" align="right">0.5</td>
											<td width="60" align="right">0.5</td>
										</tr>
									</tbody>
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
