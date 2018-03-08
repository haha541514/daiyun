package com.daiyun.pgweb.action;

import java.util.List;


import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.CollectionUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeColumns;
import kyle.leis.fs.dictionary.district.bl.DHLRemoteDistrict;
import kyle.leis.fs.dictionary.district.da.AirwaycompanyCondition;
import kyle.leis.fs.dictionary.district.da.CountryColumns;
import kyle.leis.fs.dictionary.district.da.DhlairportlocationCondition;
import kyle.leis.fs.dictionary.district.da.DhldistrictCondition;
import kyle.leis.fs.dictionary.district.da.DhlremotedistrictCondition;
import kyle.leis.fs.dictionary.district.da.PortCondition;
import kyle.leis.fs.dictionary.district.dax.AirwayCompanyDemand;
import kyle.leis.fs.dictionary.district.dax.DistrictDemand;
import kyle.leis.fs.dictionary.district.dax.PortDemand;

import com.daiyun.dax.CountryDemand;
import com.daiyun.dax.DhldistrictEX;

/**
 * 基础数据查询
 * @author Administrator
 *
 */
public class BaseDataAccessAction extends ActionSupportEX {
	private static final long serialVersionUID = 1L;
	private ShipperconsigneeColumns m_objSCColumns;
	/**
	 * 城市查询
	 * @return
	 * @throws Exception 
	 */
	public String cityAccess() throws Exception{
		String ddCityName = request.getParameter("ddCityName");
		if (ddCityName == null) {
			ddCityName = "";
		}
		String ddHubCode = request.getParameter("ddHubCode");
		if (ddHubCode == null) {
			ddHubCode = "";
		}
		String ddCityCName = request.getParameter("ddCityCName");
		//分页参数
		int pageCount=0;
		if(StringUtility.isNull(request.getParameter("customInputCount")) ||
				"".equals(request.getParameter("customInputCount"))){
			pageCount=9;
		} else {
			pageCount=Integer.parseInt(request.getParameter("customInputCount"));
		}
		//传回页面的值
		request.setAttribute("pageCount", pageCount);		
		
		DhldistrictCondition condition = new DhldistrictCondition();
		m_objPageConfig.setMaxPageResultCount(pageCount);
		condition.setPageConfig(m_objPageConfig);
		List list = DistrictDemand.queryDHLDistrict(condition, ddCityName.toUpperCase().trim(), 
				ddHubCode.toUpperCase().trim(), ddCityCName);
		request.setAttribute("districtList", list);
		
		request.setAttribute("ddCityName", ddCityName);
		request.setAttribute("ddHubCode", ddHubCode);
		
		String result = request.getParameter("result");
		if (StringUtility.isNull(result)) {
			return SUCCESS;
		} else {
			return result;
		}
		
	}
	/**
	 * 全球机场查询 
	 * @return
	 * @throws Exception 
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
		//分页参数
		int pageCount=0;
		if(StringUtility.isNull(request.getParameter("customInputCount")) ||
				"".equals(request.getParameter("customInputCount"))){
			pageCount=9;
		} else {
			pageCount=Integer.parseInt(request.getParameter("customInputCount"));
		}
				
		m_objPageConfig.setMaxPageResultCount(pageCount);
		request.setAttribute("pageCount",pageCount);
		DhlairportlocationCondition condition = new DhlairportlocationCondition();		
		condition.setPageConfig(m_objPageConfig);	    
		
		List list = DhldistrictEX.queryDHLDistrict(condition,ddHubCode.toUpperCase().trim(),
				ddCityCName,ddCityName.toUpperCase().trim());
		
		//传回页面的值
		request.setAttribute("pageCount", pageCount);
		request.setAttribute("districtList", list);		
		
		if(!CollectionUtility.isNull(list)){
			request.setAttribute("objPageConfig", m_objPageConfig);			
		}		
		String result = request.getParameter("result");		
		if (StringUtility.isNull(result)) {
			return SUCCESS;
		} else {
			return result;
		}
		
	}
	
	/**
	 * 偏远地区查询
     * @return
	 * @throws Exception 
	 */
	public String remoteDistrictAccess()throws Exception{
		String hubcode     = request.getParameter("Dtdt_hubcode"); 
		String strPostcode = request.getParameter("strPostcode");
		String strCityname = request.getParameter("strCityname");
		String country     = request.getParameter("country");
		DHLRemoteDistrict dhlRemoteDistrict = new DHLRemoteDistrict();
		//分页参数
		int pageCount=0;
		if(StringUtility.isNull(request.getParameter("customInputCount")) ||
				"".equals(request.getParameter("customInputCount"))){
			pageCount=9;
		} else {
			pageCount=Integer.parseInt(request.getParameter("customInputCount"));
		}
		m_objPageConfig.setMaxPageResultCount(pageCount);
		DhlremotedistrictCondition objDRDCondition = new DhlremotedistrictCondition();
		objDRDCondition.setPageConfig(m_objPageConfig);
		List RemoteDistrictList = dhlRemoteDistrict.query(objDRDCondition,hubcode.toUpperCase().trim(),
		strPostcode, strCityname.toUpperCase().trim());
		//传回页面的值
		request.setAttribute("pageCount", pageCount);
		if(!CollectionUtility.isNull(RemoteDistrictList)){
			request.setAttribute("objPageConfig", m_objPageConfig);			
		}	
		request.setAttribute("hubcode", hubcode);
		request.setAttribute("strPostcode",strPostcode);
	    request.setAttribute("strCityname", strCityname);
	    request.setAttribute("country",country);
		request.setAttribute("RemoteDistrictList", RemoteDistrictList);
		return SUCCESS;
	}
	
	/**
	 * 根据二字代码得到国家编号
     * @return
	 * @throws Exception 
	 */
	public String getCountryCodeByHubCode()throws Exception{
		String dthubcode = request.getParameter("hubcode");
		CountryDemand countryDemand = new CountryDemand();
		List listCountryColumns = countryDemand.queryDtcodeByHubcode(dthubcode);
		CountryColumns a = (CountryColumns) listCountryColumns.get(0);
		String dtDt_name = a.getDtdt_name();
		response.getWriter().write(dtDt_name);
		return null;
	}
	
	/**
	 * 根据国家名字得到二字代码
	 * @return
	 * @throws Exception 
	 */
	public String getHubCodeByCountryName()throws Exception{
		String country = request.getParameter("country");
		CountryDemand countryDemand = new CountryDemand();
		List listCountryColumns = countryDemand.queryDtHubCodeByCountry(country);
		CountryColumns a = (CountryColumns) listCountryColumns.get(0);
		String dtDt_code = a.getDtdt_hubcode();
		response.getWriter().write(dtDt_code);
		return null;
	}
	
	
	/**
	 * 港口查询
	 * @return
	 * @throws Exception 
	 */
	public String portAccess() throws Exception{
		String ddPortEName = request.getParameter("ddPortEName");
		String ddPortCName = request.getParameter("ddPortCName");
		int pageCount = 0;
		if(StringUtility.isNull(request.getParameter("customInputCount")) ||
				"".equals(request.getParameter("customInputCount"))){
			pageCount=9;
		} else {
			pageCount=Integer.parseInt(request.getParameter("customInputCount"));
		}			
		PortCondition condition = new PortCondition();
		m_objPageConfig.setMaxPageResultCount(pageCount);
		request.setAttribute("pageCount", pageCount);
		condition.setPageConfig(m_objPageConfig);
		if(!StringUtility.isNull(ddPortEName)){
			condition.setPtename(ddPortEName.toUpperCase().trim());
		}
		if(!StringUtility.isNull(ddPortCName)){
			condition.setPtcname(ddPortCName.trim());
		}
		List portList = PortDemand.queryPort(condition);
		if(!CollectionUtility.isNull(portList)){
			request.setAttribute("objPageConfig", m_objPageConfig);			
		}	
		request.setAttribute("ddPortEName", ddPortEName);
    	request.setAttribute("ddPortCName", ddPortCName);
		request.setAttribute("portList", portList);
		return SUCCESS;		
	}
	
	/**
	 * 航空公司查询
	 * @return
	 * @throws Exception 
	 */
	public String airwayCompanyAccess() throws Exception{
		String Achubcode = request.getParameter("Achubcode");
		String Acthreehubcode = request.getParameter("Acthreehubcode");
		String Acename = request.getParameter("Acename");
		String Accname = request.getParameter("Accname");
		int pageCount = 0;
		if(StringUtility.isNull(request.getParameter("customInputCount")) ||
				"".equals(request.getParameter("customInputCount"))){
			pageCount=9;
		} else {
			pageCount=Integer.parseInt(request.getParameter("customInputCount"));
		}			
		AirwaycompanyCondition condition = new AirwaycompanyCondition();
		m_objPageConfig.setMaxPageResultCount(pageCount);
		request.setAttribute("pageCount", pageCount);
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
		List airwayCompanyList = AirwayCompanyDemand.queryAirwayCompany(condition);
		request.setAttribute("Achubcode", Achubcode);
		if(!CollectionUtility.isNull(airwayCompanyList)){
			request.setAttribute("objPageConfig", m_objPageConfig);			
		}	
    	request.setAttribute("Acthreehubcode", Acthreehubcode);
    	request.setAttribute("Acename", Acename);
    	request.setAttribute("Accname", Accname);
		request.setAttribute("airwayCompanyList", airwayCompanyList);
		return SUCCESS;		
	}
	
	//验证码判断
    public String  ajaxCheckValiteCode() throws Exception{
    	String validateCode=request.getParameter("validateCode");
    	String sessionValidateCode = (String) session.getAttribute("CheckCodeImageAction");
    	String result="Y";
    	if (!StringUtility.isNull(validateCode))
			validateCode =  validateCode.toLowerCase();
    	if (!StringUtility.isNull(validateCode) && 
				!StringUtility.isNull(sessionValidateCode) &&
				!validateCode.equals(sessionValidateCode.toLowerCase())){
    		result="N";
		}
    	response.getWriter().write(result);
    	return null;
    }
    //手机验证码判断
    public String  checkMobileValiteCode() throws Exception{
    	String validateCode=request.getParameter("mobileValidateCode");
    	String sessionValidateCode = (String) session.getAttribute("mobileValidateCode");
    	String result="Y";
    	if (!StringUtility.isNull(validateCode))
			validateCode =  validateCode.toLowerCase();
    	if (!StringUtility.isNull(validateCode) && 
				!StringUtility.isNull(sessionValidateCode) &&
				!validateCode.equals(sessionValidateCode.toLowerCase())){
    		result="N";
		}
    	response.getWriter().write(result);
    	return null;
    }
    
    
    
	
	
}
