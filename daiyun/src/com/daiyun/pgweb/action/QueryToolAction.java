package com.daiyun.pgweb.action;

import java.util.List;

import com.daiyun.dax.DhldistrictEX;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.fs.dictionary.district.bl.DHLRemoteDistrict;
import kyle.leis.fs.dictionary.district.da.AirwaycompanyCondition;
import kyle.leis.fs.dictionary.district.da.DhlairportlocationCondition;
import kyle.leis.fs.dictionary.district.da.DhlremotedistrictCondition;
import kyle.leis.fs.dictionary.district.da.PortCondition;
import kyle.leis.fs.dictionary.district.dax.AirwayCompanyDemand;
import kyle.leis.fs.dictionary.district.dax.PortDemand;

public class QueryToolAction extends ActionSupportEX {
	private static final long serialVersionUID = 1L;
	/**
	 * 全球机场查询 
	 * @return
	 * @throws Exception 
	 */
	private String gmcodeAction;
	private int pageCountAction;
	private List<String> listAction;
	private String hubcode; 
	private String strPostcode;
	private String strCityname;
	private String country;
	private String ddPortEName; 
	private String ddPortCName;
	private String Achubcode;
	private String Acthreehubcode;
	private String Acename;
	private String Accname;
	
	/**
	 * 全球机场查询
     * @return
	 * @throws Exception 
	 * 
	 */
	public String worldAccess() throws Exception{
		String ddCityName = request.getParameter("ddCityName");
		if (ddCityName == null) {
			ddCityName = "";
		}
		String ddHubCode = request.getParameter("ddHubCode");
		if (ddHubCode == null) {
			ddHubCode = "";
		}
		String ddCityCName = request.getParameter("ddCityCName");
		gmcodeAction=request.getParameter("gmcode1");
		//分页参数		
		if(StringUtility.isNull(request.getParameter("customInputCount")) ||
				"".equals(request.getParameter("customInputCount"))){
			pageCountAction=9;
		} else {
			pageCountAction=Integer.parseInt(request.getParameter("customInputCount"));
		}
				
		m_objPageConfig.setMaxPageResultCount(pageCountAction);		
		DhlairportlocationCondition condition = new DhlairportlocationCondition();		
		condition.setPageConfig(m_objPageConfig);
		
		listAction = DhldistrictEX.queryDHLDistrict(condition,ddHubCode.toUpperCase().trim(),
					ddCityCName,ddCityName.toUpperCase().trim());
		
		return SUCCESS;		
		
	}
	
	/**
	 * 偏远地区查询
     * @return
	 * @throws Exception 
	 * 
	 */
	public String remoteDistrictAccess()throws Exception{
		hubcode     = request.getParameter("Dtdt_hubcode"); 
		strPostcode = request.getParameter("strPostcode");
		strCityname = request.getParameter("strCityname");
		country     = request.getParameter("country");
		gmcodeAction=request.getParameter("gmcode1");
		DHLRemoteDistrict dhlRemoteDistrict = new DHLRemoteDistrict();
		//分页参数		
		if(StringUtility.isNull(request.getParameter("customInputCount")) ||
				"".equals(request.getParameter("customInputCount"))){
			pageCountAction=9;
		} else {
			pageCountAction=Integer.parseInt(request.getParameter("customInputCount"));
		}
		m_objPageConfig.setMaxPageResultCount(pageCountAction);
		DhlremotedistrictCondition objDRDCondition = new DhlremotedistrictCondition();
		objDRDCondition.setPageConfig(m_objPageConfig);
		listAction = dhlRemoteDistrict.query(objDRDCondition,hubcode.toUpperCase().trim(),
		strPostcode, strCityname.toUpperCase().trim());		
		return SUCCESS;
	}		
	
	/**
	 * 港口查询
	 * @return
	 * @throws Exception 
	 */
	public String portAccessTool() throws Exception{
		ddPortEName = request.getParameter("ddPortEName");
		ddPortCName = request.getParameter("ddPortCName");
		gmcodeAction=request.getParameter("gmcode1");		
		if(StringUtility.isNull(request.getParameter("customInputCount")) ||
				"".equals(request.getParameter("customInputCount"))){
			pageCountAction=9;
		} else {
			pageCountAction=Integer.parseInt(request.getParameter("customInputCount"));
		}			
		PortCondition condition = new PortCondition();
		m_objPageConfig.setMaxPageResultCount(pageCountAction);		
		condition.setPageConfig(m_objPageConfig);
		if(!StringUtility.isNull(ddPortEName)){
			condition.setPtename(ddPortEName.toUpperCase().trim());
		}
		if(!StringUtility.isNull(ddPortCName)){
			condition.setPtcname(ddPortCName.trim());
		}
		listAction = PortDemand.queryPort(condition);		
		return SUCCESS;		
	}
	
	/**
	 * 航空公司查询
	 * @return
	 * @throws Exception 
	 */
	public String airwayCompanyAccessTool() throws Exception{
		Achubcode = request.getParameter("Achubcode");
		Acthreehubcode = request.getParameter("Acthreehubcode");
		Acename = request.getParameter("Acename");
		Accname = request.getParameter("Accname");
		gmcodeAction=request.getParameter("gmcode1");
		if(StringUtility.isNull(request.getParameter("customInputCount")) ||
				"".equals(request.getParameter("customInputCount"))){
			pageCountAction=9;
		} else {
			pageCountAction=Integer.parseInt(request.getParameter("customInputCount"));
		}			
		AirwaycompanyCondition condition = new AirwaycompanyCondition();
		m_objPageConfig.setMaxPageResultCount(pageCountAction);		
		condition.setPageConfig(m_objPageConfig);
		if(!StringUtility.isNull(Achubcode)){
			condition.setAchubcode(Achubcode.toUpperCase().trim());
		}
		if(!StringUtility.isNull(Acthreehubcode)){
			condition.setActhreehubcode(Acthreehubcode.trim());
		}
		if(!StringUtility.isNull(Acename)){
			condition.setAcename(Acename.toUpperCase().trim());
		}
		if(!StringUtility.isNull(Accname)){
			condition.setAccname(Accname.trim());
		}
		listAction = AirwayCompanyDemand.queryAirwayCompany(condition);		
		return SUCCESS;		
	}
	
	
	public String getGmcodeAction() {
		return gmcodeAction;
	}


	public void setGmcodeAction(String gmcodeAction) {
		this.gmcodeAction = gmcodeAction;
	}


	public int getPageCountAction() {
		return pageCountAction;
	}


	public void setPageCountAction(int pageCountAction) {
		this.pageCountAction = pageCountAction;
	}


	public List<String> getListAction() {
		return listAction;
	}


	public void setListAction(List<String> listAction) {
		this.listAction = listAction;
	}
	public String getHubcode() {
		return hubcode;
	}
	public void setHubcode(String hubcode) {
		this.hubcode = hubcode;
	}
	public String getStrPostcode() {
		return strPostcode;
	}
	public void setStrPostcode(String strPostcode) {
		this.strPostcode = strPostcode;
	}
	public String getStrCityname() {
		return strCityname;
	}
	public void setStrCityname(String strCityname) {
		this.strCityname = strCityname;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}

	public String getDdPortEName() {
		return ddPortEName;
	}

	public void setDdPortEName(String ddPortEName) {
		this.ddPortEName = ddPortEName;
	}

	public String getDdPortCName() {
		return ddPortCName;
	}

	public void setDdPortCName(String ddPortCName) {
		this.ddPortCName = ddPortCName;
	}

	public String getAchubcode() {
		return Achubcode;
	}

	public void setAchubcode(String achubcode) {
		Achubcode = achubcode;
	}

	public String getActhreehubcode() {
		return Acthreehubcode;
	}

	public void setActhreehubcode(String acthreehubcode) {
		Acthreehubcode = acthreehubcode;
	}

	public String getAcename() {
		return Acename;
	}

	public void setAcename(String acename) {
		Acename = acename;
	}

	public String getAccname() {
		return Accname;
	}

	public void setAccname(String accname) {
		Accname = accname;
	}
	

}
