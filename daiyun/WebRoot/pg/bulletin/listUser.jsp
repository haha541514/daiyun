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
<title>实名认证</title>
<link href="<%=path%>/style/page_master.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
<script type="text/javascript">
function mySearch(){
        var name = $("#userName").val();
        var opcode=$("#userOpcode").val();
        $("#m_opname").val(name);
        $("#m_opcode").val(opcode);
		document.getElementById("listform").action = "${pageContext.request.contextPath }/queryUsersByCon";s
		document.getElementById("listform").submit();
	}
	/* 
	function Pass(){
        $("#statue").val("Y");
		document.getElementById("listform").action = "${pageContext.request.contextPath }/modifyIndentify";
		document.getElementById("listform").submit();
	}
	function NoPass(){      
        $("#statue").val("N");
		document.getElementById("listform").action = "${pageContext.request.contextPath }/modifyIndentify";
		document.getElementById("listform").submit();
	}
	*/
	function Pass(){
	
        $("#statue").val("Y");
		document.getElementById("listform").action = "${pageContext.request.contextPath }/queryUsersByCon";
		document.getElementById("listform").submit();
	}
	function NoPass(){      
        $("#statue").val("N");
		document.getElementById("listform").action = "${pageContext.request.contextPath }/queryUsersByCon";
		document.getElementById("listform").submit();
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
<s:set var="ubean" value="#request.user"></s:set>
  <div id="top"><img src="<%=path%>/m_images/logo.jpg" /> <span>首您现在的位置：<a href="<%=path%>/daiyun.jsp">首页</a>---会员中心---查看新闻</span> </div>
  <div class="master">
  <input type="hidden" id="m_opname"  name="m_opname"/>
  <input type="hidden" id="m_opcode"  name="m_opcode"/>
  <input type="hidden" name="opid" value="<s:property value="#ubean.opopid"/>"/>
  <input type="hidden" id="statue"  name="statue" />  
    <jsp:include page="tree.jsp"></jsp:include>
    <div class="right">
      <div class="admin_rit_ads">
         <div class="admin_ads_head">
          <div class="admin_ads_head_lft"></div>
          <div class="admin_piece_rit">
            <input type="button" value="查 询" style="width:82px;margin-left:222px;height:28px; background:url(<%=path %>/m_images/add.jpg); border:0px;" onclick="mySearch();"/>   
            &nbsp;&nbsp;&nbsp;
            <input type="button" value="通 过" style="width:82px; height:28px; background:url(<%=path %>/m_images/add.png); border:0px;" onclick="Pass();"/>
            &nbsp;&nbsp;&nbsp;
            <input type="button" value="未通过 " style="width:82px; height:28px; color:#FFF; background:url(<%=path %>/m_images/delete.png); border:0px;" onclick="NoPass();"/>
          </div>
        </div>
         <div class="admin_ads_check" align="center">   
        
                     <table width="765" border="0" id="review_table">
  <tr>
    <td><span>用户名：</span>
              <input  name="userName" id="userName" value="<s:property value="#ubean.opopname"/>" type="text" style="width:110px;" /></td>
    <td><span>帐号：</span>
              <input name="userOpcode" id="userOpcode" value="<s:property value="#ubean.opopcode"/>" type="text" style="width:110px;" /></td>
              <td>认证状态: <select name="m_statue" id="m_statue">
              <option value="" selected="selected">全部</option>
              <option value="Z">待审核</option>
              <option value="N">未通过</option>
              <option value="Y">已认证</option>
              </select></td>
  </tr>
  <s:if test="#ubean!=null">
  <tr>
    <td><span>真实姓名：</span>
              <input  name="userName" id="userName" value="<s:property value="#ubean.opopname"/>" type="text" style="width:210px;" /></td>
    <td><span>身份证号：</span>
              <input name="userOpcode" id="userOpcode" value="<s:property value="#ubean.opopidnumber"/>" type="text" style="width:210px;" /></td>
  </tr>
  <tr>
    <td><span>身份证正面：</span><img id="img1" src="<s:property value="#ubean.opopidnumberpicurl"/>" width="215" height="109" />
    <div class="map"><button class="larger_map" type="button" onclick="JavaScript:void(0);"></button></div>
    </td>
    <td><span>身份证正面：</span><img id="img2" src="<s:property value="#ubean.opopidnumberrpicurl"/>" width="215" height="109" />
    <div class="map"><button class="larger_map" type="button" onclick="JavaScript:void(0);"></button></div></td>
  </tr>
  <tr>
    <td><span style="width:150px">认证状态：<s:if test='#ubean.opopidnumberconfirmsign.equals("N")'>未通过</s:if><s:if test='#ubean.opopidnumberconfirmsign.equals("Z")'>审核中</s:if><s:if test='#ubean.opopidnumberconfirmsign.equals("Y")'>已通过</s:if><s:if test='#ubean.opopidnumberconfirmsign==null'>未提交信息</s:if></span>
    </td>
  </tr>
  </s:if>
</table>


        </div>
        <s:if test="#ubean==null">
        <div style="width: 818px; margin-top:20px;">
          <div class="admin_table" style="OVERFLOW-y: auto; OVERFLOW-x: auto; WIDTH: 785px; HEIGHT: 335px; background:#FFF;">
            <table width="900px" border="0" cellpadding="0" cellspacing="0"  bgcolor="#d5d5d5" class="manage_form"  >
              <tr class="manage_form_bk4" style="height:30px; background:url(m_images/tit_bg.png) repeat-x; left:20px;">
                <td width="25%" align="center">用户名</td>
                <td width="10%" align="center">用户帐号</td>
                <td width="15%" align="center">注册时间</td>
                <td width="20%" align="center">认证状态</td>
                <td width="15%" align="center">操作</td>
              </tr>
              <%int i = 0; %>
                 <s:iterator var="UserBean" value="#request.UserList">
							<% i++;if(i%2==0){%>
								<tr  class="manage_form_bk">
								<%}else{%>
								<tr class="manage_form_bk2">
								<%}%>
									<td align="center"><a href="${pageContext.request.contextPath }/queryUsersByCon?m_opid=<s:property  value='#UserBean.opopid'/>">
										<s:property  value="#UserBean.opopname"/></a></td>
									<td align="center">
										<s:property value="#UserBean.opopcode"/>
									</td>
									<td align="center">
										<s:property value="#UserBean.opopcreatedate"/>
									</td>
									<td align="center">
										<s:if test="#UserBean.opopidnumberconfirmsign==null">
											未提交

										</s:if>
										<s:elseif test='#UserBean.opopidnumberconfirmsign.equals("Z")'>
											待审核

										</s:elseif>
										<s:elseif test='#UserBean.opopidnumberconfirmsign.equals("N")'>
											未通过
										</s:elseif>
										<s:elseif test='#UserBean.opopidnumberconfirmsign.equals("Y")'>
											已认证

										</s:elseif>
									</td>
									<td align="center">
										<s:property value="#UserBean.Bllblname"/>查看信息
									</td>
								</tr>
								</s:iterator>
								<s:set var="beans" value="#request.UserList" />
									<s:if test="#beans==null">	
										<tr class="manage_form_bk">
											<td colspan="7" align="left"><h3>&nbsp;&nbsp;&nbsp;&nbsp;对不起,没有查询到对应条件的记录!</h3></td>
										</tr>
									</s:if>
									<s:else>
										<s:if test="#beans.size()==0">
										<tr class="manage_form_bk">
											<td colspan="7" align="left"><h3>&nbsp;&nbsp;&nbsp;&nbsp;对不起,没有查询到对应条件的记录!</h3></td>
										</tr>
										</s:if>
						</s:else>	
            </table>  
          </div>   
          <div class="pageNav">    
            <p:pager url="queryUsersByCon"/>    
        </div>     
        </div>  
        </s:if>    
        </div>
      </div>
    </div>
  </div>
</form>


</body>


</html>
