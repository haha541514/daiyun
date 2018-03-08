package com.daiyun.dax;

import java.util.List;

import kyle.leis.es.company.companys.da.CorporationdColumns;
import kyle.leis.es.company.companys.da.CorporationdCondition;
import kyle.leis.es.company.companys.da.CorporationdQuery;
import kyle.leis.fs.dictionary.dictionarys.da.TdiOperatorDC;
import kyle.leis.hi.TdiOperator;

public class CompanyDemand {
	public static CorporationdColumns queryCompanyByOpId(String opid) throws Exception{
		TdiOperator objTdiOperatorDC=TdiOperatorDC.loadByKey(opid);
		CorporationdQuery query = new CorporationdQuery();
		CorporationdCondition con = new CorporationdCondition();
		try {
			objTdiOperatorDC.getTcoCorporation().getCoCode();
		} catch (Exception e) {
			//System.out.println("查询用户异常");
			return  new CorporationdColumns();
		}
		con.setCocode(objTdiOperatorDC.getTcoCorporation().getCoCode());
		query.setCondition(con);
		List list =query.getResults();
		if(list.size()!=0)
			return (CorporationdColumns) list.get(0);
		return null;
		
	}
	
	public static CorporationdColumns queryCompanyById(String id) throws Exception{
		CorporationdQuery query = new CorporationdQuery();
		CorporationdCondition con = new CorporationdCondition();
		con.setCocode(id);
		query.setCondition(con);
		List list =query.getResults();
		if(list.size()!=0)
			return (CorporationdColumns) list.get(0);
		return null;
		
	}
	
}
