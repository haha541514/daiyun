<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="kyle.leis.fs.authoritys.user.da.UserColumns"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>账户充值</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.qrcode.min.js"></script> 
  </head>

		<script type="text/javascript">
			var Timeout=null;
			function change(){
				document.getElementById("erweima").style.display='none';
				document.getElementById("zfb").style.display='';
				document.getElementById("wx").style.display='none'
		   		document.getElementById("ts").style.display='none';
				document.getElementById("wxbutton").style.display='none';	
			    document.getElementById("alipaybutton").style.display='';
			    document.getElementById("zjbj").style.backgroundImage='url(${pageContext.request.contextPath}/order_images/order_bg.png';
	 		    document.getElementById("wx2bj").style.backgroundImage='url(${pageContext.request.contextPath}/order_images/order_bg01.png';
	 			clearTimeout(Timeout); 
			}
	 		function alipay(){
			var amount= document.getElementById("amount").value;
			document.getElementById("alipaybutton").style.display='none';
			document.getElementById("ts2").style.display='';
 	 		if(amount==null||amount==""){
					alert('请输入充值金额');
					document.getElementById("alipaybutton").style.display='';
					document.getElementById("ts2").style.display='none';
					return false;
				}
			document.getElementById("alipayamount").value=amount;
		    	
		    $.ajax({
      		type: "post",       
            dataType:"text",
            url:"AlipayAction",    
            data:{"rechargeAmount":amount},   
            success: alipayTs});	  
		    }
		    function alipayTs(data){   
		      alert("请支付完成跳转至结果页面再关闭浏览器");
		      document.alipayform.submit();    
	     
		    }
		    function change2(){
		     document.getElementById("alipaybutton").style.display='none';
		     document.getElementById("wxbutton").style.display='';
			 document.getElementById("zfb").style.display='none';
			 document.getElementById("wx").style.display='';
			 document.getElementById("erweima").style.display='none';
			 document.getElementById("ts").style.display='none';
			 document.getElementById("wx2bj").style.backgroundImage='url(${pageContext.request.contextPath}/order_images/order_bg.png';
	 		 document.getElementById("zjbj").style.backgroundImage='url(${pageContext.request.contextPath}/order_images/order_bg01.png';
	 		 clearTimeout(Timeout); 
		    }
		    function wxpay(){
		    document.getElementById("ts2").style.display='';
		    document.getElementById("wxbutton").style.display='none';
			var amount= document.getElementById("amount").value;
 	 		if(amount==null||amount==""){
					alert('请输入充值金额');
					document.getElementById("wxbutton").style.display='';
					document.getElementById("ts2").style.display='none';
					return false;
				}
			$.ajax({
      		type: "post",       
            dataType: "text",
            url:"WeChatAction",    
            data:{"rechargeAmount":amount},   
            success: doCheckSuccess });
            
            Timeout=setTimeout("myTimeout()",120000);//1000为1秒钟
			}
			 function doCheckSuccess(data){  	  
				$('#erweima').html("");
				$("#erweima").qrcode({ 
				   render:"table",
   				   text:data ,
  				   width: 180, //宽度 
  				   height:180 ,//高度 	
				 }); 		
  				  document.getElementById("erweima").style.display='';
				  document.getElementById("ts").style.display='';
				  document.getElementById("ts2").style.display='none';
    		}
           
    	
      		function myTimeout(){
    		  document.getElementById("erweima").style.display='none';
           	  document.getElementById("ts").style.display='none';
           	  document.getElementById("wxbutton").style.display='';
      		}	
 	 
  
		</script>

 
  <body>
<form action="${pageContext.request.contextPath}/alipay/alipayapi.jsp" name="alipayform" method="post">
	<input type="hidden" name="total_fee"  id="alipayamount"/>
  	<input type="hidden" name="strCocode" value="<%=session.getAttribute("Cocode")%>" />
  	<input type="hidden" name="opId" value="<%=session.getAttribute("OpId")%>" />
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
       <div class="right"><span><a href="${pageContext.request.contextPath}/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath}/op/recharge.jsp" target="_blank">充值</a></span>| <span><a href="#">English</a></span></div>
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
        <h3>我的代运  > 我的账户 > <span>账户充值</span></h3>
      </div>
    <div class="recharge">
        <div class="r_title">账户充值</div>
        <div class="nir">
          <div class="money">充值金额：
            <input id="amount" name="rechargeAmount" type="text" style="width:195px;color: black;" />
            <font>RMB(¥)</font><span>(请输入整数或精确到分) </span></div>
          <div class="money">充值账户：
            <input name="money" type="text"  readonly="readonly" style="width:195px;color: black;" value="<%=session.getAttribute("Opcode")%>"  />
          </div>
          <div class="headline">
            <ul>
        	   <li id="alipaybj"><a href="javascript:change()" id="zjbj" style=" color:#333; display:block; width:85px; height:28px; background:url(${pageContext.request.contextPath}/images/order_bg.png);" >支付宝</a></li>
               <li  id="wxbj"><a href="javascript:change2()" id="wx2bj">微信支付</a></li>
	        </ul>
          </div>
          
          <div class="payment" >
            <div class="left" style=" padding-top:20px;float:left">
              <div class="pay" style="float:left"><span>支付方式：</span> </div >
              <div id="zfb"  style="float:left">
              <img src="${pageContext.request.contextPath}/images/alipay.png" width="180px" height="180px" />
              </div>
				<div id="wx" style="display: none;float:left" >
					 <img src="${pageContext.request.contextPath}/images/WeChat.png" />
				</div>
			   <div style="padding-left:60px;padding-top:30px;float:left" >
                <button id="wxbutton" style="display: none;" class="button2" type="button" onclick="wxpay();" >确定充值</button>
                <button  id="alipaybutton" class="button2" type="button" onclick="alipay();" >确定充值</button>
                <p id="ts2"  style="display: none;color:#02abee; font-weight:bold;font-size:16px;">正在充值，请稍后 </p>
               </div>
           	  </div>
           	  <div class="right" >
 				   <div id="erweima" style="display: none; "></div>
					 	 <p id="ts"  style="display: none; ">
					 	 	请使用微信扫一扫完成支付，<br />
					 	 	二维码2分钟后消失,<br />
					 	 	充值成功后五分钟内金额到账!
					 	 </p></div>
			 	 	 
       		</div>
       		
            <div class="clear"></div>
          </div><br/>
         
          <table class=yhtable width="100%" cellpadding="0" cellspacing="0" bordercolor="#00BFFF" border="1" >
									<tr style="background:#1E90FF;text-align:center; ">
										<td style="font-size:18px;font-weight:bold;height:30px;color:#FFFAFA;" >开户银行</td>
										<td style="font-size:18px;font-weight:bold;height:30px;color:#FFFAFA;">我司户名</td>
										<td style="font-size:18px;font-weight:bold;height:30px;color:#FFFAFA;">我司账号</td>
									</tr>
									<tr style="text-align:center; " >	
										<td style="font-size:15px;height:30px;">中国银行深圳机场支行</td>
										<td style="font-size:15px;height:30px;">深圳市代运物流网络有限公司</td>
										<td style="font-size:15px;height:30px;">7692&nbsp;6777&nbsp;2660</td>
									</tr>
          	 </table><br/>
          	 	<div style="border:1px dashed red; ">
               	  <p style=" color:red;font-size:14px;padding:10px 10px 10px 10px">
               	     开发票说明：<br/>
               	  1、公司客户可开具增值税普通发票、增值税专用发票。<br/>
               	  2、公司客户如需开具增值税普通发票，请提供单位名称、地址、纳税识别号、固定电话、开户银行及账号；如需开具增值税专用发票，<br/>&nbsp;&nbsp;&nbsp;除提供前述资料，还需提供一般纳税人的证明资料（一般纳税人认定通知书或认定为一般纳税人的税务事项告知书）。<br/>
               	  3、个人客户只能开具增值税普通发票，如需开票，请提供开票信息。<br/>
               	  4、我司提供指定地点的上门取票服务，如需快递，费用自担。<br/>
               	  5、倡议有条件的客户自主打印电子发票。<br/>
               	  6、所有开票客户需签订网上固定条款、格式的协议，如有补充条款，请联系我司业务人员。<br/>
               	  7、除未按提供的信息开票外，发票一经开出，不得退票。	  </p>	
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
