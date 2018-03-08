<%@page language="java" pageEncoding="UTF-8"%>
<%@ page import="kyle.leis.fs.authoritys.user.da.UserColumns"%>
<%@ page import="kyle.common.util.jlang.*"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--打印  -->
<object id=factory viewastext style="display:none" 
	classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" 
	codebase="${pageContext.request.contextPath }/cab/smsx.cab#Version=7,0,0,8">
</object>
<style media="print">
.noprint {
display:none;
	}
</style>

	
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="../css/admin.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/Ext3/css/ext-all.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js">
</script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js">
</script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/component/My97DatePicker/WdatePicker.js">
</script>	
<title>标签打印</title>
<style type="text/css">
	.tab{
	    table-layout: fixed;
	}
</style> 
<script type="text/javascript"> 
    var indexstyle=new Array(1); 
    indexstyle[0]="<link rel='stylesheet' type='text/css' href='../css/compatibility.css'>"; 
    indexstyle[1]="<link rel='stylesheet' type='text/css' href='../css/compatibility2.css'>"; 
   if(-[1,]){ 
    
    document.write(indexstyle[1]);
   }else{ 
  	document.write(indexstyle[0]); 
  } 
 </script>	
<script>
	function rturnHistory(){
	
		document.getElementById("myform").action="${pageContext.request.contextPath }/order/queryTransientOrders?link=transient";
		document.getElementById("myform").submit();
	}
</script>
<script type="text/javascript" charset="UTF-8">
  var cwcode="${dgmCode}";
  var raval= "${raval}";
  if(cwcode!=''){ 
  		console.log('cwcode');
	  if(raval=='5'){
		  console.log('5');
		  window.open("${pageContext.request.contextPath}/PrintPDFLableServlet.xsv?sign=s&cwcode="+cwcode,"_blank");
	  }else{
		  console.log('print');//dgmCode不为空,普通格式下dgmCode为空.
		  window.open("${pageContext.request.contextPath}/PrintPDFLableServlet.xsv?sign=s&isnewv=N&cwcode="+cwcode,"_blank");
	  }
  }
</script>
<script language="javascript"> 
	var HKEY_RootPath="HKEY_CURRENT_USER\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
	var HKEY_Key="";
	// 设置页眉页脚为空
	function PageSetup_del(){      
 	try{
    var WSc=new ActiveXObject("WScript.Shell");    
    HKEY_Key="header";
    WSc.RegWrite(HKEY_RootPath+HKEY_Key,"");
 	HKEY_Key="footer";
    WSc.RegWrite(HKEY_RootPath+HKEY_Key,"");  
       }catch(e){
			alert("没有运行Active控件");
         }
     }
	function SetPrintSettings(){
		if(!factory.object) { 
	    alert("打印控件没有正确安装!"); 
	    	return; 
	  	} else { 
		    factory.printing.leftMargin = 0; 
		    factory.printing.topMargin = 0; 
		    factory.printing.rightMargin = 0; 
		    factory.printing.bottomMargin = 0; 
		}
	//function Print(frame) {
	//factory.printing.Print(true, frame) // print with prompt
	//}
	}
	function  PreviewLable(){
		if (window.ActiveXObject){	
			PageSetup_del();
			SetPrintSettings();
			factory.printing.Preview();
		}else{
			window.print();			
		}
	}
	function printLable(){
		if (window.ActiveXObject){		
			PageSetup_del();
			SetPrintSettings();
			factory.printing.print(true);
		}else{
			window.print();			
		}
	}

	function exportPDF(){
		var cwcode = document.getElementById("checkboxCode").value;
		window.open("${pageContext.request.contextPath }/PrintPDFLableServlet.xsv?sign=s&cwcode="+cwcode,"_blank");
	}
	
</script>
</head>
	<body >
<form action="printAll"  method="post" id="myform">
	<input type="hidden"  value="<s:property value='#session.checkboxCode'/>" id="checkboxCode" name="checkboxCode"/>
	<br/>
		<center class="noprint" style="margin-bottom: 30px;">
			<input type="button" id="PDFPrinter" value="导出PDF" onclick="exportPDF();" />
			<input type="submit" id="allPrinter" value="  打 印   " onclick="printLable();" />
			<input type="button" value="页面设置" onclick="factory.printing.PageSetup()" />
			<input type="submit" id="allPrinter" value="非正常打印" onclick="return window.print(false)" />
			<input type="button" value="打印预览" onclick="PreviewLable()" />
			<input type="button" id="allPrinter2" value=" 返回暂存页面 " onclick="rturnHistory()"/>
		 </center>
	<center> 		 
		<!--设置表头-->
  		<thead style="display:table-header-group;font-weight:bold" >	  									
			<s:if test="#request.raval==1">
				<!-- bq百千宝发票 -->
				<jsp:include page="../include/printPage/bq1.jsp" />
				<!-- 其他格式标签 -->
				<jsp:include page="../include/printPage/ots.jsp" />
				<!-- 香港平邮和香港小包 -->
				<jsp:include page="../include/printPage/xgpy_1.jsp"/>
				<jsp:include page="../include/printPage/xgph_1.jsp"/>
				<!-- 新加坡 -->
				<jsp:include page="../include/printPage/xjbgh.jsp" />
				<jsp:include page="../include/printPage/xjbpy.jsp" />	
				<!-- 瑞典邮政挂号 -->
				<jsp:include page="../include/printPage/swgh.jsp" />
				<!-- 瑞士邮政挂号 -->
				<jsp:include page="../include/printPage/swiss.jsp" />
				<jsp:include page="../include/printPage/orSwiss.jsp" />
				<!-- 其他格式带发件人 -->			
				<jsp:include page="../include/printPage/otsr.jsp" />
				<!-- DHLGlobeMail -->	
				<jsp:include page="../include/printPage/dhlGM.jsp" />
				<jsp:include page="../include/printPage/ppl.jsp" />
				<!--香港GM  -->
				<jsp:include page="../include/printPage/HKGM.jsp" />
				<!--德国GM  -->
				<jsp:include page="../include/printPage/DEGM.jsp" />
				<!--德国以外GM  -->
				<jsp:include page="../include/printPage/EXDEGM.jsp" />
				<!--瑞点GM  -->
				<jsp:include page="../include/printPage/SEGM.jsp" />
				<jsp:include page="../include/printPage/sdhlGM.jsp" />
				<!--法邮 -->
				<jsp:include page="../include/printPage/FL.jsp" />
				<!--平邮 德国 意大利 其他国家 -->	
				<jsp:include page="../include/printPage/PG.jsp" />
				<jsp:include page="../include/printPage/PL.jsp" />
				<jsp:include page="../include/printPage/PO.jsp" />
				<!--桂号 澳大利亚 德国 其他国家 -->
				<jsp:include page="../include/printPage/GA.jsp" />
				<jsp:include page="../include/printPage/GO.jsp" />
				<jsp:include page="../include/printPage/HKDGM.jsp" />
				<jsp:include page="../include/printPage/sgde.jsp" />
				<!--UDF-HKDGM挂号 -->
				<jsp:include page="../include/printPage/udfDe.jsp" />
				<jsp:include page="../include/printPage/udfOr.jsp" />
				<!--UDF-HKDGM平邮 -->
				<jsp:include page="../include/printPage/udfDeP.jsp" />
				<jsp:include page="../include/printPage/udfOrP.jsp" /> 
				<!-- DGM -->
				<jsp:include page="../include/printPage/dgmG.jsp" />
				<jsp:include page="../include/printPage/dgmP.jsp" /> 
				<!--  -->
				<jsp:include page="../include/printPage/hunP.jsp" />
				<jsp:include page="../include/printPage/hunG.jsp" /> 
				<jsp:include page="../include/printPage/DGMUDF.jsp" /> 
				<jsp:include page="../include/printPage/A2B_DGM.jsp" /> 
				<jsp:include page="../include/printPage/A2B_DGP.jsp" /> 
			</s:if>
			<s:if test="#request.raval==2">	
							
				<!-- bq百千宝发票 -->
				<jsp:include page="../include/printPage/bq.jsp" />
				<!-- 香港平邮和香港小包 -->
				<jsp:include page="../include/printPage/py_1.jsp"/>
				<jsp:include page="../include/printPage/ph_1.jsp"/>
				<!-- 新加坡 -->
				<jsp:include page="../include/printPage/xjbgh1.jsp" />
				<jsp:include page="../include/printPage/xjbpy1.jsp" />
				<!-- 瑞典邮政挂号 -->
				<jsp:include page="../include/printPage/swghA4.jsp" />				
				<!-- 其他格式标签 -->
				<table style="width:17.5cm;" align="center"><tr><td align="left" valign="top">
				<jsp:include page="../include/printPage/otsA4.jsp" />	
				<!-- 其他格式带发件人 -->		
				<jsp:include page="../include/printPage/otsrA4.jsp" />
				</td></tr></table>	
				<!-- DHLGlobeMail -->
				<jsp:include page="../include/printPage/dhlGMA4.jsp" />	
				<jsp:include page="../include/printPage/ppl.jsp" />	
				<jsp:include page="../include/printPage/FL.jsp" />
				<jsp:include page="../include/printPage/sdhlGM.jsp"/>	
				<!-- DGM -->
				<jsp:include page="../include/printPage/dgmG.jsp" />
				<jsp:include page="../include/printPage/dgmP.jsp" />
			</s:if>
			<s:if test="#request.raval==3">
				<!-- bq百千宝发票 -->
				<jsp:include page="../include/printPage/bqn.jsp" />
				<!-- 其他格式标签 -->
				<jsp:include page="../include/printPage/ots.jsp" />
				<!-- 香港平邮和香港小包 -->
				<jsp:include page="../include/printPage/xgpy_n.jsp"/>
				<jsp:include page="../include/printPage/xggh_n.jsp"/>
				<!-- 新加坡 -->
				<jsp:include page="../include/printPage/xjbghn.jsp" />
				<jsp:include page="../include/printPage/xjbpyn.jsp" />	
				<!-- 瑞典邮政挂号 -->
				<jsp:include page="../include/printPage/swghn.jsp" />
					<!-- 瑞士邮政挂号 -->
				<jsp:include page="../include/printPage/swiss.jsp" />
				<jsp:include page="../include/printPage/orSwiss.jsp" />
				<!-- 其他格式带发件人 -->		
				<jsp:include page="../include/printPage/otsr.jsp" />
				<!-- DHLGlobeMail -->
				<jsp:include page="../include/printPage/dhlGMn.jsp" />	
			
				<!--香港GM  -->
				
				<!--德国GM  -->
				<jsp:include page="../include/printPage/DEGM.jsp" />
				<!--德国以外GM  -->
				<jsp:include page="../include/printPage/EXDEGM.jsp" />
				<!--瑞点GM  -->
				<jsp:include page="../include/printPage/SEGM.jsp" />
				<!--法邮 -->
				<jsp:include page="../include/printPage/FL.jsp" />
				<!--平邮 德国 意大利 其他国家 -->	
				<jsp:include page="../include/printPage/PG.jsp" />
				<jsp:include page="../include/printPage/PL.jsp" />
				<jsp:include page="../include/printPage/PO.jsp" />
				<!--桂号 澳大利亚 德国  其他国家 -->
				<jsp:include page="../include/printPage/GA.jsp" />
				<jsp:include page="../include/printPage/GO.jsp" />
				<jsp:include page="../include/printPage/HKDGM.jsp" /> 
				<jsp:include page="../include/printPage/sgde.jsp" />
				<!--UDF-HKDGM挂号 -->
				<jsp:include page="../include/printPage/udfDe.jsp" />
				<jsp:include page="../include/printPage/udfOr.jsp" /> 
				<!--UDF-HKDGM平邮 -->
				<jsp:include page="../include/printPage/udfDeP.jsp" />
				<jsp:include page="../include/printPage/udfOrP.jsp" /> 
				<!-- DGM -->
				<jsp:include page="../include/printPage/dgmG.jsp" />
				<jsp:include page="../include/printPage/dgmP.jsp" />
				<!--  -->
				<jsp:include page="../include/printPage/hunP.jsp" />
				<jsp:include page="../include/printPage/hunG.jsp" /> 
			</s:if>
			<s:if test="#request.raval==4">				 
				<table style="width:17cm;" align="center"><tr><td align="left" valign="top">
					<!-- bq百千宝发票 -->
					<jsp:include page="../include/printPage/bq1n.jsp" />
					<!-- 其他格式标签 -->
					<jsp:include page="../include/printPage/otsA4n.jsp" />
					<!-- 香港平邮和香港小包 -->
					<jsp:include page="../include/printPage/py_1n.jsp"/>
					<jsp:include page="../include/printPage/ph_1n.jsp"/>
					<!-- 新加坡 -->
					<jsp:include page="../include/printPage/xjbgh1n.jsp" />
					<jsp:include page="../include/printPage/xjbpy1n.jsp" />	
					<!-- 瑞典邮政挂号 -->
					<jsp:include page="../include/printPage/swghA4n.jsp" />
					<!-- 其他格式带发件人 -->		
					<jsp:include page="../include/printPage/otsrA4n.jsp" />
					<!-- DHLGlobeMail -->
					<jsp:include page="../include/printPage/dhlGMA4n.jsp" />	
					<jsp:include page="../include/printPage/ppl.jsp" />	
				    <!-- DGM -->
				<jsp:include page="../include/printPage/dgmG.jsp" />
				<jsp:include page="../include/printPage/dgmP.jsp" />
				</td></tr></table>		
			</s:if>	
			<s:if test="#request.raval==5">	
			<!-- DGM -->
				<jsp:include page="../include/printPage/dgmG_V.jsp" />
				<jsp:include page="../include/printPage/dgmP_V.jsp" />
			<!-- 其他格式标签 -->
				<jsp:include page="../include/printPage/ots.jsp" />
			</s:if>
			</thead>	
		  <!--  <tfoot style="display:table-footer-group; border:none;">&nbsp;</tfoot>-->
	</center>
</form>
	<!--   var="message"
	<s:set  var="message" value="#session.MESSAGEBEAN"></s:set>
	
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;
				<font color="#3284BE">错误提示：</font>
				<font color="#FF0000"><s:property
						value="#message.strTitle" /> </font>
			</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;
				<font color="#3284BE">订单号：</font>
				<font color="#FF0000"><s:property
						value="#message.strMessage" /> </font>
			</td>
		</tr>
 -->


</body>
</html>
