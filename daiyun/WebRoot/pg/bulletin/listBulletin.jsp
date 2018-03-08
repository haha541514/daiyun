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
<title>查看新闻页面</title>
<link href="<%=path%>/style/page_master.css" type="text/css" rel="stylesheet" />

</head>
<style>
a{color:#333333;text-decoration:none;}
.pageNav { text-align:center; margin-top:10px; height:26px; padding:3px 0px;color: #000000;}
.pageNav a { display:inline; border:1px solid #ccc; height:20px; line-height:20px; margin-left:5px; padding:2px 7px;}
.pageNav a:hover { border:1px solid #3a739d; text-decoration:none; color:#3a739d; background:#f6fbff;}
</style>
<script language="javascript" type="text/javascript">
	function mySearch(){
		document.getElementById("listform").action = "${pageContext.request.contextPath }/page/queryBulletin";
		document.getElementById("listform").submit();
	}
	
	function changeCheckBox(){
		var cboxes=document.listform.elements;
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

	function link(){
		document.getElementById("listform").action = "${pageContext.request.contextPath }/pg/bulletin/addBulletin.jsp";
		document.getElementById("listform").submit();
	}

	function chooseOneAtLeast(){
		var obj = document.listform.elements;
		var k=0;
		for(var i=0;i<obj.length;i++){
			if (obj[i].name == "delid"){
				if(obj[i].checked == true){
					k+=1;
				}		
			}
		}
		if(k==0){
			alert("请至少选择一条新闻");
			return false;
		}else{
			return true;
		}
	}
	
	function link2(){
		if(chooseOneAtLeast()){
			document.getElementById("listform").action="${pageContext.request.contextPath }/page/deleteBulletin";
			document.getElementById("listform").submit();
		}
	}
</script>

<body>
<form action="${pageContext.request.contextPath }/page/fsupport/queryArticle"
	method="post" name="listform" id="listform" >
<div id="admin">
  <div id="top"><img src="<%=path%>/m_images/logo.jpg" /> <span>首您现在的位置：<a href="<%=path%>/daiyun.jsp">首页</a>---会员中心---查看新闻</span> </div>
  <div class="master">
    <jsp:include page="tree.jsp"></jsp:include>
    <div class="right">
      <div class="admin_rit_ads">
        <div class="admin_ads_head">
          <div class="admin_ads_head_lft"></div>
          <div class="admin_piece_rit">
            <input type="button" value="增 加" style="width:82px; height:28px; margin-left: 220px; background:url(<%=path %>/m_images/add.jpg); border:0px;" onclick="link();"/>
            &nbsp;&nbsp;&nbsp;
            <input type="button" value="查 询" style="width:82px; height:28px; background:url(<%=path %>/m_images/add.jpg); border:0px;" onclick="mySearch();"/>
            &nbsp;&nbsp;&nbsp;
            <input type="button" value="删 除" style="width:82px; height:28px; background:url(<%=path %>/m_images/delete.jpg); border:0px;" onclick="link2();"/>
          </div>
        </div>
        <div class="admin_ads_check" align="center">
          <p >
          <table width="600" border="0" cellpadding="0" cellspacing="0">
            <tr>
              <td width="65">公告标题：</td>
              <td width="535"><input  name="bulletinHeading" type="text" class="input_text" style="width:525px; height:25px; border:1px solid #cccccc; padding-left:5px;" value="<%=request.getAttribute("searchArticleTitle")==null?"":request.getAttribute("searchArticleTitle") %>" /></td>
            </tr>
          </table>
          </p>
          <p>
          <table width="600" border="0" cellpadding="0" cellspacing="0" >
            <tr>
              <td width="65">公告类型：</td>
              <td width="135"><select name="bulletinType" style="width: 130px; height:25px; border:1px solid #cccccc;">
                  <option value="">=====请选择=====</option>
                 <s:iterator var="bllkBean" value="@kyle.leis.es.bulletin.dax.BulletinDemand@queryAllBllKing()">
                                		<s:if test="#request.bulletinType.equals(#bllkBean.Bkbkcode)">
                                			<option value="<s:property value='#bllkBean.Bkbkcode'/>" selected="selected"><s:property value="#bllkBean.Bkbkname"/></option>
                                		</s:if>
                                		<s:else>
                                			<option value="<s:property value='#bllkBean.Bkbkcode'/>"><s:property value="#bllkBean.Bkbkname"/></option>
                                		</s:else>
                                	</s:iterator>
                </select></td>
              <td width="65">&nbsp;公告级别：</td>
              <td width="135"><select name="bulletinLevle" style="width: 130px; height:25px; border:1px solid #cccccc;">
                  <option value="">=====请选择=====</option>
                 <s:iterator var="bllLBean" value="@kyle.leis.es.bulletin.dax.BulletinDemand@queryAllbllLevel()">
                                		<s:if test="#request.bulletinLevle.equals(#bllLBean.Blblcode)">
                                			<option value="<s:property value='#bllLBean.Blblcode'/>" selected="selected"><s:property value="#bllLBean.Blblname"/></option>
                                		</s:if>
                                		<s:else>
                                			<option value="<s:property value='#bllLBean.Blblcode'/>"><s:property value="#bllLBean.Blblname"/></option>
                                		</s:else>
                                	</s:iterator>
                </select></td>
              <td width="65">&nbsp;&nbsp;创&nbsp;建&nbsp;人：</td>
              <td width="135"><input name="bulletinCreater" type="text" class="input_text" style="width: 130px; height:25px; border:1px solid #cccccc;" value="${searchArticleCreater }" /></td>
            </tr>
          </table>
          </p>
        </div>
        <div style="width: 818px; margin-top:20px;">
          <div class="admin_table" style="OVERFLOW-y: auto; OVERFLOW-x: auto; WIDTH: 785px; HEIGHT: 335px; background:#FFF;">
            <table width="900px" border="0" cellpadding="0" cellspacing="0"  bgcolor="#d5d5d5" class="manage_form"  >
              <tr class="manage_form_bk4" style="height:30px; background:url(m_images/tit_bg.png) repeat-x; left:20px;">
                <td width="8%"  style=" text-align:center;">全选

                  <label>
                    <input type="checkbox" name="selectAllCheckBox" id="selectAllCheckBox"  style="width:20px" onclick="changeCheckBox();"/>
                  </label></td>
                <td width="25%" align="center">公告标题</td>
                <td width="10%" align="center">公告ID</td>
                <td width="15%" align="center">公告类型</td>
                <td width="20%" align="center">发布时间</td>
                <td width="15%" align="center">创建者</td>
                <td width="15%" align="center">公告级别</td>
              </tr>
              <%int i = 0; %>
							<s:iterator var="bulletinBean" value="#request.bulletinList">
							
							<% i++;if(i%2==0){%>
								<tr  class="manage_form_bk">
								<%}else{%>
								<tr class="manage_form_bk2">
								<%}%>
									<td height="16px" style="text-align:center;">
										<input type="checkbox" name="delid" value="<s:property  value="#bulletinBean.Blblid"/>" />
									</td>
									<td align="center"><a href="${pageContext.request.contextPath }/page/getBulletinById?strBlId=<s:property  value='#bulletinBean.Blblid'/>">
										<s:property  value="#bulletinBean.Blblheading"/></a></td>
									<td align="center">
										<s:property value="#bulletinBean.Blblid"/>
									</td>
									<td align="center">
										<s:property value="#bulletinBean.Bkbkname"/>
									</td>
									<td align="center"><s:property  value="#bulletinBean.Blblcreatedate"/></td>
									<td align="center">
										<s:if test="#bulletinBean.Copopid.equals('0')">
											XS000
										</s:if>
										<s:else>
											other
										</s:else>
									</td>
									<td align="center">
										<s:property value="#bulletinBean.Bllblname"/>
									</td>
								</tr>
								</s:iterator>
								<s:set var="beans" value="#request.bulletinList" />
									<s:if test="#beans==null">	
										<tr class="manage_form_bk">
											<td colspan="7" align="left"><h3>对不起,没有查询到对应条件的记录!</h3></td>
										</tr>
									</s:if>
									<s:else>
										<s:if test="#beans.size()==0">
										<tr class="manage_form_bk">
											<td colspan="7" align="left"><h3>对不起,没有查询到对应条件的记录!</h3></td>
										</tr>
										</s:if>
						</s:else>	
            </table> 
          </div>
          <div class="pageNav">    
            <p:pager url="queryBulletin"/>        
        </div>  
        </div>
      </div>
    </div>
  </div>
</div>
</form>
</body>


</html>
