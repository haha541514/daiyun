<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>

<%@taglib uri = "/project" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>价格查询</title>
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
$(function(){
	var linkvalue = $('input[name="linkValue"]').val();
		console.log(linkvalue);
		$('#condition'+linkvalue).show();
		$('#button'+linkvalue).show();
		$('#result'+linkvalue).show();
		$('.headline ul li').eq(linkvalue-1).attr('class','first');
	})
function searchPrice(){
	var checkbox = $('input[name="checkbox"]').val();
	console.log(checkbox);
	$('#myform').attr("action", "Price_Query");
	$('#myform').submit();
	
}
function refresh(){
	$('#myform').attr("action", "Price_Query");
	$('#myform').submit();
	
}
function exportPrice(){
	var isexport = $('input[name="isexport"]').val();
	if(isexport == '1'){
	//没有查询时不能导出
	$.ajax({
		type: "post",
		url:"exportPrice",
		dataType:"text",
		success: function (message) {//返回数据根据结果进行相应的处理  
			if(message!=null){//去路径下下载。 
				var url="${pageContext.request.contextPath }/export_excel/"+message;
				window.open(url,"_blank");
				// window.location.reload();
			}
		}
		});
	}
}		
	
</script>
	</head>

<body>

<div id="main">
 
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
 	
  <div class="forwarding">
    <jsp:include page="../op/tree.jsp" />

    <div class="right">
      <div class="home">
        <h3><a href="#">我的代运</a> > 我的账户 > <span>价格查询</span></h3>
      </div>
      <div class="lading">
      <div class="headline">
          <ul>
            <li><a href="${pageContext.request.contextPath }/Price_Query">价格查询</a></li>
            <li><a href="${pageContext.request.contextPath }/Price_Manage">价格明细</a></li>
          </ul>
          </div>
     <input name="linkValue" id="linkValue" value="<s:property value='#request.linkValue'/>" style="display: none;"/>
     <input name="isexport" type="hidden" value="<s:property value='#request.isexport'/>" />
      <div class="condition" id="condition1" style="height: 160px;display: none;">
            <table width="818" border="0">
            <tr>
             	<td width="30%">客户名称：
             	    <input name="co_coname" disabled="disabled" type="text" value="<s:property  value="#request.co_coname"/>" style="width:165px;height:26px;"/>    
             	</td>
          
             <td width="30%" >销售产品：
		     <select id="pkCode" name="pkCode" style="width:170px;height:26px;">                
                  <option value="">----请选择物流渠道----</option>
                  <s:iterator var="products" value="@com.daiyun.dax.ProductkindDemand@getAllProduct()">
                        <s:if test="(#request.pkCode).equals(#products.Pkcode) ">
                          <option value="<s:property value='#products.Pkcode'/>" selected="selected">
                          <s:property value="#products.Pkname" />
                          </option>
                        </s:if>
                        <s:else>
                          <option value="<s:property value='#products.Pkcode'/>">
                          <s:property value="#products.Pkname"/>
                          </option>
                        </s:else>
                      </s:iterator>             
                </select>      
                </td>
                
                
               <td width="30%">价格状态：
                <select  id="psPscode" disabled="disabled" name="psPscode" style="width:170px;height:26px;">
                          <option value="" >发布</option>
      
                    </select></td>
            </tr>
            
            
           <tr>
            <td width="30%" >付费方式：
                     <select id="pmpmcode" name="pmpmcode" style="width:170px;height:26px;">
                        <s:if test="#request.pmpmcode==null">
                          <option value="" selected="selected" >-------请选择-------</option>
                          <s:iterator var="pm" value="@com.daiyun.dax.PriceDemand@getPaymentmode()">
                            <option value="<s:property value='#pm.pmPmcode'/>">
                            <s:property value="#pm.pmPmname"/>
                            </option>
                          </s:iterator>
                        </s:if>
                        <s:else>
                          <option value="" >-------请选择-------</option>
                          <s:iterator var="pm" value="@com.daiyun.dax.PriceDemand@getPaymentmode()">
                            <s:if test='(#request.pmpmcode).equals(#pm.pmPmcode) '>
                              <option  value="<s:property value='#pm.pmPmcode'/>" selected="selected">
                              <s:property value="#pm.pmPmname"/>
                              </option>
                            </s:if>
                            <s:else>
                              <option  value="<s:property value='#pm.pmPmcode'/>">
                              	<s:property value="#pm.pmPmname"/>
                              </option>
                            </s:else>
                          </s:iterator>
                        </s:else>  
                    </select>
                    
                    </td>
                <td width="30%"><span style="margin-left:5px;">收货点：</span>
                <select id="dtCode" name="dtCode"  style="width:170px;height:26px;">
                <option value="">--------请选择--------</option>
                <s:iterator var="dt" value="@com.daiyun.dax.DistrictqueryDemand@queryStartDistrict()">
                	<s:if test="(#request.dtCode).equals(#dt.diDtcode)">
                		<option value="<s:property value='#dt.diDtcode'/>" selected="selected">
                			<s:property value="#dt.diDtname"/>
                		</option>
                	 </s:if>
                     <s:else>
                		<option value="<s:property value='#dt.diDtcode'/>">
                			<s:property value="#dt.diDtname"/>
                		</option>
                		  </s:else>
                	</s:iterator>
               	
               	</select>            
              </td> 

            </tr>
            
            <tr>
             <td  width="30%">有效日期：
                <input name="startdate" type="text" value="<s:property value='#request.startdate'/>" src="${pageContext.request.contextPath}/images/time.png" style="  width:140px; height:24px" 
               	 class="Wdate"	id="startdate" onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>
               	 <input type="checkbox"  name="checkbox"  value="1"/>
               	 </td>          
            	 <td width="30%">快件类型：
                 <select id="ctCtcode" name="ctCtcode"  style="width:170px;height:26px;">
	                <option value="">--------请选择--------</option>
	                <s:iterator var="cargo" value="@com.daiyun.dax.CargoTypeDemand@queryAllCargotypes()">
	                	<s:if test="(#request.ctCtcode).equals(#cargo.ctCtcode)">
	                		<option value="<s:property value='#cargo.ctCtcode'/>" selected="selected">
	                			<s:property value="#cargo.ctCtname"/>
	                		</option>
	                	 </s:if>
	                     <s:else>
	                		<option value="<s:property value='#cargo.ctCtcode'/>">
	                			<s:property value="#cargo.ctCtname"/>
	                		</option>
	                		  </s:else>
	                </s:iterator>
               	</select>
              	</td>
                <td width="30%">
                 	
              	</td>
                                   
             </tr>
          
         
          </table>
          
         
          </div>
          
          
          
      <div class="condition" id="condition2" style="display: none;">
          <table width="818" border="0">
          	<s:set var="column" value="#request.columns"/>
      		<tr>
      	 		<td width="30%" >销售产品：
                <input  name="customercode" disabled="disabled"  type="text" style="width:165px;" value="<s:property value="#column.pkPkname"/>" /></td>
             	 <td width="30%"><span style="margin-left:16px;">快件类型：</span>
                <input  name="szd" type="text"  disabled="disabled"  style="width:165px;" value="<s:property value="#column.ctCtname"/>"/></td>
          		 <td width="30%"><span>付款方式：</span>
                <input  name="szd" type="text"  disabled="disabled"  style="width:165px;" value="<s:property value="#column.pmPmname"/>"/></td>
          	</tr>
          		<tr>
      	 		<td width="30%" >分区名称：
                <input  name="customercode"   disabled="disabled"  type="text" style="width:165px;" value="<s:property value="#column.znZnname"/>" /></td>
             	 <td width="30%"><span style="margin-left:16px;">生效日期：</span>
                <input  name="szd" type="text"   disabled="disabled"  style="width:165px;" value="<s:property value="#column.epEpstartdate"/>"/></td>
          		 <td width="30%"><span>失效日期：</span>
                <input  name="szd" type="text" disabled="disabled"  style="width:165px;" value="<s:property value="#column.epEpenddate"/>"/></td>
          	</tr>
          	
          	  <tr>
      	 		<td width="30%" >币&nbsp;&nbsp;种：
                <input  name="customercode" type="text"  disabled="disabled"  style="width:165px;" value="<s:property value="#column.ckCkname"/>" /></td>
             	 <td width="30%"><span style="margin-left:16px;">单&nbsp;&nbsp;位：</span>
                <input  name="szd" type="text"  disabled="disabled"  style="width:165px;" value="<s:property value="#column.utUtname"/>"/></td>
          		 <td width="30%"><span style="margin-left:13px;">收货点：</span>
                <input style="width:165px;" name="diDtname"  disabled="disabled"  value="<s:property value="#column.dtDtname"/>" type="text"/></td>
          	</tr>
          	
          	
          </table>
      </div>     
          

          
          
        <div class="button" id="button1" style="display: none;" > 
          <button class="buttonbg" value="" type="button" onclick="refresh();">刷新</button>
          <button class="buttonbg" value="" type="button" onclick="searchPrice();">查询</button>

        </div>
        
        <div class="button" id="button2" style="display: none;"> 
          <button class="buttonbg" value="" type="button" onclick="exportPrice();">导出</button>

        </div>
        
        
        <div class="result" id="result1" style="display: none;">
		<table id="attributeval" class="manage_form" style="margin: 0px;" width="860" cellspacing="1" cellpadding="0" border="0">
						
						<thead>
						<tr style="background:#edf8fd;">
							<td width="70">价格编码</td>										
							<td width="100">销售产品</td>
							<td width="50">货物类型</td>
							<td width="50">付款方式</td>
							<!--<td width="50">代理商</td>-->
							<!--<td width="50">价格状态</td>-->
							<td width="150">生产日期</td>
							<td width="150">失效日期</td>		
							<td width="100">备注</td>
						</tr>
						</thead>
						<tbody>
						<s:iterator var="bean" value="#request.resultList" status="index">
							<tr>
								<td ><a style="color: #02ABEE;" href="${pageContext.request.contextPath }/Price_Manage?epcode=<s:property value="#bean.fpEpcode"/>&epcode=<s:property value="#bean.fpEpcode"/>"><s:property value="#bean.fpEpcode"/></a></td>											
								<td ><s:property value="#bean.pkPkname"/></td>
								<td ><s:property value="#bean.ctCtname"/></td>
								<td ><s:property value="#bean.pmPmname"/></td>
								<!--<td ><s:property value="#bean.coConame"/></td>--><!-- ctCtname包裹类型 -->
								<!--<td ><s:property value="#bean.pdPdname"/></td>-->
								<td ><s:property value="#bean.epEpstartdate"/></td>
								<td ><s:property value="#bean.epEpenddate"/></td>
								<td ><s:property value="#bean.epEpremark"/></td>
							</tr>
								
								
								
							</s:iterator>
						</tbody>
					</table>
        </div>
        
        
        
        <div class="result" id="result2" style="display: none;">
			<table id="attributeval" class="manage_form" style="margin: 0px;" width="800" cellspacing="1" cellpadding="0" border="0">
						<thead>
						
						<tr style="background:#edf8fd;">
							<s:iterator var="bean" value="#request.createTableHead2">
								<td width="50">
									<s:property/>
								</td>
							</s:iterator>	
						</tr>
						</thead>
						<tbody>
						<s:iterator var="map" status="st" value="#request.transFreightvalueList">
							<tr>
								<s:iterator value="#request.transFreightvalueList[#st.index]">
									<td>
										<input type="hidden" value="<s:property value="key"/>"/>
										<s:property value="value"/>
									</td>
								</s:iterator>
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
