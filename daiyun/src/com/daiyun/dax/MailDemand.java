package com.daiyun.dax;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeColumns;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeCondition;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeQuery;

public class MailDemand extends ActionSupportEX {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public static List<ShipperconsigneeColumns> query() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
    	HttpSession session = request.getSession();
    	String Cocode=(String) session.getAttribute("Cocode");
    	
		ShipperconsigneeQuery objSCQuery = new ShipperconsigneeQuery();
		ShipperconsigneeCondition objSCCondition=new ShipperconsigneeCondition();
		objSCCondition.setCmcocode(Cocode);
		objSCCondition.setScshipperconsigneetype("M");
		objSCQuery.setCondition(objSCCondition);
		return objSCQuery.getResults();
	}
}
