<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib uri = "/project" prefix="p" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>执照审核</title>
<link href="<%=path%>/style/page_master.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript">
function mySearch(){
        var cocode = $("#cocode").val();
        var labercode=$("#labercode").val();
		document.getElementById("listform").action = "${pageContext.request.contextPath }/queryCorporation";
		document.getElementById("listform").submit();
	}
//审核。
	function Pass(){
	var auditStatue=$("#auditStatue").val();
	var cocode=$("#cocode").val();
	if(cocode==null||cocode==""){
	alert("请先选择公司编号");
	return;
	}
	if(auditStatue=="已审核"){
	alert("该公司营业执照已审核");
	return;
	}
	$.ajax({
	type:'post',
	url:'<%=path%>/ModifyAuditStatue',
	data:{cocode:cocode},
	success:function(data){
	if(data=="OK"){
	alert("操作成功");
	}else{
	alert("操作失败");
	}
	}
	});
	}
	//退回

	function Returned(){
	var remark=$("#remark").val();
	var cocode=$("#cocode").val();
	var auditStatue=$("#auditStatue").val();
	if(auditStatue=="已审核"){
	alert("该公司营业执照已审核");
	return;
	}
	if(remark==null||remark==""){
	alert("请先填写退回原因");
	return;
	}
	$.ajax({
	type:'post',
	url:'<%=path%>/AuditReturned',
	data:{cocode:cocode,remark:remark},
	success:function(data){
	if(data=="OK"){
	alert("操作成功");
	}else{
	alert("操作失败");
	}
	}
	});
	}
</script>
<script type="text/javascript">
 $(function(){
 	$("#img1").click(function() {
 		var img_src = $(this).attr('src');
 		var body_height = $('body').outerHeight();
 		$('#show_img').attr('src',img_src) ;
 		var img_h = $('#show_img').height();
 		var img_w = $('#show_img').width();
 		var mg_left = -img_w/2;
 		var mg_top = -img_h/2;
 		$('#show_img').css({'margin-top':mg_top,'margin-left':mg_left,'display':'block'});
 		$('#img_bg').css('height',body_height).show();
 		return false;
 	});

 	$('#show_img,#img_bg').click(function() {
 		$('#show_img,#img_bg').hide();
 	});
 })
 
 $(function(){
 	$("#img2").click(function() {
 		var img_src = $(this).attr('src');
 		var body_height = $('body').outerHeight();
 		$('#show_img').attr('src',img_src) ;
 		var img_h = $('#show_img').height();
 		var img_w = $('#show_img').width();
 		var mg_left = -img_w/2;
 		var mg_top = -img_h/2;
 		$('#show_img').css({'margin-top':mg_top,'margin-left':mg_left,'display':'block'});
 		$('#img_bg').css('height',body_height).show();
 		return false;
 	});

 	$('#show_img,#img_bg').click(function() {
 		$('#show_img,#img_bg').hide();
 	});
 })
 
/* function magnify(args){
   var width = $("#img1").width();
   if(width==250)
                    {
                        $("#img1").width(750);
                        $("#img1").height(450);
                    }
                    else
                    {
                        $("#img1").width(250);
                        $("#img1").height(150);
                    }
 }*/
 </script>

</head>
<style>
a{color:#333333;text-decoration:none;}
.pageNav { text-align:center; margin-top:10px; height:26px; padding:3px 0px;color: #000000;}
.pageNav a { display:inline; border:1px solid #ccc; height:20px; line-height:20px; margin-left:5px; padding:2px 7px;}
.pageNav a:hover { border:1px solid #3a739d; text-decoration:none; color:#3a739d; background:#f6fbff;}
</style>
<body>
<img src="" style='z-index:1002;position:fixed; top:50%;left:50%; display:none' id="show_img"/>
<div id='img_bg' style="width:100%; height:100%; opacity:0.6; background:#000000; z-index:1001; position:absolute;top:0;left:0;right:0; display:none"></div>
<form action="${pageContext.request.contextPath }/queryUserByIdBg"
	method="post" name="listform" id="listform" >
<div id="admin">
<s:set var="ubean" value="#request.corporationColumns"></s:set>
  <div id="top"><img src="<%=path%>/m_images/logo.jpg" /> <span>首您现在的位置：<a href="<%=path%>/daiyun.jsp">首页</a>---会员中心---公司信息</span> </div>
  <div class="master"><!--
  <input type="hidden" id="m_opname"  name="m_opname"/>
  <input type="hidden" id="m_opcode"  name="m_opcode"/>
  <input type="hidden" name="opid" value="<s:property value="#ubean.opopid"/>"/>
  <input type="hidden" id="statue"  name="statue" />  
    --><jsp:include page="tree.jsp"></jsp:include>
    <div class="right">
      <div class="admin_rit_ads">
         <div class="admin_ads_head">
          <div class="admin_ads_head_lft"></div>
          <div class="admin_piece_rit">
     
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="button" value="审  核" style="width:82px; margin-left:150px; height:28px; background:url(<%=path %>/m_images/add.png); border:0px;" onclick="Pass();"/>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="button" value="退  回" style="width:82px; height:28px; background:url(<%=path %>/m_images/add.png); border:0px;" onclick="Returned();"/>
          </div>
        </div>
         <div class="admin_ads_check" align="center">   
        
                     <table width="765" border="0" id="review_table">
        <s:if test="#ubean==null">
        <tr class="manage_form_bk">
											<td colspan="7" align="left"><h3>&nbsp;&nbsp;&nbsp;&nbsp;对不起,没有查询到对应条件的记录!</h3></td>
										</tr>  
        </s:if>   
        <s:if test="#ubean!=null">            
  <tr>
    <td><span>公司编号：</span>
              <input  name="cocode" id="cocode" value="<s:property value="#ubean.cococode"/>" type="text" style="width:110px;" /></td>
   
    <td><span>公司代码：</span>
              <input name="labercode" id="labercode" value="<s:property value="#ubean.cocolabelcode"/>" type="text" style="width:110px;" /></td>
  <td>审核状态: <select name="m_statue" id="m_statue">
              <option value="Z" selected="selected">未审核</option>
              <option value="N">待审核</option>
              <option value="Y">已审核</option>
              </select></td>
  </tr>

  
  <tr>
    <td><span>营业执照：</span><img id="img1" src="download/<s:property value="#ubean.cocobusinesspicurl"/>" width="250" height="250" />
 <!--     <div class="map"><button class="larger_map" type="button" onclick="magnify(true);"></button></div>-->
    </td>
     <td><span style="width:150px" >审核状态：<input id="auditStatue" name="auditstatue" value='<s:if test="#ubean.cocobpicconfirmsign==null">未审核</s:if><s:elseif test='#ubean.coCobpicconfirmsign.equals("Y")'>已审核</s:elseif><s:elseif test='#ubean.coCobpicconfirmsign.equals("N")'>审核中</s:elseif>'/></span>
    </td>
  </tr>
  <tr>
   <td><span>公司名称：</span>
              <input  value="<s:property value="#ubean.coconame"/>" type="text" style="width:160px;" /></td>
  <td><span>英文名称：</span>
              <input  value="<s:property value="#ubean.cocosename"/>" type="text" style="width:160px;" /></td>
  </tr>
  <tr>
   <td><span>详细地址：</span>
              <input  value="<s:property value="#ubean.cocoaddress"/>" type="text" style="width:280px;" /></td>
  </tr>
  <tr>
   <td><span>退回原因：</span>
              <input  id="remark" name="remark" type="text" style="width:380px;height:25px"/></td>
  </tr>
  </s:if>
</table>
        </div>
            </table>  
          </div>       
        </div>  
       
        </div>
      </div>
    </div>
  </div>
</form>


</body>


</html>
