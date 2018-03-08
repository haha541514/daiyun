package com.daiyun.opweb.action;


import java.math.BigDecimal;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.finance.cashrecord.bl.CashRecord;
import kyle.leis.eo.finance.cashrecord.da.CashrecordColumns;

import org.apache.struts2.ServletActionContext;

import com.daiyun.opweb.wechat.Weixin_pay;
import com.opensymphony.xwork2.ActionSupport;

public class WeChatAction extends ActionSupport implements Runnable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	HttpServletRequest request = ServletActionContext.getRequest();
	static String rechargeAmount2="";
	static String opid="";
	static String Cocode="";
	static String out_trade_no="";
	public void wechat() {
	   
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpSession session = request.getSession();
		
		String rechargeAmount = request.getParameter("rechargeAmount"); 
		rechargeAmount2=rechargeAmount;
		opid=(String) session.getAttribute("OpId");
		Cocode=(String) session.getAttribute("Cocode");
	    out_trade_no=StringUtility.generateRandomString(15); // 订单号
	        
		Double amount=Double.valueOf(rechargeAmount)*100;
		Double dou=new Double(amount);
		int amount2=dou.intValue();
		String Amount=String.valueOf(amount2);

		Weixin_pay wx = new Weixin_pay();
		try {
			  wx.weixin_pay(Amount,session,request,response,out_trade_no);// 微信支付请求的地址

		} catch (Exception e) {

			e.printStackTrace();
		}
	}

	public void run() {
		    CashRecord cd=new CashRecord();
			CashrecordColumns objCashrecordColumns=new CashrecordColumns();
			Long id=Long.valueOf(opid);	 
			Date date=new Date();
		
			objCashrecordColumns.setCrcrtotal(new BigDecimal(rechargeAmount2));
			objCashrecordColumns.setCrkcrkcode("RA");
			objCashrecordColumns.setPtptcode("WX");
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
			objCashrecordColumns.setCrcrremark("微信网上付款");
			
			try {
				cd.save(objCashrecordColumns, opid);//修改金额
			} catch (Exception e) {
				 
				e.printStackTrace();
			}
		
	}

}
