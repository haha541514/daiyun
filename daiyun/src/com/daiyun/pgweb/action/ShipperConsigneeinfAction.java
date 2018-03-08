package com.daiyun.pgweb.action;


import java.util.List;
import kyle.common.dbaccess.cache.QueryCache;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.es.company.shipperconsignee.bl.Shipperconsignee;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeColumns;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeCondition;
import kyle.leis.es.company.shipperconsignee.dax.ShipperconsigneeDemand;
import kyle.leis.fs.authoritys.user.da.UserColumns;
import org.apache.struts2.ServletActionContext;
import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;
import com.opensymphony.xwork2.ActionSupport;

public class ShipperConsigneeinfAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8542289874267902226L;

	private List m_listShipperInfo;
	private String m_strSccode;

	private ShipperconsigneeColumns m_objSCColumns;


	public ShipperconsigneeColumns getM_objSCColumns() {
		return m_objSCColumns;
	}

	public void setM_objSCColumns(ShipperconsigneeColumns m_objSCColumns) {
		this.m_objSCColumns = m_objSCColumns;
	}

	public List getListShipperInfo() {
		return m_listShipperInfo;
	}

	public void setListShipperInfo(List shipperInfo) {
		m_listShipperInfo = shipperInfo;
	}
	
	public String getSccode() {
		return m_strSccode;
	}
	
	public void setSccode(String strSccode) {
		m_strSccode = strSccode;
	}		
	public UserColumns objWebUserColumns;

	public UserColumns getObjWebUserColumns() {
		return objWebUserColumns;
	}

	public void setObjWebUserColumns(UserColumns objWebUserColumns) {
		this.objWebUserColumns = objWebUserColumns;
	}
	
	public String queryShipperInfo() {
		MessageBean objMessageBean = null;
		try {
			ShipperconsigneeCondition objSCCondition = new ShipperconsigneeCondition();
			objSCCondition.setScshipperconsigneetype("S");
			objSCCondition.setCmcocode((String)ServletActionContext.getRequest().getSession().getAttribute("Cocode"));
			
			List shipperList = ShipperconsigneeDemand.query(objSCCondition);
			objSCCondition.setScshipperconsigneetype("C");
			List consigneeList = ShipperconsigneeDemand.query(objSCCondition);
			objSCCondition.setScshipperconsigneetype("T");
			List TinfoList = ShipperconsigneeDemand.query(objSCCondition);
			objSCCondition.setScshipperconsigneetype("M");
			List MailList = ShipperconsigneeDemand.query(objSCCondition);
			
			
			ServletActionContext.getRequest().setAttribute("listShipperInfo",shipperList);
			ServletActionContext.getRequest().setAttribute("listConsignee",consigneeList);
			ServletActionContext.getRequest().setAttribute("listTinfo",TinfoList);
			ServletActionContext.getRequest().setAttribute("listMail",MailList);
			return SUCCESS;
		} catch (Exception ex) {
			ex.printStackTrace();
			objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "查询发件人资料失败",  ex.getMessage());
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
			return ERROR;			
		}
	}
	
	public String loadShipperInfo() {
		MessageBean objMessageBean = null;
		try {
			if (StringUtility.isNull(m_strSccode)) {
				objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "查询发件人资料失败",  "发件人资料参数为空");
				ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
				return ERROR;					
			}
			// m_objSCColumns = gettest();
			ShipperconsigneeColumns objShipperconsigneeColumns = ShipperconsigneeDemand.load(m_strSccode);
			ServletActionContext.getRequest().setAttribute("objShipperconsigneeColumns", objShipperconsigneeColumns);
			
			return SUCCESS;
		} catch (Exception ex) {
			ex.printStackTrace();
			objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "查询发件人资料失败",  ex.getMessage());
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
			return ERROR;			
		}
	}	
	
	public String deleteShipperInfo() {
		MessageBean objMessageBean = null;
		try {
			if (StringUtility.isNull(m_strSccode)) {
				objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "删除发件人资料失败",  "发件人资料参数为空");
				ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
				return ERROR;					
			}
			Shipperconsignee objShipperconsignee = new Shipperconsignee();
			objShipperconsignee.delete(m_strSccode);
			return SUCCESS;
		} catch (Exception ex) {
			ex.printStackTrace();
			objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "删除发件人资料失败",  ex.getMessage());
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
			return ERROR;			
		}
	}	
	
	public String saveShipperInfo() {
		MessageBean objMessageBean = null;
		try {
			if (m_objSCColumns == null) {
				objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "保存发件人资料失败",  "待保存的信息为空");
				ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
				return ERROR;					
			}
			String cocode=(String)ServletActionContext.getRequest().getSession().getAttribute("Cocode");
			
			//先判断保存发件人还是收件人
			String type=ServletActionContext.getRequest().getParameter("sign");
			String mail=ServletActionContext.getRequest().getParameter("mail");
			if(!StringUtility.isNull(mail)){
				m_objSCColumns.setScscshipperconsigneetype(mail);
				m_objSCColumns.setScscaddress2("*");
				m_objSCColumns.setScscaddress3("*");
				m_objSCColumns.setScsccitycode("*");
				m_objSCColumns.setScsccompanyname("*");
				m_objSCColumns.setScscfax("*");
				m_objSCColumns.setScscpostcode("*");
				m_objSCColumns.setScsclabelcode(m_objSCColumns.getScscname()+cocode);
			}else{
				if(!StringUtility.isNull(type)){
					m_objSCColumns.setScscshipperconsigneetype(type);
				}
				else{
					m_objSCColumns.setScscshipperconsigneetype("C");
				}
				if(StringUtility.isNull(m_objSCColumns.getScsclabelcode())){
					m_objSCColumns.setScsclabelcode(m_objSCColumns.getScscname()+cocode);
				}
				if(StringUtility.isNull(m_objSCColumns.getScscpostcode())){
					m_objSCColumns.setScscpostcode("*");
				}
				if(StringUtility.isNull(m_objSCColumns.getScscfax())){
					m_objSCColumns.setScscfax("*");
				}
				if(StringUtility.isNull(m_objSCColumns.getScsccitycode())){
					m_objSCColumns.setScsccitycode("*");
				}
			}
			Shipperconsignee objShipperconsignee = new Shipperconsignee();
			//判断是否重复
			if(StringUtility.isNull(m_objSCColumns.getScsccode())&&objShipperconsignee.checkRepeat(m_objSCColumns)){
				objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "发（收）件人重复！","发（收）件人"+m_objSCColumns.getScscname()+"已存在");
				ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
				return ERROR;
			}
						
			m_objSCColumns.setCmcocode((String)ServletActionContext.getRequest().getSession().getAttribute("Cocode"));
			m_objSCColumns = objShipperconsignee.save(m_objSCColumns);	
			new QueryCache().reset(); 
			
			return SUCCESS;
		} catch (Exception ex) {
			ex.printStackTrace();
			objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "保存发件人资料失败",  ex.getMessage());
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
			return ERROR;			
		}		
	}	
	
	 //ajax保存发件人信息
	public String ajaxSaveShipperInfo() throws Exception{
		ShipperconsigneeColumns ajax_objSCColumns = new ShipperconsigneeColumns();
		ajax_objSCColumns.setScscshipperconsigneetype("S");
		Shipperconsignee objShipperconsignee = new Shipperconsignee();
		String cocode=(String)ServletActionContext.getRequest().getSession().getAttribute("Cocode");
		String name = ServletActionContext.getRequest().getParameter("name");
		String postcode=ServletActionContext.getRequest().getParameter("postcode");
		String company=ServletActionContext.getRequest().getParameter("company");
		String address =ServletActionContext.getRequest().getParameter("address");
		String tel = ServletActionContext.getRequest().getParameter("tel");
		String scsccode=ServletActionContext.getRequest().getParameter("scsccode");
		String sclabelcode=ServletActionContext.getRequest().getParameter("sclabelcode");
		String city = ServletActionContext.getRequest().getParameter("city");
		ajax_objSCColumns.setScscfax("fax");
		ajax_objSCColumns.setCmcocode(cocode);
		ajax_objSCColumns.setScscname(name);
		ajax_objSCColumns.setScsccompanyname(company);
		ajax_objSCColumns.setScsctelephone(tel);
		ajax_objSCColumns.setScsclabelcode(name);
		ajax_objSCColumns.setScscaddress1(address);
		ajax_objSCColumns.setScscaddress2("a2");
		ajax_objSCColumns.setScscaddress3("a3");
		ajax_objSCColumns.setScscpostcode(postcode);
		ajax_objSCColumns.setScsccitycode(city);
		if(StringUtility.isNull(cocode)){
			cocode="1";
		}
		String result ="1";
		ajax_objSCColumns.setCmcocode(cocode);
		if(objShipperconsignee.checkRepeat(ajax_objSCColumns)){
			result="2";
		}	
		try { 
			ajax_objSCColumns=objShipperconsignee.save(ajax_objSCColumns);
		} catch (Exception e) {
		
			result="0";
		}
		ServletActionContext.getResponse().getWriter().write(result);
		new QueryCache().reset(); 
		return null;
	}
	
	
	 //ajax保存收件人信息
	public String ajaxConsigneeInfo() throws Exception{
		ShipperconsigneeColumns ajax_objSCColumns = new ShipperconsigneeColumns();
		ajax_objSCColumns.setScscshipperconsigneetype("C");
		Shipperconsignee objShipperconsignee = new Shipperconsignee();
		String cocode=(String)ServletActionContext.getRequest().getSession().getAttribute("Cocode");
		String name = ServletActionContext.getRequest().getParameter("name");
		String postcode=ServletActionContext.getRequest().getParameter("postcode");
		String company=ServletActionContext.getRequest().getParameter("company");
		String address =ServletActionContext.getRequest().getParameter("address");
		String tel = ServletActionContext.getRequest().getParameter("tel");
		String scsccode=ServletActionContext.getRequest().getParameter("scsccode");
		String sclabelcode=ServletActionContext.getRequest().getParameter("sclabelcode");
		String city = ServletActionContext.getRequest().getParameter("city");
		ajax_objSCColumns.setScscfax("fax");
		ajax_objSCColumns.setCmcocode(cocode);
		ajax_objSCColumns.setScscname(name);
		ajax_objSCColumns.setScsccompanyname(company);
		ajax_objSCColumns.setScsctelephone(tel);
		ajax_objSCColumns.setScsclabelcode(name);
		ajax_objSCColumns.setScscaddress1(address);
		ajax_objSCColumns.setScscaddress2("a2");
		ajax_objSCColumns.setScscaddress3("a3");
		ajax_objSCColumns.setScscpostcode(postcode);
		ajax_objSCColumns.setScsccitycode(city);
		String result ="1";
		if(StringUtility.isNull(cocode))
			cocode="1";
		if(objShipperconsignee.checkRepeat(ajax_objSCColumns)){
			result="2";
		}	
		ajax_objSCColumns.setCmcocode(cocode);
		try { 
			ajax_objSCColumns=objShipperconsignee.save(ajax_objSCColumns);
		} catch (Exception e) {
			result="0";
		}
		ServletActionContext.getResponse().getWriter().write(result);
		new QueryCache().reset(); 
		return null;
	}
	
	
	


}
