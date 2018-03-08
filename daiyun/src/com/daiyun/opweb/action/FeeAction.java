package com.daiyun.opweb.action;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.dbaccess.query.PageConfig;
import kyle.common.util.jlang.CollectionUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.billing.calculate.feecalculate.bl.SaleTrialCalculate;
import kyle.leis.eo.billing.calculate.feecalculate.dax.SaleTrialCalculateParameter;
import kyle.leis.eo.billing.calculate.feecalculate.dax.SaleTrialCalculateResult;
import kyle.leis.eo.billing.receivable.da.ReceivableColumns;
import kyle.leis.eo.billing.receivable.dax.ReceivableDemand;
import kyle.leis.eo.operation.corewaybillpieces.da.CorewaybillpiecesColumns;
import kyle.leis.eo.operation.housewaybill.da.WaybillforbillColumns;
import kyle.leis.eo.operation.housewaybill.da.WaybillforbillCondition;
import kyle.leis.eo.operation.housewaybill.dax.HousewaybillDemand;
import kyle.leis.fs.dictionary.district.da.CountryColumns;
import kyle.leis.fs.dictionary.productkind.dax.ProductkindDemand;
import org.apache.struts2.ServletActionContext;
import com.daiyun.dax.CargoTypeDemand;
import com.daiyun.dax.CountryDemand;
import com.daiyun.dax.FeeDemand;
import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;
import com.daiyun.dax.Mycomparator;
import com.daiyun.dax.PaymentmodeDemand;
import com.daiyun.dax.QueryFeeResult;

public class FeeAction extends ActionSupportEX {
	/**
	 * 
	 */
	private static final long serialVersionUID = 395398555983479801L;
	private String cw_code;
	private String cw_customerewbcode;
	private String ctcode;
	private String pkcode;
	private String pmcode;
	private String startdate;
	private String enddate;

	private List<QueryFeeResult> listQueryFeeResult = new ArrayList<QueryFeeResult>();
	private QueryFeeResult objQueryFeeResult;

	@SuppressWarnings("unchecked")
	public String queryFee() throws Exception{
		WaybillforbillCondition objWBFBCondition = new WaybillforbillCondition();
		objWBFBCondition.setPageConfig(new PageConfig());
		if(!StringUtility.isNull(this.getCw_customerewbcode()))
			objWBFBCondition.setCw_customerewbcode(this.getCw_customerewbcode());
		if(!StringUtility.isNull(this.getCtcode()))
			objWBFBCondition.setCt_code(this.getCtcode());
		if(!StringUtility.isNull(this.getPkcode()))
			objWBFBCondition.setPk_code(this.getPkcode());
		if(!StringUtility.isNull(this.getPmcode()))
			objWBFBCondition.setPm_code(this.getPmcode());
		/*if(!StringUtility.isNull(this.getStartdate()))
			objWBFBCondition.setStartadddate(this.getStartdate());
		if(!StringUtility.isNull(this.getEnddate()))
			objWBFBCondition.setEndadddate(this.getEnddate());*/
		/*if(!StringUtility.isNull(this.getStartdate()))
			objWBFBCondition.setStartbwadddate(this.getStartdate());
		if(!StringUtility.isNull(this.getEnddate()))
			objWBFBCondition.setEndbwadddate(this.getEnddate());*/
		
		List<WaybillforbillColumns> objList = HousewaybillDemand.queryForBill(objWBFBCondition);
		if(CollectionUtility.isNull(objList)){
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", new MessageBean(IBasicData.MSG_TYPE_ERROR,"查询出错","没有查询到相关结果！"));
			return ERROR;
		}
		for(WaybillforbillColumns objWBFBColumns:objList){
			List<ReceivableColumns> listReceivableColumns = ReceivableDemand.load(objWBFBColumns.getCwcw_code());
			objQueryFeeResult = new QueryFeeResult();
			BigDecimal objFreight = new BigDecimal("0");
			BigDecimal objOilFee = new BigDecimal("0");
			BigDecimal objOtherFee = new BigDecimal("0"); 
			for(ReceivableColumns objReceivableColumns:listReceivableColumns){
				if("A0101".equals(objReceivableColumns.getFkfkcode()))
					objFreight = objFreight.add(new BigDecimal(objReceivableColumns.getRvrvactualtotal()));
				else if("A0102".equals(objReceivableColumns.getFkfkcode()))
					objOilFee = objOilFee.add(new BigDecimal(objReceivableColumns.getRvrvactualtotal()));
				else
					objOtherFee = objOtherFee.add(new BigDecimal(objReceivableColumns.getRvrvactualtotal()));
			}
			objQueryFeeResult.setCw_code(objWBFBColumns.getCwcw_code());
			objQueryFeeResult.setCw_customerewbcode(objWBFBColumns.getCwcw_customerewbcode());
			objQueryFeeResult.setFreight(objFreight.toString());
			objQueryFeeResult.setOilFee(objOilFee.toString());
			objQueryFeeResult.setOtherFee(objOtherFee.toString());
			objQueryFeeResult.setTotalFee(objWBFBColumns.getRvtotal());
			listQueryFeeResult.add(objQueryFeeResult);
		}
		ServletActionContext.getRequest().setAttribute("listQueryFeeResult", listQueryFeeResult);
		return SUCCESS;
	}
	/**
	 * 费用试算
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "static-access", "unchecked" })
	public String costBudget() throws Exception{
		//货物名称
		ProductkindDemand pkd=new ProductkindDemand();
		List objProductkind=pkd.queryProductkind2();
		ServletActionContext.getRequest().setAttribute("objProductkind", objProductkind);
		//货物类型
		CargoTypeDemand ctd=new CargoTypeDemand();
		List objCargoTypeDemand=ctd.queryAllCargotypes();
		ServletActionContext.getRequest().setAttribute("objCargoTypeDemand", objCargoTypeDemand);
		//付费类型
		PaymentmodeDemand pmd=new PaymentmodeDemand();
		List objPaymentmodeDemand=pmd.queryAllPaymentmodes();
		ServletActionContext.getRequest().setAttribute("objPaymentmodeDemand", objPaymentmodeDemand);
		//起运地
		String op=ServletActionContext.getRequest().getParameter("op");
		if(op.equals("bg")){
			String dthubcode=ServletActionContext.getRequest().getParameter("Dtdt_hubcode");
			CountryDemand cd=new CountryDemand();
			List<CountryColumns> listCountryColumns=cd.queryDtcodeByHubcode(dthubcode);
			String Dtdt_code="";
			if(listCountryColumns==null || listCountryColumns.size()==0){
				Dtdt_code="174";
			}else{
				Dtdt_code=listCountryColumns.get(0).getDtdt_code();
			}
			String Pkcode=ServletActionContext.getRequest().getParameter("Pkcode");//“”
			String Grossweight=ServletActionContext.getRequest().getParameter("Grossweight");
			String Ctctcode=ServletActionContext.getRequest().getParameter("Ctctcode");//AWPX
			int num=Integer.parseInt(ServletActionContext.getRequest().getParameter("num"));
			String Pmpmcode=ServletActionContext.getRequest().getParameter("Pmpmcode");//APP
			String Postcode=ServletActionContext.getRequest().getParameter("Postcode");
			String OrginDtcode=ServletActionContext.getRequest().getParameter("OrginDtcode");
						
			//产品的列表
			List listPieces=new ArrayList();			
			for(int i=1;i<num+1;i++){
				try{					
//					BigDecimal weight=new BigDecimal(ServletActionContext.getRequest().getParameter("weight"+i));
					BigDecimal weight=new BigDecimal(ServletActionContext.getRequest().getParameter("weight"+i));
					BigDecimal length=new BigDecimal(ServletActionContext.getRequest().getParameter("length"+i));
					BigDecimal width=new BigDecimal(ServletActionContext.getRequest().getParameter("width"+i));
					BigDecimal height=new BigDecimal(ServletActionContext.getRequest().getParameter("height"+i));
					
					CorewaybillpiecesColumns cc=new CorewaybillpiecesColumns();
					cc.setCpcpgrossweight(weight);
					cc.setCpcplength(length);
					cc.setCpcpwidth(width);
					cc.setCpcpheight(height);
					listPieces.add(cc);
					//request.setAttribute("lengthValue", length);
					//request.setAttribute("widthValue", width);
					//request.setAttribute("heightValue", height);
				}catch(NumberFormatException nfe){
					CorewaybillpiecesColumns cc=new CorewaybillpiecesColumns();
//					cc.setCpcpgrossweight(new BigDecimal("0"));
					cc.setCpcplength(new BigDecimal("0"));
					cc.setCpcpwidth(new BigDecimal("0"));
					cc.setCpcpheight(new BigDecimal("0"));
					listPieces.add(cc);
				}
				
			}
			//取到公司代码	
			String cocode=ServletActionContext.getRequest().getSession().getAttribute("Cocode").toString();
			SaleTrialCalculateParameter stcParameter=new SaleTrialCalculateParameter();
			stcParameter.setCocode(cocode);//设置公司代码
			stcParameter.setPkcode(Pkcode);//设置产品名称
			stcParameter.setCtcode(Ctctcode);//设置货物类型
			stcParameter.setPmcode(Pmpmcode);//设置付费类型
			stcParameter.setOrginDtcode(OrginDtcode);//起运地
			stcParameter.setDestDtcode(Dtdt_code);//目的国家
			stcParameter.setGrossweight(Grossweight);//重量
			stcParameter.setPiecesList(listPieces);//设置产品件数
			stcParameter.setPostcode(Postcode);//邮编
			SaleTrialCalculate sc=new SaleTrialCalculate();
			List<SaleTrialCalculateResult> saleList=sc.calculate(stcParameter);	
			//转至页面的各个默认值
			ServletActionContext.getRequest().setAttribute("dthubcode",dthubcode);
			ServletActionContext.getRequest().setAttribute("Pkcode",Pkcode);
			ServletActionContext.getRequest().setAttribute("Grossweight",Grossweight);
			ServletActionContext.getRequest().setAttribute("Ctctcode",Ctctcode);
			ServletActionContext.getRequest().setAttribute("num",num);
			ServletActionContext.getRequest().setAttribute("Pmpmcode",Pmpmcode);
			ServletActionContext.getRequest().setAttribute("Postcode",Postcode);
			ServletActionContext.getRequest().setAttribute("OrginDtcode",OrginDtcode);
			ServletActionContext.getRequest().setAttribute("listPieces",listPieces);
			session.setAttribute("listPieces", listPieces);
			ServletActionContext.getRequest().setAttribute("bud","bud");
			
			//根据总额进行排序
			Comparator comp = new Mycomparator();
			Collections.sort(saleList,comp);
			ServletActionContext.getRequest().setAttribute("objSaleTrialCalculateResult", saleList);
		}
		return SUCCESS;
	}
	
	/**
	 * 首页费用试算
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "static-access", "unchecked" })
	public String indexCostBudget() throws Exception{
		//货物名称
		ProductkindDemand pkd=new ProductkindDemand();
		List objProductkind=pkd.queryProductkind2();
		ServletActionContext.getRequest().setAttribute("objProductkind", objProductkind);
		//货物类型
		CargoTypeDemand ctd=new CargoTypeDemand();
		List objCargoTypeDemand=ctd.queryAllCargotypes();
		ServletActionContext.getRequest().setAttribute("objCargoTypeDemand", objCargoTypeDemand);
		//付费类型
		PaymentmodeDemand pmd=new PaymentmodeDemand();
		List objPaymentmodeDemand=pmd.queryAllPaymentmodes();
		ServletActionContext.getRequest().setAttribute("objPaymentmodeDemand", objPaymentmodeDemand);
		//起运地
		String op=ServletActionContext.getRequest().getParameter("op");
		if(op.equals("bg")){
			String dthubcode=ServletActionContext.getRequest().getParameter("Dtdt_hubcode");
			CountryDemand cd=new CountryDemand();
			List<CountryColumns> listCountryColumns=cd.queryDtcodeByHubcode(dthubcode);
			String Dtdt_code="";
			if(listCountryColumns==null || listCountryColumns.size()==0){
				Dtdt_code="174";
			}else{
				Dtdt_code=listCountryColumns.get(0).getDtdt_code();//147
			}
			String dtName = listCountryColumns.get(0).getDtdt_name();
			String Pkcode=ServletActionContext.getRequest().getParameter("Pkcode");//
			String Grossweight=ServletActionContext.getRequest().getParameter("Grossweight");
			String Ctctcode=ServletActionContext.getRequest().getParameter("Ctctcode");
			String Pmpmcode=ServletActionContext.getRequest().getParameter("Pmpmcode");
			String OrginDtcode=ServletActionContext.getRequest().getParameter("OrginDtcode");
			//产品的列表
			List listPieces=new ArrayList();	
			BigDecimal length = null;
			BigDecimal width = null;
			BigDecimal height = null;
				try{					
				     length=new BigDecimal(ServletActionContext.getRequest().getParameter("length"));
					 width=new BigDecimal(ServletActionContext.getRequest().getParameter("width"));
					 height=new BigDecimal(ServletActionContext.getRequest().getParameter("height"));
					CorewaybillpiecesColumns cc=new CorewaybillpiecesColumns();
					cc.setCpcplength(length);
					cc.setCpcpwidth(width);
					cc.setCpcpheight(height);
					listPieces.add(cc);
				}catch(NumberFormatException nfe){
					CorewaybillpiecesColumns cc=new CorewaybillpiecesColumns();
					cc.setCpcplength(new BigDecimal("0"));
					cc.setCpcpwidth(new BigDecimal("0"));
					cc.setCpcpheight(new BigDecimal("0"));
					listPieces.add(cc);
				}
			SaleTrialCalculateParameter stcParameter=new SaleTrialCalculateParameter();
			stcParameter.setCocode("2");//设置公司代码
			stcParameter.setPkcode(Pkcode);//设置产品名称
			stcParameter.setCtcode(Ctctcode);//设置货物类型
			stcParameter.setPmcode(Pmpmcode);//设置付费类型
			stcParameter.setOrginDtcode(OrginDtcode);//起运地
			stcParameter.setDestDtcode(Dtdt_code);//目的国家
			stcParameter.setGrossweight(Grossweight);//重量
			stcParameter.setPiecesList(listPieces);//设置产品件数
			SaleTrialCalculate sc=new SaleTrialCalculate();
			List<SaleTrialCalculateResult> saleList=sc.calculate(stcParameter);
			//设置产品介绍链接
			FeeDemand fd = new FeeDemand();
			for(int i=0;i<saleList.size();i++){
				SaleTrialCalculateResult stcr = saleList.get(i);
				String pkName = stcr.getPkname();
				String introductionlink = fd.findLinkByPkName(pkName);
				stcr.setIntroductionlink(introductionlink);
			}
			//转至页面的各个默认值
			ServletActionContext.getRequest().setAttribute("dthubcode",dthubcode);
			ServletActionContext.getRequest().setAttribute("dtName",dtName);
			ServletActionContext.getRequest().setAttribute("Pkcode",Pkcode);
			ServletActionContext.getRequest().setAttribute("Grossweight",Grossweight);
			ServletActionContext.getRequest().setAttribute("Ctctcode",Ctctcode);
			ServletActionContext.getRequest().setAttribute("Pmpmcode",Pmpmcode);
			ServletActionContext.getRequest().setAttribute("OrginDtcode",OrginDtcode);
			ServletActionContext.getRequest().setAttribute("listPieces",listPieces);
			ServletActionContext.getRequest().setAttribute("length",length);
			ServletActionContext.getRequest().setAttribute("height",height);
			ServletActionContext.getRequest().setAttribute("width",width);
			
			ServletActionContext.getRequest().setAttribute("bud","bud");
			//根据总额进行排序
			Comparator comp = new Mycomparator();
			Collections.sort(saleList,comp); 
			ServletActionContext.getRequest().setAttribute("objSaleTrialCalculateResult", saleList);
		}
		return SUCCESS;
	}
	
	public String getCw_code() {
		return cw_code;
	}

	public void setCw_code(String cw_code) {
		this.cw_code = cw_code;
	}

	public String getCw_customerewbcode() {
		return cw_customerewbcode;
	}

	public void setCw_customerewbcode(String cw_customerewbcode) {
		this.cw_customerewbcode = cw_customerewbcode;
	}

	public String getCtcode() {
		return ctcode;
	}

	public void setCtcode(String ctcode) {
		this.ctcode = ctcode;
	}

	public String getPkcode() {
		return pkcode;
	}

	public void setPkcode(String pkcode) {
		this.pkcode = pkcode;
	}

	public String getPmcode() {
		return pmcode;
	}

	public void setPmcode(String pmcode) {
		this.pmcode = pmcode;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	
	

}
