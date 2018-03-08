<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="com.daiyun.dax.WebDemand" %>
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
    
 <link rel="stylesheet" type="text/css" href="<%=path%>/style/index.css"/>
<link rel="stylesheet" type="text/css" href="<%=path%>/style/total.css"/>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/banner.js"></script>
<title>代运物流网站</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  <SCRIPT type="text/javascript">
  //轨迹查询验证
function checkTrackForm() {
	var queryCode = document.getElementById("queryCode").value;
	if (checkNull(queryCode)) {
		alert("运单号不为能空，请输入运单号!");
		return false;
	}
	document.queryTrackForm.submit();
}

function changeValidateCode(obj) 
		{
	    //获取当前的时间作为参数，无具体意义

	    var timenow = new Date().getTime();
	    //每次请求需要一个不同的参数，否则可能会返回同样的验证码
	    //可能和浏览器的缓存机制有关系
	    obj.src="util/ValidateImage?d="+timenow;
   	 	}
   	 	function clearInfo()
    	{
	    document.getElementById("userName").value = "";
	    document.getElementById("password").value = "";
	    document.getElementById("validateCode").value = "";	    
		}
	function setTab(name,cursel,n){
			for(i=1;i<=n;i++){
			var menu=document.getElementById(name+i);/* zzjs1 */
			var con=document.getElementById("con_"+name+"_"+i);/* con_zzjs_1 */
			menu.className=i==cursel?"hover":"";/*三目运算 等号优先*/
			con.style.display=i==cursel?"block":"none";
			}
		}
		
		</SCRIPT>
  </head>
  <body onload="changeTopmenu(0)">

<div id="main">
  <form action="login" method="post">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left"></div>
        <div class="right"><span><a href="<%=path%>/pg/member/login.jsp">登录</a></span> | <span><a href="<%=path%>/pg/member/Register.jsp">注册</a></span> | <span><a href="#">充值</a></span> | <span><a href="#">English</a></span></div>
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
    <div class="banner_bg">
      <div class="banner">
        <ul class="nav_img">
          <li><a href=""><img src="images/banner.jpg" alt=""></a></li>
          <li><a href=""><img src="images/banner.jpg" alt=""></a></li>
          <li><a href=""><img src="images/banner.jpg" alt=""></a></li>
        </ul>
        <ul class="nav_banner">
          <li ><a title="" href=""></a></li>
          <li><a title="" href=""></a></li>
          <li><a title="" href=""></a></li>
        </ul>
      </div>
    </div>
  </div>
  <div id="center">
    <div class="userbg">
      <div class="user">
        <div class="left">用户名
          <input name="OperCode" type="text" size="" />
     	     密码
          <input name="Word" type="text" size="" />
        </div>
        <div class="right"><span class="anniu">
          <button class="user_login" type="submit" ></button>
          </span><span><a href="#">立即注册</a> | <a href="#">忘记密码？</a></span></div>
      </div>
    </div>
    </form>
    <div class="center">
      <div class="left"> 
        <div id="tab">
          <div class="tabList">
            <ul>
              <li class="hover" id="product1" onmousemove="setTab('product',1,3)" ><a href="" target="_blank">国际快递</a></li>
              <li id="product2" onmousemove="setTab('product',2,3)"><a href="" target="_blank">国际小包</a></li>
              <li id="product3" onmousemove="setTab('product',3,3)" style="margin:0;"><a href="" target="_blank">国际专线机</a></li>
            </ul>
          </div>
          <div class="tabCon">
            <div class="product_list" id="con_product_1">
              <div class="cur">
                <ul>
                  <li class="lia">
                    <input type="text" value="深圳市[Shenzhen]"  class="input_1" name="form" id="CodeBox1"/>
                  </li>
                  <li class="lia">
                    <input type="text" value="请输入目的国家"  class="input_1" name="to" id="CodeBox2"/>
                  </li>
                  <li class="lia">
                    <input type="text" value="请输入计费重(kg)"  class="input_2" name="weight" id="CodeBox3"/>
                    <span class="con_package" id="sppackage"> <em>包裹类型：</em>
                    <input type="radio" class="middle" name="rdoPackageType" value="1"  checked="checked" />
                    <label for="rdoPackageType_1">包裹</label>
                    &nbsp;
                    <input type="radio" class="middle" name="rdoPackageType" value="2" />
                    <label for="rdoPackageType_2">文件</label>
                    </span> </li>
                  <li class="goods">
                    <h3>货物种类：</h3>
                    <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    普货</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    纺织品</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    内置电池</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    配套电池</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    移动电源</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    手机</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    电子烟</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    木箱</span> </li>
                  <li class="bot"> <span class="bot_01"><a href="#">不接货物</a></span> <span class="bot_02"><a href="#">国家禁运品声明</a></span>
                    <button class="order" type="submit" onclick="GotoSerachPage();"></button>
                  </li>
                </ul>
              </div>
            </div>
            <div class="product_list" id="con_product_2">
              <div class="cur">
                <ul>
                  <li class="lia">
                    <input type="text" value="深圳市[Shenzhen]"  class="input_1" name="form" id="CodeBox1"/>
                  </li>
                  <li class="lia">
                    <input type="text" value="请输入目的国家"  class="input_1" name="to" id="CodeBox2"/>
                  </li>
                  <li class="lia">
                    <input type="text" value="请输入重量(kg)"  class="input_1" name="weight" id="CodeBox3"/>
                  </li>
                  <li class="goods">
                    <h3>货物种类：</h3>
                    <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    普货</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    纺织品</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    内置电池</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    配套电池</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    移动电源</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    手机</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    电子烟</span> <span>
                    <input class="middle" name="" type="checkbox" style="margin-right:10px;">
                    木箱</span> </li>
                  <li class="bot"> <span class="bot_01"><a href="#">不接货物</a></span> <span class="bot_02"><a href="#">国家禁运品声明</a></span>
                    <button class="order" type="submit" onclick="GotoSerachPage();"></button>
                  </li>
                </ul>
              </div>
            </div>
            <div class="product_list" id="con_product_3">
              <div class="cur">
                <ul>
                  <li class="lia">
                    <input type="text" value="深圳市[Shenzhen]"  class="input_1" name="form" id="CodeBox1"/>
                  </li>
                  <li class="lia">
                    <input type="text" value="请输入目的国家"  class="input_1" name="to" id="CodeBox2"/>
                  </li>
                  <li class="lia">
                    <input type="text" value="请输入体积重，重量中的最大值"  class="input_1" name="weight" id="CodeBox3"/>
                  </li>
                  <li class="bot"> <span class="bot_01"><a href="#">不接货物</a></span> <span class="bot_02"><a href="#">国家禁运品声明</a></span>
                    <button class="order" type="submit" onclick="GotoSerachPage();"></button>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <div class="tool">
          <div class="title">
            <h3>物流工具</h3>
          </div>
          <div class="nir">
            <ul>
              <li><a href="#"><img src="images/tool_01.png" /><span>下单流程</span></a></li>
              <li><a href="#"><img src="images/tool_02.png" /><span>送货地址</span></a></li>
              <li><a href="#"><img src="images/tool_03.png" /><span>代运取货</span></a></li>
              <li><a href="#"><img src="images/tool_04.png" /><span>模板下载</span></a></li>
              <li><a href="#"><img src="images/tool_05.png" /><span>计费重计算</span></a></li>
              <li><a href="#"><img src="images/tool_06.png" /><span>帮助中心</span></a></li>
              <li><a href="#"><img src="images/tool_07.png" /><span>外贸工具</span></a></li>
              <li><a href="#"><img src="images/tool_08.png" /><span>出口报关资料</span></a></li>
              <li><a href="#"><img src="images/tool_09.png" /><span>目的国清关资料</span></a></li>
              <li><a href="<%=path%>/queryCode?code=3312"><img src="images/tool_10.png" /><span>机场三字码</span></a></li>
              <li><a href="<%=path%>/queryCode?code=2286"><img src="images/tool_12.png" /><span>港口查询</span></a></li>
              <li><a href="<%=path%>/queryCode?code=3312"><img src="images/tool_11.png" /><span>海关编码查询</span></a></li>
            </ul>
          </div>
        </div>
      </div>
      <div class="right">
        <div class="track">
          <div class="title">
            <h3>物流工具</h3>
          </div>
          <div class="nir">
          <form name="queryTrackForm" id="queryTrackFrom" action="page/queryTrack" method="post">
            <div class="search">
              <textarea name="queryCode" id="queryCode" class="input_3" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}" style="color: rgb(153, 153, 153);">请在此输入您的订单号/代理单号/跟踪号，最多支持五个订单号的查询。输入多个订单号，请用“,”分隔 。</textarea>
            </div>
            <div class="check">
              <ul>
                <li>
                  <input name="validateCode" value="验证码" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}"  style="color: rgb(153, 153, 153);" />
                </li>
                <li class="check_letter"><img src="util/ValidateImage?d=<%= new Date().getTime() %>" onClick="changeValidateCode(this)" style="float:left;margin-left:-10px;margin-top:2.5px;width:40px;height:20px"/></li>
                <li>
                  <button class="check_but" type="submit" onclick="return checkTrackForm();"></button>
                </li>
              </ul>
            </div>
            </form>
          </div>
        </div>
        <div class="news">
          <div class="title">
            <h3>通知公告</h3>
            <s:set var="newnum" value="@com.daiyun.dax.WebDemand@STquery('D0101')"/>
            <!--  <s:set var="newnum" value="@com.daiyun.dax.WebDemand@STquery('D0101')"/> -->
            <span><a href="<%=request.getRequestURI()%>item/newCode?code=<s:property value="#newnum"/>">更多</a></span></div>
          <div class="nir">
            <div class="new"> <img src="images/index_01.jpg" />
              <h3><a href="#">国际空运的发展趋势</a></h3>
              <p>在数据全球化的今天，市场经济早已潜移默化，普及全球而作为市场经济的链接桥梁，国际物流处于举足轻重的地位。而在这跟桥梁上，国际空运以时效快、安全性高备受用户的倾慕。......<a href="#">[详细]</a></p>
            </div>
            <div class="new"> <img src="images/index_02.jpg" />
              <h3><a href="#">国际快递逆转跨境电商价格战</a></h3>
              <p>价格便宜、保证正品、选择更多……一系列优势让跨境电商受到越来越多消费者的青睐。不过国际快递行业下的百运网则表示，在跨境电商税改新政风暴下，拼折扣卖爆款的模式已不再适合现在的跨境电商行业，......<a href="#">[详细]</a></p>
            </div>
            <ul>
             
              
           <s:set var="ggnum" value="@com.daiyun.dax.WebDemand@STquery('D0102')"/>
           <s:iterator var="btBean" value="@com.daiyun.dax.BulletinOpr@queryByBkcode('002','5')">                 	
              <li><h3><a href='item/qyByBlIdTool?gmcode=<s:property value="#ggnum"/>&pf=newsDetails&blId=<s:property value="#btBean.Blblid" />'>
	            <s:if test="#btBean.Blblheading.getBytes().length>60">
	             <s:property value="@com.daiyun.util.StrUtil@splitString(#btBean.Blblheading,60)"/>...
              </s:if>
	             <s:else>
	              <s:property value="#btBean.Blblheading"/>
	           </s:else></a></h3><span><s:property value="#btBean.Blblvaliddate.split(' ')[0]"/></span></li>
           </s:iterator>  
            </ul>
          </div>
        </div>
      </div>
    </div>
    <div class="clear"></div>
    <div class="bottom">
      <div class="partner">
        <div class="title">
          <h3>合作伙伴</h3>
          <div class="partner_title"><a class="leftbtuuon" onmousedown="ISL_GoUp()" onmouseup="ISL_StopUp()" onmouseout="ISL_StopUp()"><img src="images/leftbutton.png" alt="合作伙伴" /></a><a class="rightbtuuon" onmousedown="ISL_GoDown()" onmouseup="ISL_StopDown()" onmouseout="ISL_StopDown()"><img src="images/rightbutton.png" alt="合作伙伴" /></a></div>
        </div>
        <div class="Cont" id="ISL_Cont">
          <div class="ScrCont">
            <ul id="List1">
              <li><img src="images/partner01.jpg" border='0' width='100' height='50' /></li>
              <li><img src="images/partner02.jpg" border='0' width='100' height='50' /></li>
              <li><img src="images/partner03.jpg" border='0' width='100' height='50' /></li>
              <li><img src="images/partner04.jpg" border='0' width='100' height='50' /></li>
              <li><img src="images/partner05.jpg" border='0' width='100' height='50' /></li>
              <li><img src="images/partner06.jpg" border='0' width='100' height='50' /></li>
              <li><img src="images/partner07.jpg" border='0' width='100' height='50' /></li>
              <li><img src="images/partner08.jpg" border='0' width='100' height='50' /></li>
            </ul>
            <ul id="List2">
            </ul>
          </div>
        </div>
        <div class="clear"></div>
      </div>
      <script language="javascript" type="text/javascript">
<!--//--><![CDATA[//><!--
//图片滚动列表 mengjia 070816
var Speed = 10; //速度(毫秒)
var Space = 5; //每次移动(px)
var PageWidth = 120; //翻页宽度
var fill = 0; //整体移位
var MoveLock = false;
var MoveTimeObj;
var Comp = 0;
var AutoPlayObj = null;
GetObj("List2").innerHTML = GetObj("List1").innerHTML;
GetObj('ISL_Cont').scrollLeft = fill;
GetObj("ISL_Cont").onmouseover = function(){clearInterval(AutoPlayObj);}
GetObj("ISL_Cont").onmouseout = function(){AutoPlay();}
AutoPlay();
function GetObj(objName){if(document.getElementById){return eval('document.getElementById("'+objName+'")')}else{return eval('document.all.'+objName)}}
function AutoPlay(){ //自动滚动
 clearInterval(AutoPlayObj);
 AutoPlayObj = setInterval('ISL_GoDown();ISL_StopDown();',3000); //间隔时间
}
function ISL_GoUp(){ //上翻开始

 if(MoveLock) return;
 clearInterval(AutoPlayObj);
 MoveLock = true;
 MoveTimeObj = setInterval('ISL_ScrUp();',Speed);
}
function ISL_StopUp(){ //上翻停止
 clearInterval(MoveTimeObj);
 if(GetObj('ISL_Cont').scrollLeft % PageWidth - fill != 0){
  Comp = fill - (GetObj('ISL_Cont').scrollLeft % PageWidth);
  CompScr();
 }else{
  MoveLock = false;
 }
 AutoPlay();
}
function ISL_ScrUp(){ //上翻动作
 if(GetObj('ISL_Cont').scrollLeft <= 0){GetObj('ISL_Cont').scrollLeft = GetObj('ISL_Cont').scrollLeft + GetObj('List1').offsetWidth}
 GetObj('ISL_Cont').scrollLeft -= Space ;
}
function ISL_GoDown(){ //下翻
 clearInterval(MoveTimeObj);
 if(MoveLock) return;
 clearInterval(AutoPlayObj);
 MoveLock = true;
 ISL_ScrDown();
 MoveTimeObj = setInterval('ISL_ScrDown()',Speed);
}
function ISL_StopDown(){ //下翻停止
 clearInterval(MoveTimeObj);
 if(GetObj('ISL_Cont').scrollLeft % PageWidth - fill != 0 ){
  Comp = PageWidth - GetObj('ISL_Cont').scrollLeft % PageWidth + fill;
  CompScr();
 }else{
  MoveLock = false;
 }
 AutoPlay();
}
function ISL_ScrDown(){ //下翻动作
 if(GetObj('ISL_Cont').scrollLeft >= GetObj('List1').scrollWidth){GetObj('ISL_Cont').scrollLeft = GetObj('ISL_Cont').scrollLeft - GetObj('List1').scrollWidth;}
 GetObj('ISL_Cont').scrollLeft += Space ;
}
function CompScr(){
 var num;
 if(Comp == 0){MoveLock = false;return;}
 if(Comp < 0){ //上翻
  if(Comp < -Space){
   Comp += Space;
   num = Space;
  }else{
   num = -Comp;
   Comp = 0;
  }
  GetObj('ISL_Cont').scrollLeft -= num;
  setTimeout('CompScr()',Speed);
 }else{ //下翻
  if(Comp > Space){
   Comp -= Space;
   num = Space;
  }else{
   num = Comp;
   Comp = 0;
  }
  GetObj('ISL_Cont').scrollLeft += num;
  setTimeout('CompScr()',Speed);
 }
}
//--><!]]>
</script> 
    </div>
    
  </div>
  <div id="bottom">
    <div class="copyright">
      <div class="nir">
        <div class="left"> Copyright © 2012 深圳市代运物流网络有限公司<br />
          (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号 </div>
        <div class="right"><img src="images/tel2.jpg" /></div>
      </div>
    </div>
    <div class="bottom_nav"> <a href="#">首页</a>│<a href="<%=path%>/track/searchTrack">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
</div>
<span id="chat_f2"><img  src="images/consult.jpg" style="float:right;cursor:pointer;"></span>
<div id="chat_f1" style="display:block;">
<span id="close_chat"><img  src="images/close.png" style="float: right;margin-top:-7px;cursor:pointer;" > </span>
  <div id="chat_f1_main"></div>
  <div class="chat_f1_expr" style="height: 184px; display: block;"> 
    <!------------>
    <div class="list">
      <div class="name">
        <h5><a href="http://wpa.qq.com/msgrd?v=3&uin=364366761&site=qq&menu=yes" target="_blank">快速咨询</a></h5>
      </div>
    </div>
    <!------------> 
    <!------------>
    <div class="list">
      <div class="name">
        <h5><a  href="http://wpa.qq.com/msgrd?v=3&uin=469440513&site=qq&menu=yes" target="_blank">更多咨询</a></h5>
      </div>
    </div>
    <!------------> 
    <!------------>
    
    <div class="list">
      <div class="name">
        <h5><a href="http://wpa.qq.com/msgrd?v=3&uin=364366761&site=qq&menu=yes"target="_blank">离线留言</a></h5>
      </div>
    </div>
    <!------------> 
  </div>
</div>
</body>
</html>
