package com.daiyun.dax;

import java.util.List;

import kyle.common.util.jlang.StringUtility;
import kyle.leis.fs.dictionary.district.da.DhlairportlocationCondition;
import kyle.leis.fs.dictionary.district.da.DhlairportlocationQuery;


public class DhldistrictEX extends DhlairportlocationQuery{
	public static List queryDHLDistrict(DhlairportlocationCondition objDDCondition,String ddHubCode,
			String ddCName,String ddEName ) throws Exception {
		DhlairportlocationQuery objDhldistrictQuery =new DhldistrictEX(ddHubCode, ddCName,ddEName);
		objDhldistrictQuery.setCondition(objDDCondition);
		return objDhldistrictQuery.getResults();
	}	
	public DhldistrictEX( String ddHubCode,String ddCName,String ddEName){		
		m_strWhereClause = " ap.dt_code = dt.dt_code  ";
		//System.out.println("三字码："+ddHubCode+",中文名："+ddCName+"，英文名："+ddEName);
		if (!StringUtility.isNull(ddHubCode)) {
			m_strWhereClause += " and ap.ap_hubcode = '" + ddHubCode + "' ";
		}				
		if (!StringUtility.isNull(ddCName)) {
			m_strWhereClause += " and ap.ap_cname like '%" + ddCName + "%' ";
		}
		if (!StringUtility.isNull(ddEName)) {
			m_strWhereClause += " and ap.ap_ename like '%" + ddEName + "%' "; 
		}
	}
}
