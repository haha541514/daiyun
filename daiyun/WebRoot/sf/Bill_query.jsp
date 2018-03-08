<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@taglib uri = "/project" prefix="p" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>账单查询</title>
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
function Detail(brid_code){
	var url = "queryBillRecordForDetial?brBrid="+brid_code;
	window.open(url,"_blank");
}
function loadPDF(brid_code){
	$.ajax({
		url : "downloadBillRecord?brBrid="+brid_code,
		type : 'post',
		success : function(message) {
			if (message != null) {
				var url="${pageContext.request.contextPath }"+message;
				window.open(url,"_blank");
				//location.href(url);
			} 		
		}
	});
}
	
function loadExcel(brid_code){
	$.ajax({
		url : "downloadBillRecordForExcel?brBridcode="+brid_code,
		type : 'post',
		success : function(message) {
			if (message != null) {
				var url="${pageContext.request.contextPath }/download/"+message;
				window.open(url,"_blank");
				//location.href(url);
			} 		
		}
	});
}		
function exportInfo(){
	var isExport=confirm("确认导出数据？");
	if(!isExport){
		return false;
	}	
	var tablelen= $("#attributeval").find("tr").length;	
	if(tablelen==3){
		strStartdate="1900-03-01 00:00:00";
		strEnddate="1900-03-01 00:00:00";
		strAbwcode="";
		strCocode="";
		dateType="";
	}else if(tablelen==4){
		var obj=$("#attributeval tr td[class='selected']");
		var prev1=obj.parent();
		var tdcontent=prev1.find("td").eq(obj.index()).find("h3").eq(0).html();
		var tdcontent1="对不起,没有查询到对应条件的记录！";
		if(tdcontent==tdcontent1){
			strStartdate="1900-03-01 00:00:00";
			strEnddate="1900-03-01 00:00:00";
			strAbwcode="";
			strCocode="";
			dateType="";
		}
	}
	$.ajax({
		url : 'importExcel',
		type : 'post',
		data : {dateType : dateType,strStartdate : strStartdate,strEnddate : strEnddate,strCocode : strCocode,strAbwcode : strAbwcode},
		success : function(message) {
			if(message!=null){//请求成功后的毁掉函数
				var url="${pageContext.request.contextPath }/download/accountsForBill/"+message;
//				window.open(url,"_blank");
//				window.location.href(url);
				window.open(url,"_self");
			}
		}
	});
}

var GotoSerachPage = function(){
	$('#myform').attr({action:'queryBillRecord',method:'post'});
	//$('#myform').attr('action','queryBillRecord');//默认get方式
	$('#myform').submit();
}
var seachAccount = function(){
	$('#myform').attr({action:'queryNotAccountDetail',method:'post'});
	$('#myform').submit();
}

$(function(){
	var linkValue = $("input[name='linkValue']").val();
	console.log(linkValue);
	if(linkValue == 'BillRecord'){//账单界面
		$('#queryNotAccount').hide();
		$('#exportBill').hide();
		$('#seachAccount').hide();
		$('#timeType').hide();
	}else if (linkValue == 'queryNotAccountDetail'){//未出帐界面


		$('#queryBill').hide();
		$('#refresh').hide();
		$('.all_orders ul li').eq(0).removeClass('first');
		$('.all_orders ul li').eq(1).addClass('first');
	}	
	
})



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
 <form id="myform"> 
 	<input name="linkValue" id="linkValue" value="<s:property value='#request.linkValue'/>" style="display: none;"/>
  <div class="forwarding">
    <jsp:include page="../op/tree.jsp" />
     <jsp:include page="../sf/QQCommunicate.jsp" />
    <div class="right">
      <div class="home">
        <h3>我的代运  > 我的订单 > <span>账单查询</span></h3>
      </div>
      <div class="bill">
      
        <div class="condition" id="billButton">
          <table width="818" border="0" >
            <tr>
              <td colspan="3">创建时间：


                <input name="startdate" type="text" value="<s:property value='#request.startdate'/>" src="${pageContext.request.contextPath}/images/time.png" style="  width:170px; height:24px" 
               	 class="Wdate"	id="startdate" onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>
                <!--<span style="padding-right:28px; font-size:18px; background:url(${pageContext.request.contextPath}/images/to.png) no-repeat left center;"></span>-->
				<span>&nbsp;&nbsp;&nbsp;截止时间:</span>
                <input name="enddate" type="text" value="<s:property value='#request.enddate'/>" src="${pageContext.request.contextPath}/images/time.png" style=" width:170px; height:24px" 
               	class="Wdate" id="enddate"  onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"	/>&nbsp&nbsp
                <button class="buttonbg" id="refresh" value="" type="submit" onclick="GotoSerachPage();" >查询</button>
                <button class="buttonbg" id="seachAccount" type="submit" onclick="seachAccount();" >查询</button>
                <button class="buttonbg" id="exportBill" type="button" onclick="exportInfo();"  >导出Excel</button>
                
                </td>                       
                 
            </tr>
            
           
          </table>
        </div>
        	<div id = "timeType" class="condition">
        		<tr>
            		<td align="right" width="65px" >时间类型：</td>
						<td align="left">
							<s:set var="dateType" value="#request.dateType"/>
							<select name="dateType" id="dateType" style="height:26px">
								<s:if test='#dateType==null || "signindate".equals(#dateType)'>
									<option value="signindate" selected="selected">收货日期</option>
									<option value="occurdate">费用日期</option>
								</s:if>
								<s:else>
									<option value="signindate">收货日期</option>
									<option value="occurdate" selected="selected">费用日期</option>
								</s:else>
							</select>
						</td> &nbsp;&nbsp;&nbsp;
 
                 <td align="right" width="65" style="margin-left: 20ps;">到货主单：</td>
						<td >
							<input type="hidden" id="stra" value="<s:property value='#request.strAbwcode'/>" />
							<select id="sel" style="width: 192px;height:26px" name="strAbwcode">
							<option value="">=======请选择=======</option>
									<s:iterator var="bean" value="#request.listRFBColumns">
								<option value="<s:property value='#bean.Abwbwlabelcode'/>"><s:property value="#bean.Abwbwlabelcode"/></option>
							</s:iterator>	
							</select>
						</td>
					</tr>
          	  </div>
        <div class="all_orders">
          <ul>
            <li class="first"><a href="${pageContext.request.contextPath}/queryBillRecord">所有账单</a></li>
            <li><a href="${pageContext.request.contextPath}/queryNotAccountDetail">未出账</a></li>
          </ul>
          
          
          <!-- 账单界面 -->
         <div id="queryBill">
          <table width="860" border="0">
            <tr style="background:#edf8fd;">
              <td>账单编号</td>
              <td>账单日期</td>
              <td>账单金额</td>
              <td>类型</td>
              <td>操作</td>
              <td>状态</td>
              <td>备注</td>
            </tr>
            
            <s:if test="#request.listBillrecord == null || #request.listBillrecord.size() == 0">
            <tr>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            </s:if>
           
            <s:else>
            
              <s:iterator var="bean" value="#request.listBillrecord" >
              <tr>
              <td><s:property value="#bean.Brbrid"/></td>
              <td><s:property value="#bean.Brbroccurdate"/></td>
              <td><s:property value="#bean.Brbrtotal"/></td>
              <td><s:property value="#bean.Bkbkname"/></td>
              <td>
             	 <s:url var="detialUrl" action="page/queryBillRecordForDetial">
				<s:param name="brBrid"><s:property value="#bean.Brbrid"/></s:param>	
				</s:url>
				<s:url var="downloadUrl" action="downloadBillRecord">
					<s:param name="brBrid"><s:property value="#bean.Brbrid"/></s:param>	
				</s:url>
				<s:url var="downloadExcelUrl" action="downloadBillRecordForExcel">
					<s:param name="brBridcode"><s:property value="#bean.Brbrid"/></s:param>	
				</s:url>
				<s:a href="%{detialUrl}">明 细</s:a>
				<s:a href="%{downloadUrl}">&nbsp;&nbsp;下载(pdf)</s:a>
				<a href="javascript:void(0);"  onclick="loadExcel(<s:property value="#bean.Brbrid"/>);">&nbsp;&nbsp;下载(excel)</a>
		</td>
              <td><s:property value="#bean.Brsbrsname"/></td>
              <td><s:property value="#bean.Brbrremark"/></td>
            </tr>
         	</s:iterator> 
            </s:else>
          </table>
          		<div class="page"  style="margin-right: 10px; float: right">
					<p:pager url="queryBillRecord" />
				</div>
        </div>
        
        <!-- 未出帐界面  -->
         <div id= "queryNotAccount">
			<div class="admin_table" style="OVERFLOW-y: auto; OVERFLOW-x: auto; WIDTH: 870px; HEIGHT: 335px;">
        	 <table  id="attributeval" width="1760px" border="0" cellpadding="0" cellspacing="1" >
                     <thead>
                     <tr align="center"   style="background:#edf8fd;">
                     		<td rowspan="3" width="45" align="center" 
                     			onclick="$.simpleTableSort(this, 0, true);" >
                     			序号
                     		</td>
                     		<td width=200 height="40px;" rowspan="3"  align="center" 
                     			onclick="$.simpleTableSort(this, 1, false);" >
								<strong>到货日期</strong>
							</td>
							<td width=100 height="40px;" rowspan="3"  align="center" 
								onclick="$.simpleTableSort(this, 2, false);" >
								<strong>运单号</strong>
							</td>
							<td width=100 rowspan="3"  align="center" 
								onclick="$.simpleTableSort(this, 3, false);" >
								<strong>百千诚运单号</strong>	
							</td>									
							<td width=100 rowspan="3"  align="center"
								onclick="$.simpleTableSort(this, 4, false);" >
								<strong>转单号</strong>									</td>																
							<td width=140 rowspan="3" 
								onclick="$.simpleTableSort(this, 5, false);" >
								<strong>产品</strong>									</td>
							<td width=100 rowspan="3" 
								onclick="$.simpleTableSort(this, 6, false);" >
								<strong>贷物类型</strong>									</td>
							<td width=60 rowspan="3" 
								onclick="$.simpleTableSort(this, 7, true);" >
								<strong>件数</strong>									</td>
							<td  id="grossweight" width=80 rowspan="3" 
								onclick="$.simpleTableSort(this, 8, true);" >
								<strong>实重(kg)</strong>									</td>
							<td  width=100 rowspan="3" 
								onclick="$.simpleTableSort(this, 9, true);" >
								<strong>体积重(kg)</strong>									</td>
							<td id="tableSort" width=100 rowspan="3" 
								onclick="$.simpleTableSort(this, 10, true);" >
								<strong>计费重(kg)</strong>									</td>
								
								
							<td width=120 rowspan="3"  
								onclick="$.simpleTableSort(this, 11, false);" >
								<strong>目的地</strong>									</td>
							<td width=60 colspan="5"  >
								<strong>应收费用</strong>									</td>
						</tr>
						<tr align="center" style="background:#edf8fd;">
							<td width=100 height="20px;" rowspan="2" 
								onclick="$.simpleTableSort(this, 12, true);" >
								<strong>运费</strong>									
							</td>
							<td width=100 height="20px" rowspan="2" 
								onclick="$.simpleTableSort(this, 13, true);" >
								<strong>燃油费</strong>									
							</td>
							<td width=80 height="20px" colspan="2"  >
								<strong>杂费</strong>									
							</td>
							<td width=120 height="20px" rowspan="2" 
								onclick="$.simpleTableSort(this, 16, true);" >
								<strong>本位币合计</strong>									
						    </td>
						</tr>
						<tr align="center" style="background:#edf8fd;">
							<td width=120  height="20px"  
								onclick="$.simpleTableSort(this, 14, false);" >
								<strong>杂费项目</strong>									
							</td>
							<td width=100  height="20px" 
								onclick="$.simpleTableSort(this, 15, true);" >
								<strong>金额</strong>									
							</td>
							
	
								
						</tr>
						</thead>
						<tbody id="info">
					<%int i=0; %>
					<s:iterator var="bean" value="#request.listRFBColumns" status="index">
					<%i++;if(i%2==0){ %>
					<tr class="manage_form_bk">
					<%}else{ %>
					<tr class="manage_form_bk2">
					<%} %>
					<td><s:property value="#index.index + 1" /></td>
					<td class="selected" width=200 align="left"><s:property value="#bean.Rvrvoccurdate" /></td>
					<td width=100 align="left"><s:property value="#bean.Cwcwcustomerewbcode" /></td>
					<td width=100 align="left"><s:property value="#bean.Cwcwewbcode" /></td>					
					<td width=100 align="left">
					<s:if test='#bean.Pkpkshowserverewbcode!=null&&"N".equals(#bean.Pkpkshowserverewbcode)'>
						<s:property value="#bean.Cwcwewbcode" />
					</s:if>	  
					<s:else>
						<s:property value="#bean.Cwcwserverewbcode" />
					</s:else>
					</td>																		
					<td width=140 align="left"><s:property value="#bean.Pkpkname" /></td>
					<td width=100 align="left"><s:property value="#bean.Ctctname" /></td>
					<td width=60 align="right"><s:property value="#bean.Cwcwpieces" /></td>
					<td width=80 align="right"><s:property value="#bean.Cwcwgrossweight" /></td>
					<td width=80 align="right"><s:property value="@java.lang.String@format('%.3f',@java.lang.Double@parseDouble(@kyle.leis.eo.operation.corewaybill.dax.CorewaybillDemand@getVolumeweight(#bean.Cwcwcode)))"/></td>
					<td width=80 align="right"><s:property value="#bean.Cwcwchargeweight" /></td>
					<td width=120 align="left">
					<s:if test="#bean.Cddtdtname!=null">
						<s:property value="#bean.Cddtdtname" />
					</s:if>
					<s:elseif test="#bean.Odtdtname!=null">
						<s:property value="#bean.Odtdtname" />
					</s:elseif>
					<s:else>&nbsp;</s:else>
					</td>
					<td width=80 align="right"><s:property value="#bean.Rvrvunitnumber" /></td>
					<td width=120 align="right"><s:property value="#bean.Rvrvunitprice" /></td>
					<td width=60 align="left"><s:property value="#bean.Pmpmname" /></td>
					<td width=60 align="right"><s:property value="#bean.Pmpmcode" /></td><!-- 金额 -->
					<td width=60 ><div align="right" style="margin-right:-0px;"><s:property value="#bean.Rvrvactualtotal" /></div></td><!-- 本币为合计 -->
				</tr>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
				<!-- 这里统计金额 -->
				
				</s:iterator>
					<!-- 判断定制块的值是否为空 -->
					<s:set var="queryAccount" value="#request.listRFBColumns" />
					<s:if test="#queryAccount.size()==0">
						<tr class="manage_form_bk2">
							<td class="selected" colspan="18"><h3 style="color: red;">对不起,没有查询到对应条件的记录！</h3></td>
						</tr>
					</s:if>
					<s:if test="#queryAccount==null">
						<tr class="manage_form_bk2">
							<td class="selected" colspan="18"><h3 style="color: red;">对不起,没有查询到对应条件的记录！</h3></td>
						</tr>
					</s:if>
					</tbody>
			  </table> 
         	</div>
				<TABLE cellSpacing=1 cellPadding=0 width="580" bgColor=#f9f9f9 border=0 height="50">
				<tr>
      				<td align="left" width=80 > 统计金额： </td>
        			<td align="left" width=120 >
        				<label id="moneyTotal"><s:property value="#request.totalMoney"/></label>
          			</td>
          			<td align="left" width=80>统计票数：</td>
          			<td align="left" >
        				<label id="billCountsTotal"><s:property value="#request.listRFBColumns.size()"/></label>
          			</td>
          			
          				<td align="left" width=80 >总重量：</td>
          				<td align="left" >
        			<label id="billCountsTotal"><s:property value="#request.totalWeight"/></label>
        				
          			<br /></td>
          			
	 			</tr>
			</TABLE>
        </div>
 
 
          	 
 
 
        
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
