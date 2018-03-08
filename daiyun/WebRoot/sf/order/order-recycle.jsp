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

		<title>订单回收站</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/Ext3/css/ext-all.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>

		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_total.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_page.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style type="text/css">
a{color:#333333;text-decoration:none;}
.pageNav { text-align:right; margin-top:10px; height:26px; padding:3px 0px;color: #000000;}
.pageNav a { display:inline; border:1px solid #ccc; height:20px; line-height:20px; margin-left:5px; padding:2px 7px;}
.pageNav a:hover { border:1px solid #3a739d; text-decoration:none; color:#3a739d; background:#f6fbff;}
</style>
<script type="text/javascript">
function changeCheckBox(){
		var cboxes=document.getElementById("myform").elements;
		var cbox=document.getElementById("selectAllCheckBox");
		for(i=0;i<cboxes.length;i++){
			if(cboxes[i].Type="checkbox"){
				if(cbox.checked==true){
					cboxes[i].checked=true;
					cbox.checked=true;
				}else{
					cboxes[i].checked=false;
					cbox.checked=false;
				}
			}
		}
	}
 
 	function chooseOneAtLeast(){
		var obj = document.getElementById("myform").elements;
		var k=0;
		for(var i=0;i<obj.length;i++){
			if (obj[i].name == "checkbox"){
				if(obj[i].checked == true){
					k+=1;
				}		
			}
		}
		if(k==0){
			alert("请至少选择一条记录");
			return false;
		}else{
			return true;
		}
	}
  	function myrecover(){
  		if(chooseOneAtLeast()){
  	  		if(confirm("确认还原？")){
		  		document.getElementById("myform").action="${pageContext.request.contextPath }/order/recoverRecycleOrders";
				document.getElementById("myform").submit();
  	  		}
		}	
  	}
  	
  	function doReset(){
		document.location.href="${pageContext.request.contextPath }/order/queryRecycleOrders?link=recycle";
	}
  	
  	function mysearch(){
		document.getElementById("myform").action="${pageContext.request.contextPath }/order/queryRecycleOrders?link=recycle";
		document.getElementById("myform").submit();
	}
	
	function mydelete(){
		if(chooseOneAtLeast()){
			if(confirm("确认彻底删除？")){
				document.getElementById("myform").action="${pageContext.request.contextPath }/order/deleteRecycleOrders";
				document.getElementById("myform").submit();
			}
		}	
	}

	/*条件批量删除*/
	function deleteBatchRecycle(){
		var customerewbcode = document.getElementById("customerewbcode").value.replace(/^\s+|\s+$/g,"");
		//var strHwconsigneename = document.getElementById("strHwconsigneename").value.replace(/^\s+|\s+$/g,"");
		var pkCode = document.getElementById("pkCode").value.replace(/^\s+|\s+$/g,"");
		//var strHwConsigneeCompany = document.getElementById("strHwConsigneeCompany").value.replace(/^\s+|\s+$/g,"");
		var startdate = document.getElementById("startdate").value;
		var enddate = document.getElementById("enddate").value;
		//var buyerid = document.getElementById("buyerid").value.replace(/^\s+|\s+$/g,"");//买家id
		//var transactionid = document.getElementById("transactionid").value.replace(/^\s+|\s+$/g,"");
		if((customerewbcode==""||customerewbcode==null)&&
				//(strHwconsigneename==""||strHwconsigneename==null)&&(strHwConsigneeCompany==""||strHwConsigneeCompany==null)&&(buyerid==""||buyerid==null)&&(transactionid==""||transactionid==null)
				(pkCode==""||pkCode==null)&&
				(startdate==""||startdate==null)&&
				(enddate==""||enddate==null)
				){
			alert("请至少输入一个条件!");
			return;
		}else{
			if(confirm("确定要批量删除吗?")){	
				document.getElementById("myform").action='${pageContext.request.contextPath }/order/deleteBatchRecycle?customerewbcode='+customerewbcode+
				//'&strHwconsigneename='+strHwconsigneename+'&strHwConsigneeCompany='+strHwConsigneeCompany+'&=buyerid'+buyerid+'&=transactionid'+transactionid;
				'&pkCode='+pkCode+
				'&=startdate'+startdate+
				'&enddate='+enddate+
				
				
				document.getElementById("myform").submit();
			}
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
	function setPageCount(){
		if(checkPageCount()){
			document.getElementById("myform").action='${pageContext.request.contextPath }/order/queryRecycleOrders?link=recycle';
			document.getElementById("myform").submit();
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
        <div class="right"><span><a href="${pageContext.request.contextPath }/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath }/op/recharge.jsp" target="_blank">充值</a></span> | <span><a href="#">English</a></span></div>
      </div>
      <div class="logo">
        <div class="left"><img src="${pageContext.request.contextPath }/images/logo.jpg" /></div>
        <div class="right"><img src="${pageContext.request.contextPath }/images/tel.jpg" /></div>
      </div>
      <div class="nav">
       	<jsp:include page="../../pg/include/main_menu.jsp"></jsp:include>
        <div class="nav_last"><a href="${pageContext.request.contextPath }/userinfo"><img src="${pageContext.request.contextPath }/images/my_nav.jpg"/></a></div>
    </div>
  </div>
  <div class="forwarding">
     	<jsp:include page="../../op/tree.jsp" />
    <div class="right">
      <div class="home">
        <h3><a>我的代运</a> > 我的订单 > <span>订单回收站</span></h3>
      </div>
      <div class="recycle">
      <div class="condition" style="height: 130px">
      		<div style="width: 250px;height: 130px;float: left;">
      		<font style="width:60px;height:15px; float: left;">客户单号：</font>
             <textarea id="customerewbcode" name="customerewbcode"  placeholder="输入多个订单号，请用“,”分隔 。" class="order_box" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}" style="color: rgb(153, 153, 153);float: right;">${customerewbcode }</textarea>
      		</div>
          <table width="520" border="0" style="float: right;">
            <tr>
            <!--   <td width="30%" align="left">客户单号：
                <input id="customerewbcode" name="customerewbcode" placeholder="输入多个订单号，请用“,”分隔 。" value="${customerewbcode }" type="text" style="width:165px;;height:22px;" />
                </td>
            -->    
                
                
            	 <td width="50%" align="left" style="padding-left: 0px;">服务商单号：
                <input id="strCwserverewbcode" name="strCwserverewbcode" value="${strCwserverewbcode }" type="text" style="width:165px;;height:22px;" /></td> 
           
              <td width="50%" align="right">物流渠道：
            <select id="pkCode" name="pkcode" style="width:170px;;height:24px;">
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
             <!--   <td width="30%">客户单号：
                <input name="order" type="text" style="width:165px;;height:22px;" /></td>-->
                
              <td width="50%" style="padding-left: 12px;">开始时间：
              <input name="startdate" type="text" value="<s:property value='#request.startdate'/>" src="${pageContext.request.contextPath}/images/time.png" style="  width:165px;height:22px;" 
               	 class="Wdate"	id="startdate" onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>
              
                </td>
   				 
   				 <td width="50p%" align="center" style="padding-left: 20px;">结束时间：
                 <input name="enddate" type="text" value="<s:property value='#request.enddate'/>" src="${pageContext.request.contextPath}/images/time.png" style=" width:165px;height:22px;" 
               	class="Wdate" id="enddate"  onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"	/>
               
                </td>

            </tr>
     
          </table>
        </div>
        <div class="button">
          <button class="buttonbg" value="" type="button" onclick="doReset();">刷新</button>
          <button class="buttonbg" value="" type="button" onclick="mysearch();">查询</button>
          <button class="buttonbg" value="" type="button" onclick="myrecover();">还原</button>
          <button class="buttonbg" value="" type="button" onclick="mydelete();">彻底删除</button>
          <button class="buttonbg" value="" type="button" onclick="deleteBatchRecycle();">全部删除</button>
        </div>
        <div class="result">
<table id="attributeval" class="manage_form" style="margin: 0px;" width="1844" cellspacing="1" cellpadding="0" border="0">
						
									<thead>
									<tr style="background:#edf8fd;">
										<td style="text-align: center;" width="72px">
											<label>
												<input  name="selectAllCheckBox" id="selectAllCheckBox" onclick="changeCheckBox();" type="checkbox"/>
											</label>
										</td>
										<td width="150">客户单号</td>
										<td width="118">服务商运单号</td>
										<td width="150">代运单号</td>
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
						<s:set var="beans" value="#request.listWaybillforpredictColumns" />
						<s:if test="#beans==null || #beans.size()==0">							
							<tr class="manage_form_bk">								
								<td align="left" width="300"  colspan="5"><h3 style="color: red;">对不起,没有查询到对应条件的记录!</h3></td>
							</tr>
						</s:if>
						<s:else>
								
									<s:iterator var="bean" value="#request.listWaybillforpredictColumns" >	
									<tr >	
									<td style="text-align:center;" height="16px" ><input type="checkbox"  style="width:20px;" name="checkbox"  value="<s:property value='#bean.Cwcw_code'/>" id="checkbox"/>
									</td>
								 	<td width=125 class="tab6"><a style="" href="${pageContext.request.contextPath }/order/queryOrdersDetail?cw_code=<s:property value='#bean.Cwcw_code'/>&link=received">
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
								  
								  <td width=135 class="tab6"><s:property value="#bean.Cwcw_ewbcode" /></td><!-- 代运单号 moalwindow(this)-->								  
								  <td width=71 class="tab6"><s:property value="#bean.Pkpk_sename" /></td>
								  <td width=100 class="tab6"><s:property value="#bean.Dtdt_name" /></td><!-- 目的国家 -->
								  <td width=150 class="tab6"><s:property value="#bean.Hwhw_consigneename" /></td><!-- 收件人 -->	
								 
								  <td width=140 class="tab6"><s:property value="#bean.Cwcw_createdate" /></td>
								  <td width=140 class="tab6"><s:property value="#bean.Hwhw_customerdeclaredate" /></td>
								  <td id="printdate" width=140 class="tab6" ><s:property value="#bean.Hwhw_customerlabelprintdate" /></td><!-- 12 -->
			
								  <td id="signoutdate" width=140 class="tab6" ><s:property value="#bean.Hwhw_signoutdate" /></td>
								    	
								  <td width=300 class="tab6" ><s:property value="#bean.Hwhw_consigneecompany" /></td>
								
								  <!-- 客户重量 -->
								  <td width=87 class="tab6" align="right"><s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_customerchargeweight)" /></td>
								  
								
								  <!-- 计费重 -->
								  <td width=73 class="tab6" align="right"><s:property value="@java.lang.Double@parseDouble(#bean.Cwcw_chargeweight)" /></td>
									
								
								
								</tr>
								</s:iterator>
							
							</s:else>
									
									
										
									</tbody>
								</table>
        
        
        </div>
        
         <div class="pageNav" id= "pageNav" style="display: none;"> 
           		   	<p:pager url="queryRecycleOrders" />
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
