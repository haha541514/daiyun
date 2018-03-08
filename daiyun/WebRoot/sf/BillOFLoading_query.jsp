<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@taglib uri = "/project" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>提货单查询</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/Ext3/css/ext-all.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
	
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_total.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_page.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<style>

.page { text-align:right; margin-top:10px; height:26px; padding:3px 0px;color: #000000;}
.page a { display:inline; border:1px solid #ccc; height:20px; line-height:20px; margin-left:5px; padding:2px 7px;}
.page a:hover { border:1px solid #3a739d; text-decoration:none; color:#3a739d; background:#f6fbff;}
</style>
<script type="text/javascript">
var serach = function(){
	var linkvalue = $("input[name='linkvalue']").val();
	if(linkvalue = '1'){
		
		$('#myform').attr('action','${pageContext.request.contextPath }/order/BillLoading');			
		$('#myform').submit();			
	}else if(linkvalue = '2'){
		$('#myform').attr('action','${pageContext.request.contextPath }/order/BillLoadingManager');			
		$('#myform').submit();			
	}
	
}
var refresh = function(){
	var linkvalue = $("input[name='linkvalue']").val();
	if(linkvalue = '1'){
		document.location.href	='${pageContext.request.contextPath }/order/BillLoading';	
	}else if(linkvalue = '2'){
		document.location.href	='${pageContext.request.contextPath }/order/BillLoadingManager';	
	}			
}

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
function newCreate(){//ajax
if(checkValueValidate()){
		$('#myform').attr('action','${pageContext.request.contextPath }/order/CreateBill');
		$('#myform').submit();
	}
}
function saveBill(){
	if(checkValueValidate()){
		$.post("${pageContext.request.contextPath }/order/SaveBill", 
			$("#myform").serialize(),
			function(data){
				if(data =='1'){
					alert('保存成功');
				}else{
					alert('保存失败');
				}
		});	
	}	
}
function InvalidBill(){
	var bwcode = $("input[name='bwcodehidden']").val();
	if(bwcode != ''){
		var diableTwbscode = $('#diableTwbscode').val();
		if(diableTwbscode != ''){
			alert('新建状态才可以作废');
		}else{
			if(confirm('是否作废')){
				$.post("${pageContext.request.contextPath}/order/InvalidBill", 
					{bwcode:bwcode},
					function(data){
						if(data =='1'){
							alert('作废成功');
						}else{
							alert('修改保存失败');
						}
					});	
			}
		}	
	}		
}
$(document).ready(function(){
	var linkvalue = $("input[name='linkvalue']").val();
	var statusvalue = '';
	var obj = null;
	if(linkvalue == '1'){
	$('.all_orders ul li').eq(0).addClass('first');
		$('#result').show();
		$('#condition1').show();
		$('#button1').show();
		statusvalue = $("input[name='bwsStatusInput']").val();
		obj = $('#bwsStatus');
	}else if(linkvalue == '2'){
		$('.all_orders ul li').eq(1).addClass('first');
		$('#condition2').show();
		$('#button2').show();
		statusvalue = $("input[name='bwsStatusInput2']").val();
		obj = $('#bwsStatus2');
	}
	changeStatus(obj,statusvalue);
	disableInput();
})
function changeStatus(obj,value){
	if(value == null || value ==''){
		}else if(value == 'NW'){
			$('#'+$(obj).attr('id') +' option').eq(1).attr('selected','selected');
		}else if(value == 'EL'){
			$('#'+$(obj).attr('id') +' option').eq(2).attr('selected','selected');
		}else if(value == 'CT'){
			$('#'+$(obj).attr('id') +' option').eq(3).attr('selected','selected');
		}else if(value == 'AA'){
		 	$('#'+$(obj).attr('id') +' option').eq(4).attr('selected','selected');
		}else if(value == 'AP'){
		 	$('#'+$(obj).attr('id') +' option').eq(5).attr('selected','selected');
		}else if(value == 'DA'){
		 	$('#'+$(obj).attr('id') +' option').eq(6).attr('selected','selected');
		 }
}
function checkValueValidate(){
//货物重量不能为空，货物件数不能为小数，备注长度，公司名不能大于50，联系电话纯数字，
	var isValidate = false;
	var bw_totalgrossweight = $("input[name='bw_totalgrossweight']").val();
	if(bw_totalgrossweight == '' || !(/[1-9]\d*.\d*|0.\d*/).test(bw_totalgrossweight)){
		alert('重量必须是数字，例如：100.20')
		return false;
	}
	var bw_totalpieces  = $("input[name='bw_totalpieces']").val();
	if(bw_totalpieces == '' || !(/^[1-9]\d*/).test(bw_totalpieces)){
		alert('件数必须是整数');
		return false;
	}
	if( $("input[name='bw_contactperson']").val() == ''){
		alert('联系人不能为空');
		return false;
	}
	var bw_contacttel = $("input[name='bw_contacttel']").val();
	if(bw_contacttel == '' || !(/0?(13|14|15|18)[0-9]{9}/).test(bw_contacttel) || !(/([0-9-()( )]{7,18})/).test(bw_contacttel)){
		alert('联系电话不对');
		return false;
	}
	if($("input[name='bw_contactaddress']").val() ==''){
		alert('地址不能为空');
		return false;
	} 
	var bw_company = $("input[name='bw_company']").val();
	if(bw_company ==''|| bw_company.length >=50){
		alert('提货公司不能大于50个字符并且不能为空');
		return false(); 
	}
	/*if($("input[name='bwcodehidden']").val() ==''){
		alert('提货编号不能为空');
		return false(); 
	}*/
	return true;
}
function disableInput(){
	var disablevalue = $('#disablevalue').val();
	if(disablevalue !=null && disablevalue != ''){
		$("button[name='createBill']").hide();
		$("input[name='createBillhiden']").show();
		$("input[name='createBillhiden']").css('background-image','url(${pageContext.request.contextPath}/images/button_grey_03.png)');
		
		
	}
	var IsInvalid = $('#IsInvalid').val();
	if(IsInvalid !=null && IsInvalid != ''){
		$("button[name='invalidBut']").hide();
		$("input[name='zuofei']").show();
		$("input[name='zuofei']").css('background-image','url(${pageContext.request.contextPath}/images/button_grey_03.png)');
	}
}
function print(){
	//打印条形码,BillLodingPrint
	$('#myform').attr('target','_blank');
	$('#myform').attr('action','${pageContext.request.contextPath }/order/BillLodingPrint');			
	$('#myform').submit();	
}
$(function(){
	$('#tihuo').change(function(){
		$.post('tihuochange',{scscode:$('#tihuo').val()},
		function(data){
				//解析json字符串
				var jsonObj = JSON.parse(data);  // JSON.parse(); 解析json数据
				//console.log( jsonObj.connectPerson ); 
				$('input[name="bw_contactaddress"]').val(jsonObj.connectAddress);
				$('input[name="bw_contactperson"]').val(jsonObj.connectPerson);
				$('input[name="bw_contacttel"]').val(jsonObj.telephone);
		})
	
	})

})




</script>
	</head>

<body>

<form action="" method="post"  id="myform">
<input type="hidden" name="linkvalue" id="" value="${LinkValue}"/>


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
        <div class="nav_last">
        </div>
      </div>
    </div>
  </div>
  <div class="forwarding">
        	<jsp:include page="../op/tree.jsp" />
        	 <jsp:include page="../sf/QQCommunicate.jsp" />
   <div class="right">
      <div class="home">
        <h3><a>我的代运</a> > 我的订单 > <span>提货单查询</span></h3>
      </div>
      <div class="lading">
      <div class="all_orders">
          <ul>
            <li ><a href="${pageContext.request.contextPath }/order/BillLoading">提货单查询</a></li>
            <li><a href="${pageContext.request.contextPath }/order/BillLoadingManager">提货单管理</a></li>
          </ul>
          </div>
      <div class="condition" id="condition1" style="display: none;">
          <table width="818" border="0">
          	<tr>
            <td width="30%" >开始时间：
              <input name="startdate" type="text" value="<s:property value='#request.startdate'/>" src="${pageContext.request.contextPath}/images/time.png" style="  width:165px;height:22px;" 
               	 class="Wdate"	id="startdate" onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>
              
                </td>
   				 
   				 <td width="30p%" align="left" style="">结束时间：
                 <input name="enddate" type="text" value="<s:property value='#request.enddate'/>" src="${pageContext.request.contextPath}/images/time.png" style=" width:165px;height:22px;" 
               	class="Wdate" id="enddate"  onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"	/>
               
                </td>
            
             	<td width="30p%" align="left"  style="">提货状态：
             		<input type="hidden"  name="bwsStatusInput" value="${bwsStatus }"/>    
                    <select id="bwsStatus" name="bwsStatus"  style="width:165px;height:22px;">                               
                	  <option value="">--------请选择--------</option>
                	  <option value="NW">新建</option>
                	  <option value="EL">作废</option>
                	  <option value="CT">指派</option>
                	  <option value="AD">审核</option>
                	  <option value="AA">完成</option>
                	  <option value="DA">发车</option>
             	   </select>
   
             	 </td>
                     
             
               </tr> 
               <tr>
           		<td width="30%" >提&nbsp;单&nbsp;号：
                          <input type="text" name="bwlablecode" id="bwlablecode" value="${bwlablecode}" style=" width:165px;height:22px;" />
                </td>  				 
   			       
               </tr> 
          </table>
          </div>
           
        <div class="condition" id="condition2" style="display: none;">
        <input type="hidden" id="disablevalue"  value="${disablevalue}"/>
        <input type="hidden" id="IsInvalid"  value="${IsInvalid}"/>
        <s:set var="bean" value="#request.BatchwaybillColumns2"/>
        	<input  type="hidden" id="diableTwbscode"  value="<s:property value='#bean.Ttstwbscode'/>"/>
          <table width="818" border="0">
          	<tr>
              <td width="30%">委托公司：
              <!--<input  readonly="readonly"  type="text" style="width:152px;" name="bweename" value="<s:property value='#request.eename'/> " />-->
               	<select id="eecodeId" name="eecodeId"  style="width:170px;height:26px;">
               	 <s:if test="#bean.Eeeecode==null || #bean == null">
                	<option value="">--------请选择--------</option>
                	<s:iterator var="bean1" value="@com.daiyun.dax.EnterpriseelementDemandPlus@query()">
                		<option value="<s:property value='#bean1.Eeeecode'/>">
                			<s:property value="#bean1.Eeeename"/>
                		</option>
                	</s:iterator>
                </s:if>
                <s:else>
                	<s:iterator var="bean1" value="@com.daiyun.dax.EnterpriseelementDemandPlus@query()">
                		<option value="<s:property value='#bean1.Eeeecode'/>">
                			<s:property value="#bean1.Eeeename"/>
                		</option>
                	</s:iterator>
                </s:else>
               	</select>
               </td>
                <td width="40%" align="center">提货地址：
              <!--<input  readonly="readonly"  type="text" style="width:152px;" name="bweename" value="<s:property value='#request.eename'/> " />-->
               	<select id="tihuo" name="tihuo"  style="width:170px;height:26px;">
               	 <s:if test="#bean.Bwsbwscode==null || #bean == null">
                	<option value="">--------请选择--------</option>
                	<s:iterator var="bean2" value="@com.daiyun.dax.CorewaybillstatusKindDemand@getTihuoAddress()">
                		<option value="<s:property value='#bean2.Scsccode'/>">
                			<s:property value="#bean2.Scscname"/>
                		</option>
                	</s:iterator>
                </s:if>
                <s:else>
                	<s:iterator var="bean2" value="@com.daiyun.dax.CorewaybillstatusKindDemand@getTihuoAddress()">
                		<option value="<s:property value='#bean2.Scsccode'/>">
                			<s:property value="#bean2.Scscname"/>
                		</option>
                	</s:iterator>
                </s:else>
               	</select>
               </td>
               
                 <td width="30%" align="center">联系电话：
                <input type="text" style="width:165px;" name="bw_contacttel" value="<s:property value='#bean.Bwbwcontacttel'/>"/><font color="#FF0000" style="font-weight:bolder; font-size:10px"> *</font></td>
            </tr>
             <tr>
              <td width="30%">预报重量：
                <input  type="text" style="width:165px;" name="bw_totalgrossweight" value="<s:property value='#bean.Bwbwtotalgrossweight'/>"/><font color="#FF0000" style="font-weight:bolder; font-size:10px"> *</font></td>
              	<td width="40%" align="center">预报件数&nbsp;：
                <input  type="text" style="width:165px;" name="bw_totalpieces"  value="<s:property value='#bean.Bwbwtotalpieces'/>"/><font color="#FF0000" style="font-weight:bolder; font-size:10px"> *</font></td>
                 <td width="30%" align="center">公司名称：
                <input   type="text" style="width:165px;" name="bw_company" value="<s:if test='#bean != null'><s:property value='#bean.Bwbwcontactcompany'/></s:if><s:else><s:property value='#request.eename'/></s:else>"/>
               
                <font color="#FF0000" style="font-weight:bolder; font-size:10px;float:right;padding-top:7px;"> *</font></td>
                
            </tr>
            <tr>
             <td  colspan="2">详细地址：
                <input  type="text" name="bw_contactaddress"  style="width:455px;" value="<s:property value='#bean.Bwbwcontactaddress'/>"/><font color="#FF0000" style="font-weight:bolder; font-size:10px"> *</font></td>
               <td width="40%" align="center">联&nbsp;系&nbsp;人&nbsp;：
                <input  type="text" style="width:165px;"   name="bw_contactperson" value="<s:property value='#bean.Bwbwcontactperson'/>"/><font color="#FF0000" style="font-weight:bolder; font-size:10px"> *</font></td>            
             
            </tr> 
            
            <tr>
            <td colspan="2">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注：
                <input  type="text"  name="bw_remark" style="width:455px;" value="<s:property value='#bean.Bwbwremark'/>"/></td>    
           <td width="30%" >提货编号：
                <input disabled="disabled" type="text" style="width:165px;" name="bw_code" value="<s:property value='#bean.Bwbwlabelcode'/>"/>
                <input type="hidden" name="bwcodehidden" value="<s:property value='#bean.Bwbwcode'/>"/>
                 <input type="hidden" name="bwblabelcode" value="<s:property value='#bean.Bwbwlabelcode'/>"/>
                </td> 
           </tr>
           <tr>
           		
                  
            </tr>      
             
            <tr>      
            
            </tr>
          </table>
          </div>
          
     
        <div class="button" id="button1" style="display: none;"> 
          <button class="buttonbg" value="" type="button" onclick="serach();">查询</button>
          <button class="buttonbg" value="" type="button" onclick="refresh();">刷新</button>
          
        </div>
        
        <div class="button" id="button2" style="display: none;"> 
          <button name="createBill" class="buttonbg" value="" type="button" onclick="newCreate();">新建</button>
          <input name="createBillhiden" type="button" class="buttonbg"  type="button" value="新建" style="display: none;"/> 
          <button class="buttonbg" value="" type="button" onclick="saveBill();">保存</button>
          <button name="invalidBut" class="buttonbg" value="" type="button" onclick="InvalidBill();">作废</button>
          <input  name="zuofei" type="button" class="buttonbg"  type="button" value="作废" style="display: none;"/> 
          <button class="buttonbg" value="" type="button" onclick="refresh();">刷新</button>
          <button class="buttonbg" value="" type="button" onclick="print();">打印</button>
       
        </div>
        
       <div class="result" id="result" style="display: none;">
		<table id="attributeval" class="manage_form" style="margin: 0px;" width="1400px" cellspacing="1" cellpadding="0" border="0">
						
									<thead>
									<tr style="background:#edf8fd;">
									
										<td width="90px">委托客户</td>
										<td width="100px">委托公司</td>
										<td width="160px">提单号</td>
										<td width="65px">提单状态</td>
										<td width="60px">预报重量</td>
										<td width="60px">预报件数</td>										
										<td width="80px">联系人</td>
										<td width="100px">联系电话</td>
										<td width="140px">详细地址</td> 
										<td width="130px">公司名称</td>
										<!--<td width="130px">运输主单</td>
										 <td width="130px">运输code</td> -->
										<td width="65px">运输状态</td>
										<!-- <td width="50px">创建人</td>
										<td width="50px">修改人</td> 
										<td width="140px">创建时间</td>-->
										<td width="140px">修改时间</td>
										<td >备注</td>
									</tr>
									</thead>
						<tbody>			
						<s:set var="beans" value="#request.BatchwaybillColumns" />
						<s:if test="#beans==null || #beans.size()==0">							
							<tr class="manage_form_bk">								
								<td align="left" width="300"  colspan="5"><h3 style="color: red;">对不起,没有查询到对应条件的记录!</h3></td>
							</tr>
						</s:if>
						<s:else>
								
							<s:iterator var="bean" value="#request.BatchwaybillColumns" >	
							<tr >	
							 	
							  <td  width="90px" class="tab6"><s:property value="#bean.Coconame" /></td><!-- -->								  
							  <td  width="100px" class="tab6"><s:property value="#bean.Eeeesname" /></td>
							
							 <!-- <td  width="160px"  class="tab6"><a href="${pageContext.request.contextPath }/order/BillLoadingManager?bwlabelcode=<s:property value='#bean.Bwbwlabelcode' />"><font color="#0000FF"><s:property value="#bean.Bwbwlabelcode" /></font></a></td>提单号 -->
							<td  width="160px"  class="tab6"><a href="${pageContext.request.contextPath }/order/BillLoadingManager?bw_code=<s:property value='#bean.bwBwcode' />"><font color="#0000FF"><s:property value="#bean.Bwbwlabelcode" /></font></a></td>
							  <td  width="65px" class="tab6">
							  		<s:if test="#bean.Bwsbwscode == 'EL' ">作废</s:if>
							  		<s:elseif test="#bean.Ttstwbscode == 'DA' ">发车</s:elseif>
									<s:elseif test="#bean.Ttstwbscode == 'AA'">完成</s:elseif>
									<s:elseif test="#bean.Ttstwbscode == 'CT'">指派</s:elseif>
							  		<s:else>
							  			<s:property value="#bean.Bwsbwsname" />
							  		</s:else>
							  </td><!--提单状态<s:property value="#bean.Bwsbwsname" /> -->	
							 
							  <td width="60px" class="tab6"><s:property value="#bean.Bwbwtotalgrossweight" /></td>
							  <td width="60px" class="tab6"><s:property value="#bean.Bwbwtotalpieces" /></td>
							  <!--<td width="60px" class="tab6"><s:property value="#bean.Bwbwtotalchargeweight" /></td><!-- 结算重量 -->
							  <td width="80px" class="tab6"><s:property value="#bean.Bwbwcontactperson" /></td>
							  <td width="100px" class="tab6"><s:property value="#bean.Bwbwcontacttel" /></td>
						  	  <td width="140px" class="tab6"><s:property value="#bean.Bwbwcontactaddress" /></td> 
							  <td  width="130px" class="tab6"><s:property value="#bean.Bwbwcontactcompany" /></td>
							  <!-- <td  width="130px" class="tab6"><s:property value="#bean.Tttwblabelcode" /></td>
							   <td  width="130px" class="tab6"><s:property value="#bean.Ttstwbscode" /></td>-->
							  <td  width="65px" class="tab6">
								  <s:if test="#bean.Ttstwbscode == 'DA' ">发车</s:if>
								  <s:elseif test="#bean.Ttstwbscode == 'AA'">完成</s:elseif>
								  <s:elseif test="#bean.Ttstwbscode == 'CT'">指派</s:elseif>
								  <s:else></s:else>
							  </td>				<!-- 运输状态 -->
							 <!--  <td  width="50px" class="tab6"><s:property value="#bean.Copopname" /></td>
							  <td  width="50px" class="tab6"><s:property value="#bean.Mopopname" /></td>
							  <td  width="140px"  class="tab6"><s:property value="#bean.Bwbwcreatedate" /></td> -->
							  <td  width="140px" class="tab6"><s:property value="#bean.Bwbwmodifydate" /></td>
							  <td  class="tab6"><s:property value="#bean.Bwbwremark" /></td>
						
								
								
								</tr>
								</s:iterator>
							
							</s:else>
									
									
										
									</tbody>
								</table>
        </div>
        <div class="pageNav" id= "pageNav"> 
        <!--<span><a disabled="disabled" style="margin-right:5px;">首页</a></span><span><a disabled="disabled" style="margin-right:5px;">上一页</a></span><span style="margin-right:5px;font-weight:Bold;color:red;">1</span><span><a disabled="disabled" style="margin-right:5px;">下一页</a></span><span><a disabled="disabled" style="margin-right:5px;">尾页</a></span> -->
   				<p:pager url="BillLoading" />
        
        
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
</form>
</body>
</html>