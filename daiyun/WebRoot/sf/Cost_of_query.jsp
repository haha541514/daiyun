<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@taglib uri = "/project" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache"/>
		<meta http-equiv="cache-control" content="no-cache"/>
		<meta http-equiv="expires" content="0"/>    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3"/>

		<title>费用查询</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/Ext3/css/ext-all.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
	
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_total.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_page.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>
</style>
<script type="text/javascript">
$(function(){
	var costvalue = $('input[name="costvalue"]').val();
	if(costvalue == '' ){
		$('#condition1').show();
		$('#button1').show();
		$('#result1').show();
		$('.headline ul li').eq(0).attr('class','first');
	}else{
		//console.log(costvalue);
		$('#condition'+costvalue).show();
		$('#button'+costvalue).show();
		$('#result'+costvalue).show();
		$('.headline ul li').eq(costvalue-1).attr('class','first');
	}
})
var GotoSerachPage = function(){
	$('#myform').attr('action','${pageContext.request.contextPath}/CostOFQuery');
	$('#myform').submit();
}
var searchCost = function(){
	GotoSerachPage();
}
//检查是否选中
function chooseOneAtLeast(){
	var temp="";
	var obj = document.myform.elements;
	
	var k=0;
	for(var i=0;i<obj.length;i++){
		if (obj[i].name == "checkbox" && obj[i].checked == true){
			k+=1;
		}
	}
	if(k == 0){
		alert("请选择一条问题进行操作");
		return false;
	}
	return true;
}
	
var exportCost = function(){
	
		/*var checkbox = document.getElementsByName('checkbox');
		var cwCw_code  = "";
		for(var index = 0 ; index < checkbox.length ; index ++){
			if(checkbox[index].checked == true){
				cwCw_code += checkbox[index].value+",";
			}
		}*/
		$.post("${pageContext.request.contextPath }/exportCostExcel",
			function(message){
				if(message=='N'){ 
					alert("没有记录");
				}else{
					var url="${pageContext.request.contextPath }/export_excel/"+message;
					window.open(url,"_blank");
				}
		});
}





</script>
	</head>

<body>

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
        <div class="nav_last">
             <a href="${pageContext.request.contextPath }/userinfo"><img src="${pageContext.request.contextPath }/images/my_nav.jpg"/></a>
        </div>
      </div>
    </div>
  </div>
 <form id="myform" name="myform" method="post"> 
 	<input name="linkValue" id="linkValue" value="<s:property value='#request.linkValue'/>" style="display: none;"/>
  <div class="forwarding">
    <jsp:include page="../op/tree.jsp" />

    <div class="right">
      <div class="home">
        <h3><a href="#">我的代运</a> > 我的账户 > <span>费用查询</span></h3>
      </div>
      <div class="lading">
      <div class="headline">
          <ul>
            <li><a href="${pageContext.request.contextPath }/CostOFQuery">费用查询</a></li>
            <li><a href="${pageContext.request.contextPath }/CostOFManager">费用明细</a></li>
          </ul>
          </div>
          <input type="hidden"  name="costvalue"  value="<s:property value="#request.costvalue"/>"/>
          
      <div class="condition" id="condition1" style="display: none;height: 130px;">
            <div style="width: 250px;height: 130px;float: left;">
      		<font style="width:60px;height:15px; float: left;">客户单号：</font>
             <textarea id="style="cw_customerewbcode" name="cw_customerewbcode"  placeholder="输入多个订单号，请用“,”分隔 。" class="order_box" onfocus="if(value==defaultValue){value='';this.style.color='#666'}" onblur="if(!value){value=defaultValue;this.style.color='#666'}" style="color: rgb(153, 153, 153);float: right;">${cw_customerewbcode }</textarea>
      		</div>
          
          <table width="520" border="0" style="float: right;">
            <tr>
            <!-- <td width="30%">客户单号：
                <input name="cw_customerewbcode" type="text" style="width:165px;"  value="<s:property value="#request.cw_customerewbcode"/>"/></td> -->
              <td width="50%" ><span style="margin-left:-20px;">服务商单号：</span>
                <input name="cw_serverewbcode" type="text" style="width:165px;"  value="<s:property value="#request.cw_serverewbcode"/>"/></td>
              
              <td width="50%" align="right">运单状态：
                <select id="Cwscwscode" name="Cwscwscode" style="width:170px;height:26px;">
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
            </tr>
            <tr>
              <td width="50%">付费模式：
	                <select name="payment" id="payment" style="width:170px;height:26px;" >
	                  <option value="">--------请选择--------</option>
	            	  <option value="APP">预付</option>
                	  <option value="ACC">到付</option>
                	  <option value="AFR">免费</option>
	                </select>
	           </td>
              	<td width="50%" align="right">公司单号：
               		<input name="cw_ewbcode" type="text" style="width:165px;"  value="<s:property value="#request.cw_ewbcode"/>"/>
              	</td>
               <!-- <td width="30%" align="right">目的城市：
	               <select name="entrust" style="width:170px;height:26px;">
	                  <option value="">----请选择----</option>
	                </select>
                </td>
                 --> 
            </tr>
           <tr>
             <td colspan="2">创建时间：
                <input name="startdate" type="text" value="<s:property value='#request.startdate'/>" src="${pageContext.request.contextPath}/images/time.png" style="  width:165px; height:24px" 
               	 class="Wdate"	id="startdate" onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>
                <!--<span style="padding-right:28px; font-size:18px; background:url(${pageContext.request.contextPath}/images/to.png) no-repeat left center;"></span>-->
				<span style="">&nbsp;&nbsp;截止时间：</span>
                <input name="enddate" type="text" value="<s:property value='#request.enddate'/>" src="${pageContext.request.contextPath}/images/time.png" style=" width:165px; height:24px" 
               	class="Wdate" id="enddate"  onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"	/>&nbsp;&nbsp;
       
                
                </td>                       
             </tr>
              
          </table>
          </div>
          
          
          
          
      <div class="condition" id="condition2" style="display: none;">
      		<s:set var="column" value="#request.objWaybillforbillColumns"></s:set>
          <table width="818" border="0">
            <tr>
            <td width="30%" >客户单号：
                <input disabled="disabled" name="order" type="text" style="width:165px;" value="<s:property value="#column.cwCw_customerewbcode"/>" /></td>
              <td width="40%"><span style="margin-left:3px;" >服务商单号：</span>
                <input disabled="disabled" name="order" type="text" style="width:165px;" value="<s:property value="#column.cwCw_serverewbcode"/>"/></td>
              <td width="30%" align="right">公司单号：
                <input disabled="disabled" name="order" type="text" style="width:165px;" value="<s:property value="#column.cwCw_ewbcode"/>"/></td>
            </tr>
           <tr>
            <td width="30%" >客户简称：
                <input disabled="disabled" name="order" type="text" style="width:165px;" value="<s:property value="#column.coCo_sname"/>"/></td>
              <td width="40%"><span style="margin-left:15px;">到货主单：</span>
                <input disabled="disabled" name="order" type="text" style="width:165px;" value="<s:property value="#column.bwBw_labelcode"/>"/></td>
              <td width="30%" align="right">付费模式：
                <input disabled="disabled" name="order" type="text" style="width:165px;" value="<s:property value="#column.pmPm_name"/>"/></td>
            </tr>
            <tr>
            <td width="30%" >货物类型：
                <input disabled="disabled"  name="order" type="text" style="width:165px;" value="<s:property value="#column.ctCt_name"/>"/></td>
              <td width="40%"><span style="margin-left:26px;">收货点：</span>
                <input  disabled="disabled" name="order" type="text" style="width:165px;" value="<s:property value="#column.odtDt_hubcode"/>"/></td>
              <td width="30%" align="right">客户代码：
                <input  disabled="disabled" name="order" type="text" style="width:165px;" value="<s:property value="#column.coCo_code"/>"/></td>
            </tr>
            <tr>
            <td width="30%" >出货主单：
                <input  disabled="disabled" name="order" type="text" style="width:165px;" value="<s:property value="#column.dbwBw_labelcode"/>"/></td>
              <td width="40%"><span style="margin-left:15px;">代理渠道：</span>
                <input disabled="disabled"  name="order" type="text" style="width:165px;" value="<s:property value="#column.chnChn_sname"/>"/></td>
              <td width="30%" align="right">销售产品：
                <input  disabled="disabled" name="order" type="text" style="width:165px;" value="<s:property value="#column.pkPk_sname"/>"/></td>
            </tr>
            <tr>
            <td width="30%" >目的国家：
                <input  disabled="disabled" name="order" type="text" style="width:165px;" value="<s:property value="#column.sdtDt_hubcode"/>"/></td>
              <td width="40%"><span style="margin-left:15px;">代理商重：</span>
                <input  disabled="disabled" name="order" type="text" style="width:165px;" value="<s:property value="#column.cwCw_serverchargeweight"/>"/></td>
              <td width="30%" style="padding-left: 10px;">收货重量：
                <input  disabled="disabled" name="order" type="text" style="width:40px;" value="<s:property value="#column.cwCw_grossweight"/>"/>
               	 件数：
                <input  disabled="disabled" name="order" type="text" style="width:40px;" value="<s:property value="#column.cwCw_pieces"/>"/></td>
            </tr>
         
          </table>
          </div>     
          

          
          
        <div class="button" id="button1" style="display: none;" > 
          <button class="buttonbg" value="" type="button" onclick="GotoSerachPage();">刷新</button>
          <button class="buttonbg" value="" type="button" onclick="searchCost();">查询</button>
          <button class="buttonbg" value="" type="button" onclick="exportCost();">导出</button>
        </div>
        
        <div class="button" id="button2" style="display: none;"> 
          <!-- <button class="buttonbg" value="" type="button" onclick="GotoSerachPage();">保存</button>
          <button class="buttonbg" value="" type="button" onclick="GotoSerachPage();">添加</button>
          <button class="buttonbg" value="" type="button" onclick="GotoSerachPage();">删除</button>
          <button class="buttonbg" value="" type="button" onclick="GotoSerachPage();">确定</button>
          <button class="buttonbg" value="" type="button" onclick="GotoSerachPage();">审核</button>
          <button class="buttonbg" value="" type="button" onclick="GotoSerachPage();">重新计费</button>
          <input type="checkbox" name="" id="" onclick="showAllCost();" style=""/>显示所有费用 -->
        </div>
        
        
        <div class="result" id="result1" style="display: none;">
<table id="attributeval" class="manage_form" style="margin: 0px;" width="1300" cellspacing="1" cellpadding="0" border="0">
						
						<thead>
						<tr style="background:#edf8fd;">
							<td style="text-align: center;" width="40px">
								序号
							</td>
							
							
							
						
							<td width="130">客户运单号</td>										
							<td width="130">服务商单号</td>
							<td width="100">公司运单号</td>
							<td width="60">运单状态</td>
							<td width="50">件数</td>
							
							<td width="50">计费重</td>
							<td width="50">实重</td>
							<!--  <td width="50">应收费用(HKD)</td>-->
							<td width="50">应收费用(RMB)</td>
							<!--  <td width="50">应收费用(USD)</td>-->
							
							<td width="50">收货国家</td>
							<td width="50">提货点</td>
							<td width="50">付费模式</td>
							<td width="150">到货主单</td>
							
							<td width="100">分拨中心</td>
							<td width="150">收货时间</td>
							
						</tr>
						</thead>
						<tbody>
						<s:iterator var="bean" value="#request.objList" status="index">
							<s:set var="#index.index" value="varIndex"></s:set>
							<tr>
								<td style="text-align: center;" height="16px">
									<s:property value="#index.index+1"/>
								</td>
								
								
								
							
								<td width="130"><a style="color: #02ABEE;" href="${pageContext.request.contextPath }/CostOFManager?customerewbcode=<s:property value="#bean.cwCw_customerewbcode"/>&cwcode=<s:property value="#bean.cwCw_code"/>"><s:property value="#bean.cwCw_customerewbcode"/></a></td>											
								<td width="130"><s:property value="#bean.cwCw_serverewbcode"/></td>
								<td width="100"><s:property value="#bean.cwCw_ewbcode"/></td>
								<td width="60"><s:property value="#bean.cwsCws_name"/></td>
								
								
								<td width="50"><s:property value="#bean.cwCw_pieces"/></td>
								<td width="50"><s:property value="#bean.cwCw_grossweight"/></td>
								<td width="50"><s:property value="#bean.cwCw_chargeweight"/></td>
								<!--  <td width="50"><s:property value="#bean.Rvtotal"/></td>-->
								<td width="50"><s:property value="#bean.Rvrmbtotal"/></td>
								<!--  <td width="50"><s:property value="#bean.Rvusdtotal"/></td>-->
								
								<td width="50"><s:property value="#bean.sdtDt_hubcode"/></td>
								<td width="50"><s:property value="#bean.odtDt_hubcode"/></td>
								<td width="50"><s:property value="#bean.pmPm_name"/></td>
								<td width="150"><s:property value="#bean.bwBw_labelcode"/></td>
								
						
								<td width="100"><p>
						 	 			 <s:property value="#bean.Eeee_sname"/></p>
						 	 	</td>
								<td width="150">
									<s:property value="#bean.bwAdd_date"/>
								</td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
        </div>
        
        
        
        <div class="result" id="result2" style="display: none;">
			<table id="attributeval" class="manage_form" style="margin: 0px;" width="850" cellspacing="1" cellpadding="0" border="0">
						<thead>
						<tr style="background:#edf8fd;">
							<td style="text-align: center;" width="40px">
								序号
							</td>
							<td width="118">费用名称</td>
							<td width="20">费用状态</td>
							<!--  <td width="100">客户简称</td>-->
							
							<td width="50">实际金额</td>
							<td width="50">金额</td>
							<td width="50">币种</td>
							<td width="50">单价</td>
							<td width="50">单位数量</td>										
							
							
							
						</tr>
						</thead>
						<tbody>
						<s:iterator var="bean" value="#request.receiveList" status="index">
							<s:set var="#index.index" value="varIndex"></s:set>
							<tr>
								<td style="text-align: center;" height="16px">
									<s:property value="#index.index+1"/>
								</td>
								<td width="118"><s:property value="#bean.fkFkname"/></td>
								<td width="50"><s:property value="#bean.fsFsname"/></td>
								<!-- <td width="100"><s:property value="#bean.coConame"/></td> -->
								
								<td width="20"><s:property value="#bean.rvRvactualtotal"/></td>
								<td width="50"><s:property value="#bean.rvRvtotal"/></td>
									<td width="50"><s:property value="#bean.ckCkname"/></td>
								<td width="50"><s:property value="#bean.rvRvunitprice"/></td>
								<td width="50"><s:property value="#bean.rvRvunitnumber"/></td>										
								
							

							</tr>
							</s:iterator>
						</tbody>
					</table>
        </div>
        
        
      </div>
    </div>
  </div>
 </form> 
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
</body>
</html>
