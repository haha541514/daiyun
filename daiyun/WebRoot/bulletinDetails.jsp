<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!-- <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> -->
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<html>
<s:set value="#request.bulletinColumns" var="columns"/>
  <head>
    <title><s:property value="#columns.blblheading" /></title>
  </head>
  <body>
    <s:property value="#columns.blblcontent" />
    loding....
  </body>
</html>
