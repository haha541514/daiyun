package com.daiyun.pgweb.action;

import java.math.BigDecimal;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.ServletActionContext;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.externalsv.recharge.IAfterRecharge;
import kyle.common.externalsv.recharge.IKuaiAfterRecharge;
import kyle.common.externalsv.recharge.IKuaiRecharge;
import kyle.common.externalsv.recharge.IRecharge;
import kyle.common.externalsv.recharge.KuaiRechargeParam;
import kyle.common.externalsv.recharge.RechargeParam;
import kyle.common.externalsv.recharge.RechargeReturn;
import kyle.common.externalsv.recharge.impl.AlipayRecharge;
import kyle.common.externalsv.recharge.impl.AlipayRechargeReturn;
import kyle.common.externalsv.recharge.impl.KuaiAlipayRecharge;
import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.common.util.prompt.PromptUtilityCollection;
import kyle.leis.eo.finance.cashrecord.bl.AlipayAfterRecharge;
import kyle.leis.eo.finance.cashrecord.bl.KuaiAlipayAfterRecharge;
import kyle.leis.eo.finance.cashrecord.da.CashrecordCondition;
import kyle.leis.eo.finance.cashrecord.dax.CashRecordDemand;
import kyle.leis.fs.dictionary.dictionarys.da.TdiOperatorDC;
import kyle.leis.hi.TdiOperator;

import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;

public class RechargeAction extends ActionSupportEX {

	/**
	 * 充值于充值记录查询
	 */
	private static final long serialVersionUID = 1L;
	private String m_strRechargeAmount = "0";
	private String m_strStartdate;
	private String m_strEnddate;
	private List m_listCashRecords;
	private RechargeReturn m_objRechargeReturn;
	
	/**
	 * 充值
	 * @return
	 */
	public String recharge() {
		MessageBean objMessageBean = null;
	    String strRechargeMode = request.getParameter("rechargemode");
		try {
			if (StringUtility.isNull(m_strRechargeAmount)) {
				objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "充值金额错误",  "充值金额不能为空");
				ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
				return ERROR;
			}
			if (new BigDecimal(m_strRechargeAmount).compareTo(new BigDecimal("0")) < 0) {
				objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "充值金额错误",  "充值金额只能为数字");
				ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
				return ERROR;
			}
			RechargeParam objRechargeParam = new RechargeParam();
			IRecharge objRecharge = null;
			IAfterRecharge objAfterRecharge = null;
			if (strRechargeMode.equals("APY")) {
				objRecharge = new AlipayRecharge();
				objAfterRecharge = new AlipayAfterRecharge();
				objRechargeParam.setBusinessNumber((String)ServletActionContext.getRequest().getSession().getAttribute("Cocode") + 
						DateFormatUtility.getCompactNocommaSysdate());
				objRechargeParam.setTitle(DateFormatUtility.getCompactNocommaSysdate() + "ALIPAY");
				objRechargeParam.setRemark(DateFormatUtility.getCompactNocommaSysdate() + "ALIPAY");
				// objRechargeParam.setConfigResourceName(ServletActionContext.getServletContext().getRealPath(ALIPAYCONFIG_FILE));
				objRechargeParam.setConfigResourceName("AlipayConfig");
			}
			KuaiRechargeParam objKuaiRechargeParam=new KuaiRechargeParam();
			IKuaiRecharge objKuaiRecharge=null;
			IKuaiAfterRecharge objKuaiAfterRecharge=null;
			if(strRechargeMode.equals("KQ")){
				objKuaiRecharge = new KuaiAlipayRecharge();
				objKuaiAfterRecharge = new KuaiAlipayAfterRecharge();
				objKuaiRechargeParam.setMerchant_id((String)ServletActionContext.getRequest().getSession().getAttribute("Cocode") + 
						DateFormatUtility.getCompactNocommaSysdate());
			//	objKuaiRechargeParam.setTitle(DateFormatUtility.getCompactNocommaSysdate() + "ALIPAY");
				objKuaiRechargeParam.setMerchant_param(DateFormatUtility.getCompactNocommaSysdate() + "ALIPAY");
				// objRechargeParam.setConfigResourceName(ServletActionContext.getServletContext().getRealPath(ALIPAYCONFIG_FILE));
				objKuaiRechargeParam.setstrConfigResourcename("AlipayConfig");	
			}

			if (objRecharge == null&&objKuaiRecharge==null) { 
				objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "充值错误",  "初始化充值Service失败");
				ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
				return ERROR;
			}
			String strOperId = (String)ServletActionContext.getRequest().getSession().getAttribute("OpId");
			TdiOperator objTdiOperator = TdiOperatorDC.loadByKey(strOperId);
			PromptUtilityCollection objPU =null;
			if (strRechargeMode.equals("APY")) {
				objRechargeParam.setOperId(strOperId);
				objRechargeParam.setCocode((String)ServletActionContext.getRequest().getSession().getAttribute("Cocode"));
				objRechargeParam.setSellerEmail(objTdiOperator.getOpMsnname());
				// objRechargeParam.setOperId("1064");
				// objRechargeParam.setCocode("2162");
				objRechargeParam.setRechargeAmount(new BigDecimal(m_strRechargeAmount));
				objRecharge.setParam(objRechargeParam);
				
				 objPU = objRecharge.recharge(objAfterRecharge, ServletActionContext.getResponse());

			}else if (strRechargeMode.equals("KQ")) {
				objKuaiRechargeParam.setstrOperId(strOperId);
				objKuaiRechargeParam.setstrCocode((String)ServletActionContext.getRequest().getSession().getAttribute("Cocode"));
				objKuaiRechargeParam.setPemail(objTdiOperator.getOpMsnname());
				// objRechargeParam.setOperId("1064");
				// objRechargeParam.setCocode("2162");
				objKuaiRechargeParam.setAmount(new BigDecimal(m_strRechargeAmount));
				objKuaiRecharge.setParam(objKuaiRechargeParam);
				 objPU = objKuaiRecharge.recharge(objKuaiAfterRecharge, ServletActionContext.getResponse());
			}
			
			if (objPU != null && !objPU.canGo(false)) { 
				objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "充值错误",  "保存充值记录失败" + objPU.getCollection().get(0).getDescribtion());
				ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
				return ERROR;
			}
			ServletActionContext.getRequest().setAttribute("rechargehtml", objPU.getCollection().get(0).getDescribtion());
			return SUCCESS;
		} catch (Exception ex) {
			objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "充值错误",  "保存充值记录失败" + ex.getMessage());
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
			return ERROR;
		}
	}
	
	/**
	 * 处理支付宝充值返回结果
	 * @return
	 */
	public String parseArlipayRechargeReturn() {
		MessageBean objMessageBean = null;
		try {
			//获取支付宝GET过来反馈信息
			HttpServletRequest request = ServletActionContext.getRequest();
			AlipayRechargeReturn objARReturn = new AlipayRechargeReturn("AlipayConfig");
			m_objRechargeReturn = objARReturn.parseRechargeReturn(request);
			// m_objRechargeReturn.setIsSuccess(true);
			if (m_objRechargeReturn != null && m_objRechargeReturn.getIsSuccess()) {
				// 保存收款记录
				IAfterRecharge objAfterRecharge = new AlipayAfterRecharge();
				RechargeParam objRechargeParam = new RechargeParam();
				objRechargeParam.setOperId((String)ServletActionContext.getRequest().getSession().getAttribute("OpId"));
				objRechargeParam.setCocode((String)ServletActionContext.getRequest().getSession().getAttribute("Cocode"));
				// objRechargeParam.setOperId("102600");
				// objRechargeParam.setCocode("15302");
				objRechargeParam.setBusinessNumber(m_objRechargeReturn.getTransactionNumber());
				objRechargeParam.setRechargeAmount(m_objRechargeReturn.getRechargeAmount());
				objRechargeParam.setTitle(m_objRechargeReturn.getTitle());
				objRechargeParam.setRemark(m_objRechargeReturn.getRemark() + "；订单号为：" + m_objRechargeReturn.getBusinessNumber());
				objAfterRecharge.saveRechargeRecord(objRechargeParam);
			}
			return SUCCESS;
		} catch (Exception ex) {
			objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "充值错误",  "解析充值记录失败" + ex.getMessage());
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
			return ERROR;
		}
	}
	
	
	public String queryrecharge() {
		try {
			CashrecordCondition objCrCondition = new CashrecordCondition();
			objCrCondition.setCocode((String)ServletActionContext.getRequest().getSession().getAttribute("Cocode"));
			objCrCondition.setStartoccurdate(m_strStartdate);
			objCrCondition.setEndoccurdate(m_strEnddate);
			// objCrCondition.setCocode("2162");
			objCrCondition.setPtcode("APY");
			m_listCashRecords = CashRecordDemand.query(objCrCondition);
			return SUCCESS;
		} catch (Exception ex) {
			ex.printStackTrace();
			MessageBean objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "查询错误",  "查询错误" + ex.getMessage());
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
			return ERROR;			
		}
	}
	
	public String getRechargeAmount() {
		return m_strRechargeAmount;
	}

	public void setRechargeAmount(String strRechargeAmount) {
		m_strRechargeAmount = strRechargeAmount;
	}	
	
	
	public void setStartdate(String strStartdate) {
		m_strStartdate = strStartdate;
	}	
	
	public String getStartdate() {
		return m_strStartdate;
	}	
	
	public void setEnddate(String strEnddate) {
		m_strEnddate = strEnddate;
	}	
	
	public String getEnddate() {
		return m_strEnddate;
	}		
	
	public List getCashReocords() {
		return m_listCashRecords;
	}
	
	public RechargeReturn getRechargeReturn() {
		return m_objRechargeReturn;
	}
}
