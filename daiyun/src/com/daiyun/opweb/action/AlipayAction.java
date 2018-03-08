package com.daiyun.opweb.action;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.struts2.ServletActionContext;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.finance.cashrecord.bl.CashRecord;
import kyle.leis.eo.finance.cashrecord.da.CashrecordColumns;
import kyle.leis.eo.finance.cashrecord.da.CashrecordCondition;
import kyle.leis.eo.finance.cashrecord.da.CashrecordQuery;

public class AlipayAction  extends ActionSupportEX {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void alipay() throws Exception{
    	HttpServletRequest request = ServletActionContext.getRequest();
    	HttpSession session = request.getSession();
 
    	String rechargeAmount = request.getParameter("rechargeAmount"); 
    	String opid=(String) session.getAttribute("OpId");
    	String Cocode=(String) session.getAttribute("Cocode");
    	String out_trade_no=StringUtility.generateRandomString(16);
    	session.setAttribute("out_trade_no", out_trade_no);
    	CashRecord cd=new CashRecord();
    				CashrecordColumns objCashrecordColumns=new CashrecordColumns();	 
    				Long id=Long.valueOf(opid);	 	
    				Date date=new Date(); 
    				objCashrecordColumns.setCrcrtotal(new BigDecimal(rechargeAmount));
    				objCashrecordColumns.setCrkcrkcode("RA");
    				objCashrecordColumns.setPtptcode("APY");
    				objCashrecordColumns.setCkckcode("RMB");
    				objCashrecordColumns.setEeeecode("1");
    				objCashrecordColumns.setCopopid(id);
    				objCashrecordColumns.setCococode(Cocode);
    				objCashrecordColumns.setMopopid(id);
    				objCashrecordColumns.setCrscrscode("N"); 
    				objCashrecordColumns.setCrcrcurrencyrate(new BigDecimal("1.000"));
    				objCashrecordColumns.setCrcroccurdate(date);
    				objCashrecordColumns.setCrcrcreatedate(date);
    				objCashrecordColumns.setCrcrmodifydate(date);
    				objCashrecordColumns.setCrcrlabelcode(out_trade_no);
    				objCashrecordColumns.setCrcrremark("支付宝付款");
    				cd.save(objCashrecordColumns, opid);//修改金额
	  
    }
	@SuppressWarnings("unchecked")
	public static void modify(){
		HttpServletRequest request = ServletActionContext.getRequest();
    	 
		CashRecord cr=new CashRecord();
		String opid = request.getParameter("opid"); 
		String out_trade_no = request.getParameter("out_trade_no"); 
		CashrecordQuery cq=new CashrecordQuery();
		CashrecordCondition cd=new CashrecordCondition();	 
		cd.setCrlabelcode(out_trade_no);
		cd.setCrscode("N");	
		cq.setCondition(cd);	 
		try {
			List<CashrecordColumns> lis=cq.getResults(); 
			for(CashrecordColumns col:lis){	 
				String crid=col.getCrcrid();
				cr.modifyStatus(crid, "C", opid);	
				}
			} catch (Exception e1) {			 
				e1.printStackTrace();
			}	 
	}
}
