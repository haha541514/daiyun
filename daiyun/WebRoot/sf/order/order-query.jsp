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

		<title>订单查询管理</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/Ext3/css/ext-all.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>

		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_total.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_page.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

		<script charset="gb2312" type="text/javascript" src="${pageContext.request.contextPath}/js/orderquery.js"></script>
	
	</head>
<style type="text/css">
a{color:#333333;text-decoration:none;}
.pageNav { text-align:right;  height:26px; padding:3px 0px;color: #000000;}
.pageNav a { display:inline; border:1px solid #ccc; height:20px; line-height:20px; margin-left:5px; padding:2px 7px;}
.pageNav a:hover { border:1px solid #3a739d; text-decoration:none; color:#3a739d; background:#f6fbff;}
</style>

<script type="text/javascript">
	$(function(){//选项卡切换
		var link = $('#linkValue').val();
		if(link == ''){
		}else{//直接设置css  
			var table = document.getElementById("attributeval");
			$('#ordermenu li').eq(link-1).addClass('first'); 
			$('.button'+link).show();
			$('#pageNav'+link).show();
			$('.button0').hide();
			$('.button'+link).removeAttr('style'); //ie,ff均支持	
			if(link == 3){//打印有打印时间，扣件状态，配货标记
				setHiddenCol(table,13);
				setHiddenCol(table,18);	
				setHiddenCol(table,19);		
			}else if(link == 4){
				setHiddenCol(table,13);
			}else if(link == 5){//显示
				setHiddenCol(table,4);
				setHiddenCol(table,10);
				setHiddenCol(table,14);
				//setHiddenCol(table,17);	
				setHiddenCol(table,5);
				setHiddenCol(table,19);		
			}
		}
		$("#selectAllCheckBox").click(function(){    
	    if(this.checked){    
	        $("input[name='checkbox']").attr("checked", true);   
	    }else{    
	        $("input[name='checkbox']").attr("checked", false); 
	    }    
		});  
		
		
	})
	
function setHiddenCol(oTable,iCol){
    for (i=0;i < oTable.rows.length ; i++){
       	oTable.rows[i].cells[iCol].style.display = "";       
        //oable.rows[i].cells[iCol].style.display=="none";
		//如果该列隐藏则让其显示，反之则让其隐藏
		//oTable.rows[i].cells[iCol].style.display=="none"?"block":"none";
    }
}
	
	
	/*$(function(){
		//截取字符串的函数是js中的,p标签先加载，没用
		var pUrl = window.location.href;
		if(pUrl.indexOf('=')){
			var newPurl = pUrl.substring(pUrl.lastIndexOf('/')+1,pUrl.indexOf('?'));
			//console.log(newPurl);，分页的url加上时已经分页了。
	 		$('#pageNav p').attr('url', newPurl);
	 	}
	})*/
	//查询，每个界面都有一个查询对应的Action
	
	var mysearch = function(){
		var seachUrl,linkParam;
		var linkValue;
		var pUrl = window.location.href;
		var ISbool = pUrl.indexOf('=')
		if(ISbool > 0){//含有link
			seachUrl = pUrl.substring(pUrl.lastIndexOf('/')+1,pUrl.indexOf('?'));
		}else{//不含有link
			var pLength = pUrl.length;
			seachUrl = pUrl.substring(pUrl.lastIndexOf('/')+1,pLength+1);
		}
		
		if(seachUrl == 'queryTransientOrders'){
			linkParam = 'transient'; linkValue = 1;
		}else if(seachUrl == 'queryDeclaredOrders'){
			linkParam = 'declared'; linkValue = 2;
		}else if(seachUrl == 'queryPrintedOrders'){
			linkParam = 'printed'; linkValue = 3;
		}else if(seachUrl == 'queryAllocateOrders'){
			linkParam = 'allocate'; linkValue = 4;
		}else if(seachUrl == 'queryReceivedOrders'){
			linkParam = 'received'; linkValue = 5;
		}
		$('#link').val(linkParam);
		$('#linkValue').val(linkValue);
		document.getElementById("myform").action='${pageContext.request.contextPath }/order/'+seachUrl+"?link="+linkParam;
		document.getElementById("myform").submit();
	}
	//导出EXCEL
	function myexport(){				
		if(chooseOneAtLeast()){	
			var temp1 = document.getElementById("cwcode").value;
			$.ajax({
				type: "post",
				url:"export",//路径
				data: "items="+ temp1,
				dataType:"text",
				success: function (message) {//返回数据根据结果进行相应的处理  
					if(message!=null){//去路径下下载。 
						var url="${pageContext.request.contextPath }/export_excel/"+message;
						window.open(url,"_blank");
						
					}
				}
			});
		}	
	}	
function exportPrint(){
	if(chooseOneAtLeast()){	
			var temp1=document.getElementById("cwcode").value;
			$.ajax({
				type: "post",
				url:"exportprint",
				data: "items="+ temp1,
				dataType:"text",
				success: function (message) {
					if(message!=null){
						var url="${pageContext.request.contextPath }/export_excel/"+message;//本地不加basePath无法导出
						window.open(url,"_blank");
						
					}
				}
			});
		}	
}
//弹出窗口
function moalwindow(e){
	var rowIndex =  e.parentNode.parentNode.rowIndex;//rowIndex=2
	var tab = document.getElementById("attributeval");
	var checkboxValue = document.getElementsByName("checkbox");
	
	//var cwcwcode = checkboxValue[rowIndex+1].value; //cwcwcode查不出来
	var customecode = tab.rows[rowIndex].cells[1].innerText;//客户单号可以查不来
	var querycode = tab.rows[rowIndex].cells[3].innerHTML;//百千单号查不出来
	var cwsname = tab.rows[rowIndex].cells[9].innerHTML;

	if(cwsname == "到货" || cwsname == "制单" || cwsname == "出货" ){
		window.showModalDialog("${pageContext.request.contextPath }/queryTrack?queryCode="+customecode,window, "dialogHeight:450px;dialogWidth:750px;status=no;");
	}
}	



$(function(){
		var tab = document.getElementById("attributeval");
		var links = document.getElementsByName("zhuizong");
		//var links = $("input[name='zhuizong']");
		for(var index = 1 ; index <=links.length ; index++){
				var cwsname = tab.rows[index].cells[9].innerHTML;
			
				if(cwsname != "到货" || cwsname != "制单" || cwsname != "出货"){
						//links[index-1].html().css("color","#01B0EE");//DOM ,JQ混用不行。
						//links[index-1].style.display = "none";//数组长度从0开始
						links[index-1].style.color = "#555555";
				}
			}
		});
function setPageCount(){
	var seachUrl;
	var linkParam;
	var pUrl = window.location.href;
	var ISbool = pUrl.indexOf('=')
	if(checkPageCount()){
		if(ISbool > 0){//含有link
			seachUrl = pUrl.substring(pUrl.lastIndexOf('/')+1,pUrl.indexOf('?'));
		}else{//不含有link
			var pLength = pUrl.length;
			seachUrl = pUrl.substring(pUrl.lastIndexOf('/')+1,pLength+1);
		}
	
	 if(seachUrl == 'queryTransientOrders'){
			linkParam = 'transient'; linkValue = 1;
		}else if(seachUrl == 'queryDeclaredOrders'){
			linkParam = 'declared'; 
		}else if(seachUrl == 'queryPrintedOrders'){
			linkParam = 'printed'; 
		}else if(seachUrl == 'queryAllocateOrders'){
			linkParam = 'allocate'; 
		}else if(seachUrl == 'queryReceivedOrders'){
			linkParam = 'received'; 
		}
		document.getElementById("myform").action='${pageContext.request.contextPath }/order/'+seachUrl+"?link="+linkParam;
		document.getElementById("myform").submit();
	}
}
//设置分页
function checkPageCount(){
	var pageCount=$("#customInputCount").val();
	var ergRuleNumberForDaiGou = new RegExp(/^\d+$/);
	if(!ergRuleNumberForDaiGou.test(pageCount)){
		alert("请输入有效数字!");
		$("#customInputCount").select();
		$("#customInputCount").focus();
	  }else if($("#customInputCount").val()<= 0){
		alert("查询的数据至少多余1条!");
	  }else{
		return true;
	}
}

</script>
	<body style="height: 1157px;">
	
	
<div id="main">
<form action="" method="post" name="myform" id="myform">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="${pageContext.request.contextPath }/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath }/op/recharge.jsp" target="_blank">充值</a></span> | <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="${pageContext.request.contextPath}/images/logo.jpg" /></div>
        <div class="right"><img src="${pageContext.request.contextPath}/images/tel.jpg" /></div>
      </div>
      <div class="nav">
   		<jsp:include page="../../pg/include/main_menu.jsp"></jsp:include>
        <div class="nav_last"><a href="${pageContext.request.contextPath }/userinfo"><img src="${pageContext.request.contextPath }/images/my_nav.jpg"/></a></div>
      </div>
    </div>
  </div>
  
  <div class="forwarding">
 	<jsp:include page="../../op/tree.jsp" />
   <jsp:include page="../../sf/QQCommunicate.jsp" />
    <div class="right" style="width: 860px;height: 750px;">
      <div class="home">
        <h3><a>我的代运</a> > 我的订单 > <span>订单查询管理</span></h3>
      </div>
      <div class="query">
        <div class="condition" style="height: 130px">
        
        <div style="width: 250px;height: 130px;float: left;">
      		<font style="width:60px;height:15px; float: left;">客户单号：</font>
             <textarea id="customerewbcode" name="customerewbcode"  placeholder="输入多个订单号，请用“,”分隔 。" class="order_box" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}" style="color: rgb(153, 153, 153);float: right;">${customerewbcode }</textarea>
      		</div>
        
        
          <table width="520" border="0" style="float: right;">
            <tr>
              <!--  <td width="30%">客户单号：
                <input name="customerewbcode" type="text" style="width:165px;height:22px;" placeholder="输入多个订单号，请用“,”分隔 。" value="<s:property value='#request.customerewbcode'/>" /></td>-->
              <td width="50%" align="left">订单状态：
              <select id="Cwscwscode" name="Cwscwscode" style="width:170px;height:22px;">
                        <s:if test="#request.Cwscode==null">
                          <option value="" selected="selected" >-------请选择-------</option>
                          <s:iterator var="bean" value="@com.daiyun.dax.CorewaybillstatusKindDemand@getAllCWSStatus()">
                            <option value="<s:property value='#bean.Cwscwscode'/>">
                            <s:property value="#bean.Cwscwsname"/>
                            </option>
                          </s:iterator>
                        </s:if>
                        <s:else>
                          <option value="" >-------请选择-------</option>
                          <s:iterator var="bean" value="@com.daiyun.dax.CorewaybillstatusKindDemand@getAllCWSStatus()">
                            <s:if test="(#bean.Cwscwscode).equals(#request.Cwscode)">
                              <option  value="<s:property value='#bean.Cwscwscode'/>" selected="selected">
                              <s:property value="#bean.Cwscwsname"/>
                              </option>
                            </s:if>
                            <s:else>
                              <option  value="<s:property value='#bean.Cwscwscode'/>">
                              <s:property value="#bean.Cwscwsname"/>
                              </option>
                            </s:else>
                          </s:iterator>
                        </s:else>
                    </select>	 
              
             </td>
              <td width="50%" align="right">物流渠道：
					  <select id="pkCode" name="pkcode" style="width:165px;height:22px;">
                        <s:if test="#request.pkcode==null">
                          <option value="" selected="selected" >-------请选择-------</option>
                          <s:iterator var="bean" value="@com.daiyun.dax.ProductkindDemand@getAllProduct()">
                            <option value="<s:property value='#bean.Pkcode'/>">
                            <s:property value="#bean.Pkname"/>
                            </option>
                          </s:iterator>
                        </s:if>
                        <s:else>
                          <option value="" >-------请选择-------</option>
                          <s:iterator var="bean" value="@com.daiyun.dax.ProductkindDemand@getAllProduct()">
                            <s:if test="(#bean.Pkcode).equals(#request.pkcode)">
                              <option  value="<s:property value='#bean.Pkcode'/>" selected="selected">
                              <s:property value="#bean.Pkname"/>
                              </option>
                            </s:if>
                            <s:else>
                              <option  value="<s:property value='#bean.Pkcode'/>">
                              <s:property value="#bean.Pkname"/>
                              </option>
                            </s:else>
                          </s:iterator>
                        </s:else>
                    </select>				
                    </td>
        		
            </tr>
             <tr>
            <td width="50%" >货件状态：
              <select id="wbtp_code" name="wbtp_code" style="width:170px;height:22px;">
                        <s:if test="#request.wbtp_code==null">
                          <option value="" selected="selected" >-------请选择-------</option>
                          <s:iterator var="bean" value="@com.daiyun.dax.CorewaybillstatusKindDemand@getGoogsState()">
                            <option value="<s:property value='#bean.Wbtpwbtp_code'/>">
                            <s:property value="#bean.Wbtpwbtp_name"/>
                            </option>
                          </s:iterator>
                        </s:if>
                        <s:else>
                          <option value="" >-------请选择-------</option>
                          <s:iterator var="bean" value="@com.daiyun.dax.CorewaybillstatusKindDemand@getGoogsState()">
                            <s:if test="(#bean.Wbtpwbtp_code).equals(#request.wbtp_code)">
                              <option  value="<s:property value='#bean.Wbtpwbtp_code'/>" selected="selected">
                              <s:property value="#bean.Wbtpwbtp_name"/>
                              </option>
                            </s:if>
                            <s:else>
                              <option  value="<s:property value='#bean.Wbtpwbtp_code'/>">
                              <s:property value="#bean.Wbtpwbtp_name"/>
                              </option>
                            </s:else>
                          </s:iterator>
                        </s:else>
                    </select>	 
              
             </td>
            <td width="50%" align="right" >服务商单号：
       			    <input id="strCwserverewbcode" name="strCwserverewbcode" value="${strCwserverewbcode }" type="text" style="width:160px;height:22px;" /> 
                </td>
            
            </tr>
            <tr>
              <td width="50%"  style="">创建时间：
                <input name="startdate" type="text" value="<s:property value='#request.startdate'/>" src="${pageContext.request.contextPath}/images/time.png" style="width:165px;height:22px;" 
               	 class="Wdate"	id="startdate" onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>
                <!--<span style="padding-right:28px; font-size:18px; background:url(${pageContext.request.contextPath}/images/to.png) no-repeat left center;"></span>-->
				</td>
				<td width="50%" align="right" style="">
				<span>截止时间：</span>
                <input name="enddate" type="text" value="<s:property value='#request.enddate'/>" src="${pageContext.request.contextPath}/images/time.png" style=" width:160px;height:22px;" 
               	class="Wdate" id="enddate"  onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"	/>
                
                </td>
   				
            </tr>
           
          </table>
        </div>
       
        <!--  <div class="button0" id="but1">所有订单 
          <ul><li><button class="buttonbg" value="" type="button" onclick="doReset();">刷新</button></li>
            <li><button class="buttonbg" value="" type="button" onclick="mysearch();">查询</button></li>
            <li><button class="buttonbg" value="" type="button" onclick="mydetail();">订单详情</button></li>
        </div>-->
        
        <div class="button1" id="but2" style="display:none">
          <ul><!-- 暂存订单 -->
          	<li><button class="buttonbg" value="" type="button" onclick="doReset();">刷新</button></li>
           	<li><button class="buttonbg" value="" type="button" onclick="mysearch();">查询</button></li>
           	<li><button class="buttonbg" value="" type="button" onclick="mydeclare();">确认</button></li>
            <li><button class="buttonbg" value="" type="button" onclick="mycomplete();">确认并完成</button></li>
            <li><button class="buttonbg" value="" type="button" onclick="updateProIf();">修改信息</button></li>
            <li><button class="buttonbg" value="" type="button" onclick="mydelete();">删除</button></li>
            <li><button class="buttonbg" value="" type="button" onclick="deleteBatch();">全部删除</button></li>
            <!-- <li><button class="buttonbg" value="" type="button" onclick="doPack('add');">打包</button></li>
          	<li><button class="buttonbg" value="" type="button" onclick="doPack('remove');">拆包</button></li> -->
       		<li><button class="buttonbg" value="" type="button" onclick="alonecustoms();">单独报关</button></li>
       		<li><button class="buttonbg" value="" type="button" onclick="noalonecustoms();">取消报关</button></li>
       		</ul>
        </div>
              
        <div class="button2" id="but3" style="display: none">
          <ul><!-- 已申报订单 -->
         	<li><button class="buttonbg" value="" type="button" onclick="doReset();">刷新</button></li>
            <li><button class="buttonbg" value="" type="button" onclick="mysearch();">查询</button></li>
            <li><button class="buttonbg" value="" type="button" onclick="updateProIf();">修改货物信息</button></li>
            <li><button class="buttonbg" value="" type="button" onclick="showdiv();">打印标签</button></li>
            <li><button class="buttonbg" value="" type="button" onclick="billPrint();">打印发票</button></li>
        	<li><button class="buttonbg" value="" type="button" onclick="myrecover();">撤销</button></li>
        	<li><button class="buttonbg" value="" type="button" onclick="mydelete();">删除</button></li>
        	</ul> 	
 			
 			<div id="print_format" style="margin:0 auto;">
		        	<div class="print_format" id="xian" style="position:absolute;display:none;z-index:99;margin-left:30%; ">
						<span>&nbsp;</span><br/>
						<div style="font-size:14px; color:#02abee;">请选择打印格式：</div>
						<div style="margin-left:30px;margin-top:10px;">	
							<input type="hidden" name="raval" id="raval" value="2" />						
							<!--  <input type="radio"  value="1" name="dy" style="width:20px;" onclick="selra(this.value);"/>7.9×8.8标签纸(含CN2)<br/>-->
							<!--  <input type="radio" value="3" name="dy" style="width:20px;" onclick="selra(this.value);"/>7.9×8.8标签纸(不含CN2)<br/>-->
							<!--  <input type="radio" value="4" name="dy" style="width:20px;" onclick="selra(this.value);"/>A4(不含CN2)<br/>-->
							<input type="radio" value="5" name="dy" style="width:20px;" onclick="selra(this.value);"/><font size="2">4×4</font><br/>
							<input type="radio" value="2" name="dy" checked="checked" id="defaultCheck" style="width:20px;padding-top: 5px;" onclick="selra(this.value);"/><font size="2">A&nbsp;&nbsp;4</font><br/>
							</div>
						<div style="padding-top: 5px;padding-bottom: 5px;">
							<input type="button" style="margin-left: 10px;" class="buttonbg" value="确定" onclick="lablePrint();"/>
							<input type="button" style="margin-left: 30px;"class="buttonbg" value="取消" onclick="closediv();" style="margin-left:40px;"/>
						</div>
					</div>	
					</div>
        </div>
        <div class="button3" id="but4" style="display:none">
          <ul><!-- 已打印订单 -->
          	  <li><button class="buttonbg" value="" type="button" onclick="doReset();">刷新</button></li>
	          <li><button class="buttonbg" value="" type="button" onclick="mysearch();">查询</button></li>
	          <li><button class="buttonbg" value="" type="button" onclick="mydetail();">订单详情</button></li>
	          <li><button class="buttonbg" value="" type="button" onclick="exportPrint();">导出Excel</button></li>
	          <li><button class="buttonbg" value="" type="button" onclick="myprint();">重复打印</button></li>
	          <li><button class="buttonbg" value="" type="button" onclick="printRecover();">撤销</button></li>
	     	  <li><button class="buttonbg" value="" type="button" onclick="detain();">设为扣件</button></li>
	     	  <li><button class="buttonbg" value="" type="button" onclick="myallocate();">配货</button></li>	  
	      </ul>      
        </div>
         <div class="button4" id="but4" style="display:none">
          <ul><!-- 配货 -->
          	  <li><button class="buttonbg" value="" type="button" onclick="doReset();">刷新</button></li>
	          <li><button class="buttonbg" value="" type="button" onclick="mysearch();">查询</button></li>
	          <li><button class="buttonbg" value="" type="button" onclick="completeAllocate();">完成配货</button></li>
	      </ul>
        </div>
        <div class="button5" id="but4" style="display:none">
          <ul><!-- 已收货订单 -->
          	  <li><button class="buttonbg" value="" type="button" onclick="doReset();">刷新</button></li>
	          <li><button class="buttonbg" value="" type="button" onclick="mysearch();">查询</button></li>
	          <li><button class="buttonbg" value="" type="button" onclick="mydetail();">订单详情</button></li>
	          <li><button class="buttonbg" value="" type="button" onclick="showdiv();">打印标签</button></li>
	          <li><button class="buttonbg" value="" type="button" onclick="myexport();">导出Excel</button></li>
	          <li><button class="buttonbg" value="" type="button" onclick="detain();">设为扣件</button></li>
	         
	      </ul>
        </div>
        
     
       <input type="hidden" name="cwcode" id="cwcode" />
       <input type="hidden" name="link" id="link"/>
       <input type="hidden" name="linkValue" id="linkValue"  value="<s:property value='#request.linkValue' />"/>
        <div class="all_orders" style="z-index:3;">
          <ul id ="ordermenu">
           <!--   <li><a href="${pageContext.request.contextPath }/order/queryAllOrders?link=queryAll">所有订单</a></li>-->
            <li><a href="${pageContext.request.contextPath }/order/queryTransientOrders?link=transient&startdate=${startdate }&enddate=${enddate}">新建</a></li>
            <li><a href="${pageContext.request.contextPath }/order/queryDeclaredOrders?link=declared&startdate=${startdate }&enddate=${enddate}">确认</a></li>
            <li><a href="${pageContext.request.contextPath }/order/queryPrintedOrders?link=printed&startdate=${startdate }&enddate=${enddate}">已打印</a></li>
            <li><a href="${pageContext.request.contextPath }/order/queryAllocateOrders?link=allocate&startdate=${startdate }&enddate=${enddate}">已配货</a></li>
            <li><a href="${pageContext.request.contextPath }/order/queryReceivedOrders?link=received&startdate=${startdate }&enddate=${enddate}">已收货</a></li>
          </ul>
          
          <!-- 滚动条 -->
          <div style="width: 870px;margin-top:5px" >
			<div class="admin_table" style="OVERFLOW-y: auto; OVERFLOW-x: auto; WIDTH: 870px; HEIGHT: 335px;">
        		 <s:set var="beans" value="#request.listWaybillforpredictColumns" />
						<s:if test="#beans==null || #beans.size()==0">							
							<table id="abc" width="1844" border="0" cellpadding="0" cellspacing="1"  class="manage_form" >
						</s:if>
						<s:else>
						<table id="attributeval" width="1844" border="0" cellpadding="0" cellspacing="1"  class="manage_form" >
						</s:else>
						<thead>
							<tr class="manage_form_bk4" style="background: #EDF8FD;">
							<td width="36" style=" text-align:center;">
								<label>
									<input type="checkbox" name="selectAllCheckBox" id="selectAllCheckBox"  style="width:20px" onclick="changeCheckBox();"/>
								</label>							
						  	</td>
							<td width=125 class="tab4"><strong>客户单号</strong></td>
							<td width=150 class="tab4"><strong>服务商运单号</strong></td>
							<td width=135 class="tab4"><strong>代运单号</strong></td>
							<td width=73 class="tab4" style="display: none;"><strong>轨迹追踪</strong></td><!--新增 轨迹追踪 -->
							<td width=73 class="tab4" style="display: none;"><strong>货件状态</strong></td>
							
						  	<td width=85 class="tab4"><strong>运输方式</strong></td>
							<td width=100 class="tab4"><strong>目的国家</strong></td>
							<td width=150 class="tab4"><strong>收件人</strong></td>	
							<td width=73 class="tab4"><strong>运单状态</strong></td><!-- 新增 运单状态-->		
											
							<td width=150 class="tab4" style="display: none;"><strong>收货时间</strong></td>
							
							
							<td width=150 class="tab4"><strong>上传时间</strong></td>
							<td width=150 class="tab4"><strong>申报时间</strong></td>
							<td width=150 class="tab4" style="display: none;"><strong>打印时间</strong></td>
							<td width=150 class="tab4" style="display: none;"><strong>出货时间</strong></td><!-- 出货时间列 -->
							
							<td width=150 class="tab4"><strong>收件人公司</strong></td>
							<td width=87 class="tab4" ><strong>客户重量</strong></td>
							<td width=73 class="tab4"><strong>计费重</strong></td>
							<td width=73 class='tab4' style="display: none;"><strong>扣件状态</strong></td>
							<td width=73 class='tab4' style="display: none;"><strong>配货标记</strong></td>
							
						</tr>
					  </thead>
						<tbody>
						<s:set var="beans" value="#request.listWaybillforpredictColumns" />
						<s:if test="#beans==null || #beans.size()==0">							
							<tr class="manage_form_bk">								
								<td align="left" width="300"  colspan="5"><h3 style="color: red;">对不起,没有查询到对应条件的记录!</h3></td>
							</tr>
						</s:if>
						<s:else>
								
									<s:iterator var="bean" value="#request.listWaybillforpredictColumns" >	
									<tr >	
									<td style="text-align:center;" height="16px" >
									<input type="checkbox"  style="width:20px;" name="checkbox"  value="<s:property value='#bean.Cwcw_code'/>" id="checkbox"/>
									</td>
								 	<td width=125 class="tab6"><a href="${pageContext.request.contextPath }/order/queryOrdersDetail?cw_code=<s:property value='#bean.Cwcw_code'/>&link=received">
								 		<font color="#02ABEE"><s:if test="#bean.Originorderid==null">
										 	<s:property value="#bean.Cwcw_customerewbcode" /></s:if><s:else>
										 	<s:property value="#bean.Cwcw_customerewbcode" />&nbsp;<s:property value="#bean.Originorderid" /></s:else>
										 </font>	
										 	</a>
									</td>
								  
								  
								  <td width=150 class="tab6"><!-- 服务商 -->
									<s:if test="#bean.Pkpk_showserverewbcode == null || #bean.Pkpk_showserverewbcode.equals(\"Y\")">
									<s:property value="#bean.Cwcw_serverewbcode" />
									</s:if>
									<s:else>
									<s:property value="#bean.Cwcw_ewbcode" />
									</s:else>							
								  </td>
								  
								  <td width=135 class="tab6"><s:property value="#bean.Cwcw_ewbcode" /></td><!-- 百千诚单号 moalwindow(this)-->
								  <td id="trace" width=73 class="tab6" style="display: none;">
										 <a  href="javascript:void(0)" name="zhuizong"  onclick="moalwindow(this)" style="color: #0055E5;">
										 <font color="#02ABEE">   追踪</font></a>
								 </td><!-- 轨迹追踪 -->								  
								  <!-- 货件状态 -->	
								<td width=73 class="tab6"  style="display: none;"><s:property value="#bean.WbtpWbtp_name" /></td>
					
								  <td width=71 class="tab6"><s:property value="#bean.Pkpk_sename" /></td>
								  <td width=100 class="tab6"><s:property value="#bean.Dtdt_name" /></td><!-- 目的国家 -->
								  <td width=150 class="tab6"><s:property value="#bean.Hwhw_consigneename" /></td><!-- 收件人 -->	
								
								  <td width=73 class="tab6"><s:property value="#bean.Cwscws_name" /></td><!-- 运单状态 -->
													  
								  <td id="signindate" width=150 class="tab6" style="display: none;"><s:property value="#bean.Hw_signindate" /></td><!-- 收货时间 -->
								 
								  <td width=150 class="tab6"><s:property value="#bean.Cwcw_createdate" /></td>
								  <td width=150 class="tab6" ><s:property value="#bean.Hwhw_customerdeclaredate" /></td>
								  <td id="printdate" width=140 class="tab6" style="display: none;"><s:property value="#bean.Hwhw_customerlabelprintdate" /></td><!-- 12 -->
								 
								  <td id="signoutdate" width=140 class="tab6" style="display: none;"><s:property value="#bean.Hwhw_signoutdate" /></td>
								    	
								  <td width=150 class="tab6" ><s:property value="#bean.Hwhw_consigneecompany" /></td>
								
								  <!-- 客户重量 -->
								  <td width=87 class="tab6" align="right"><s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_customerchargeweight)" /></td>
								  
								  
								  <!-- 计费重 -->
								  <td width=73 class="tab6" align="right"><s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_chargeweight)" /></td>
								
									<!-- 扣件 -->
									<td id="koujian" width=75 class="tab6"  style="display: none;">
					    				<s:property value="#bean.Ihsihs_name" /></td>
					    			<!--配货  -->
									<td  id="peihuo" width=84 class="tab6" style="display:none;">
										<s:if test="\"I\".equals(#bean.Hwhw_attacheinfosign)">
											配货
										</s:if>
									</td>
										
								</tr>
								</s:iterator>
							
							</s:else>
				
					</tbody>
           		  </table>
           		  
 
    </div>
    </div>
     </div>  
         <div style="float: left;" style="width: 400px;height: 100px;">Tips:已收货界面点击追踪可查看轨迹<br/>
         Tips:未出货订单支持客户线上扣件,已出货订单点不能扣件
         </div>  
     <div style="float:right;width: 400px;height: 200px;">
     	
              <div class="pageNav" id= "pageNav0" style="display: none;"> 		
           		  
		      </div> 
           	  <div class="pageNav" id= "pageNav1" style="display: none;loat: right;position: relative;padding-right: 10px;"> 
           	 		<p:pager url="queryTransientOrders" /> 
           	 		        	
		      </div> 
		        <div class="pageNav" id= "pageNav2" style="display: none;"> 
           		   	<p:pager url="queryDeclaredOrders" /> 	 		       		   	
		      </div> 
		        <div class="pageNav" id= "pageNav3" style="display: none;"> 
           		   	<p:pager url="queryPrintedOrders" />
		      </div> 
		        <div class="pageNav" id= "pageNav4" style="display: none;"> 
           		   	<p:pager url="queryAllocateOrders" />
           	 	  		   	
		      </div> 
		        <div class="pageNav" id= "pageNav5" style="display: none;"> 
           		   	<p:pager url="queryReceivedOrders" />
		      </div>
		  
		  	<div style="float: right;width: 216px;height: 40px;padding-top:25px; ">
           	 	设置每页显示&nbsp;<input class="input_text" style="width: 30px;"  name="customInputCount" id="customInputCount"  type="text" value="<s:property value='#request.pageCount'/>" />&nbsp;条记录&nbsp;&nbsp;&nbsp;&nbsp;
				<input name="pageCountSizeSure" id="pageCountSizeSure" type="button" value="确定" onclick="setPageCount()" style="border:1px solid #3a739d; text-decoration:none;  background:#f6fbff;"/>
    			
    		</div>
	</div>
		
	</div>
	</form>
	</div>
</div>	
		  <div class="clear"></div>
		  <div id="bottom" style="">
		    <div class="copyright">
		      <div class="nir">
		        <div class="left" style=""> Copyright © 2012 深圳市代运物流网络有限公司<br />
		          (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号 </div>
		        <div class="right" style=""><img src="${pageContext.request.contextPath}/images/tel2.jpg" /></div>
		      </div>
		    </div>
		    <div class="bottom_nav"> <a href="#">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
		  </div>
	


	
	</body>
</html>
