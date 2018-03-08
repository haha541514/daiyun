package com.daiyun.opweb.action;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.finance.applyreceiptrecord.bl.Applyreceiptrecord;
import kyle.leis.eo.finance.applyreceiptrecord.da.ApplyreceiptrecordColumns;
import kyle.leis.eo.finance.applyreceiptrecord.da.ApplyreceiptrecordCondition;
import kyle.leis.eo.finance.applyreceiptrecord.da.ApplyreceiptrecordQuery;
import kyle.leis.eo.finance.applyreceiptrecord.dax.ApplyreceiptrecordDemand;
import kyle.leis.eo.finance.applyreceiptrecord.tp.UpdateMailMessageTran;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeColumns;
import kyle.leis.es.company.shipperconsignee.dax.ShipperconsigneeDemand;
import org.apache.struts2.ServletActionContext;
import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;


public class ApplyreceiptrecordAction extends ActionSupportEX {
	private static final long serialVersionUID = 1L;
	
	public String applyreceiptrecord() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();

		String coCode=(String)session.getAttribute("Cocode");
		String opid=(String) session.getAttribute("OpId");
		String action = request.getParameter("action");
		String arrcode = request.getParameter("arrcode");
		String bankName = request.getParameter("bankName"); 
		String bankAccount = request.getParameter("bankAccount"); 
		String companyName = request.getParameter("companyName"); 
		String payNumber = request.getParameter("payNumber"); 
		String applyRemark = request.getParameter("applyRemark"); 
		String mailName = request.getParameter("mailName"); 
		String mailAddress = request.getParameter("mailAddress"); 
		String mailTelephone = request.getParameter("mailTelephone"); 
		String checkBox = request.getParameter("checkBox"); 
	 
		
		ApplyreceiptrecordColumns applyreceiptrecord=new ApplyreceiptrecordColumns();
		applyreceiptrecord.setCococode(coCode);
		applyreceiptrecord.setOpopid(Long.parseLong(opid));
		applyreceiptrecord.setTfarrbankaccount(bankAccount);
		applyreceiptrecord.setTfarrbankname(bankName);
		applyreceiptrecord.setTfarrcompanyname(companyName);
		applyreceiptrecord.setTfarrtaxpayerid(payNumber);
		int rtcode=Integer.valueOf(request.getParameter("invoiceType"));
		int arscode=Integer.valueOf(request.getParameter("arscode"));
		if(!StringUtility.isNull(applyRemark)){
			applyreceiptrecord.setTfarrremark(applyRemark);
		}
		if(!StringUtility.isNull(mailName)){
			applyreceiptrecord.setTfarrmailedcontactperson(mailName);
		}
		if(!StringUtility.isNull(mailAddress)){
			applyreceiptrecord.setTfarrmailedaddress(mailAddress);
		}
		if(!StringUtility.isNull(mailTelephone)){
			applyreceiptrecord.setTfarrmailedtel(mailTelephone);
		}
		try {
			System.out.println(action+arrcode);
			if(!StringUtility.isNull(action)){
			    Applyreceiptrecord.modifyApplyreceiptrecord(applyreceiptrecord, rtcode, arscode, arrcode);
			}else{
				Applyreceiptrecord.saveApplyreceiptrecord(applyreceiptrecord, rtcode,arscode);
			}
			
		} catch (Exception e) {
			session.setAttribute("MESSAGEBEAN", new MessageBean(IBasicData.MSG_TYPE_ERROR,"提交出错",e.getMessage()));
			return ERROR;	 
		}
	 
			if(StringUtility.isNull(checkBox)&&!StringUtility.isNull(applyRemark)&&!StringUtility.isNull(mailAddress)&&!StringUtility.isNull(mailTelephone)){
				String scCode=(String) session.getAttribute("scCode");
				UpdateMailMessageTran upda=new UpdateMailMessageTran();
				upda.setParams(scCode, mailAddress, mailName, mailTelephone);
				upda.execute();
			}
			request.setAttribute("pageCount", "12");
			m_objPageConfig.setMaxPageResultCount(12);
			ApplyreceiptrecordCondition acd=new ApplyreceiptrecordCondition();
			acd.setOpid(opid);
			acd.setPageConfig(m_objPageConfig);
			List<ApplyreceiptrecordColumns> list=ApplyreceiptrecordDemand.query(acd);
			request.setAttribute("listApplyreceiptrecord", list);
		 
   
		return SUCCESS;	 
	}
	public String applyreceiptrecordQuery(){

		String opid=(String) session.getAttribute("OpId");
		String coCode=(String) session.getAttribute("Cocode");
		String strStartdate = request.getParameter("startdate");
		String strEnddate = request.getParameter("enddate");
		request.setAttribute("pageCount", "12");
		m_objPageConfig.setMaxPageResultCount(12);
		
		try {
			ApplyreceiptrecordCondition acd=new ApplyreceiptrecordCondition();
			if(!StringUtility.isNull(coCode)){
				acd.setCocode(coCode);
			}else{
				acd.setOpid(opid);
			}
			if(!StringUtility.isNull(strStartdate)){
				acd.setStartcreatedate(strStartdate);
			}
			if(!StringUtility.isNull(strEnddate)){
				acd.setEndcreatedate(strEnddate);
			}	 
			acd.setPageConfig(m_objPageConfig);
			List<ApplyreceiptrecordColumns> list=ApplyreceiptrecordDemand.query(acd);
			request.setAttribute("listApplyreceiptrecord", list);
		} catch (Exception e) {
			session.setAttribute("MESSAGEBEAN", new MessageBean(IBasicData.MSG_TYPE_ERROR,"查询出错",e.getMessage()));
			return ERROR;	 
		}
		return SUCCESS;
	}
	public void mailQuery() throws Exception{
		String scCode = request.getParameter("scCode"); 
		session.setAttribute("scCode", scCode);
		ShipperconsigneeColumns sc=ShipperconsigneeDemand.load(scCode);
		String name=sc.getScscname();
		String address=sc.getScscaddress1();
		String tel=sc.getScsctelephone();
		response.getWriter().print(address+"-"+tel+"-"+name);
	}
	public String applyModifyQuery() throws Exception{
		String arrcode = request.getParameter("arrcode"); 
		ApplyreceiptrecordQuery query=new ApplyreceiptrecordQuery();
		ApplyreceiptrecordCondition ac=new ApplyreceiptrecordCondition();
		ac.setArrcode(arrcode);
		query.setCondition(ac);
		ApplyreceiptrecordColumns columns=(ApplyreceiptrecordColumns) query.getResults().get(0);
		request.setAttribute("ApplyreceiptrecordColumns", columns);
		return SUCCESS;
	}
}
