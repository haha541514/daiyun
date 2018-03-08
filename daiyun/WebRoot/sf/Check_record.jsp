<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri = "/project" prefix="p" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>查看记录</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/Ext3/css/ext-all.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
		
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_total.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Forwarding_page.css"/>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/Calendar.css"/>
		<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>

<style type="text/css">
 	.result table .trs td{border:1px solid #dedede; height:27px; line-height:25px; text-align:center;}
	.result table .trs2 td{border:1px solid #dedede; height:27px; line-height:25px; text-align:center;}
	
</style>
<script type="text/javascript">
function doReset(){
		location.href = '${pageContext.request.contextPath}/order/aliImportLog';
	}
	function doSearch(){
		/*var v = $("#totalRecode").val();
		if(isNaN(v)){
			alert("总记录数必须输入数字！");
			$("#totalRecode").focus();
			return;
		}
		if($.trim(v) == ''){
			$("#totalRecode").val('');
		}*/
		document.getElementById("Log").submit();
	}
	//检查是否选中
	function chooseOneAtLeast(){
		var obj = document.myform.elements;		
		var k=0;
		for(var i=0;i<obj.length;i++){
			if (obj[i].name == "checkbox" && obj[i].checked == true){
				document.getElementById("selval").value=obj[i].value;
				k+=1;
			}
		}
		if(k==0){
			alert("请选择一条记录");
			return false;
		}
		if(k>1){
			alert("只能选择一条记录");
			return false;
		}
		return true;
	}
	//查询行数据

	function searchRD(){
		if(chooseOneAtLeast()){
			var sv=document.getElementById("selval").value;
			document.getElementById("Log").action="${pageContext.request.contextPath}/order/aliImportLogDetail?cwlId="+sv;
			document.getElementById("Log").submit();
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
			alert("查询的数据至少多于1条!");
		  }else{
			return true;
		}
	}
	
	function setPageCount(){
		if(checkPageCount()){
			document.getElementById("Log").action="${pageContext.request.contextPath}/order/aliImportLog";
			document.getElementById("Log").submit();
		}
	}

</script>
	</head>

<body>
<form action="aliImportLog" method="post" name="myform" id="Log">
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="${pageContext.request.contextPath }/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath }/op/recharge.jsp" target="_blank">充值</a></span> | <span><a href="#">English</a></span></div>
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
        <h3>我的代运  > 我的订单 > <span>ERP接口订单</span></h3>
      </div>
      <div class="recycle">
      <div class="r_title">查看记录</div>
      <div class="condition">
          <table width="818" border="0">
            <tr>
              
              <td width="35%">开始时间：
              	<input name="startdate" type="text" value="<s:property value='#request.startdate'/>" src="${pageContext.request.contextPath}/images/time.png" style="  width:170px; height:24px" 
               	 class="Wdate"	id="startdate" onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>
              <td width="35%">结束时间：

                <input name="enddate" type="text" value="<s:property value='#request.enddate'/>" src="${pageContext.request.contextPath}/images/time.png" style=" width:170px; height:24px" 
               	class="Wdate" id="enddate"  onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"	/>
               
                </td>
                <td width="30%">总记录数：

                <input type="text" id="totalRecode" name="totalRecode" value="<s:property value='#request.totalRecode'/>"/>
                </td>
            </tr>
          </table>
        </div>
        <div class="button">
          <button class="buttonbg" value="" type="submit" onclick="doReset();">刷新</button>
          <button class="buttonbg" value="" type="submit" onclick="doSearch();">查询</button>
          <button class="buttonbg" value="" type="submit" onclick="searchRD();">查询详情</button>
          <button class="buttonbg" value="" type="submit" onclick="location.href='aliexpressImportUI';">导入订单</button>
        </div>
      </div>
      <div class="result">
		<table id="attributeval"  width="860"    style="margin-top:10px; text-align:center; line-height:24px;   border-collapse:collapse;">
						
			<thead>
			<tr style=" background:#edf8fd;" class="trs">
				<td width="60px" >选择</td>
				<td width="150px"  >上传时间</td>
				<td width="118px"   >总记录数</td>
				<td width="150px"  >失败记录数</td>
				<td width="100px"   >备注</td>
				<td width="150px"  >状态</td>
			</tr>
			</thead>
			
		<tbody id="info">
					<s:if test="#request.cwbimportLogList.size == 0">
						<tr ><td colspan="7"  style="color: red;font-size:16px;font-weight: bold;border:1px solid #dedede;height:33px">抱歉，没有查询到数据!</td></tr>
					</s:if>
					<s:iterator var="bean" value="#request.cwbimportLogList" status="stat">
			
						<tr class="trs2">
							<td width=60px; style="text-align: center;">							
								<input type="checkbox" name="checkbox" value="<s:property value='#bean.Toccwlid'/>"  />		
								<input type="hidden" id="selval" value="" />	    	
							</td>
							<td width=120px; ><s:property value="#bean.Toccwlcreatedate" /></td>									
							<td width=70px; ><s:property value="#bean.Toccwltotalrecords" /></td>
							<td width=70px; ><a title="点击查看" href='aliImportLogDetail?cwlId=<s:property value='#bean.Toccwlid'/>'>
											<font color="red"><s:property value="#bean.Toccwlunsuccessfulrecords" /></font></a></td>
							<td width=350px; ><s:property value="#bean.Toccwlremark" /></td>
							<td width=100px; >
								<s:if test='"C".equals(#bean.Toccwlstatus)'>上传完毕</s:if>
								<s:else>正在上传</s:else>
							</td>													
						</tr>
					</s:iterator>
				</tbody>					
		</table>
              
        </div>
    </div>
	<div style="float: right;" class="page" style="margin-right: 10px">
	设置每页显示&nbsp;<input class="input_text" style="width: 18px;padding-left:7px"  name="customInputCount" id="customInputCount"  type="text" value="<s:property value='#request.pageCount'/>" />&nbsp;条记录&nbsp;&nbsp;&nbsp;&nbsp;
		<input name="pageCountSizeSure" id="pageCountSizeSure" type="button" value="确定" onclick="setPageCount();"
		style="color:#FFF; width:57px; height:27px; line-height:27px; background:url(${pageContext.request.contextPath}/images/print_button.png); border:none; margin:0 5px;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<p:pager url="aliImportLog" />
  </div>
  <div class="clear"></div>
  <div id="bottom">
    <div class="copyright">
      <div class="nir">
        <div class="left"> Copyright © 2012 深圳市代运物流网络有限公司<br />
          (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号 </div>
        <div class="right"><img src="${pageContext.request.contextPath}/images/tel2.jpg" /></div>
      </div>
    </div>
    <div class="bottom_nav"> <a href="#">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
</div>
	
			
</form>

</body>
</html>
