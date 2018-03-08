<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>模板设置</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.4.2.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
  </head>
 <script type="text/javascript">
   function saveExcel() {
		var customerLength = $("input[name='customerCheck']:checked").length;
		var templateLength = $("input[name='templateCheck']:checked").length;
		if (customerLength == 0 || templateLength == 0) {
			alert("请选择映射列");
			return false;
		}
		if (templateLength > 1) {
			alert("只能对应一个标准模板映射列");
			return false;
		}

		if($('#cmtCode').val()==""||$('#cmtCode').val()==null){			
			alert("请选择映射方式");
			return false;
		}
		
//		if($('#dmkCode').val()==""||$('#dmkCode').val()==null){
//			alert("请选择基础数据");
//			return false;
//		}

		document.getElementById("form1").action = '${pageContext.request.contextPath }/page/saveData';
		document.getElementById("form1").submit();

	}
	
	function removeExcel() {
		var templateLength = $("input[name='templateCheck']:checked").length;
		if (templateLength == 0) {
			alert("请选择撤销的映射列");
			return false;
		}
		document.getElementById("form1").action = '${pageContext.request.contextPath }/page/removeData';
		document.getElementById("form1").submit();
	}

	function saveTemplate() {
		if(confirm("确定保存模板？")){
			if($('#fileName').val()==""||$('#fileName').val()==null){
				alert("文件名称不能为空");
				$('#fileName').focus();
				return;
			}else{
				document.getElementById("form1").action = '${pageContext.request.contextPath }/page/save';
				document.getElementById("form1").submit();
			}
		}
	}

	function listCountry(){
		//window.open('${pageContext.request.contextPath }/page/listCountry.jsp',"_blank");
		var potId=document.getElementById("potId").value;
		document.form1.action ="${pageContext.request.contextPath }/page/listCountry?potId="+potId;
		document.form1.submit();
	}
       
 </script>
  <body>
  <form id="form1" name="form1" action="" method="post">  
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
        <div class="left">亲，<span><%=session.getAttribute("Opname")%></span> 您好！欢迎登录我的代运！</div>
        <div class="right"><span><a href="${pageContext.request.contextPath}/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath}/op/recharge.jsp" target="_blank">充值</a></span> | <span><a href="#">English</a></span></div>
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
        <h3><a href="#">我的代运</a> > 批量上传 > <span>模板设置</span></h3>
        </div>
        <div class="forwarding">
        <div style="padding-top:40px;">
     <p align="left" >文件名称：
					<input type="hidden" id="potId" value="<s:property value='#session.excelList[0].Potvcomp_idpotid'/>" />
					<input type="text" name="uploadFile" value="<s:property value='#request.pathName'/>" style="width: 192px;" id="fileName" />
						&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;&nbsp;&nbsp;	&nbsp;&nbsp;
					<s:if test="#session.excelList[0].Potvcomp_idpotid==1||#session.excelList[0].Potvcomp_idpotid==284">
						<input type="button" value="保存模板" onclick="saveTemplate()"  disabled="disabled"/>
					</s:if>
					<s:else>
						<input type="button" value="保存模板" onclick="saveTemplate()" />
					</s:else>					
 						&nbsp;&nbsp;&nbsp;&nbsp;
 					<input type="button" value="国家映射" onclick="listCountry()"/>
 					</p><br/>
 					</div>
 				</div>	
			</div>	
	 	<div style="width: 1000px;padding-top:15px" >
        	<table>
            	<tr>
		            <td width="280px">
						<div class="admin_table" style="OVERFLOW-y: auto;OVERFLOW-x: auto; WIDTH: 320px; HEIGHT: 420px;float:left; padding-left:10px;padding-top:15px">
							<div style="height:380px;">
							 
								<table id="cusTemp" width="300" style="border-collapse: collapse;"  border="1" class="manage_form" >
									<tr>
										<td colspan="3" align="center"><font size="3">客户模板</font></td>
							       </tr>
							    
							       <tr class="manage_form_bk4" align="center">
									<td width="30" ><input type="hidden" name="potId" value="<s:property value="#session.excelList[0].Potvcomp_idpotid"/>"/></td>
									<td width="30" height="30">序号</td>
							         <td width="170" height="30">名称</td>    
							       </tr>
							     
							       <s:iterator var="customer" value="#session.excelList" status="index">
							       <tr>
							         <td height="30"> <input style="width:30px;" type="checkbox" value="<s:property value='#customer.Potvcomp_idpotvid'/>" name="customerCheck"/></td>
							         <td align="center" height="30"><s:property value="#customer.Potvcomp_idpotvid"/></td>
							         <td align="center" height="30">
							         <s:property value="#customer.Potvpotvcolumnname"/>       
							         </td>
							       </tr>
									</s:iterator>
								 
								</table>
							</div>
						</div>
					</td>
					<td width="180px" align="center">
						<table style="margin-top: 30px;height:200px">
							<tr style="height: 40px;">
								<td>映射方式
									<select name="cmtCode" id="cmtCode">
										<option value="">===请选择===</option>
										<s:iterator var="cmt" value="@kyle.leis.es.company.predicttemplate.dax.PredicttemplateDemand@queryCMT()">
										<option value="<s:property value="#cmt.Cmtcmt_code"/>"><s:property value="#cmt.Cmtcmt_name"/></option>
										</s:iterator>
									</select>
								</td>
							</tr>
							<tr style="height: 40px;">
								<td>基础数据
									<select name="dmkCode" id="dmkCode">
										<option value="">===请选择===</option>
										<s:iterator var="dmk" value="@kyle.leis.es.company.predicttemplate.dax.PredicttemplateDemand@queryDMT()">
										<option value="<s:property value="#dmk.Dmkdmk_code"/>"><s:property value="#dmk.Dmkdmk_name"/></option>
										</s:iterator>
									</select>
								</td>
							</tr>
							<tr style="height: 40px;">
								<td align="center">
							      <!--  映射列：<input type="text" value="" name="" style="width: 100px;"/><br/><br/>-->
									<input type="button" value="映  射" onclick="saveExcel()" style="width:60px"/>
									<input type="button" name="" value="撤销映射" onclick="removeExcel()"/>
								</td>
							</tr>
						</table>
					
        		</td>
        		<td width="340px">
			        <div class="admin_table" style=" OVERFLOW-y: auto;OVERFLOW-x: auto; WIDTH: 338px; HEIGHT: 420px;float:left;padding-left:10px;padding-top:15px;">
						<div style="height:380px; ">
					  		<table width="320" style="border-collapse: collapse;height:450px;"  border="1" cellspacing="0" cellpadding="0" class="manage_form">
						       <tr>
						         <td colspan="5" align="center"><font size="3" >标准模板</font></td>
						       </tr>
						       <tr class="manage_form_bk4" align="center">
						         <td width="30">&nbsp;</td>
						         <td  height="30" align="center" >名称</td>
						         <td width="50" height="30">动作</td>
						         <td height="30" width="60">映射列</td>
						         <td height="30" width="60" >允许为空</td>
						       </tr>
						       <s:iterator var="template" value="#session.templateList" status="index">
						       <tr >
						         <td height="30"><input type="checkbox" style="width:30px;" name="templateCheck" value="<s:property value='#template.Tctcid'/>" /></td>
						         <td align="center"  height="30"><s:property value="#template.Tctccolumnname"/></td>
						         <td height="30"><s:property value="#session.arrCmt[#template.Tctcid-1]"/></td>
						         <td height="30"><s:property value="#session.arrIndex[#template.Tctcid-1]"/></td>
						         <td align="center" height="30"><s:if test='#template.Tctcallownullsign.equals("Y")'>是</s:if><s:else>否</s:else></td>
						       </tr>
					       	</s:iterator>
					     	</table>
						</div>
					</div>
    			</td>
   			</tr>
    	</table>
   	</div>
	<div style="clear:both"></div>
    </div></div>
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
 
<div id="light" class="white_content"></div> 
</form>
</body>
</html>
