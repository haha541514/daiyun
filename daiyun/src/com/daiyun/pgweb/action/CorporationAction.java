/**
 * 
 */
package com.daiyun.pgweb.action;

import java.io.PrintWriter;
import java.util.List;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.es.company.companys.bl.Companys;
import kyle.leis.es.company.companys.da.CorporationxColumns;
import kyle.leis.es.company.companys.da.CorporationxCondition;
import kyle.leis.es.company.companys.da.CorporationxQuery;

public class CorporationAction extends ActionSupportEX {
	public String queryCorporation() throws Exception {

		CorporationxQuery query = new CorporationxQuery();
		CorporationxCondition con = new CorporationxCondition();
		String cocode = request.getParameter("cocode");
		if (!StringUtility.isNull(cocode)) {
			con.setCocode(cocode);
		}
		String colabelcode = request.getParameter("labercode");
		if (!StringUtility.isNull(colabelcode)) {
			con.setColabelcode(colabelcode);
		}
		String statue = request.getParameter("m_statue");
		if (!StringUtility.isNull(statue)) {
			if (statue.equals("Z")) {
				statue = null;
			}
			con.setCobpicconfirmsign(statue);
		}
		m_objPageConfig.setMaxPageResultCount(8);
		con.setPageConfig(m_objPageConfig);
		query.setCondition(con);
		List<CorporationxColumns> list = query.getResults();
		CorporationxColumns columns = null;
		if (list.size() == 1 && !StringUtility.isNull(cocode)) {
			columns = list.get(0);
			request.setAttribute("corporationColumns", columns);
		} else {
			request.setAttribute("listCorporation", list);
		}
		return SUCCESS;
	}

	public String ModifyAuditStatue() throws Exception {
		String cocode = request.getParameter("cocode");
		String OpId = (String) session.getAttribute("OpId");
		Companys com = new Companys();
		com.saveAudit(cocode, "Y", OpId);
		PrintWriter pw = response.getWriter();
		pw.print("OK");
		return null;
	}

	public String queryCorporationByCode() throws Exception {

		CorporationxQuery query = new CorporationxQuery();
		CorporationxCondition con = new CorporationxCondition();
		String cocode = request.getParameter("cocode");
		if (!StringUtility.isNull(cocode)) {
			con.setCocode(cocode);
		}
		query.setCondition(con);
		List<CorporationxColumns> list = query.getResults();
		CorporationxColumns columns = null;
		if (list.size() == 1 && !StringUtility.isNull(cocode)) {
			columns = list.get(0);
			request.setAttribute("corporationColumns", columns);
		}
		return SUCCESS;
	}

	public String AuditReturned() throws Exception {
		String cocode = request.getParameter("cocode");
		String remark = request.getParameter("remark");
		String OpId = (String) session.getAttribute("OpId");
		Companys com = new Companys();
		com.saveRemark(cocode, remark, OpId);
		PrintWriter pw = response.getWriter();
		pw.print("OK");
		return null;
	}

}
