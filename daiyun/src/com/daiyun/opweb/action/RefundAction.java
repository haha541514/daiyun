package com.daiyun.opweb.action;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.finance.refund.bl.Refund;
import kyle.leis.eo.finance.refund.da.RefundColumns;
import kyle.leis.eo.finance.refund.da.RefundCondition;
import kyle.leis.eo.finance.refund.da.RefundQuery;
import kyle.leis.eo.finance.refund.dax.RefundDemand;
import org.apache.struts2.ServletActionContext;
import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;

public class RefundAction extends ActionSupportEX {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public String refund(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
 
		String coCode=(String)session.getAttribute("Cocode");
		String opid=(String) session.getAttribute("OpId");
		String action = request.getParameter("action"); 
		String rrcode = request.getParameter("rrcode"); 
		String bankName = request.getParameter("bankName"); 
		String bankAccount = request.getParameter("bankAccount"); 
		String applyReason = request.getParameter("applyReason"); 
		String applyRemark = request.getParameter("applyRemark"); 
		RefundColumns refundColumns=new RefundColumns();
		refundColumns.setCococode(coCode);
		refundColumns.setTfrrApplyreason(applyReason);
		
		if(!StringUtility.isNull(applyRemark)){
			refundColumns.setTfrrapplyremark(applyRemark);
		}
		refundColumns.setTfrrbankaccount(bankAccount);
		refundColumns.setTfrrbankname(bankName);
		refundColumns.setOpopid(Long.parseLong(opid));
		int ricode=Integer.valueOf(request.getParameter("refundType"));
		int rscode=Integer.valueOf(request.getParameter("rscode"));
		try {
			if(!StringUtility.isNull(action)){
				Refund.modifyRefund(refundColumns, ricode, rscode, rrcode);
			}else{
				Refund.saveRefund(refundColumns, ricode,rscode);
			}
		} catch (Exception e) {
			session.setAttribute("MESSAGEBEAN", new MessageBean(IBasicData.MSG_TYPE_ERROR,"提交出错",e.getMessage()));
			return ERROR;	 
		}
		try {
			request.setAttribute("pageCount", "12");
			RefundCondition rc=new RefundCondition();
			rc.setOpid(opid);
			m_objPageConfig.setMaxPageResultCount(12);
			List<RefundColumns> list=RefundDemand.query(rc);
			request.setAttribute("listRefund", list);
		} catch (Exception e) {
			session.setAttribute("MESSAGEBEAN", new MessageBean(IBasicData.MSG_TYPE_ERROR,"查询出错",e.getMessage()));
			return ERROR;	 
		}
		 
		
		return SUCCESS;	 
	}
	public String refundQuery(){
		String opid=(String) session.getAttribute("OpId");
		String coCode=(String) session.getAttribute("Cocode");
		String strStartdate = request.getParameter("startdate");
		String strEnddate = request.getParameter("enddate");
		try {	
			request.setAttribute("pageCount", "12");
			RefundCondition rc=new RefundCondition();
			if(!StringUtility.isNull(coCode)){
				rc.setCocode(coCode);
			}else{
				rc.setOpid(opid);
			}
			if(!StringUtility.isNull(strStartdate)){
				rc.setStartcreatedate(strStartdate);
			}
			if(!StringUtility.isNull(strEnddate)){
				rc.setEndcreatedate(strEnddate);
			}
			m_objPageConfig.setMaxPageResultCount(12);
			List<RefundColumns> list=RefundDemand.query(rc);
			request.setAttribute("listRefund", list);
		} catch (Exception e) {
			session.setAttribute("MESSAGEBEAN", new MessageBean(IBasicData.MSG_TYPE_ERROR,"查询出错",e.getMessage()));
			return ERROR;	 
		}
		return SUCCESS;
	}
	
	public String refundModifyQuery() throws Exception{
		String rrcode = request.getParameter("rrcode"); 
		RefundQuery query=new RefundQuery();
		RefundCondition ac=new RefundCondition();
		ac.setRrcode(rrcode);
		query.setCondition(ac);
		RefundColumns columns=(RefundColumns) query.getResults().get(0);
		request.setAttribute("RefundColumns", columns);
		return SUCCESS;
		
	}
}
