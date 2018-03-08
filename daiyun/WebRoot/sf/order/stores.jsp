<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<s:if test="#request.stores.size == 0">
	<option value="">----暂无店铺----</option>
</s:if>
<s:else>
	<s:iterator value="#request.stores" var="bean">
		<option value="<s:property value="#bean.cawtcawtid"/>"><s:property value="#bean.cawtcawtusername"/></option>
	</s:iterator>
</s:else>



