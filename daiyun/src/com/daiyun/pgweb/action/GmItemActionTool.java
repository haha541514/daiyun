package com.daiyun.pgweb.action;

import java.util.List;

import kyle.common.util.jlang.CollectionUtility;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemColumns;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemCondition;
import kyle.leis.fs.authoritys.gmenus.dax.GmenusItemDemand;
import kyle.leis.fs.dictionary.district.da.DhlairportlocationCondition;

public class GmItemActionTool extends GmItemAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//²éÑ¯ÄÚÈÝ
	private String gmcodeAction;
	private int pageCountAction;
	private List<String> listAction;
	private String hubcode; 
	private String strPostcode;
	private String strCityname;
	private String country;
    public String queryBygmcode() throws Exception{
    	String gmcode=request.getParameter("code"); 
    	
    	if(gmcode==null||"".equals(gmcode)){
    		gmcode=gmcodeAction;
    		request.setAttribute("pageCount", pageCountAction);
    	    request.setAttribute("districtList", listAction);
    	    request.setAttribute("hubcode", hubcode);
    		request.setAttribute("strPostcode",strPostcode);
    	    request.setAttribute("strCityname", strCityname);
    	    request.setAttribute("country",country);
        	m_objPageConfig.setMaxPageResultCount(pageCountAction);
    	    DhlairportlocationCondition condition = new DhlairportlocationCondition();		
    		condition.setPageConfig(m_objPageConfig);
    		if(!CollectionUtility.isNull(listAction)){
    			request.setAttribute("objPageConfig", m_objPageConfig);			
    		}
    	}
    	    	
 	    GmenusitemCondition objGmenusitemCondition=new GmenusitemCondition();
 	    objGmenusitemCondition.setIskcode("LEWFDIS");
 	    objGmenusitemCondition.setGmcode(gmcode);
 	    List<GmenusitemColumns> l;
		  l = GmenusItemDemand.query(objGmenusitemCondition);
		  request.setAttribute("gmcode", gmcode);
		  request.setAttribute("content", l.get(0).getGmigmi_content());
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
	
}
