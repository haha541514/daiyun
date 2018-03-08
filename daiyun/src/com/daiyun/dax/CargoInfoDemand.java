package com.daiyun.dax;

import java.math.BigDecimal;
import java.util.List;

import kyle.leis.eo.operation.cargoinfo.da.CargoinfoColumns;
import kyle.leis.eo.operation.cargoinfo.da.CargoinfoCondition;
import kyle.leis.eo.operation.cargoinfo.da.CargoinfoQuery;

public class CargoInfoDemand {
	public static List queryByCwCode(String strCwcode) 
	throws Exception {
		CargoinfoCondition objCIC = new CargoinfoCondition();
		objCIC.setCwcode(strCwcode);
		CargoinfoQuery objCIQ = new CargoinfoQuery();
		objCIQ.setCondition(objCIC);
		return objCIQ.getResults();
	}
	
	public static List queryAndweightByCwCode(String strCwcode,
			String strTotalweight) 
	throws Exception {
		List listResults = queryByCwCode(strCwcode);
		if (listResults == null || listResults.size() < 1)
			return listResults;
		BigDecimal obj = new BigDecimal(strTotalweight);
		BigDecimal objDivideValue = obj.divide(new BigDecimal(listResults.size()), 3, 1);
		BigDecimal objRetail = obj.add(objDivideValue.multiply(new BigDecimal(listResults.size())).multiply(new BigDecimal("-1")));
		for (int i = 0; i < listResults.size(); i++) {
			CargoinfoColumns objCIC = (CargoinfoColumns)listResults.get(i);
			if (i == 0)
				objCIC.setCiciattacheinfo(objDivideValue.add(objRetail).toString());
			else
				objCIC.setCiciattacheinfo(objDivideValue.toString());
		}
		return listResults;
	}
}
