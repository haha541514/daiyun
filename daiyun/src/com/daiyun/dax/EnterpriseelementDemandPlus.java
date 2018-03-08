package com.daiyun.dax;

import java.util.List;

import kyle.leis.fs.dictionary.enterpriseelement.da.EnterpriseelementColumns;
import kyle.leis.fs.dictionary.enterpriseelement.da.EnterpriseelementCondition;
import kyle.leis.fs.dictionary.enterpriseelement.da.EnterpriseelementQuery;
import kyle.leis.fs.dictionary.enterpriseelement.dax.EnterpriseelementDemand;


/**
 * Î¯ÍÐ¹«Ë¾
 * */
public class EnterpriseelementDemandPlus extends EnterpriseelementDemand{
	
	@SuppressWarnings("unchecked")
	public static List<EnterpriseelementColumns> query() throws Exception{
		EnterpriseelementCondition objEnterpriseelementCon = new EnterpriseelementCondition();
		EnterpriseelementQuery objEnterpriseelementQue = new EnterpriseelementQuery();
		objEnterpriseelementCon.setEekcode("DC"); 
		objEnterpriseelementQue.setCondition(objEnterpriseelementCon);
		List<EnterpriseelementColumns> objReturnlist = objEnterpriseelementQue.getResults();
		return objReturnlist;
	}
	
}