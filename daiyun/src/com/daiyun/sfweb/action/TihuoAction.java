package com.daiyun.sfweb.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.CollectionUtility;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeColumns;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeCondition;
import kyle.leis.es.company.shipperconsignee.dax.ShipperconsigneeDemand;



/**
 *提货单
 * */
public class TihuoAction extends ActionSupportEX {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 接受scscode返回地址,联系人信息。
	 * @throws Exception 
	 * */
	public String tihuochange() throws Exception{
		String scscode = request.getParameter("scscode");
		ShipperconsigneeCondition objSCCondition = new ShipperconsigneeCondition();
		objSCCondition.setCmcocode((String)ServletActionContext.getRequest().getSession().getAttribute("Cocode"));
		objSCCondition.setScshipperconsigneetype("T");
		objSCCondition.setSccode(scscode);
		List<ShipperconsigneeColumns> TinfoList = ShipperconsigneeDemand.query(objSCCondition);
		
		if(!CollectionUtility.isNull(TinfoList)){
			ShipperconsigneeColumns columns = (ShipperconsigneeColumns)TinfoList.get(0);
			
			String connectInfo = toJson(columns.getScscname(),columns.getScscaddress1(),columns.getScsctelephone());
			response.getWriter().print(connectInfo);
		}
		return null;
	}
	
	public String toJson(String connectPerson,String connectAddress,String telephone){
		 JSONObject json=new JSONObject();  
		 json.accumulate("connectPerson", connectPerson);//联系人
		 json.accumulate("connectAddress", connectAddress);//联系地址
		 json.accumulate("telephone", telephone);
		// System.out.println(json.toString());
		 return json.toString();
	}
	
	
	
	
	
}