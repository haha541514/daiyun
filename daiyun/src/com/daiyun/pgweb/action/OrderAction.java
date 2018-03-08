package com.daiyun.pgweb.action;


import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;


import javax.servlet.http.HttpServletResponse;

import kyle.baiqian.fs.web.action.ActionSupportEX;

import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.StringUtility;

import kyle.leis.eo.billing.calculate.feecalculate.bl.SaleTrialCalculate;
import kyle.leis.eo.billing.calculate.feecalculate.dax.SaleTrialCalculateParameter;
import kyle.leis.eo.billing.calculate.feecalculate.dax.SaleTrialCalculateResult;
import kyle.leis.eo.operation.cargoinfo.da.CargoinfoColumns;
import kyle.leis.eo.operation.cargoinfo.da.CargoinfoCondition;
import kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand;

import kyle.leis.eo.operation.corewaybill.da.SimplecorewaybillColumns;
import kyle.leis.eo.operation.corewaybill.dax.CorewaybillDemand;
import kyle.leis.eo.operation.corewaybillpieces.da.CorewaybillpiecesColumns;
import kyle.leis.eo.operation.corewaybillpieces.dax.CorewaybillpiecesDemand;

import kyle.leis.eo.operation.housewaybill.bl.PredictOrderEX;
import kyle.leis.eo.operation.housewaybill.da.InputAllQReturn;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictColumns;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictCondition;
import kyle.leis.eo.operation.housewaybill.dax.HousewaybillDemand;
import kyle.leis.eo.operation.housewaybill.dax.PredictOrderColumnsEX;
import kyle.leis.eo.operation.predictwaybill.da.PredictcargoinfoColumns;
import kyle.leis.eo.operation.predictwaybill.da.PredictwaybillColumns;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeColumns;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeCondition;
import kyle.leis.es.company.shipperconsignee.dax.ShipperconsigneeDemand;
import kyle.leis.fs.dictionary.district.da.CountryColumns;
import kyle.leis.fs.dictionary.district.dax.DistrictDemand;

import net.sf.json.JSONArray;


import org.apache.struts2.ServletActionContext;


import com.daiyun.dax.CountryDemand;
import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;




public class OrderAction extends ActionSupportEX {

	private static final String REDIRECT_URI = "/order/addStoreUI";
	/*
	 * ���涩��
	 */
	public String saveOrder() throws Exception {

		String cw_code = request.getParameter("cw_code");
		String serverewbcode = request.getParameter("serverewbcode");
		String ewbcode = request.getParameter("ewbcode");
		PredictOrderColumnsEX objPredictOrderColumnsEX = new PredictOrderColumnsEX();
		String strCocode = (String) session.getAttribute("Cocode");
		if (StringUtility.isNull(strCocode)) {
			strCocode = "1";
		}
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
//		System.out.println(objWaybillforpredictColumns.getHwcgk_code());
//		System.out.println(objWaybillforpredictColumns.getHwpat_code());
//		System.out.println(objWaybillforpredictColumns.getHwhw_dcustomssign());
//		System.out.println(objWaybillforpredictColumns.getHwhw_shippercompany());
		List<CargoinfoColumns> listCargoInfo = new ArrayList<CargoinfoColumns>();
		List<CorewaybillpiecesColumns> listCorepieces = new ArrayList<CorewaybillpiecesColumns>();
 		objWaybillforpredictColumns.setCwdt_code_signin(objWaybillforpredictColumns.getDtdt_hubcode());
		// ������Ϣ����
		String[] ciciname = request.getParameterValues("ciciname");
		String[] cicipieces = request.getParameterValues("cicipieces");
		String[] ciciunitprice = request.getParameterValues("ciciunitprice");
		String[] ciciattacheinfo = request.getParameterValues("ciciattacheinfo");
		String[] ciciename= request.getParameterValues("ciciename");
		String ckCkcode=request.getParameter("ckckcode");
		//String ciciremark = request.getParameter("ciciremark");
		objCargoinfoColumns = new CargoinfoColumns[ciciname.length];
		for (int i = 0; i < ciciname.length; i++) {
			objCargoinfoColumns[i] = new CargoinfoColumns();
			if(StringUtility.isNull(ciciname[i])){
				break;
			}
			objCargoinfoColumns[i].setCiciname(ciciname[i].toUpperCase());
			objCargoinfoColumns[i].setCiciename(ciciename[i]);
			objCargoinfoColumns[i].setCicipieces(Integer.parseInt(cicipieces[i]));
			objCargoinfoColumns[i].setCiciunitprice(new BigDecimal(ciciunitprice[i]));
			objCargoinfoColumns[i].setCiciattacheinfo(ciciattacheinfo[i].toUpperCase());
			objCargoinfoColumns[i].setCkckcode(ckCkcode);
			listCargoInfo.add(objCargoinfoColumns[i]);
		}
		//������Ϣ����
		String[] cpCpgrossweight = request.getParameterValues("cpCpgrossweight");
		String[] cpCplength = request.getParameterValues("cpCplength");
		String[] cpCpwidth = request.getParameterValues("cpCpwidth");
		String[] cpCpheight = request.getParameterValues("cpCpheight");
		String[] cpciename= request.getParameterValues("ciciename");
		objlistPieces = new CorewaybillpiecesColumns[cpCpgrossweight.length];
		for(int i=0;i<cpCpgrossweight.length;i++){
			objlistPieces[i] = new CorewaybillpiecesColumns();
			try {
				objlistPieces[i].setCpcpgrossweight(new BigDecimal(
						cpCpgrossweight[i]));
				objlistPieces[i].setCpcpheight(new BigDecimal(cpCpheight[i]));
				objlistPieces[i].setCpcplength(new BigDecimal(cpCplength[i]));
				objlistPieces[i].setCpcpwidth(new BigDecimal(cpCpwidth[i]));
			} catch (NumberFormatException e) {
				objlistPieces[i].setCpcpgrossweight(new BigDecimal("0"));
				objlistPieces[i].setCpcpheight(new BigDecimal("0"));
				objlistPieces[i].setCpcplength(new BigDecimal("0"));
				objlistPieces[i].setCpcpwidth(new BigDecimal("0"));
			}
			listCorepieces.add(objlistPieces[i]);
		}
		objPredictOrderColumnsEX.setListCargoInfo(listCargoInfo);
		objPredictOrderColumnsEX.setListCorewaybillpieces(listCorepieces);
		objWaybillforpredictColumns.setCwscws_code("CTS");
		objWaybillforpredictColumns.setCwcw_chargeweight(objWaybillforpredictColumns
				.getCwcw_customerchargeweight());
		objWaybillforpredictColumns.setPwpwb_createdate(DateFormatUtility.getStandardSysdate());
		if (!StringUtility.isNull(cw_code)) {
			objWaybillforpredictColumns.setCwcw_code(cw_code);
		}
		if (!StringUtility.isNull(serverewbcode)) {
			objWaybillforpredictColumns.setCwcw_serverewbcode(serverewbcode);
		}
		if (!StringUtility.isNull(ewbcode)) {
			objWaybillforpredictColumns.setCwcw_ewbcode(ewbcode);
		}

		//���˿ո�
		objWaybillforpredictColumns.setCwcw_customerewbcode(objWaybillforpredictColumns.getCwcw_customerewbcode().trim().toUpperCase());		
		objPredictOrderColumnsEX.setWaybillforpredict(objWaybillforpredictColumns);
		// �����˴���
		String shipperInfoLabelcode = request.getParameter("shipperInfoLabelcode");
		//�����˹��Ҵ���ת��
		String dtcode=DistrictDemand.getDtcodeByHubcode(objWaybillforpredictColumns.getCwdt_code_origin());
		//objWaybillforpredictColumns.setCwdt_code_origin(dtcode);
		
		String dtcodeshipper = DistrictDemand.getDtcodeByHubcode(objWaybillforpredictColumns.getHwdt_code_shipper());
		objWaybillforpredictColumns.setHwdt_code_shipper(dtcodeshipper);
		InputAllQReturn objIAR = new PredictOrderEX().save(strCocode,
				objPredictOrderColumnsEX, OpId, shipperInfoLabelcode);
		if (objIAR == null) {
			return ERROR;
		}
		if (objIAR.getPromptUtilityCollection() != null
				&& objIAR.getPromptUtilityCollection().canGo(false)) {
			return SUCCESS;
		}
		if (objIAR.getPromptUtilityCollection() != null
				&& !objIAR.getPromptUtilityCollection().canGo(false)) {
			MessageBean objMessageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, 
					"����ʧ��",  
					objIAR.getPromptUtilityCollection().toString());
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessageBean);
			return ERROR;
		}
		// }
		return SUCCESS;
	}	
	/*
	 * ������ajax�ж�
	 */
	public void orderIdAJAX() throws Exception {
		PrintWriter out = response.getWriter();
		String strCustomercode = request.getParameter("customercode");
		String ajaxCustomercode = request.getParameter("ajaxCustomercode");
		String strCocode = (String) session.getAttribute("Cocode");
		// ����ͻ��˵���δ�޸�
		// δ���붩����
		if (StringUtility.isNull(strCustomercode)) {
			out.print("NO");
			return;
		}
		if (strCustomercode.equals(ajaxCustomercode)) {
			out.print("NO");
			return;
		}
		SimplecorewaybillColumns objSCWC = CorewaybillDemand.loadSimpleCorewaybill(strCustomercode, 
				strCocode);
		if (objSCWC == null) {
			out.print("NO");
			return;
		}
		if (!objSCWC.getCwcws_code().equals("CEL") &&!objSCWC.getCwcws_code().equals("EL")) {
			out.print("YES");
			return;
		}
		out.print("NO");
	}
	//��ȡ�������б�
	public String getShipperInfo() {
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			
			String strCocode = (String)ServletActionContext.getRequest().getSession().getAttribute("Cocode");
			if(StringUtility.isNull(strCocode))
				strCocode="1";
			ShipperconsigneeCondition objSCCondition = new ShipperconsigneeCondition();
			objSCCondition.setCmcocode(strCocode);
			objSCCondition.setScshipperconsigneetype("S");
			objSCCondition.setUseCacheSign(true);
			
			List<ShipperconsigneeColumns> listResults = ShipperconsigneeDemand.query(objSCCondition);			
			JSONArray JsonArray = JSONArray.fromObject(listResults);
			String jsonData = JsonArray.toString();
			out.print(jsonData);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//��ȡ�������б�
	public String getConsigneeInfo() {
		try {
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			
			String strCocode = (String)ServletActionContext.getRequest().getSession().getAttribute("Cocode");
			if(StringUtility.isNull(strCocode))
				strCocode="1";
			ShipperconsigneeCondition objSCCondition = new ShipperconsigneeCondition();
			objSCCondition.setCmcocode(strCocode);
			objSCCondition.setScshipperconsigneetype("C");
			objSCCondition.setUseCacheSign(true);
			
			List<ShipperconsigneeColumns> listResults = ShipperconsigneeDemand.query(objSCCondition);			
			JSONArray JsonArray = JSONArray.fromObject(listResults);
			String jsonData = JsonArray.toString();
			out.print(jsonData);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	

	/*
	 * �鿴��������
	 */
	public String queryOrdersDetail() throws Exception {
		String link = request.getParameter("link");
		request.setAttribute("link", link);
		String cw_code = request.getParameter("cw_code");
		if(cw_code.equals("0")){
			cw_code=(String)request.getAttribute("cw_code");
		}
		if (StringUtility.isNull(cw_code)) {
			if (!("".equals(request.getParameterValues("checkbox")) || request
					.getParameterValues("checkbox") == null)) {
				String[] strCwCode = request.getParameterValues("checkbox");
				for (int i = 0; i < strCwCode.length; i++) {
					cw_code = strCwCode[i];
				}
			}
		}
		WaybillforpredictCondition objWaybillforpredictCondition = new WaybillforpredictCondition();
		objWaybillforpredictCondition.setCwcode(cw_code);
		WaybillforpredictColumns obj_WaybillforpredictColumns = (WaybillforpredictColumns) HousewaybillDemand
				.queryForPredict(objWaybillforpredictCondition).get(0);
		obj_WaybillforpredictColumns.setCwdt_code_origin(DistrictDemand.getDthubcodeByDtcode(obj_WaybillforpredictColumns.getCwdt_code_origin()));
		request.setAttribute("objWaybillforpredictColumns",obj_WaybillforpredictColumns);
		obj_WaybillforpredictColumns.setHwdt_code_shipper(DistrictDemand.getDthubcodeByDtcode(obj_WaybillforpredictColumns.getHwdt_code_shipper()));
		request.setAttribute("objWaybillforpredictColumns",obj_WaybillforpredictColumns);
		List<CargoinfoColumns> listCargoinfoColumns = CargoInfoDemand.queryByCwCode(cw_code);
		List<CorewaybillpiecesColumns> listcwpieces = CorewaybillpiecesDemand.load(cw_code);
		CargoinfoColumns columns=new CargoinfoColumns();
		request.setAttribute("listCargoinfoColumns", listCargoinfoColumns);
		request.setAttribute("listcwpieces", listcwpieces);
		CargoinfoCondition objCondition=new CargoinfoCondition();
		objCondition.setCwcode(cw_code);
	/*	CargoinfoQuery query=new CargoinfoQuery();
		query.setCondition(objCondition);
	String price=columns.getCiciunitprice();
	String pieces=columns.getCicipieces();
		int i=Integer.parseInt(price);
		int j=Integer.parseInt(pieces);
		int m=i*j;
		String money=String.valueOf(m);
		System.out.println(money);
		request.setAttribute("money",money);
		*/
		return SUCCESS;
	}
	
	//�˷Ѽ���
	public String costBudgetAjax() throws Exception{
		//������Ϣ����
		 HttpServletResponse response =ServletActionContext.getResponse();
		 PrintWriter pw=response.getWriter();
		List<CorewaybillpiecesColumns> listCorepieces = new ArrayList<CorewaybillpiecesColumns>();
		String[] cpCpgrossweight = request.getParameterValues("cpCpgrossweight");
		String[] cpCplength = request.getParameterValues("cpCplength");
		String[] cpCpwidth = request.getParameterValues("cpCpwidth");
		String[] cpCpheight = request.getParameterValues("cpCpheight");
		String[] cpciename= request.getParameterValues("ciciename");
		String ctcode=request.getParameter("ctcode");
		if(!StringUtility.isNull(String.valueOf(cpCpgrossweight.length))){
		objlistPieces = new CorewaybillpiecesColumns[cpCpgrossweight.length];
		}
		for(int i=0;i<cpCpgrossweight.length;i++){
			objlistPieces[i] = new CorewaybillpiecesColumns();
			try {
				objlistPieces[i].setCpcpgrossweight(new BigDecimal(
						cpCpgrossweight[i]));
				objlistPieces[i].setCpcpheight(new BigDecimal(cpCpheight[i]));
				objlistPieces[i].setCpcplength(new BigDecimal(cpCplength[i]));
				objlistPieces[i].setCpcpwidth(new BigDecimal(cpCpwidth[i]));
			} catch (NumberFormatException e) {
				objlistPieces[i].setCpcpgrossweight(new BigDecimal("0"));
				objlistPieces[i].setCpcpheight(new BigDecimal("0"));
				objlistPieces[i].setCpcplength(new BigDecimal("0"));
				objlistPieces[i].setCpcpwidth(new BigDecimal("0"));
			}
			listCorepieces.add(objlistPieces[i]);
		}
		String dthubcode=objWaybillforpredictColumns.getDtdt_hubcode();
		CountryDemand cd=new CountryDemand();
		List<CountryColumns> listCountryColumns=cd.queryDtcodeByHubcode(dthubcode);
		String Dtdt_code="";
		if(listCountryColumns==null || listCountryColumns.size()==0){
			Dtdt_code="174";
		}else{
			Dtdt_code=listCountryColumns.get(0).getDtdt_code();
		}
		String cocode=ServletActionContext.getRequest().getSession().getAttribute("Cocode").toString();
		SaleTrialCalculateParameter stcParameter=new SaleTrialCalculateParameter();
		stcParameter.setCocode(cocode);//���ù�˾����
		stcParameter.setPkcode(objWaybillforpredictColumns.getPkpk_code());//���ò�Ʒ����
		stcParameter.setCtcode(ctcode);//���û�������
		stcParameter.setPmcode("APP");//���ø�������
		stcParameter.setOrginDtcode(objWaybillforpredictColumns.getCwdt_code_origin());//���˵�
		stcParameter.setDestDtcode(Dtdt_code);//Ŀ�Ĺ���
		stcParameter.setGrossweight(objWaybillforpredictColumns.getCwcw_customerchargeweight());//����
		stcParameter.setPiecesList(listCorepieces);//���ò�Ʒ����
		stcParameter.setPostcode("");//�ʱ�
		SaleTrialCalculate sc=new SaleTrialCalculate();
		List<SaleTrialCalculateResult> saleList=sc.calculate(stcParameter);	
		System.out.println("�˷Ѽ۸������:"+saleList.size());
		String result="";
		if(saleList.size()>0){
		 result =saleList.get(0).getFreightvalue()+saleList.get(0).getIncidentalvalue()+saleList.get(0).getSurchargevalue();
		}
		System.out.println(result);
		if(!StringUtility.isNull(result)){
			pw.write(result);
		    pw.close();
		}
		else{
			pw.write("xxx");
		    pw.close();
		}
	
		return null;
		
	}
	
	
	private WaybillforpredictColumns objWaybillforpredictColumns;
	private CargoinfoColumns[] objCargoinfoColumns;
	private PredictwaybillColumns objPredictwaybillColumns;
	private CorewaybillpiecesColumns[] objlistPieces;

	private String authUrl;

		private List<PredictcargoinfoColumns> objPredictcargoinfoColumns;
	
	public List<PredictcargoinfoColumns> getObjPredictcargoinfoColumns() {
		return objPredictcargoinfoColumns;
	}

	public void setObjPredictcargoinfoColumns(
			List<PredictcargoinfoColumns> objPredictcargoinfoColumns) {
		this.objPredictcargoinfoColumns = objPredictcargoinfoColumns;
	}

	public String getAuthUrl() {
		return authUrl;
	}

	public void setAuthUrl(String authUrl) {
		this.authUrl = authUrl;
	}

	public PredictwaybillColumns getObjPredictwaybillColumns() {
		return objPredictwaybillColumns;
	}

	public void setObjPredictwaybillColumns(
			PredictwaybillColumns objPredictwaybillColumns) {
		this.objPredictwaybillColumns = objPredictwaybillColumns;
	}

	public CargoinfoColumns[] getObjCargoinfoColumns() {
		return objCargoinfoColumns;
	}

	public void setObjCargoinfoColumns(CargoinfoColumns[] objCargoinfoColumns) {
		this.objCargoinfoColumns = objCargoinfoColumns;
	}
    
	public WaybillforpredictColumns getObjWaybillforpredictColumns() {
		return objWaybillforpredictColumns;
	}

	public void setObjWaybillforpredictColumns(
			WaybillforpredictColumns objWaybillforpredictColumns) {
		this.objWaybillforpredictColumns = objWaybillforpredictColumns;
	}



}
