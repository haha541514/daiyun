package com.daiyun.pgweb.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.CollectionUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.es.bulletin.da.BulletinColumns;
import kyle.leis.es.bulletin.da.BulletinCondition;
import kyle.leis.es.bulletin.dax.BulletinDemand;

import org.apache.struts2.ServletActionContext;

import com.daiyun.dax.Bulletin;
import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;
import com.daiyun.dax.WebDemand;

public class BulletinAction extends ActionSupportEX {

	private static final long serialVersionUID = 3193353022281437259L;

	/**
	 * ��ѯ��Ҫ����
	 * 
	 * @return
	 * @throws Exception
	 */
	public void queryImportantBulletin() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		List<BulletinColumns> listBulletin = (List<BulletinColumns>) Bulletin
				.queryByBkcode("001", "4");
		if (!CollectionUtility.isNull(listBulletin))
			request.setAttribute("listImportantBulletin", listBulletin);
	}

	/**
	 * ��ѯ��˾����
	 * 
	 * @throws Exception
	 */
	public void queryNews() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		List<BulletinColumns> listBulletin = (List<BulletinColumns>) Bulletin
				.queryByBkcode("002", "3");
		if (!CollectionUtility.isNull(listBulletin))
			request.setAttribute("listNewsBulletin", listBulletin);
	}

	/**
	 * ���ݹ�˾��Ų�ѯ
	 * 
	 * @return
	 * @throws Exception
	 */
	public String queryByBlId() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String strBlId = request.getParameter("blId");
		BulletinColumns objBulletinColumns = Bulletin.queryByBlId(strBlId);
		if (objBulletinColumns != null) {
			request.setAttribute("objBulletin", objBulletinColumns);
			request
					.setAttribute("content", objBulletinColumns
							.getBlblcontent());
			System.out.println(objBulletinColumns.getBlblcontent());
			return SUCCESS;
		}
		return ERROR;
	}

	/**
	 * �������Ͳ�ѯ����
	 * 
	 * @return
	 * @throws Exception
	 */
	public String queryByBkCode() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String strBkCode = request.getParameter("bkCode");
		String strPageFlag = request.getParameter("pageFlag");
		m_objPageConfig.setMaxPageResultCount(10);
		BulletinCondition objBulletinCondition = new BulletinCondition();
		objBulletinCondition.setBkcode(strBkCode);
		if (!StringUtility.isNull(strPageFlag)) {
			int iPageFlag = Integer.parseInt(strPageFlag);
			if (m_objPageConfig.getTotalPageCount() < iPageFlag)
				iPageFlag = m_objPageConfig.getTotalPageCount();
			if (iPageFlag < 1)
				iPageFlag = 1;
			m_objPageConfig.setCurrentPageNo(iPageFlag);
		}
		objBulletinCondition.setPageConfig(m_objPageConfig);
		List objList = BulletinDemand.query(objBulletinCondition);
		if (!CollectionUtility.isNull(objList)) {
			request.setAttribute("objPageConfig", m_objPageConfig);
			request.setAttribute("listBkBulletin", objList);
			return SUCCESS;
		}
		ServletActionContext.getRequest().getSession().setAttribute(
				"MESSAGEBEAN",
				new MessageBean(IBasicData.MSG_TYPE_ERROR, "��ѯ����ʧ��.",
						"û�в�ѯ��������͵Ĺ��棡"));
		return ERROR;
	}

	/**
	 * �������Ͳ�ѯ����
	 * 
	 * @return
	 * @throws Exception
	 */
	public String newQueryByCode() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String strBkCode = "";
		String strCode = request.getParameter("code");
		if (WebDemand.STquery("D0101").equals(strCode)) {
			strBkCode = "002";
		} else if (WebDemand.STquery("D0102").equals(strCode)) {
			strBkCode = "003";
		} else if (WebDemand.STquery("D0103").equals(strCode)) {
			strBkCode = "001";
		}
		String strPageFlag = request.getParameter("pageFlag");
		String gmcode = request.getParameter("code");
		String tiltle = request.getParameter("tiltle");
		m_objPageConfig.setMaxPageResultCount(20);
		BulletinCondition objBulletinCondition = new BulletinCondition();
		objBulletinCondition.setBkcode(strBkCode);
		if (!StringUtility.isNull(strPageFlag)) {
			int iPageFlag = Integer.parseInt(strPageFlag);
			if (m_objPageConfig.getTotalPageCount() < iPageFlag)
				iPageFlag = m_objPageConfig.getTotalPageCount();
			if (iPageFlag < 1)
				iPageFlag = 1;
			m_objPageConfig.setCurrentPageNo(iPageFlag);
		}
		objBulletinCondition.setPageConfig(m_objPageConfig);
		List objList = BulletinDemand.query(objBulletinCondition);
		if (!CollectionUtility.isNull(objList)) {
			request.setAttribute("objPageConfig", m_objPageConfig);
			request.setAttribute("listBkBulletin", objList);
			request.setAttribute("gmcode", gmcode);
			request.setAttribute("tiltle", tiltle);
			return SUCCESS;
		}
		ServletActionContext.getRequest().getSession().setAttribute(
				"MESSAGEBEAN",
				new MessageBean(IBasicData.MSG_TYPE_ERROR, "��ѯ����ʧ��.",
						"û�в�ѯ��������͵Ĺ��棡"));
		return ERROR;
	}

}
