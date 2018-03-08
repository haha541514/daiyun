<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="kyle.leis.fs.dictionary.district.da.XinshdistrictQuery"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <base href="<%=basePath%>">
    <title>问题件详情</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/component/Ext3/css/ext-all.css"/>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-base.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/component/Ext3/js/ext-all.js"></script>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/style/Forwarding_total.css"/>
    <link rel="stylesheet" type="text/css" href="<%=path%>/style/Forwarding_page.css"/>
    <!--<script type="text/javascript" src="<%=path%>/js/order.js"  charset="utf-8"></script>-->
    
<script>
//发件人国家二字码变化
//国家
	function changeCountryShipper(){
	    var Dtdt_hubcode = document.getElementById("S_Dtdt_hubcode").value;
		document.getElementById("S_countryCode").value = Dtdt_hubcode.toUpperCase();
		changeHubcodeShipper();
	}
//二字代码
	function changeHubcodeShipper(){
		var countryCode = document.getElementById("S_countryCode").value;
		document.getElementById("S_Dtdt_hubcode").value = countryCode;
	}
	
	//收件人国家二字码变化
	function changeCountryConsign(){
	    var Dtdt_hubcode = document.getElementById("C_Dtdt_hubcode").value;
		document.getElementById("C_countryCode").value = Dtdt_hubcode.toUpperCase();
		changeHubcodeConsign();
	}

	function changeHubcodeConsign(){
		var countryCode = document.getElementById("C_countryCode").value;
		document.getElementById("C_Dtdt_hubcode").value = countryCode;
	}


  Ext.onReady(function() {
  	Ext.Ajax.request({

		url: "${pageContext.request.contextPath}/getShipperInfo",

		success: function(request) {

			var data = Ext.util.JSON.decode(request.responseText);

			document.getElementById("shipperInfoLabelcode").options[0] = new Option("-选择已保存的发件人--","");

			for(var i=0;i<data.length;i++){

				var opt=new Option(data[i].scsclabelcode,data[i].scsccode); 

				document.getElementById("shipperInfoLabelcode").options[i+1] = opt;				

			}				

		 }

	 });

   });
   //收件人下拉列表初始化
   Ext.onReady(function() {
  	Ext.Ajax.request({

		url: "${pageContext.request.contextPath}/getConsigneeInfo",

		success: function(request) {

			var data = Ext.util.JSON.decode(request.responseText);

			document.getElementById("consigneeInfoLabelcode").options[0] = new Option("-选择已保存的收件人--","");

			for(var i=0;i<data.length;i++){

				var opt=new Option(data[i].scsclabelcode,data[i].scsccode); 

				document.getElementById("consigneeInfoLabelcode").options[i+1] = opt;				

			}				

		 }

	 });

   });
   
   //收件人信息转换




    function consigneeInfo(){

		var sclablecode=document.getElementById("consigneeInfoLabelcode").value;

		if(sclablecode==""){

			document.getElementById("text2").value=""

			document.getElementById("text55").value="";

			document.getElementById("text3").value="";

			document.getElementById("text4").value="";

			document.getElementById("text5").value="";

			document.getElementById("text55").readOnly=false;

			document.getElementById("text2").readOnly=false;

			document.getElementById("text3").readOnly=false;

			document.getElementById("text4").readOnly=false;

			document.getElementById("text5").readOnly=false;

			document.getElementById("text55").style.backgroundColor="";

			document.getElementById("text2").style.backgroundColor="";

			document.getElementById("text3").style.backgroundColor="";

			document.getElementById("text4").style.backgroundColor="";

			document.getElementById("text5").style.backgroundColor="";
		
			$("#tr_scsinfo").show();

		}else{
            
			document.getElementById("text55").readOnly=true;

			document.getElementById("text2").readOnly=true;

			document.getElementById("text3").readOnly=true;

			document.getElementById("text4").readOnly=true;

			document.getElementById("text5").readOnly=true;

			document.getElementById("text55").style.backgroundColor="#f1f1f1";

			document.getElementById("text2").style.backgroundColor="#f1f1f1";

			document.getElementById("text3").style.backgroundColor="#f1f1f1";

			document.getElementById("text4").style.backgroundColor="#f1f1f1";

			document.getElementById("text5").style.backgroundColor="#f1f1f1";
			
			
			$("#tr_scsinfo").hide();

			Ext.Ajax.request({

				url: "${pageContext.request.contextPath}/getConsigneeInfo",

				success: function(request) {

					var data = Ext.util.JSON.decode(request.responseText);

					for(var i=0;i<data.length;i++){

						if(data[i].scsccode==sclablecode){

							document.getElementById("text2").value=data[i].scscname;

							document.getElementById("text3").value=data[i].scsccompanyname;

							document.getElementById("text4").value=data[i].scsctelephone;

							document.getElementById("text5").value=data[i].scscpostcode;

							document.getElementById("text55").value=data[i].scscaddress1;

						}

					}				

				 }

			 });

		}

	}
   
   //发件人信息




  function shipperInfo(){

		var sclablecode=document.getElementById("shipperInfoLabelcode").value;

		if(sclablecode==""){

			document.getElementById("txt1").value=""

			document.getElementById("txt2").value="";

			document.getElementById("txt3").value="";

			document.getElementById("txt4").value="";

			document.getElementById("txt5").value="";

			document.getElementById("txt1").readOnly=false;

			document.getElementById("txt2").readOnly=false;

			document.getElementById("txt3").readOnly=false;

			document.getElementById("txt4").readOnly=false;

			document.getElementById("txt5").readOnly=false;

			document.getElementById("txt1").style.backgroundColor="";

			document.getElementById("txt2").style.backgroundColor="";

			document.getElementById("txt3").style.backgroundColor="";

			document.getElementById("txt4").style.backgroundColor="";

			document.getElementById("txt5").style.backgroundColor="";
		
			$("#tr_scsinfo").show();

		}else{
            
			document.getElementById("txt1").readOnly=true;

			document.getElementById("txt2").readOnly=true;

			document.getElementById("txt3").readOnly=true;

			document.getElementById("txt4").readOnly=true;

			document.getElementById("txt5").readOnly=true;

			document.getElementById("txt1").style.backgroundColor="#f1f1f1";

			document.getElementById("txt2").style.backgroundColor="#f1f1f1";

			document.getElementById("txt3").style.backgroundColor="#f1f1f1";

			document.getElementById("txt4").style.backgroundColor="#f1f1f1";

			document.getElementById("txt5").style.backgroundColor="#f1f1f1";
			
			
			$("#tr_scsinfo").hide();

			Ext.Ajax.request({

				url: "${pageContext.request.contextPath}/getShipperInfo",

				success: function(request) {

					var data = Ext.util.JSON.decode(request.responseText);

					for(var i=0;i<data.length;i++){

						if(data[i].scsccode==sclablecode){

							document.getElementById("txt1").value=data[i].scscname;

							document.getElementById("txt2").value=data[i].scsccompanyname;

							document.getElementById("txt3").value=data[i].scsctelephone;

							document.getElementById("txt4").value=data[i].scscpostcode;

							document.getElementById("txt5").value=data[i].scscaddress1;

						}

					}				

				 }

			 });

		}

	}
	
	function checkAjax(){
	var name = $("#d_txt1").val();
	var postcode = $("#d_txt4").val();
	var company = $("#d_txt2").val();
	var address = $("#d_txt5").val();
	var tell = $("#d_txt3").val();
	var scsccode = $("#d_scsccode").val();
	var sclabelcode = $("#d_sclabelcode").val();
	if(name == "")
	{ 
	  alert("发件人姓名不能为空");
      return false;
	}
	if(postcode == "")
	{ 
	  alert("发件人邮编不能为空");
      return false;
	}
	if(company == "")
	{ 
	  alert("发件人公司不能为空");
      return false;
	}
	if(address == "")
	{ 
	  alert("发件人地址不能为空");
      return false;
	}
	if(sclabelcode == "")
	{ 
	  alert("发件人编号不能为空");
      return false;
	}
	if(tell == "")
	{ 
	  alert("发件人电话不能为空");
      return false;
	}
	}
	
	//ajax保存新的发件人




	function addShipperInfo(){
	var name = $("#txt1").val();
	var postcode = $("#txt4").val();
	var company = $("#txt2").val();
	var address = $("#txt5").val();
	var tell = $("#txt3").val();
	var scsccode = $("#scsccode").val();
	var sclabelcode = $("#sclabelcode").val();
	var city = $("#txt8").val();
	$.ajax({
	type:"post",
	url:"ajaxAddShipperInfo",
	data:{name:name,postcode:postcode,company:company,address:address,tel:tell,scsccode:scsccode,sclabelcode:sclabelcode,city:city},
	success:function(data){
	if(data=="1"){
	alert("保存成功");
	Ext.Ajax.request({
		url: "${pageContext.request.contextPath}/getShipperInfo",

		success: function(request) {

			var data = Ext.util.JSON.decode(request.responseText);

			document.getElementById("shipperInfoLabelcode").options[0] = new Option("--选择已保存的发件人--","");

			for(var i=0;i<data.length;i++){

				var opt=new Option(data[i].scsclabelcode,data[i].scsccode); 

				document.getElementById("shipperInfoLabelcode").options[i+1] = opt;				

			}				

		 }

	 });
	}
	else if(data=="2"){
	alert("收件人重复!");
	}
	}
	});
	}
		
	//ajax保存新的收件人



	function addConsigneeInfo(){
	var name = $("#text2").val();
	var postcode = $("#text5").val();
	var company = $("#text3").val();
	var address = $("#text55").val();
	var tell = $("#text4").val();
	var scsccode = $("#scsccode").val();
	var sclabelcode = $("#sclabelcode").val();
	var city = $("#text8").val();
	$.ajax({
	type:"post",
	url:"ajaxConsigneeInfo",
	data:{name:name,postcode:postcode,company:company,address:address,tel:tell,scsccode:scsccode,sclabelcode:sclabelcode,city:city},
	success:function(data){
	if(data=="1"){
	alert("保存成功");
	Ext.Ajax.request({
		url: "${pageContext.request.contextPath}/getConsigneeInfo",

		success: function(request) {

			var data = Ext.util.JSON.decode(request.responseText);

			document.getElementById("consigneeInfoLabelcode").options[0] = new Option("--选择已保存的收件人--","");

			for(var i=0;i<data.length;i++){

				var opt=new Option(data[i].scsclabelcode,data[i].scsccode); 

				document.getElementById("consigneeInfoLabelcode").options[i+1] = opt;				
			}				

		 }

	 });
	}
	else if(data=="2"){
	alert("收件人重复!");
	}
	}
	});
	}
	
	
function showDiv()
{
var Idiv     = document.getElementById("Idiv");
var mou_head = document.getElementById('mou_head');
Idiv.style.display = "block";
//以下部分要将弹出层居中显示






Idiv.style.left=(document.documentElement.clientWidth-Idiv.clientWidth)/2+document.documentElement.scrollLeft+"px";
Idiv.style.top =(document.documentElement.clientHeight-Idiv.clientHeight)/2+document.documentElement.scrollTop-50+"px";
 
//以下部分使整个页面至灰不可点击






var procbg = document.createElement("div"); //首先创建一个div
procbg.setAttribute("id","mybg"); //定义该div的id
procbg.style.background = "#000000";
procbg.style.width = "100%";
procbg.style.height = "100%";
procbg.style.position = "fixed";
procbg.style.top = "0";
procbg.style.left = "0";
procbg.style.zIndex = "500";
procbg.style.opacity = "0.6";
procbg.style.filter = "Alpha(opacity=70)";
//背景层加入页面






document.body.appendChild(procbg);
document.body.style.overflow = "hidden"; //取消滚动条






 
//以下部分实现弹出层的拖拽效果
var posX;
var posY;
mou_head.onmousedown=function(e)
{
if(!e) e = window.event; //IE
posX = e.clientX - parseInt(Idiv.style.left);
posY = e.clientY - parseInt(Idiv.style.top);
document.onmousemove = mousemove;
}
document.onmouseup = function()
{
document.onmousemove = null;
}
function mousemove(ev)
{
if(ev==null) ev = window.event;//IE
Idiv.style.left = (ev.clientX - posX) + "px";
Idiv.style.top = (ev.clientY - posY) + "px";
}
}
function closeDiv() //关闭弹出层






{
var Idiv=document.getElementById("Idiv");
Idiv.style.display="none";
document.body.style.overflow = "auto"; //恢复页面滚动条






var body = document.getElementsByTagName("body");
var mybg = document.getElementById("mybg");
body[0].removeChild(mybg);
}
	
	
	//定位光标

	function setfocus(){

	   var txtName = document.getElementsByName("objWaybillforpredictColumns.cwcw_customerewbcode");

	   txtName[0].focus();

	}	
	
	
	
	
  	//校验文本框




  	function isCheck(id,length,name,flag,op){  	 
  	    var str = document.getElementById(id).value;
  	    var msg = "msg"+op;
  	    var num = id.substr(id.length-1,id.length); 	    
  	    num = parseInt(num) + 1;
  	    
  	    if($.trim(str)==""){
  	       $("#"+msg).text(name+"不能为空").attr("style", "color:red");
  	       return false;
  	    }
  	    else if($.trim(str).length>length&&flag==0){
  	    	 $("#"+msg).text("长度必须小于等于"+length).attr("style", "color:red");
    	       return false;
  	  	}else{
  	       $("#"+msg).text("");
  	    }
  	}
 	//校验长度

  	function isLength(id,length,name,flag,op){  	 
  	    var str = document.getElementById(id).value;
  	    var msg = "msg"+op;
  	    var num = id.substr(id.length-1,id.length); 	    
  	    num = parseInt(num) + 1;
  	    
		 if($.trim(str).length>length&&flag==0){
  	    	 $("#"+msg).text("长度必须小于等于"+length).attr("style", "color:red");
    	       return false;
  	  	}else{
  	       $("#"+msg).text("");
  	    }
  	}
 //校验下拉列框
 function selCheck(){
    var pkcode = document.getElementById("pkCode").value;
    if(pkcode == ""){
    alert("物流渠道不能为空");
       $("#pkmsg").text("物流渠道不能为空").attr("style", "color:red");
       $('html,body').animate({scrollTop:'0px'},100);
  	       return false;
  	    }else{
  	       $("#pkmsg").text("");
  	    }

    var countryCode = document.getElementById("C_countryCode").value;
    if(countryCode == ""){
    alert("国家不能为空");
       $("#countrymsg").text("国家不能为空").attr("style", "color:red");
  	       return false;
  	 }else{
  	       $("#countrymsg").text(""); 	       
  	 }
    return true;
 }
 
 function arrCheck(){
    var name = $("#cargoename1").val();
    var count = $("#cargopieces1").val();
    var mark = $("#customerremark1").val();
    var price = $("#cargoamount1").val();
       if(name == ""){
    	   alert("货物品名不能为空");
           return false;
       }
       if(count == ""){
           alert("货物件数不能为空");
           return false;
       }
       if(mark == ""){
           alert("货物重量不能为空");
           return false;
       }
       if(price == ""){
           alert("货物价值不能为空");
           return false;
       }
    return true;
 }
 //
 function initDetail(){

 var cgk_code= $("#selType input:radio:checked").val();
 var pck_code= $("#PackingWay input:radio:checked").val();
 var dcu_code= $("#dcuSign input:radio:checked").val();
 
 $("#cgk_code").val(cgk_code);
 $("#pck_code").val(pck_code);
 $("#dcu_code").val(dcu_code);

 
 }
	//提交
	function sub(){
		for(var i = 1;i<8;i++){
			var id = "text"+i;
			if(document.getElementById(id) != null){
				var txt = document.getElementById(id).value;     
				if(txt == ""){
					document.getElementById(id).onblur();
					$('html,body').animate({scrollTop:'300px'},100);
					return false;
				}
			}
		}
		for(var j=1;j<6;j++){
			var id1 = "txt"+j;
			if(document.getElementById(id1) != null){
				var text = document.getElementById(id1).value;     
				if(text == ""){				
					document.getElementById(id1).onblur();
					return false;
				}
			}
		}
		
		if(!selCheck()){
			return false;
		}

		if(!arrCheck()){
			return false;
		}	
	
		var addressCheck=document.getElementById("msgtext6").innerHTML;
		if(addressCheck != ""){
			return false;
		}
		
		if(document.getElementById("msgtext").innerHTML!=""){
			return;
		}else{
			if(checkcustomerewbcodeNotNULL()){
				if(confirm("确认提交？")){
				    initDetail();
					document.getElementById("labe").value =  document.getElementById("divgoods").innerHTML;
					document.getElementById("predictOrderForm").action="${pageContext.request.contextPath}/page/saveOrder";
					document.getElementById("predictOrderForm").submit();
				}
			}
		}
	}  

	function checkcustomerewbcodeNotNULL(){
		var customerewbcode = document.getElementById("customerewbcode");
		if(customerewbcode.value.length==0||customerewbcode.value==""){
			$("#wbmsg").text("客户单号不能为空").attr("style", "color:red");
            $('html,body').animate({scrollTop:'0px'},100);
			customerewbcode.focus();
			return false;
		}else{
			return true;
		}
	}
	
	function orderIdajax(){
		var customercode = document.getElementById("customerewbcode").value;
		var ajaxCustomercode = document.getElementById("ajaxCustomercode").value;
		var msg = "";
		if(customercode==""){
		document.getElementById("wbmsg").innerHTML = "单号不能为空";
		return false;
		}
		$.ajax({
			url : 'orderIdAJAX',
			type : 'post',
			data : {customercode : customercode,ajaxCustomercode:ajaxCustomercode},
			async: false,
			cache : false,
			timeout : 60000,
			success : function(message) {
				msg = message;
		}
		});
		if(customercode.length>20){
			document.getElementById("wbmsg").innerHTML = "长度必须小于或者等于20";	
			document.getElementById("customerewbcode").focus();
			return ;
		}
		else if(msg=="YES"){
		    document.getElementById("wbmsg").innerHTML = "";	
			document.getElementById("wbmsg").innerHTML = "单号已存在";	
			document.getElementById("customerewbcode").focus();
			return;
		}else{
			document.getElementById("wbmsg").innerHTML = "";
			document.getElementById("wbmsg").innerHTML = "";
			var el=document.getElementById("wbmsg");
			if(el.innerHTML==""){el.style.display="none";} 		
		}
	}

	/*小数的js验证 */
	function clearNoNum(obj){
		//先把非数字的都替换掉，除了数字和.
		obj.value = obj.value.replace(/[^\d.]/g,"");
		//必须保证第一个为数字而不是.
		obj.value = obj.value.replace(/^\./g,"");
		//保证只有出现一个.而没有多个.
		obj.value = obj.value.replace(/\.{2,}/g,".");
		//保证.只出现一次，而不能出现两次以上








		obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
	}
window.onload=function leng(){
	if(document.all=="1"){
	document.getElementById("text8").style.width="385";
		}
}

//货物添加
$(document).ready(function(){   
	$("#hw_info").click(function(){
		$("#hw_table").append("<tr>" +
		 "<td><input   name='ciciattacheinfo' type='text'   style='width:50px;text-align: center;border:0px'/></td>"+
           "<td><input  name='ciciname'     style='text-align: center; border:0px'/></td>"+
           "<td><input  name='ciciename' type='text'  value='' style='text-align: center; border:0px'/></td>"+
           "<td><input  type='text'  value='' style='text-align: center; border:0px'/></td>"+  
           "<td><input name='ciciunitprice'  type='text'     onkeyup='clearNoNum(this)' style='text-align: center; border:0px'/></td>"+
           "<td><input name='cicipieces'      onkeyup='clearNoNum(this)' style='text-align: center; border:0px'/></td>"+
           "<td id='hw_op'><a name='hw_edit' href='javaScript:void(0);'>保存</a><a  name='hw_de' href='javaScript:void(0);'>删除</a></td>"+
           		"</tr>");
		$("#hw_table [name='hw_de']").on("click", function(){
			$(this).parent().parent().remove();
			});	
		$("#hw_table [name='hw_edit']").last().on("click",function(){
			        if($(this).html()=='保存'){
				
					$(this).parent().siblings().children("input").attr("readonly","readonly");
					$(this).html("修改");
					$(this).css('color','#d42c96');
				}
			else
			if($(this).html()=='修改')
			  {   
				    $(this).parent().siblings().children("input").removeAttr("readonly").focus().css("border","2px");
				    $(this).html("保存");
				    $(this).css('color','red');   
				}
			});
		
		
	});
});

//货件信息添加
$(document).ready(function(){
	$("#hj_info").click(function(){
	var index=$("#hj_table tbody").children().length;
	$("#pieces_show").val(index);
		$("#hj_table").append("<tr>" +
			"<td><input name='hj_index' type='text'  value='"+index+"'style='width:50px;text-align: center;border:0px'/></td>"+
            "<td><input  name='cpCpgrossweight'  type='text' onkeyup='clearNoNum(this)'    style='text-align: center; border:0px'/></td>"+
            "<td><input  name='cpCplength' type='text'onkeyup='clearNoNum(this)'   style='text-align: center; border:0px'/></td>"+
            "<td><input  name='cpCpwidth' type='text' onkeyup='clearNoNum(this)'   style='text-align: center; border:0px'/></td>"+
            "<td><input  name='cpCpheight' type='text' onkeyup='clearNoNum(this)'   style='text-align: center; border:0px'/></td>"+
            "<td id='hj_op'><a name='hj_edit'id='hj_edit' href='javaScript:void(0);'>保存</a><a name='hj_de' id='hj_de' href='javaScript:void(0);'>删除</a>"+
"</td></tr>");
		   //删除
		    $("#hj_table [name='hj_de']").last().on("click",function(){
			$(this).parent().parent().remove();
			var a = 1;
			$("#hj_table [name='hj_index']").each(function(){
				$(this).attr("value",a);
				a=a+1;
			});
			var index=$("#hj_table tbody").children().length-1;
			$("#pieces_show").val(index);
			});
		    //编辑保存
		    $("#hj_table [name='hj_edit']").last().on("click",function(){
			if($(this).text()=='保存'){
					$(this).parent().siblings().children("input").attr("readonly","readonly");
					$(this).html("修改");
					$(this).css('color','#d42c96');
					}
			else{    
				    $(this).parent().siblings().children("input").removeAttr("readonly").focus().css("border","1px");
				    $(this).html("保存");
				    $(this).css('color','red');
				    
				}
			});
	
		});
});
//货件显示隐藏
$(document).ready(function(){
	$("#hj_all").click(function(){
	if(!$("#hj_table tr:gt(1)").is(":hidden")){
		$("#hj_all ").css("background","url(<%=path%>/m_images/icon12.png) no-repeat  ");
		$("#hj_table tr:gt(1)").hide();
	}
	else{
		$("#hj_all ").css("background","url(<%=path%>/m_images/icon11.png) no-repeat  ");
		$("#hj_table tr:gt(1)").show();
		}
	
	});
});
//货物显示隐藏
$(document).ready(function(){
	$("#hw_all").click(function(){
	if(!$("#hw_table tr:gt(1)").is(":hidden")){
		$("#hw_all ").css("background","url(<%=path%>/m_images/icon12.png) no-repeat ");
		$("#hw_table tr:gt(1)").hide();
	}
	else{
		$("#hw_all ").css("background","url(<%=path%>/m_images/icon11.png) no-repeat ");
		$("#hw_table tr:gt(1)").show();
	}
		
	})
});

//详情界面
$(document).ready(function(){
	$("#detail_btn").click(function(){
		if($("#detail").hasClass("detailed")){
		$("#detail").removeClass("detailed").addClass("off");
		$("#detail_btn").css("background","url(<%=path%>/m_images/icon11.png) no-repeat")
		$("#detail").slideUp("normal");
		}
		else
		if($("#detail").hasClass("off")){
		$("#detail").removeClass("off").addClass("detailed");
		$("#detail_btn").css("background","url(<%=path%>/m_images/icon12.png) no-repeat")
		$("#detail").slideDown("normal");
		}
	});
});


Ext.onReady(function(){
   Ext.Ajax.request({
   url:"${pageContext.request.contextPath}/getAllProductkind",
   success:function(request){
     var data =  Ext.util.JSON.decode(request.responseText);
      for(var i=0;i<data.length;i++){
         				
		}		  		
     }
  });

});

Ext.onReady(function(){
   Ext.Ajax.request({
  url:"${pageContext.request.contextPath}/getAllPaymentmodes",
  success:function(request){
     var data =  Ext.util.JSON.decode(request.responseText);  
     }
  });

});
</script>
</head>

<style>
#CountryTitie{background-color:#ebebeb;height:30px; text-align: center;}
#CountryTitie a{width:18px;display:block;line-height:30px;text-align:center;float:left;font-family:Arial, Helvetica, sans-serif;}
#CountryTitie a:hover{background-color:#d2d2d2;}

#CountryListSorting td:hover{background-color:#ebebeb;}
#CountryListSorting td .ywm{color:#858585;font-family:Arial, Helvetica, sans-serif;}
#CountryListSorting td .ezdm{color:#5c5c5c;font-weight:bold;font-family:Arial, Helvetica, sans-serif;}

#CountryListSelect  td:hover{background-color:#ebebeb;}



#C_CountryTitie{background-color:#ebebeb;height:30px; text-align: center;}
#C_CountryTitie a{width:18px;display:block;line-height:30px;text-align:center;float:left;font-family:Arial, Helvetica, sans-serif;}
#C_CountryTitie a:hover{background-color:#d2d2d2;}

#C_CountryListSorting td:hover{background-color:#ebebeb;}
#C_CountryListSorting td .ywm{color:#858585;font-family:Arial, Helvetica, sans-serif;}
#C_CountryListSorting td .ezdm{color:#5c5c5c;font-weight:bold;font-family:Arial, Helvetica, sans-serif;}

#C_CountryListSelect  td:hover{background-color:#ebebeb;}


</style>
  
  
<body onLoad="setfocus()">
<s:set var="obean" value="#request.objWaybillforpredictColumns"/>
<div id="main">
  <div id="top">
    <div class="top">
      <div class="window">
       <div class="left">亲，<span><%=session.getAttribute("Opname")%></span>  您好！欢迎登录我的代运！</div>
       <div class="right"><span><a href="${pageContext.request.contextPath}/order/loginout">退出</a></span> | <span><a href="${pageContext.request.contextPath}/op/recharge.jsp" target="_blank">充值</a></span>
        </div>
      </div>
      <div class="logo">
        <div class="left"><img src="<%=path%>/order_images/logo.jpg" /></div>
        <div class="right"><img src="<%=path%>/order_images/tel.jpg" /></div>
      </div>
      <div class="nav">
       <jsp:include page="../pg/include/main_menu.jsp"></jsp:include>
        <div class="nav_last"></div>
      </div>
    </div>
  </div>
  <div class="forwarding">
    <jsp:include page="../op/tree.jsp"></jsp:include>
  
    <div class="right" style="font-size:12px;">
    
         <form name="predictOrderForm" id="predictOrderForm" action="" method="post">
             <input type="hidden" id="OpId"  name="OpId" value="1">
                <input type="hidden" id="labe"  name="labe" value="1">
      <div class="home">
       <h3> 我的代运  > 订单辅助 > 问题件管理 > <span>订单详情</span></h3>
      </div>
      <div class="order" >
        <div class="r_title" >基本信息</div>
         
       <input type="hidden" id="sessCode1" name="objWaybillforpredictColumns.ccoCo_code" value="<%=session.getAttribute("Cocode") %>"/>

	<!-- <input type="hidden" id="sessCode2" name="objWaybillforpredictColumns.scoco_code" value="<%=session.getAttribute("Cocode") %>"/> -->

    <input type="hidden" id="ajaxCustomercode"  value="<s:property value='#obean.Cwcw_customerewbcode'/>" name="ajaxCustomercode"/>

	<input type="hidden" id="cw_code"  value="<s:property value='#objWaybillforpredictColumns.Cwcw_code'/>" name="cw_code"/>

	<input type="hidden" id="serverewbcode"  value="<s:property value='#obean.Cwcw_serverewbcode'/>" name="serverewbcode"/>

	<input type="hidden" id="ewbcode"  value="<s:property value='#obean.Cwcw_ewbcode'/>" name="ewbcode"/>
	
	<input type="hidden"  id="Dtdt_hubcode" value="<s:property value='#obean.Dtdt_hubcode'/>"/>
	
	<!--  <input type="hidden" name="objWaybillforpredictColumns.dtdt_hubcode" id="countryCode" value="<s:property value='#obean.Dtdt_hubcode'/>"/> -->
	 
	<input type="hidden" name="objWaybillforpredictColumns.dtdt_hubcode" id="C_countryCode" value="<s:property value='#obean.Dtdt_hubcode'/>"/>
	
	<!--<input type="hidden" name="objWaybillforpredictColumns.dtdt_hubcode" id="S_countryCode" value="<s:property value='#obean.Dtdt_hubcode'/>"/>-->

	<!--  <input type="hidden" id="city"  value="<s:property value='#obean.Hwhw_consigneecity'/>" name="city"/>-->
	        
        <div class="nir">
          <table width="818" border="0" id="basic_information" style="font:12px '宋体';">
            <tr>
              <td>客户单号： 
                <input id="customerewbcode" maxlength="20" name="objWaybillforpredictColumns.cwcw_customerewbcode"   value="<s:property value='#obean.Cwcw_customerewbcode'/>" onBlur="orderIdajax();" type="text" style="width:300px;" /><span id="msgtext" style="color:#FF0000;" ></span></td>
              <td align="right">物流渠道：



                <select  id="pkCode" name="objWaybillforpredictColumns.pkpk_code" style="width:300px;">
                  <option value="">--------------请选择物流渠道--------------</option>
                  <s:iterator var="products" value="@com.daiyun.dax.ProductkindDemand@getAllProduct()">
                        <s:if test="#obean.Pkpk_code.equals(#products.Pkcode)">
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
                </select></td>
            </tr>
            <tr><td ><span id="wbmsg" style="color:red"></span></td><td align="center"><span id="pkmsg" style="color:red"> </span></td></tr>
            <tr>
              <td>起运城市：






                <input name="stat" value="深圳" type="text"   value="<s:property value='#obean.Dtdt_name'/>" style="width:100px; margin-right:23px;" />
              实重：



           <input id="text1" name="purpose" name="objWaybillforpredictColumns.cwcw_customerchargeweight" value="<s:property value='#obean.Cwcw_customerchargeweight'/>" onblur="isCheck('text1','5','客户重量',1,'text1')"   type="text" style="width:100px;" /></td>
               <!--   <input name="purpose" value="<s:property value='#obean.Dtdt_name'/>"  readonly="readonly" id="destination_2" type="hidden" style="width:100px;" /></td>-->
              <td align="right" style="padding-left:90px; font:12px '宋体';">包裹类型：




               <s:iterator var="products" value="@com.daiyun.dax.CargoTypeDemand@queryAllCargotypes()">
                <input id="Package_type_0" name="objWaybillforpredictColumns." value="<s:property value='#products.ctctcode'/>" checked="checked" type="radio">
                <label for="Package_type_0" style="padding-right:30px;"><s:property value='#products.ctctname'/></label>
                 </s:iterator>
                </td>
            </tr>
            <tr>
              <td>收货网点：<span style="padding-left:8px; color:#d42c96;">根据所填写的发货城市自动计算</span></td>
              <!-- <td align="right"><span style="padding-left:24px; padding-right:30px;">实重：





                 
                <input  id="text1"  type="text" style="width:100px; margin-right:5px;" name="objWaybillforpredictColumns.cwcw_customerchargeweight" value="<s:property value='#obean.Cwcw_customerchargeweight'/>"  onblur="isCheck('text1','5','客户重量',1,'text1')" />
                kg</span> 件数：




               <s:if test="#obean.cwcw_pieces!=null">
                <input id="pieces_show" name="objWaybillforpredictColumns.cwcw_pieces" value="<s:property value='#obean.cwcw_pieces'/>" readonly="readonly"   type="text" style="width:95px;  background-color: #f1f1f1 " /></s:if>
                <s:else>
                <input id="pieces_show" name="objWaybillforpredictColumns.cwcw_pieces" value="1" readonly="readonly"   type="text" style="width:95px;  background-color: #f1f1f1 " />
                </s:else>
                </td>   -->  
              </tr>
              <tr><td></td><td><span id ="msgtext1" style="color:red" ></span></td></tr>
          </table>
        </div>
      </div>
      <div class="courier">
        <div class="left">
          <div class="r_tit">发件人信息   
          <a href ="javascript:void(0);" style="padding: 5 10px;color: #d42c96;text-decoration: underline;font:12px '宋体';margin-left: 52px;" id="btn_saveshipperInfo" onClick="addShipperInfo();"  >新增到发件人资料库</a>
          <SELECT id="shipperInfoLabelcode" style="margin:-26px 257px;width: 134px;" name="shipperInfoLabelcode"  onchange="shipperInfo();">
          </SELECT>
          </div>        
          <!-- 发件人信息 填写-->
          <div class="nir">
            <input type="hidden" id="scsccode"   value=" "  /> 
            <table width="393" border="0" id="recipient" style="font:12px '宋体';">
              <tr >     
                <td style="padding-left:6px;">&nbsp;姓名：






                  <input id="txt1" name="objWaybillforpredictColumns.hwhw_shippername" value="<s:property value='#obean.hwhw_shippername'/>" onBlur="isCheck('txt1','30','发件人姓名',1,'text2')"   type="text" style="margin-left:0px;width:135px;" /></td>
                <td style="padding-left:6px;">电话：






                  <input id="txt3" name="objWaybillforpredictColumns.hwhw_shippertelephone"  value="<s:property value='#obean.Hwhw_shippertelephone'/>" onBlur="isCheck('txt3','30','发件人电话',1,'text4')" type="text" style="width:141px;" /></td>
              </tr>
              <tr> <td><span id="msgtext2" style="color:red"></span></td><td><span id="msgtext4" style="color:red"></span></td></tr>
              <tr >
                <td style="padding-left:6px;">&nbsp;国家：     

                 <select  id="S_countryCode" name="objWaybillforpredictColumns.cwDt_code_origin" style="width:134px;height: 20px;margin-left:0px;" onChange="changeHubcodeShipper()">
                      <option value="">----请选择国家---</option>
                      <s:iterator var="country" value="@com.daiyun.dax.CountryDemand@queryAllCountry()">
                        <s:if test="#obean.cwDt_code_origin.equals(#country.dtDt_hubcode)">
                          <option  value="<s:property value='#country.dtDt_hubcode'/>" style="width:110px;height:20px;" selected="selected">
                          <s:property value="#country.Dtdt_ename"/>
                          </option>
                        </s:if> 
                        <s:else>
                          <option value="<s:property value='#country.dtDt_hubcode' />"  style="width:110px;height:20px;">
                          <s:property value="#country.Dtdt_ename"/>
                          </option>
                        </s:else>
                      </s:iterator>
                      <s:if test="#obean==null">
                        <option  value="CN" style="width:110px;height:20px;" selected="selected">China
                        </s:if>          
                    </select>
                     <div   id="S_CountryListSelect" style="display:none;float:center;border:1px solid #f1f1f1;z-index: 9999;position:absolute;background-color:#ffffff;">    	
        </div>
 </td>
                <td style="padding-left:6px;">邮编：



                  <input id="txt4" name="objWaybillforpredictColumns.hwhw_shipperpostcode" value="<s:property value='#obean.hwhw_shipperpostcode'/>" onBlur="isCheck('txt4','10','发件人邮编',1,'text5')" type="text" style="width:141px;" /></td>
              </tr>
               <tr> <td><span  style="color:red"></span></td><td><span id="msgtext5" style="color:red"></span></td></tr>
              <tr >
                <td>二字码：
                <s:if test="#obean==null">
                  <input   type="text" id="S_Dtdt_hubcode" name="Dtdt_hubcode"    style="width:135px;margin-left:0px;"  value="CN" onChange="changeCountryShipper()" />
                </s:if>
                <s:else>
                  <input   type="text" id="S_Dtdt_hubcode" name="Dtdt_hubcode"    style="width:135px;margin-left:0px;"  value="<s:property value='#obean.cwDt_code_origin'/>" onChange="changeCountryShipper()" />
                  </s:else></td>
                <td style="padding-left:6px;">城市：



                  <input name="city" id="txt8" type="text" style="width:141px;" onBlur="isCheck('txt8','30','发件公司名',1,'text8')" /></td>
              </tr>
               <tr> <td><span id="msgtext2" style="color:red"></span></td><td><span id="msgtext8" style="color:red"></span></td></tr>
              <tr >
                <td colspan="2" style="padding-left:6px;">&nbsp;公司：          
                  <input id="txt2" name="objWaybillforpredictColumns.hwhw_shippercompany" value="<s:property value='#obean.hwhw_shippercompany'/>" onBlur="isCheck('txt2','30','发件人公司名',1,'text3')" type="text" style="width:330px;margin-left: 0px;" /></td>
              </tr>
               <tr> <td><span  style="color:red"></span></td><td><span id="msgtext3" style="color:red"></span></td></tr>
              <tr >
                <td colspan="2" style="padding-left:6px;">&nbsp;地址：



                  <input id="txt5" name="objWaybillforpredictColumns.hwhw_shipperaddress1" value="<s:property value='#obean.hwhw_shipperaddress1'/>"  onblur="isCheck('txt5','90','发件人地址',0,'text6')" type="text" style="width:330px;margin-left: 0px;" /></td>
              </tr>
              <tr> <td><span  style="color:red"></span></td><td><span id="msgtext6" style="color:red"></span></td></tr>
            </table>
          </div>
        </div>
        <div class="right">
          <div class="r_tit">收件人信息




          <a href ="javascript:void(0);" style="padding: 5 10px;color: #d42c96;text-decoration: underline;font:12px '宋体';margin-left: 52px;" id="btn_saveconsineeInfo" onClick="addConsigneeInfo();"  >新增到收件人资料库</a>
          <SELECT id="consigneeInfoLabelcode" style="margin:-26px 257px;width: 134px;" name="consigneeInfoLabelcode"  onchange="consigneeInfo();">
          </SELECT></div>
          <div class="nir">
            <table width="393" border="0" id="recipient" style="font:12px '宋体';">
              <tr>
                <td style="padding-left:6px;">&nbsp;姓名：



                  <input id="text2" name="objWaybillforpredictColumns.hwhw_consigneename" value="<s:property value='#obean.Hwhw_consigneename'/>"  onblur="isCheck('text2','30','收件人名',1,'_text2')" value="张三" type="text" style="width:135px;margin-left:0px;" /></td>
                <td style="padding-left:6px;">电话：




                  <input id="text4" name="objWaybillforpredictColumns.hwhw_consigneetelephone" value="<s:property value='#obean.Hwhw_consigneetelephone'/>"  onblur="isCheck('text4','30','收件人电话',1,'_text4')" type="text" style="width:141px;" /></td>
              </tr>
              <tr> <td><span id="msg_text2" style="color:red"></span></td><td><span id="msg_text4" style="color:red"></span></td></tr>
              <tr>
                <td style="padding-left:6px;">&nbsp;国家：



                 <input type="text"   id="C_destination_2" value="<s:property value='#obean.Dtdt_name'/>" onClick="C_setLeft(this)"> 
  
 <div   id="C_CountryListSelect" style="display:none;float:center;border:1px solid #f1f1f1;z-index: 9999;position:absolute;background-color:#ffffff;">    	
        </div>
         <div onMouseOut="C_setPlay(event);" onMouseOver="clearHideTask();" id="C_CountryList" style="display:none;float:center;border:1px solid #f1f1f1;width:550px;z-index: 9999;position:absolute;background-color:#ffffff;">
        	<s:set var="countryValue" value="@com.daiyun.dax.CountryDemand@queryAllCountry()"/>        				
        	<input id="C_countryDtdt_hubcode" type="hidden" value="<s:property value='#countryValue.{Dtdt_hubcode}'/>"/>
        	<input id="C_countryDtdt_name" type="hidden" value="<s:property value='#countryValue.{Dtdt_name}'/>"/>
        	<input id="C_countryDtdt_ename" type="hidden" value="<s:property value='#countryValue.{Dtdt_ename}'/>"/>
        	
        	<table   id="C_CountryCityListShow" style="paddging:0px;border-collapse:collapse;cellpadding:0; cellspacing:0" align="center" width="100%">
        		<tr>
        			<td id="C_CountryTitie" >			
        			</td>
        		</tr>
        		<tr>
        			<td id="C_CountryListSorting">     				     				     				
        			</td>
        		</tr>
        		
        	</table>
	  </div> 
	  
	  <script>
document.onkeyup = function (e){
	var code;
	if (!e){
		var e = window.event;
	} 
	if (e.keyCode){
		code = e.keyCode; //IE
	}else if (e.which){
		code = e.which; //FF
	} 
	var act = document.activeElement.id; 
	if(act=="destination_2"){			
		var CL=document.getElementById("C_CountryList");
		var obj=document.getElementById("destination_2");	
		CL.style.display="none";			
		selectCityList(obj);		
	}
}

function isNull( str ){
	if ( str == "" ) return true;
	var regu = "^[ ]+$";
	var re = new RegExp(regu);
	return re.test(str);
}

function GetLength(str) {	 
	  var len = str.length,realLength;
	  realLength=len*10;
	  return realLength;
}

function selectCityList(obj){	
	var CS=document.getElementById("C_CountryListSelect");
	var str=obj.value;
	var strContent="<table width='100%'  cellpadding='0' cellspacing='0'>";
	var array=achieveAllCity();//arrayCH:CH,arrayCN:CN,arrayCE:CE
	var arrayCH=array.arrayCH;
	var arrayCN=array.arrayCN;
	var arrayCE=array.arrayCE;
	var arrayText=new Array();	
	if(isNull(str)){
		CS.style.display="none";
		return;
	}

	for(var i=0;i<arrayCH.length;i++){
		if(arrayCN[i].indexOf(str)==0||arrayCE[i].indexOf(str)==0){
			arrayText.push(arrayCN[i]+"("+arrayCH[i]+")"+arrayCE[i]);
		}
	}
	if(arrayText.length==0){
		CS.style.display="none";	
		return;
	}
	var width=60;
	var strLength;
	for(var i=0;i<arrayText.length;i++){
		strContent+="<tr height='20px'><td  onclick='Assignment(this);' style='padding-left:8px'>"+arrayText[i]+"</td></tr>";
		strLength=GetLength(arrayText[i]);		
		if(strLength>width){
			width=strLength;
		}
	}
	strContent+="</table>";		
	CS.style.height=arrayText.length*20;
	CS.style.width=width;	
	CS.innerHTML=strContent;	
	CS.style.top=getElementOffset(obj).top+19;
	CS.style.left=getElementOffset(obj).left;
	CS.style.display="block";
}

function decideMouse(ev){
	var bool=true;
	var ev= ev || window.event;	
	var mousePos = mouseCoords(ev);	
	var CT=document.getElementById("C_CountryCityListShow");
	var pos=getElementOffset(CT);	
	if(mousePos.x>=pos.left&&mousePos.x<=(pos.left+550)&&mousePos.y>=pos.top&&mousePos.y<=(pos.top+pos.height)){		
		bool=false;
	}	
	return bool;
}

function getElementOffset(e)
{
	var t = e.offsetTop;
	var l = e.offsetLeft;
	var w = e.offsetWidth;
	var h = e.offsetHeight-1;

	while(e=e.offsetParent) {
		t+=e.offsetTop;
		l+=e.offsetLeft;
	}
	return {top : t,left : l,width : w,height : h}
}

function mouseCoords(ev) 
{ 
	if(ev.pageX || ev.pageY){		 
		return {x:ev.pageX, y:ev.pageY}; 
	}	
	if(document.body.scrollTop!=0||document.body.scrollLeft!=0||document.body.clientLeft!=0||document.body.clientTop!=0){
		return { 
			x:ev.clientX + document.body.scrollLeft - document.body.clientLeft, 
			y:ev.clientY + document.body.scrollTop - document.body.clientTop 
			};
	}

	if(document.documentElement.scrollTop!=0||document.documentElement.scrollLeft!=0||document.documentElement.clientLeft!=0||document.documentElement.clientTop!=0){
		return { 
			x:ev.clientX + document.documentElement.scrollLeft - document.documentElement.clientLeft, 
			y:ev.clientY + document.documentElement.scrollTop - document.documentElement.clientTop 
			}; 
	}
	return{
		x:ev.clientX, 
		y:ev.clientY 
	}		
	
	
} 

function C_setLeft(obj){	
	clearHideTask();
	var CL=document.getElementById("C_CountryList");
	var CT=document.getElementById("C_CountryTitie");
	var list=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","P","Q","R","S","T","U","V","Y","Z"];//O W X
	var str="";	
	for(var i=0;i<list.length;i++){
		str+="<a onclick='changeContent(this);'>"+list[i]+"</a>";
	}	
	selectCity("A");	
	CT.innerHTML=str;		
	CL.style.top=getElementOffset(obj).top+19;
	CL.style.left=getElementOffset(obj).left;//obj.offsetLeft;
	CL.style.display="block";
	doHideTask();
}

var hideTask = null;
function doHideTask(){
	hideTask = setTimeout(function(){hideCountry();}, 2000);
}

function clearHideTask(){
	clearTimeout(hideTask);
}

function changeContent(obj){
	selectCity(obj.innerText || obj.textContent);	
}

function C_setPlay(ev){
	if(decideMouse(ev)){	
		hideCountry();
	}
}

function hideCountry(){
	var CL=document.getElementById("C_CountryList");	
	CL.style.display="none";
}

function achieveAllCity(){
	var CS=document.getElementById("C_SCountryListSorting");
	var CH=document.getElementById("C_countryDtdt_hubcode").value;
	CH=CH.substring(1,CH.length-1).split(",")
	var CN=document.getElementById("C_countryDtdt_name").value;
	CN=CN.substring(1,CN.length-1).split(",")
	var CE=document.getElementById("C_countryDtdt_ename").value;

	CE=CE.replace("NAURU, REPUBLIC OF","NAURU&#44 REPUBLIC OF");
	CE=CE.replace("MICRONESIA, FEDERATED STATES OF","MICRONESIA&#44 FEDERATED STATES OF");
	CE=CE.replace("MACEDONIA, REPUBLIC OF","MACEDONIA&#44 REPUBLIC OF");
	CE=CE.replace("PHILIPPINES, THE","PHILIPPINES&#44 THE");
	CE=CE.replace("SOMALILAND, REP OF (NORTH SOMALIA)","SOMALILAND&#44 REP OF (NORTH SOMALIA)");
	CE=CE.replace("RUSSIAN FEDERATION, THE","RUSSIAN FEDERATION&#44 THE");
	CE=CE.replace("YEMEN, REPUBLIC OF","YEMEN&#44 REPUBLIC OF");
	CE=CE.replace("CONGO, THE DEMOCRATIC REPUBLIC OF","CONGO&#44 THE DEMOCRATIC REPUBLIC OF");
	CE=CE.replace("IRELAND, REPUBLIC OF","IRELAND&#44 REPUBLIC OF");
	CE=CE.replace("KOREA, THE D.P.R OF","KOREA&#44 THE D.P.R OF");
	CE=CE.replace("NETHERLANDS, THE","NETHERLANDS&#44 THE");
	CE=CE.replace("REUNION, ISLAND OF","REUNION&#44 ISLAND OF");
	CE=CE.replace("SERBIA, REPUBLIC OF","SERBIA&#44 REPUBLIC OF");
	CE=CE.replace("CZECH REPUBLIC, THE","CZECH REPUBLIC&#44 THE");
	CE=CE.replace("CANARY ISLANDS, THE","CANARY ISLANDS&#44 THE");
	CE=CE.replace("KOREA, REPUBLIC OF","KOREA&#44 REPUBLIC OF");
	CE=CE.replace("MOLDOVA, REPUBLIC OF","MOLDOVA&#44 REPUBLIC OF");
	CE=CE.replace("MONTENEGRO, REPUBLIC OF","MONTENEGRO&#44 REPUBLIC OF");
	CE=CE.replace("CHINA, PEOPLES REPUBLIC", "CHINA&#44 PEOPLES REPUBLIC");
	CE=CE.substring(1,CE.length-1).split(",")

	for(var i=0;i<CH.length;i++){			
		while(CH[i].indexOf(" ")==0){
			CH[i]=CH[i].substring(1,CH[i].length);
		}
		while(CN[i].indexOf(" ")==0){
			CN[i]=CN[i].substring(1,CN[i].length);
		}		
		while(CE[i].indexOf(" ")==0){
			CE[i]=CE[i].substring(1,CE[i].length);			
		}			
	}
	return {arrayCH:CH,arrayCN:CN,arrayCE:CE};	
}

function selectCity(str){
	var CLS=document.getElementById("C_CountryListSelect");
	var CS=document.getElementById("C_CountryListSorting");
	var CH=document.getElementById("C_countryDtdt_hubcode").value;
	CH=CH.substring(1,CH.length-1).split(",")
	var CN=document.getElementById("C_countryDtdt_name").value;
	CN=CN.substring(1,CN.length-1).split(",")
	var CE=document.getElementById("C_countryDtdt_ename").value;
	
	CE=CE.replace("NAURU, REPUBLIC OF","NAURU&#44 REPUBLIC OF");
	CE=CE.replace("MICRONESIA, FEDERATED STATES OF","MICRONESIA&#44 FEDERATED STATES OF");
	CE=CE.replace("MACEDONIA, REPUBLIC OF","MACEDONIA&#44 REPUBLIC OF");
	CE=CE.replace("PHILIPPINES, THE","PHILIPPINES&#44 THE");
	CE=CE.replace("SOMALILAND, REP OF (NORTH SOMALIA)","SOMALILAND&#44 REP OF (NORTH SOMALIA)");
	CE=CE.replace("RUSSIAN FEDERATION, THE","RUSSIAN FEDERATION&#44 THE");
	CE=CE.replace("YEMEN, REPUBLIC OF","YEMEN&#44 REPUBLIC OF");
	CE=CE.replace("CONGO, THE DEMOCRATIC REPUBLIC OF","CONGO&#44 THE DEMOCRATIC REPUBLIC OF");
	CE=CE.replace("IRELAND, REPUBLIC OF","IRELAND&#44 REPUBLIC OF");
	CE=CE.replace("KOREA, THE D.P.R OF","KOREA&#44 THE D.P.R OF");
	CE=CE.replace("NETHERLANDS, THE","NETHERLANDS&#44 THE");
	CE=CE.replace("REUNION, ISLAND OF","REUNION&#44 ISLAND OF");
	CE=CE.replace("SERBIA, REPUBLIC OF","SERBIA&#44 REPUBLIC OF");
	CE=CE.replace("CZECH REPUBLIC, THE","CZECH REPUBLIC&#44 THE");
	CE=CE.replace("CANARY ISLANDS, THE","CANARY ISLANDS&#44 THE");
	CE=CE.replace("KOREA, REPUBLIC OF","KOREA&#44 REPUBLIC OF");
	CE=CE.replace("MOLDOVA, REPUBLIC OF","MOLDOVA&#44 REPUBLIC OF");
	CE=CE.replace("MONTENEGRO, REPUBLIC OF","MONTENEGRO&#44 REPUBLIC OF");
	CE=CE.replace("CHINA, PEOPLES REPUBLIC", "CHINA&#44 PEOPLES REPUBLIC");
	CE=CE.substring(1,CE.length-1).split(",")
	
	var CTL=document.getElementById("C_CountryList");
	
	
	var counStr="";
	CLS.style.display="none";
	
	for(var i=0;i<CH.length;i++){			
		while(CH[i].indexOf(" ")==0){
			CH[i]=CH[i].substring(1,CH[i].length);
		}
		while(CN[i].indexOf(" ")==0){
			CN[i]=CN[i].substring(1,CN[i].length);
		}		
		while(CE[i].indexOf(" ")==0){
			CE[i]=CE[i].substring(1,CE[i].length);			
		}			
	}
	var arrayCH = new Array();
	var arrayCN = new Array();
	var arrayCE = new Array();
	for(var i=0;i<CH.length;i++){					
		if(str==CE[i].charAt(0)){
			arrayCH.push(CH[i]);
			arrayCN.push(CN[i]);
			arrayCE.push(CE[i]);
		}
	}
	counStr="<table width='100%'cellpadding='0' cellspacing='0' >";	
	for(var i=0;i<arrayCH.length;i++){						
			if((i+1)%2==0){
				counStr+="<td><span onclick='Assignment(this);' style='padding-left:5px'>"+arrayCN[i]+"<span class='ezdm'>("+arrayCH[i]+")</span><span class='ywm'>"+arrayCE[i]+"</span></span></td></tr>";
			}else if(arrayCH.length%2==1&&(i+1)==arrayCH.length){
				counStr+="<tr height='25px'><td><span onclick='Assignment(this);' style='padding-left:5px'>"+arrayCN[i]+"<span class='ezdm'>("+arrayCH[i]+")</span><span class='ywm'>"+arrayCE[i]+"</span></span></td><td></td></tr>";
			}else{
				counStr+="<tr height='25px'><td weidth='50%'><span onclick='Assignment(this);' style='padding-left:5px'>"+arrayCN[i]+"<span class='ezdm'>("+arrayCH[i]+")</span><span class='ywm'>"+arrayCE[i]+"</span></span></td>";
			}			
	}
	counStr+="</table>";	
	if(arrayCH.length%2==0){
		CTL.style.height=arrayCH.length*25/2+30;
	}else{
		CTL.style.height=arrayCH.length*25/2+25+30;
	}
	
	CS.innerHTML=counStr;	
}
//
function Assignment(obj){
	var str=obj.innerText || obj.textContent;
	str=str.replace("VIRGIN ISLANDS (US),VIRGIN ISLANDS &#40US&#41");
	str=str.replace("SOMALILAND, REP OF (NORTH SOMALIA),SOMALILAND, REP OF &#40NORTH SOMALIA&#41");	
	str=str.replace("VIRGIN ISLANDS (BRITISH),VIRGIN ISLANDS &#40BRITISH&#41");	
	str=str.replace("IRAN (ISLAMIC REPUBLIC OF),IRAN &#40ISLAMIC REPUBLIC OF&#41");
	str=str.replace("GUYANA (BRITISH),GUYANA &#40BRITISH&#41");	
	var str1,str2;
	str1=str.substring(0,str.lastIndexOf("("));
	str2=str.substring(str.lastIndexOf("(")+1,str.lastIndexOf(")"));	
	document.getElementById("C_destination_2").value=str1;
	document.getElementById("C_countryCode").value=str2;
	document.getElementById("C_Dtdt_hubcode").value=str2;
	document.getElementById("C_CountryList").style.display="none";
	document.getElementById("C_CountryListSelect").style.display="none";	
	
}
</script>    
               <!--     <select  id="C_countryCode" name="objWaybillforpredictColumns.cwDt_code_destination" style="width:134px;height: 20px;margin-left:0px;" onchange="changeHubcodeConsign()">
                      <option value="">----请选择国家---</option>
                      <s:iterator var="country" value="@com.daiyun.dax.CountryDemand@queryAllCountry()">
                        <s:if test="#obean.cwDt_code_destination.equals(#country.dtDt_code)">
                          <option   value="<s:property value='#country.dtDt_code'/>" style="width:110px;height:20px;" selected="selected">
                          <s:property value="#country.Dtdt_ename"/>
                          </option>
                        </s:if>
                        <s:else>
                          <option value="<s:property value='#country.dtDt_code' />"  style="width:110px;height:20px;">
                          <s:property value="#country.Dtdt_ename"/>
                          </option>
                        </s:else>
                      </s:iterator>
                    </select> -->
</td>
       

                 <!--  <input name="countries" type="text" style="width:135px;" name="objWaybillforpredictColumns.dtDt_statecode"  value="<s:property value='#obean.dtDt_statecode'/>" />--> 
                <td style="padding-left:6px;">邮编：






                  <input id="text5" name="objWaybillforpredictColumns.hwhw_consigneepostcode"  value="<s:property value='#obean.Hwhw_consigneepostcode'/>" onBlur="isCheck('text5','10','收件人邮编',1,'_text5')" type="text" style="width:141px;" /></td>
              </tr>
              <tr> <td><span  style="color:red"></span></td><td><span id="msg_text5" style="color:red"></span></td></tr>
              <tr>
                <td>二字码：
                  <input name="province" id="C_Dtdt_hubcode" value="<s:property value='#obean.Dtdt_hubcode'/>" type="text" style="width:135px;margin-left:0px;"  onchange="changeCountryConsign()"/></td>                  
                <td style="padding-left:6px;">城市：




                  <input id="text8" name="objWaybillforpredictColumns.hwhw_consigneecity" value="<s:property value='#obean.Hwhw_consigneecity'/>" id="text8" onblur="isCheck('text8','40','收件人城市',1,'_text8')" type="text" style="width:141px;" /></td>
              </tr>
              <tr> <td><span  style="color:red"></span></td><td><span id="msg_text8" style="color:red"></span></td></tr>
              <tr>
                <td colspan="2" style="padding-left:6px;">&nbsp;公司：




                  <input name="objWaybillforpredictColumns.hwhw_consigneecompany" value="<s:property value='#obean.Hwhw_consigneecompany'/>" id="text3" onBlur="isCheck('text3','30','收件公司名',1,'_text3')" type="text" style="width:330px;" /></td>
              </tr>
               <tr> <td><span  style="color:red"></span></td><td><span id="msg_text3" style="color:red"></span></td></tr>
              <tr>
                <td colspan="2" style="padding-left:6px;">&nbsp;地址：




                  <input id="text55" name="objWaybillforpredictColumns.hwhw_consigneeaddress1" value="<s:property value='#obean.Hwhw_consigneeaddress1'/>" id="text6" onblur="isCheck('text6','90','收件地址',0,'_text6')" type="text" style="width:330px;" /></td>
              </tr>
              <tr> <td><span  style="color:red"></span></td><td><span id="msg_text6" style="color:red"></span></td></tr>
            </table>
          </div>
        </div>
      </div>
      <div class="clear"></div>
      <div class="goods">
        <div class="r_title">货件信息<a id="hj_info" href="javaScipt:void(0)"></a>
        <a href="javaScript:void(0);" id="hj_all" style="background:url(<%=path%>/m_images/icon11.png) no-repeat"></a>
        </div>
        <table id="hj_table" width="860" id="goods" style="font:12px '宋体';">
          <tr style="background:#edf8fd;">
            <td width="10%">序号</td>
            <td width="15%">实重（kg）</td>
            <td width="15%">长（cm）</td>
            <td width="15%">宽（cm）</td>
            <td width="15%">高（cm）</td>
            <td width="15%">操作</td>
          </tr>
          <s:set var="beansp" value="#request.listcwpieces" />
          <s:if test="#beansp==null">
          <tr>
            <td width="10%"><input name="hj_index" value="1" style="width:50px;text-align: center;border:0px" name="edit" type="text" readonly="readonly"  ></td>
            <td width="15%"><input name="cpCpgrossweight" type="text"  onkeyup="clearNoNum(this)"  style="text-align: center; border:0px"/></td>
            <td width="15%"><input name="cpCplength" type="text"  onkeyup="clearNoNum(this)" style="text-align: center; border:0px"/></td>
            <td width="15%"><input name="cpCpwidth" type="text"  onkeyup="clearNoNum(this)"  style="text-align: center; border:0px"/></td>
            <td width="15%"><input name="cpCpheight" type="text" onKeyUp="clearNoNum(this)" style="text-align: center; border:0px"/></td>
            <td width="15%" id="hj_op"><a name="hj_edit" id='hj_edit' href="javaScript:void(0);">保存</a><a id='hj_de' href='javaScript:void(0);'>删除</a></td>
          </tr>
          </s:if>
          <s:else>
          <s:if test="beansp.size()==0">
          <tr>
            <td width="10%"><input name="hj_index" style="width:50px;text-align: center;border:0px" name="edit" type="text" readonly="readonly" value="1" ></td>
            <td width="15%"><input name="cpCpgrossweight" type="text"  onkeyup="clearNoNum(this)" style="text-align: center; border:0px"/></td>
            <td width="15%"><input name="cpCplength" type="text"  onkeyup="clearNoNum(this)" value="shoes" style="text-align: center; border:0px"/></td>
            <td width="15%"><input name="cpCpwidth" type="text"  onkeyup="clearNoNum(this)" style="text-align: center; border:0px"/></td>
            <td width="15%"><input name="cpCpheight" type="text"  onkeyup="clearNoNum(this)" style="text-align: center; border:0px"/></td>
            <td width="15%" id="hj_op"><a name="hj_edit" id='hj_edit' href="javaScript:void(0);">保存</a><a id='hj_de' href='javaScript:void(0);'>删除</a></td>
          </tr>
          </s:if>
              <s:iterator var="listpic" value="#request.listcwpieces" status="index">
              <s:if test="#index.index==0">
              <tr>
            <td width="10%"><input name="hj_index" value="<s:property value='#index.index+1'/>"  style="width:50px;text-align: center;border:0px" name="edit" type="text" readonly="readonly"  ></td>
            <td width="15%"><input name="cpCpgrossweight" value="<s:property value='#listpic.cpcpgrossweight'/>" onKeyUp="clearNoNum(this)" type="text"   style="text-align: center; border:0px"/></td>
            <td width="15%"><input name="cpCplength" value="<s:property value='#listpic.cpcplength'/>" onKeyUp="clearNoNum(this)" type="text"   style="text-align: center; border:0px"/></td>
            <td width="15%"><input name="cpCpwidth" value="<s:property value='#listpic.cpcpwidth'/>" onKeyUp="clearNoNum(this)" type="text"  style="text-align: center; border:0px"/></td>
            <td width="15%"><input name="cpCpheight" value="<s:property value='#listpic.cpcpheight'/>" onKeyUp="clearNoNum(this)" type="text"   style="text-align: center; border:0px"/></td>
            <td width="15%" id="hj_op"><a name="hj_edit" id='hj_edit' href="javaScript:void(0);">保存</a><a id='hj_de' href='javaScript:void(0);'>删除</a></td>
          </tr>
              </s:if>
              </s:iterator>
              <s:iterator var="listpic2" value="#request.listcwpieces" status="index">
              <s:if test="#index.index!=0">
               <tr>
            <td width="10%"><input name="hj_index" value="<s:property value='#index.index+1'/>"  style="width:50px;text-align: center;border:0px" name="edit" type="text" readonly="readonly"  ></td>
            <td width="15%"><input name="cpCpgrossweight" value="<s:property value='#listpic2.cpcpgrossweight'/>" onKeyUp="clearNoNum(this)" type="text"  style="text-align: center; border:0px"/></td>
            <td width="15%"><input name="cpCplength" value="<s:property value='#listpic2.cpcplength'/>" onKeyUp="clearNoNum(this)" type="text"   style="text-align: center; border:0px"/></td>
            <td width="15%"><input name="cpCpwidth" value="<s:property value='#listpic2.cpcpwidth'/>" onKeyUp="clearNoNum(this)" type="text"  style="text-align: center; border:0px"/></td>
            <td width="15%"><input name="cpCpheight" value="<s:property value='#listpic2.cpcpheight'/>" onKeyUp="clearNoNum(this)" type="text"   style="text-align: center; border:0px"/></td>
            <td width="15%" id="hj_op"><a name="hj_edit" id='hj_edit' href="javaScript:void(0);">保存</a><a id='hj_de' href='javaScript:void(0);'>删除</a></td>
          </tr>
              
              </s:if>
              </s:iterator>
          </s:else>
        </table>
      </div>
      <div class="goods">
        <div class="r_title">货物内容<a href="javaScript:void(0);" id="hw_info"></a>
        <a href="javaScript:void(0);" id="hw_all" style="background:url(<%=path%>/m_images/icon11.png) no-repeat"></a>
        </div>
        
        <table id="hw_table" width="860" id="goods" style="font:12px '宋体';">
          <tr style="background:#edf8fd;">
            <td width="20%">海关/产品编码</td>
            <td width="15%">中文名</td>
            <td width="15%">英文名</td>
            <td width="10%">原产地</td>
            <td width="10%">单价（RMB）</td>
            <td width="10%">数量</td>
            <td width="20%">操作</td>
          </tr>
          <s:set var="beans" value="#request.listCargoinfoColumns" />
            <s:if test="#beans==null">
          <tr>     
         <td><input name="ciciattacheinfo" type="text"  value="<s:property value='#listCargoinfo.Ciciattacheinfo'/>" style="width:50px;text-align: center;border:0px"/>&nbsp; </td>
            <td><input name="ciciname" value="<s:property value='#listCargoinfo.ciciname'/>" type="text"   style="text-align: center; border:0px"  /> </td>   
            <td><input name="ciciename" value="<s:property value='#listCargoinfo.ciciename'/>" type="text"  value="shoes" style="text-align: center; border:0px"/></td>
            <td><input name="edit" type="text"  value="" style="text-align: center; border:0px"/></td>
            <td><input name="ciciunitprice" type="text"  value="<s:property value='#listCargoinfo.Ciciunitprice'/>" onKeyUp="clearNoNum(this)" style="text-align: center; border:0px"/></td>
            <td><input name="cicipieces" type="text"  value="<s:property value='#listCargoinfo.Cicipieces'/>"  onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"  style="text-align: center; border:0px"/></td>
            <td id="hw_op" style="font-size:8px"><a id="hw_edit" name='hw_edit' href="javaScript:void(0);">保存</a><a name='hw_de' href="javaScript:void(0);">删除</a></td>
          </tr>
            </s:if>
               <s:else>
                   <s:if test="#beans.size()==0">
                   <tr>     
         <td><input name="ciciattacheinfo" type="text"  value="<s:property value='#listCargoinfo.Ciciattacheinfo'/>" style="width:50px;text-align: center;border:0px"/>&nbsp; </td>
             <td><input name="ciciname" value="<s:property value='#listCargoinfo.ciciname'/>" type="text"   style="text-align: center; border:0px"  /> </td>   
            <td><input name="ciciename" value="<s:property value='#listCargoinfo.ciciename'/>" type="text"  value="shoes" style="text-align: center; border:0px"/></td>
            <td><input name="edit" type="text" readonly="readonly" value="" style="text-align: center; border:0px"/></td>
            <td><input name="ciciunitprice" type="text"  value="<s:property value='#listCargoinfo.Ciciunitprice'/>" onKeyUp="clearNoNum(this)" style="text-align: center; border:0px"/></td>
            <td><input name="cicipieces" type="text"  value="<s:property value='#listCargoinfo.Cicipieces'/>"  onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"  style="text-align: center; border:0px"/></td>
            <td id="hw_op" style="font-size:8px"><a id="hw_edit" name='hw_edit' href="javaScript:void(0);">保存</a><a name='hw_de' href="javaScript:void(0);">删除</a></td>
          </tr>
           </s:if>
            <s:else>
             <s:iterator var="listCargoinfo" value="#request.listCargoinfoColumns" status="index">
               <s:if test="#index.index==0">
              <tr>
              <td><input name="ciciattacheinfo" type="text"  value="<s:property value='#listCargoinfo.Ciciattacheinfo'/>" style="width:50px;text-align: center;border:0px"/>&nbsp; </td>
               <td><input name="ciciname" value="<s:property value='#listCargoinfo.ciciname'/>" type="text"   style="text-align: center; border:0px"  /> </td>   
            <td><input name="ciciename" value="<s:property value='#listCargoinfo.ciciename'/>" type="text"  value="shoes" style="text-align: center; border:0px"/></td>
            <td><input name="edit" type="text"  value="" style="text-align: center; border:0px"/></td>
            <td><input name="ciciunitprice" type="text"  value="<s:property value='#listCargoinfo.Ciciunitprice'/>" onKeyUp="clearNoNum(this)" style="text-align: center; border:0px"/></td>
            <td><input name="cicipieces" type="text"  value="<s:property value='#listCargoinfo.Cicipieces'/>"  onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"  style="text-align: center; border:0px"/></td>
            <td id="hw_op"  ><a id="hw_edit" name='hw_edit' href="javaScript:void(0);">保存</a><a name='hw_de' href="javaScript:void(0);">删除</a></td>
         
         </s:if>
 </s:iterator>
     <s:iterator var="list" value="#request.listCargoinfoColumns" status="index">
            <s:if test="#index.index!=0">
            <tr>
            <td><input name="ciciattacheinfo" type="text"  value="<s:property value='#listCargoinfo.Ciciattacheinfo'/>" style="width:50px;text-align: center;border:0px"/>&nbsp; </td>
            <td><input name="ciciname" value="<s:property value='#listCargoinfo.ciciname'/>" type="text"   style="text-align: center; border:0px"  /> </td>   
            <td><input name="ciciename" value="<s:property value='#listCargoinfo.ciciename'/>" type="text"  value="shoes" style="text-align: center; border:0px"/></td>
            <td><input name="edit" type="text"  value="" style="text-align: center; border:0px"/></td>
            <td><input name="ciciunitprice" type="text"  value="<s:property value='#listCargoinfo.Ciciunitprice'/>" onKeyUp="clearNoNum(this)" style="text-align: center; border:0px"/></td>
            <td><input name="cicipieces" type="text"  value="<s:property value='#listCargoinfo.Cicipieces'/>"  onkeyup="value=value.replace(/[^\d]/g,'') " onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"  style="text-align: center; border:0px"/></td>
            <td id="hw_op" ><a id="hw_edit" name='hw_edit' href="javaScript:void(0);">保存</a><a name='hw_de' href="javaScript:void(0);">删除</a></td>
           </tr>
            </s:if>
               </s:iterator>
            </s:else>
       </s:else>
        </table>
      </div>
      <div class="pop_up">
        <h3><a href="javaScipt:void(0);">详细信息</a>（点击完善详细信息）</h3>
        <span><a href="javaScipt:void(0);" id="detail_btn"></a></span> </div>
      <div class="off" style="display:none" id="detail">
        <div class="r_title">详细信息</div>
        <input id="cgk_code" type="hidden" name="objWaybillforpredictColumns.hwcgk_code" >
         <input id="pck_code" type="hidden" name="objWaybillforpredictColumns.hwpat_code" >
          <input id="dcu_code" type="hidden" name="objWaybillforpredictColumns.hwhw_dcustomssign" >
        <div class="nir">
          <ul>
          <li id="selType">货物种类：






          <s:iterator var="cargokind" value="@com.daiyun.dax.CargokindDemand@queryAll()"> 
                <s:if test="#obean.hwcgk_code.equals(#cargokind.ckcgkcode)">
                <input id="SelType_1"  name="sel_Type" value="<s:property value='#cargokind.ckcgkcode'/>" type="radio" checked="checked"  /> 
                <label for="SelType_0"  style="padding-right:24px;"> <s:property value="#cargokind.ckcgkname"/> </label>     
                </s:if>
                <s:else>
                <input id="SelType_1"  name="sel_Type" value="<s:property value='#cargokind.ckcgkcode'/>" type="radio"  /> 
               <label for="SelType_0" style="padding-right:24px;"><s:property value="#cargokind.ckcgkname"/></label>     
                </s:else>
                </s:iterator>
          
          </li>
                <li>电池种类：<select id="battery" name="objWaybillforpredictColumns.hwbk_code" style="width:200px;">
           <option value="" selected="selected">--------请选择电池种类--------</option>
           <s:iterator var="batterykind" value="@com.daiyun.dax.BatterykindDemand@getAllBatterykind()">     
                <s:if test="#obean.hwbk_code.equals(#batterykind.bkbkcode)">
                <option  value="<s:property value='#batterykind.bkbkcode'/>" style="display:none;" selected="selected"> <s:property value="#batterykind.bkbkname"/></option>
               </s:if>
               <s:else>
                <option  value="<s:property value='#batterykind.bkbkcode'/>" style="display:none;"> <s:property value="#batterykind.bkbkname"/></option>
                </s:else>
                </s:iterator>
                 </select></li>
                <li id="PackingWay">包装方式：






                <s:iterator var="pkgType" value="@com.daiyun.dax.PackagetypeDemand@queryAllType()">
                <s:if test="#obean.hwpat_code.equals(#pkgType.tdppatcode)">
                <input id="Packing_way_0" name="Packing_Way"  value="<s:property value='#pkgType.tdppatcode'/>" checked="checked" type="radio" />
                <label for="Packing_way_0" style="padding-right:24px;"><s:property value='#pkgType.tdppatname'/></label>
                </s:if>
                <s:else>
                <input id="Packing_way_0" name="Packing_Way" value="<s:property value='#pkgType.tdppatcode'/>"  type="radio" />
                <label for="Packing_way_0" style="padding-right:24px;"><s:property value='#pkgType.tdppatname'/></label>        
                </s:else>
                </s:iterator>
                </li>
                <li id="dcuSign">是否需D类报关:
         
                <s:if test='#obean.hwhw_dcustomssign=="Y"'>
                <input id="Customs_declaration_0" name="dcu_Sign"  value="Y" checked="checked" type="radio" />
                <label for="Customs_declaration_0" style="padding-right:24px;">是</label>
                </s:if>
                <s:else>
                 <input id="Customs_declaration_0" name="dcu_Sign"  value="Y" type="radio" />
                <label for="Customs_declaration_0" style="padding-right:24px;">是</label>
                </s:else>
                <s:if test='#obean.hwhw_dcustomssign=="N"'>
                <input id="Customs_declaration_1" name="dcu_Sign" value="N" checked="checked"  type="radio" /> 
                <label for="Customs_declaration_1"   style="padding-right:24px;">否</label>
                </s:if>
                <s:else>
                <input id="Customs_declaration_1" name="dcu_Sign"  value="N"   type="radio" /> 
                <label for="Customs_declaration_1"   style="padding-right:24px;">否</label>
                </s:else>
                </li>
                <li>参考运费：
                <input name="freight" type="text" value="50" style="width:100px; margin-right:5px;" />
                元</li>
                <li id="pmCode">付款方式：




                <s:iterator var="paymenttype" value="@com.daiyun.dax.PaymentmodeDemand@queryAllPaymentmodes()"> 
                <s:if test="#obean.hwpat_code.equals(#paymenttype.pmpmcode)">
                <input id="Pick_up_goods_0" name="pm_Code" value="<s:property value='#paymenttype.pmpmcode'/>" checked="checked" type="radio" />
                <label for="Pick_up_goods_0" style="padding-right:24px;"><s:property value="#paymenttype.pmpmname"/></label>
                </s:if>
                <s:else>
                <input id="Pick_up_goods_0" name="pm_Code"  value="<s:property value='#paymenttype.pmpmcode'/>"  type="radio" />
                <label for="Pick_up_goods_0" style="padding-right:24px;"><s:property value="#paymenttype.pmpmname"/></label>
                </s:else>
                </s:iterator>
                </li>
          </ul>
        </div>
      </div>
      <div >
      </div>
      </form>
    </div>
  </div>
<div id="divgoods">&nbsp;</div>
  <div class="clear"></div>
  <div id="bottom">
    <div class="copyright">
      <div class="nir">
        <div class="left"> Copyright © 2012 深圳市代运物流网络有限公司<br />
          (AT) 2008-2010 All Rights Reserved 粤ICP备0503210号 </div>
        <div class="right"><img src="<%=path%>/order_images/tel2.jpg" /></div>
      </div>
    </div>
    <div class="bottom_nav"> <a href="#">首页</a>│<a href="#">货物追踪</a>│<a href="#">提货服务</a>│<a href="#">新闻资讯</a>│<a href="#">成为供应商</a> | <a href="#">新闻中心</a> | <a href="#">联系我们</a></div>
  </div>
</div>
</body>
</html>g