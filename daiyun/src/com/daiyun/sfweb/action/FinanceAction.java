package com.daiyun.sfweb.action;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.struts2.ServletActionContext;
import com.daiyun.util.pdf.ITextFontUtil;
import com.daiyun.util.pdf.PdfBean;
import com.daiyun.util.pdf.PdfUtil;
import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;
import com.lowagie.text.BadElementException;
import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Table;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.CollectionUtility;
import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.DateUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.billing.receivable.da.ReceivableforbillColumns;
import kyle.leis.eo.billing.receivable.da.ReceivableforbillCondition;
import kyle.leis.eo.billing.receivable.dax.ReceivableDemand;
import kyle.leis.eo.finance.billrecord.da.BillrecordColumns;
import kyle.leis.eo.finance.billrecord.da.BillrecordCondition;
import kyle.leis.eo.finance.billrecord.dax.BillRecordDemand;
import kyle.leis.eo.finance.cashrecord.da.CashrecordColumns;
import kyle.leis.eo.finance.cashrecord.da.CashrecordCondition;
import kyle.leis.eo.finance.cashrecord.dax.CashRecordDemand;
import kyle.leis.eo.finance.dunning.da.FinancestatisticsColumns;
import kyle.leis.eo.finance.dunning.da.FinancestatisticsCondition;
import kyle.leis.eo.finance.dunning.da.FinancestatisticsQuery;
import kyle.leis.eo.finance.dunning.dax.DunningDemand;
import kyle.leis.eo.finance.dunning.dax.FinanceReportResults;
import kyle.leis.eo.operation.corewaybill.dax.CorewaybillDemand;
import kyle.leis.fs.dictionary.district.dax.DistrictDemand;

public class FinanceAction extends ActionSupportEX {

	private static final long serialVersionUID = 1L;
	// �����ļ���
	String fileName;
	/**
	 * �˵���ѯ���(�����ʲ�ѯ)
	 */
	public String queryFinanceReport() throws Exception {
		
		List<FinanceReportResults> listFRResults = new ArrayList<FinanceReportResults>();
		// ���ò�ѯ����
		FinancestatisticsCondition objFSCondition = new FinancestatisticsCondition();
		// ��ҳ����
		session.getAttribute("Opname");
		int pageCount = 10;
		request.setAttribute("pageCount", pageCount);
		// ���÷�ҳ
		m_objPageConfig.setMaxPageResultCount(pageCount);
		objFSCondition.setPageConfig(m_objPageConfig);
		
		String strCocode = (String) session.getAttribute("Cocode");
		if (StringUtility.isNull(strCocode)){
			
			return SUCCESS;
		}
		//strCocode = "0";
		String strStartdate = request.getParameter("startdate");
		String strEnddate = request.getParameter("enddate");
		if(strStartdate == null && strEnddate == null){//����ʱ��
			strEnddate = DateFormatUtility.getStandardSysdate();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -3);
			long date = cal.getTimeInMillis();
			
			sf.setLenient(false);//�ϸ����
			strStartdate = sf.format(new Date(date));
			
		}
	
		objFSCondition.setCocode(strCocode);
		if (!StringUtility.isNull(strCocode)
				&& !StringUtility.isNull(strStartdate)
				&& !StringUtility.isNull(strEnddate)) {
			
			List resultList =  DunningDemand.query(objFSCondition);
			if(resultList.size()>0){
				FinancestatisticsColumns objFinancestatisticsColumns = (FinancestatisticsColumns)resultList.get(0);
				listFRResults = DunningDemand.queryFinanceReport(strCocode,
						strStartdate, strEnddate, "C", "");
				// ����ҳ�淵�صĿ�ʼʱ��
				request.setAttribute("startdate", strStartdate);
				request.setAttribute("enddate", strEnddate);
				// ���湫˾���
	            BigDecimal objfsfsbalance = new BigDecimal(objFinancestatisticsColumns.getFsfsbalanceamount()).setScale(3);
				request.setAttribute("companyBalance", objfsfsbalance);
				if (listFRResults.size() == 0 && listFRResults == null) {
					// ����listFRResults�е�����
					request.setAttribute("listFRResults", 0);
				} else {
					// ����listFRResults�е�����
					
					List<FinanceReportResults> listBytime = new ArrayList<FinanceReportResults>();
					for(int index = listFRResults.size()-1 ;index >=0  ; index--){
						listBytime.add(listFRResults.get(index));
					}
					//��ȡ�˻�Ѻ�𣬹�˰Ѻ��

					CashrecordCondition objCrCondition = new CashrecordCondition();
					objCrCondition.setCocode(strCocode);
					objCrCondition.setStartoccurdate(strStartdate);
					objCrCondition.setEndoccurdate(strEnddate);
					objCrCondition.setPtcode("AD");
					List<CashrecordColumns> accountBalance = (List<CashrecordColumns>)CashRecordDemand.query(objCrCondition);
					objCrCondition.setPtcode("TD");
					List<CashrecordColumns> tariffBalance = (List<CashrecordColumns>)CashRecordDemand.query(objCrCondition);
			
					String[] astrADCrId = new String[accountBalance.size()];
					String[] astrTDCrId = new String[tariffBalance.size()];
					for(int index = 0 ; index < astrADCrId.length ; index ++){
						astrADCrId[index] = ((CashrecordColumns)accountBalance.get(index)).getCrcrid();
					}
					for(int index = 0 ; index < astrADCrId.length ; index ++){
						astrTDCrId[index] = ((CashrecordColumns)tariffBalance.get(index)).getCrcrid();
					}
					request.setAttribute("accountBalance",  CashRecordDemand.sumCashTotal(astrADCrId).getSumCrTotal());
					request.setAttribute("tariffBalance",  CashRecordDemand.sumCashTotal(astrTDCrId).getSumCrTotal());
				
					request.setAttribute("listFRResults", listBytime);
					request.setAttribute("ReceivaBlance",queryReceivaMount(strCocode,strStartdate,strEnddate)); //��ù�˾Ӧ�ս��
				}
			}
			
		}
		return SUCCESS;
	}

	/**
	 * ��ѯӦ�ս��
	 * һ����˾�ж�����¼��
	 * @throws Exception 
	 * */
	public String queryReceivaMount(String cocode,String startdate,String endate) throws Exception{
		BigDecimal fsreceivablemout = new BigDecimal("0").setScale(3);
		FinancestatisticsQuery query = new FinancestatisticsQuery();
		FinancestatisticsCondition condition = new FinancestatisticsCondition();
		condition.setCocode(cocode);
		condition.setFscarryoverenterprise("ALL");
		condition.setStartdate(startdate);
		condition.setEnddate(endate);
		query.setCondition(condition);
	
		List<FinancestatisticsColumns> resultlist = (List<FinancestatisticsColumns>)query.getResults();
		if(!CollectionUtility.isNull(resultlist)){
			for(FinancestatisticsColumns columns:resultlist){//������Ӧ�ս��
				fsreceivablemout = fsreceivablemout.add(new BigDecimal(columns.getFsfsreceivableamount()));
			}
			return fsreceivablemout.toString();
		}else{
			return null;
		}		
		
		
	}
	
	/**
	 * �˵���ѯ�������� 2016-12-07,by wukq
	 * */
	public String queryBillRecord() throws Exception {

		String strStartdate = request.getParameter("startdate");
		String strEnddate = request.getParameter("enddate");
		if(strStartdate == null && strEnddate == null){
			strEnddate = DateFormatUtility.getStandardSysdate();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -3);
			long date = cal.getTimeInMillis();
			sf.setLenient(false);
			strStartdate = sf.format(new Date(date));
		}
		
		
		String linkValue = "BillRecord";
		request.setAttribute("linkValue", linkValue);
		String strCocode = (String) session.getAttribute("Cocode");
		if (StringUtility.isNull(strCocode)){
			//strCocode = "2";
			return SUCCESS;
		}
		// ��ҳ����
		int pageCount = 10;
		request.setAttribute("pageCount", pageCount);// ���ط�ҳʱ�������
		List<BillrecordColumns> listBillrecordResults = new ArrayList<BillrecordColumns>();
		BillrecordCondition objBRCondition = new BillrecordCondition();

		objBRCondition.setCocode(strCocode);
		objBRCondition.setStartoccurdate(strStartdate);
		objBRCondition.setEndoccurdate(strEnddate);
		// ���÷�ҳ
		m_objPageConfig.setMaxPageResultCount(pageCount);
		objBRCondition.setPageConfig(m_objPageConfig);
		// �������ϵ��˵�
		objBRCondition.setNotinbrscode("E");
		if(strStartdate != null && strEnddate != null){
		listBillrecordResults = (List<BillrecordColumns>) BillRecordDemand
				.query(objBRCondition);
		System.err.println("�ǲ�����ģ���" + listBillrecordResults == null);
		System.out.println("�ж�list������������" + listBillrecordResults.size());
		if (listBillrecordResults == null && listBillrecordResults.size() == 0) {
			request.setAttribute("listBillrecord", 0);
			request.setAttribute("startdate", strStartdate);
			request.setAttribute("enddate", strEnddate);
		} else {
			for (int index = 0; index < listBillrecordResults.size(); index++) {
				BigDecimal strBrbrtotal = new BigDecimal(listBillrecordResults
						.get(index).getBrbrtotal()).divide(new BigDecimal("1"),
						3, 4);
				listBillrecordResults.get(index).setBrbrtotal(strBrbrtotal);
			}

			request.setAttribute("listBillrecord", listBillrecordResults);
			request.setAttribute("startdate", strStartdate);
			request.setAttribute("enddate", strEnddate);
		

		}
	}
		
		return SUCCESS;

	}
	/**
	 * �˵���ϸ
	 * */
	public String queryBillRecordForDetial() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String strBrid = request.getParameter("brBrid");
		// String strCurrentPageNo = request.getParameter("pageFlag");
		HashMap<String, List<ReceivableforbillColumns>> RFBColumnsMap = new HashMap<String, List<ReceivableforbillColumns>>();
		BillrecordColumns objBRColumns = null;
		List<ReceivableforbillColumns> listRFBColumns = null;
		ReceivableforbillCondition objRFBCondition = new ReceivableforbillCondition();
		if (!StringUtility.isNull(strBrid)) {
			try {
				objBRColumns = BillRecordDemand.load(strBrid);
				objRFBCondition.setBrid(strBrid);
				objRFBCondition.setBkcode("A0101");
				listRFBColumns = ReceivableDemand.queryForBill(objRFBCondition);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (objBRColumns == null || listRFBColumns == null
				|| listRFBColumns.size() < 1) {
			ServletActionContext.getRequest().getSession().setAttribute(
					"MESSAGEBEAN",
					new MessageBean(IBasicData.MSG_TYPE_ERROR, "��ѯ����",
							"��Ǹ��û�в�ѯ����ؽ����"));
			return ERROR;
		}
		//Brbrtotal�˵����תΪ��λ
		objBRColumns.setBrbrtotal( new BigDecimal(objBRColumns.getBrbrtotal()).setScale(3));
		
		
		for (int i = 0; i < listRFBColumns.size(); i++) {
			if (RFBColumnsMap.containsKey(listRFBColumns.get(i)
					.getCwcwcustomerewbcode())) {
				List<ReceivableforbillColumns> listContains = (List<ReceivableforbillColumns>) RFBColumnsMap
						.get(listRFBColumns.get(i).getCwcwcustomerewbcode());
				listContains.add(listRFBColumns.get(i));
				// RFBColumnsMap.remove(listRFBColumns.get(i).
				// getCwcwcustomerewbcode());0707
				RFBColumnsMap.put(listRFBColumns.get(i)
						.getCwcwcustomerewbcode(), listContains);
			} else {
				List<ReceivableforbillColumns> listNotContains = new ArrayList<ReceivableforbillColumns>();
				listNotContains.add(listRFBColumns.get(i));
				RFBColumnsMap.put(listRFBColumns.get(i)
						.getCwcwcustomerewbcode(), listNotContains);
			}
		}
		// request.setAttribute("objPageConfig", objPageConfig);
		request.setAttribute("objBRColumns", objBRColumns);
		request.setAttribute("RFBColumnsMap", RFBColumnsMap);
		return SUCCESS;
	}

	/***
	 * ��ѯ���(δ������ϸ��ѯ)
	 */
	@SuppressWarnings("unchecked")

	public String queryNotAccountDetailReport() throws Exception {
		BigDecimal sumWeight = new BigDecimal("0.000");
		BigDecimal sumMoney = new BigDecimal("0.000");
		String op=request.getParameter("op");//?
		String strCocode = (String) session.getAttribute("Cocode");
	
		String linkValue = "queryNotAccountDetail";
		request.setAttribute("linkValue", linkValue);
		
		if (StringUtility.isNull(strCocode)){
			//strCocode = "2";
			return SUCCESS;
		}	
		String dateType = request.getParameter("dateType");//��������
		String strStartdate = request.getParameter("startdate");
		String strEnddate = request.getParameter("enddate");
		String strAbwcode=request.getParameter("strAbwcode");
		System.out.println(strAbwcode);
		if(op==null){
			op="";
		}
		//�õ���ǰʱ����������ǰ��ʱ��
		if(dateType != null){
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar cal=Calendar.getInstance();
			cal.add(Calendar.MONTH, -2);  
			long date = cal.getTimeInMillis();
			format.setLenient(false);
			strStartdate=format.format(new Date(date));
			strEnddate=DateFormatUtility.getStandardSysdate();			
		}
		
		HashMap<String, List<ReceivableforbillColumns>> RFBColumnsMap = new HashMap<String, List<ReceivableforbillColumns>>();
		// BillrecordColumns objBRColumns = null;
		List<ReceivableforbillColumns> listRFBColumns = null;
		ReceivableforbillCondition objRFBCondition = new ReceivableforbillCondition();
		objRFBCondition.setCcocode(strCocode);
		objRFBCondition.setBkcode("A0101");
		if(dateType!=null){
			if(dateType.equals("signindate")){
				objRFBCondition.setStarthwsignindate(strStartdate);
				objRFBCondition.setEndhwsignindate(strEnddate);
			}else if(dateType.equals("occurdate")){
				objRFBCondition.setStartrvoccurdate(strStartdate);
				objRFBCondition.setEndrvoccurdate(strEnddate);
			}
			request.setAttribute("dateType", dateType);
		}
		
		objRFBCondition.setAbwlabelcode(strAbwcode);
		
		// ����������δ���ˣ�
		objRFBCondition.setFscode("C");
		listRFBColumns = ReceivableDemand.queryForBill(objRFBCondition);
		request.setAttribute("startdate", strStartdate);
		request.setAttribute("enddate", strEnddate);
		List<ReceivableforbillColumns> listRFBColumns1 = new ArrayList<ReceivableforbillColumns>();
		for (int i = 0; i < listRFBColumns.size(); i++) {
			if (RFBColumnsMap.containsKey(listRFBColumns.get(i)
					.getCwcwcustomerewbcode())) {
				List<ReceivableforbillColumns> listContains = (List<ReceivableforbillColumns>) RFBColumnsMap
						.get(listRFBColumns.get(i).getCwcwcustomerewbcode());
				listContains.add(listRFBColumns.get(i));
				RFBColumnsMap.put(listRFBColumns.get(i)
						.getCwcwcustomerewbcode(), listContains);
			} else {
				List<ReceivableforbillColumns> listNotContains = new ArrayList<ReceivableforbillColumns>();
				listNotContains.add(listRFBColumns.get(i));
				RFBColumnsMap.put(listRFBColumns.get(i)
						.getCwcwcustomerewbcode(), listNotContains);
			}
		}
		for (Map.Entry<String, List<ReceivableforbillColumns>> entry : RFBColumnsMap.entrySet()) {
			List<ReceivableforbillColumns> listReceivableforbillColumns = new ArrayList<ReceivableforbillColumns>();
			if (!RFBColumnsMap.isEmpty() && RFBColumnsMap.size() > 0) {
				BigDecimal freightValue = new BigDecimal("0");
				BigDecimal oilFee = new BigDecimal("0");
				String strFkname = "";
				String objOtherFee2 = "";
				BigDecimal objOtherFee = new BigDecimal("0");
				listReceivableforbillColumns = entry.getValue();
				ReceivableforbillColumns objRFBColumns;
				objRFBColumns = listReceivableforbillColumns.get(0);
				if (StringUtility.isNull(objRFBColumns.getCddtdtname())) {
					objRFBColumns.setCddtdtname(DistrictDemand
							.getDtnameByDtcode(objRFBColumns.getSdtdtcode()));
				}
				for (ReceivableforbillColumns objLRFBColumns : listReceivableforbillColumns) {
					if (objLRFBColumns.getFkfkcode().equals("A0101")) {
						freightValue = freightValue.add(new BigDecimal(
								objLRFBColumns.getRvrvactualtotal()));
					} else if (objLRFBColumns.getFkfkcode().equals("A0102")) {
						oilFee = oilFee.add(new BigDecimal(objLRFBColumns
								.getRvrvactualtotal()));
					} else {
						strFkname += objLRFBColumns.getFkfkname()+",";
						objOtherFee = objOtherFee.add(new BigDecimal(
								objLRFBColumns.getRvrvactualtotal()));
						objOtherFee2 += objLRFBColumns.getRvrvactualtotal()+",";
					}
				}
				/*20160926,Start by wukq*/
				if(!StringUtility.isNull(objOtherFee2)&&objOtherFee2.endsWith(",")){
					objOtherFee2=objOtherFee2.substring(0,objOtherFee2.length()-1);
					String[] objOther = objOtherFee2.split(",");
					//int intdou = objOtherFee2.indexOf(",");//-1����û��
					if(objOtherFee2.indexOf(",") != -1){
						//�������������
						objOtherFee2 = "";
						for(int index = 0; index <objOther.length ; index++){
							BigDecimal objbig = new BigDecimal(objOther[index]).divide(new BigDecimal("1"),3,4);
							
							objOtherFee2 += objbig.toString()+",";
						}
					}else{
						BigDecimal objbig = new BigDecimal(objOtherFee2).divide(new BigDecimal("1"),3,4);//0.5,0.81,�������ת��
						objOtherFee2 = objbig.toString();
					}
					
				}
				
				/*End*/
				
				if(!StringUtility.isNull(strFkname)&&strFkname.endsWith(",")){
					strFkname=strFkname.substring(0,strFkname.length()-1);
				}
				if(!StringUtility.isNull(objOtherFee2)&&objOtherFee2.endsWith(",")){
					objOtherFee2=objOtherFee2.substring(0,objOtherFee2.length()-1);
				}
				BigDecimal objTotal = new BigDecimal("0");
				objTotal = objTotal.add(freightValue);
				objTotal = objTotal.add(oilFee);
				objTotal = objTotal.add(objOtherFee);
				objTotal = objTotal.setScale(3);//������λС����Ĭ����������
				sumMoney = sumMoney.add(objTotal);
				
				ReceivableforbillColumns objFirstRFBColumns = listReceivableforbillColumns.get(0);
				//ʵ��
				objFirstRFBColumns.setCwcwgrossweight(new BigDecimal(objFirstRFBColumns.getCwcwgrossweight()).divide(new BigDecimal("1"),3,4));
				//�Ʒ���
				objFirstRFBColumns.setCwcwchargeweight(new BigDecimal(objFirstRFBColumns.getCwcwchargeweight()).divide(new BigDecimal("1"),3,4));
				//
				//�����		listRFBColumns
				BigDecimal strObjVolumeweight = new BigDecimal(CorewaybillDemand.getVolumeweight(objFirstRFBColumns.getCwcwcode())).divide(new BigDecimal("1"),3,4);
				//String objVolumeweight=CorewaybillDemand.getVolumeweight(objFirstRFBColumns.getCwcwcode());
				request.setAttribute("objVolumeweight", strObjVolumeweight.toString());
				
				BigDecimal addWeight = new BigDecimal(objFirstRFBColumns.getCwcwchargeweight()).divide(new BigDecimal("1"),3,4);
				sumWeight = sumWeight.add(addWeight);
				
				
				objFirstRFBColumns.getCwcwcustomerewbcode();
				// �˴����Ӱ�ǧ�˵��� Cwcwewbcode
				objFirstRFBColumns.getCwcwewbcode();
				String strPkshowSEWBCode = objFirstRFBColumns.getPkpkshowserverewbcode();
				if (StringUtility.isNull(strPkshowSEWBCode))
					strPkshowSEWBCode = "Y";
				if (strPkshowSEWBCode.equals("N"))
					objFirstRFBColumns.getCwcwewbcode();
				else
					objFirstRFBColumns.getCwcwserverewbcode();
				objFirstRFBColumns.getPkpkname();
				objFirstRFBColumns.getCtctname();
				objFirstRFBColumns.getCwcwpieces();
				// �˷�
				objFirstRFBColumns.setRvrvunitnumber(freightValue.divide(new BigDecimal("1"), 3, 4));
				// ȼ�ͷ�
				objFirstRFBColumns.setRvrvunitprice(oilFee.divide(new BigDecimal("1"), 3, 4));
				// ��λ�Һϼ�
				objFirstRFBColumns.setRvrvactualtotal(objTotal);
				 
				// �ӷ���Ŀ
				objFirstRFBColumns.setPmpmname(strFkname);
				// �ӷѽ��
				objFirstRFBColumns.setRvrvtotal(new BigDecimal(!String.valueOf(
						objOtherFee).equals("0") ? String.valueOf(objOtherFee
						.divide(new BigDecimal("1"), 3, 4)) : "0"));
				objFirstRFBColumns.setPmpmcode(objOtherFee2);
				listRFBColumns1.add(objFirstRFBColumns);
			}
		}
		
			request.setAttribute("listRFBColumns", listRFBColumns1);
			request.setAttribute("strAbwcode", strAbwcode);
			request.setAttribute("totalWeight", sumWeight);
			request.setAttribute("totalMoney", sumMoney);
	
	
		return SUCCESS;
	}
	

	/**
	 * �ʵ�����queryBillRecord.jspҳ��(����excel)
	 */
	@SuppressWarnings( { "unchecked", "deprecation" })
	public void downloadBillRecordForExcel() throws Exception {
		String strBrid = request.getParameter("brBridcode");
		HashMap<String, List<ReceivableforbillColumns>> RFBColumnsMap = new HashMap<String, List<ReceivableforbillColumns>>();
		BillrecordColumns objBRColumns = null;
		List<ReceivableforbillColumns> listRFBColumns = null;
		ReceivableforbillCondition objRFBCondition = new ReceivableforbillCondition();
		if (!StringUtility.isNull(strBrid)) {
			objBRColumns = BillRecordDemand.load(strBrid);
			objRFBCondition.setBrid(strBrid);
			objRFBCondition.setBkcode("A0101");
			listRFBColumns = ReceivableDemand.queryForBill(objRFBCondition);
		}
		for (int i = 0; i < listRFBColumns.size(); i++) {
			if (RFBColumnsMap.containsKey(listRFBColumns.get(i)
					.getCwcwcustomerewbcode())) {
				List<ReceivableforbillColumns> listContains = (List<ReceivableforbillColumns>) RFBColumnsMap
						.get(listRFBColumns.get(i).getCwcwcustomerewbcode());
				listContains.add(listRFBColumns.get(i));
				RFBColumnsMap.put(listRFBColumns.get(i)
						.getCwcwcustomerewbcode(), listContains);
			} else {
				List<ReceivableforbillColumns> listNotContains = new ArrayList<ReceivableforbillColumns>();
				listNotContains.add(listRFBColumns.get(i));
				RFBColumnsMap.put(listRFBColumns.get(i)
						.getCwcwcustomerewbcode(), listNotContains);
			}
		}
		try {
			String xlsName = objBRColumns.getCococode() + strBrid
					+ "_billDetail.xls";
			session.setAttribute("getExcelPathName", xlsName);
			System.out.println("getExcelPathName=" + xlsName);
			String outputFile = request.getRealPath("/download/" + xlsName);
			// ����һ��excel������
			HSSFWorkbook workbook = new HSSFWorkbook();
			// excel�������½�һ�¹�����
			HSSFSheet sheet = workbook.createSheet("Sheet1");
			// �����п��
			sheet.setColumnWidth(0, 4500);
			sheet.setColumnWidth(1, 4500);
			sheet.setColumnWidth(2, 8000);
			sheet.setColumnWidth(3, 5000);
			sheet.setColumnWidth(4, 4500);
			sheet.setColumnWidth(5, 3000);
			sheet.setColumnWidth(6, 3000);
			sheet.setColumnWidth(7, 3000);
			sheet.setColumnWidth(8, 3000);
			sheet.setColumnWidth(9, 3000);
			sheet.setColumnWidth(10, 3000);
			sheet.setColumnWidth(11, 8000);
			sheet.setColumnWidth(12, 3000);
			sheet.setColumnWidth(13, 8000);
			sheet.setColumnWidth(14, 3000);
			sheet.setColumnWidth(15, 3000);
			sheet.setColumnWidth(16, 8000);
			// ��������
			HSSFFont font = workbook.createFont();
			font.setFontName("Verdana");
			font.setBoldweight((short) 100);
			font.setFontHeight((short) 300);
			font.setColor(HSSFColor.BLUE.index);
			// ���õ�Ԫ���ʽ
			HSSFCellStyle cellStyle = workbook.createCellStyle();
			cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
			// ���ñ߿�
			cellStyle.setBottomBorderColor(HSSFColor.RED.index);
			cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
			cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
			// ��������
			cellStyle.setFont(font);
			cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			cellStyle.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);
			cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

			// ������0λ�ô�����(��һ��)
			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell1 = row.createCell((short) 0);
			HSSFCell cell2 = row.createCell((short) 1);
			HSSFCell cell3 = row.createCell((short) 2);
			HSSFCell cell17 = row.createCell((short) 3);
			HSSFCell cell4 = row.createCell((short) 4);
			HSSFCell cell5 = row.createCell((short) 5);
			HSSFCell cell6 = row.createCell((short) 6);
			HSSFCell cell7 = row.createCell((short) 7);
			HSSFCell cell8 = row.createCell((short) 8);
			HSSFCell cell9 = row.createCell((short) 9);
			HSSFCell cell10 = row.createCell((short) 10);
			HSSFCell cell11 = row.createCell((short) 11);
			HSSFCell cell12 = row.createCell((short) 12);
			HSSFCell cell13 = row.createCell((short) 13);
			HSSFCell cell14 = row.createCell((short) 14);
			HSSFCell cell15 = row.createCell((short) 15);
			HSSFCell cell16 = row.createCell((short) 16);
			

			cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell3.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell17.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell4.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell5.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell6.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell7.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell8.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell9.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell10.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell11.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell12.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell13.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell14.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell15.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell16.setCellType(HSSFCell.CELL_TYPE_STRING);
			

			cell1.setCellType(HSSFCell.ENCODING_UTF_16);
			cell2.setCellType(HSSFCell.ENCODING_UTF_16);
			cell3.setCellType(HSSFCell.ENCODING_UTF_16);
			cell17.setCellType(HSSFCell.ENCODING_UTF_16);
			cell4.setCellType(HSSFCell.ENCODING_UTF_16);
			cell5.setCellType(HSSFCell.ENCODING_UTF_16);
			cell6.setCellType(HSSFCell.ENCODING_UTF_16);
			cell7.setCellType(HSSFCell.ENCODING_UTF_16);
			cell8.setCellType(HSSFCell.ENCODING_UTF_16);
			cell9.setCellType(HSSFCell.ENCODING_UTF_16);
			cell10.setCellType(HSSFCell.ENCODING_UTF_16);
			cell11.setCellType(HSSFCell.ENCODING_UTF_16);
			cell12.setCellType(HSSFCell.ENCODING_UTF_16);
			cell13.setCellType(HSSFCell.ENCODING_UTF_16);
			cell14.setCellType(HSSFCell.ENCODING_UTF_16);
			cell15.setCellType(HSSFCell.ENCODING_UTF_16);
			cell16.setCellType(HSSFCell.ENCODING_UTF_16);
			
			
			cell1.setCellValue("�˵���");
			cell2.setCellValue("��ǧ�˵���");
			cell3.setCellValue("ת����");
			cell17.setCellValue("����ʱ��");
			cell4.setCellValue("��Ʒ");
			cell5.setCellValue("��������");
			cell6.setCellValue("����");
			cell7.setCellValue("ʵ��(KG)");
			cell8.setCellValue("�Ļ���(KG)");
			cell9.setCellValue("�Ʒ�����(KG)");
			cell10.setCellValue("Ŀ�ĵ�");
			cell11.setCellValue("Ӧ�շ���(�˷�)");
			cell12.setCellValue("ȼ�ͷ�");
			cell13.setCellValue("�ӷ�����Ŀ(�ӷ�)");
			cell14.setCellValue("���");
			cell15.setCellValue("��λ�Һϼ�");
			cell16.setCellValue("��ע");

			//Iterator iter = listRFBColumns.iterator();
			int temp = 0;
			BigDecimal bwbTotal = new BigDecimal("0");
			for (Map.Entry<String, List<ReceivableforbillColumns>> entry : RFBColumnsMap
					.entrySet()) {
				++temp;
				row = sheet.createRow((short) temp);
				HSSFCell cell111 = row.createCell((short) 0);
				HSSFCell cell112 = row.createCell((short) 1);
				HSSFCell cell122 = row.createCell((short) 2);
				HSSFCell cell1117 = row.createCell((short) 3);
				HSSFCell cell133 = row.createCell((short) 4);
				HSSFCell cell144 = row.createCell((short) 5);
				HSSFCell cell155 = row.createCell((short) 6);
				HSSFCell cell161 = row.createCell((short) 7);
				HSSFCell cell171 = row.createCell((short) 8);
				HSSFCell cell18 = row.createCell((short) 9);
				HSSFCell cell19 = row.createCell((short) 10);
				HSSFCell cell110 = row.createCell((short) 11);
				HSSFCell cell1111 = row.createCell((short) 12);
				HSSFCell cell1112 = row.createCell((short) 13);
				HSSFCell cell1113 = row.createCell((short) 14);
				HSSFCell cell1114 = row.createCell((short) 15);
				HSSFCell cell1115 = row.createCell((short) 16);
				

				List<ReceivableforbillColumns> listReceivableforbillColumns = new ArrayList<ReceivableforbillColumns>();
				if (!RFBColumnsMap.isEmpty() && RFBColumnsMap.size() > 0) {
					BigDecimal freightValue = new BigDecimal("0");
					BigDecimal oilFee = new BigDecimal("0");
					String strFkname = "";
					BigDecimal objOtherFee = new BigDecimal("0");

					listReceivableforbillColumns = entry.getValue();
					ReceivableforbillColumns objRFBColumns;
					objRFBColumns = listReceivableforbillColumns.get(0);
					if (StringUtility.isNull(objRFBColumns.getCddtdtname())) {
						objRFBColumns
								.setCddtdtname(DistrictDemand
										.getDtnameByDtcode(objRFBColumns
												.getSdtdtcode()));
					}

					for (ReceivableforbillColumns objLRFBColumns : listReceivableforbillColumns) {
						if (objLRFBColumns.getFkfkcode().equals("A0101")) {
							freightValue = freightValue.add(new BigDecimal(
									objLRFBColumns.getRvrvactualtotal()));
						} else if (objLRFBColumns.getFkfkcode().equals("A0102")) {
							oilFee = oilFee.add(new BigDecimal(objLRFBColumns
									.getRvrvactualtotal()));
						} else {
							strFkname = objLRFBColumns.getFkfkname();
							objOtherFee = objOtherFee.add(new BigDecimal(
									objLRFBColumns.getRvrvactualtotal()));
						}
					}
					BigDecimal objTotal = new BigDecimal("0").divide(new BigDecimal("1"),3,4);
					objTotal = objTotal.add(freightValue);
					objTotal = objTotal.add(oilFee);
					objTotal = objTotal.add(objOtherFee);
					bwbTotal = bwbTotal.add(objTotal);
					
					
					ReceivableforbillColumns objFirstRFBColumns = listReceivableforbillColumns
							.get(0);
					// objFirstRFBColumns = (ReceivableforbillColumns)
					// iter.next();
					cell111.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell111.setCellType(HSSFCell.ENCODING_UTF_16);
					cell111.setCellValue(objFirstRFBColumns
							.getCwcwcustomerewbcode());
					// �˴����Ӱ�ǧ�˵��� Cwcwewbcode
					cell112.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell112.setCellType(HSSFCell.ENCODING_UTF_16);
					cell112.setCellValue(objFirstRFBColumns.getCwcwewbcode());

					cell122.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell122.setCellType(HSSFCell.ENCODING_UTF_16);

					String strPkshowSEWBCode = objFirstRFBColumns
							.getPkpkshowserverewbcode();
					if (StringUtility.isNull(strPkshowSEWBCode))
						strPkshowSEWBCode = "Y";
					if (strPkshowSEWBCode.equals("N"))
						cell122.setCellValue(objFirstRFBColumns
								.getCwcwewbcode());
					else
						cell122.setCellValue(objFirstRFBColumns
								.getCwcwserverewbcode());

					cell133.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell133.setCellType(HSSFCell.ENCODING_UTF_16);
					cell133.setCellValue(objFirstRFBColumns.getPkpkname());
					

					cell1117.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell1117.setCellType(HSSFCell.ENCODING_UTF_16);
					cell1117.setCellValue(objFirstRFBColumns.getRvrvoccurdate());
					
					cell144.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell144.setCellType(HSSFCell.ENCODING_UTF_16);
					cell144.setCellValue(objFirstRFBColumns.getCtctname());
					cell155.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell155.setCellType(HSSFCell.ENCODING_UTF_16);
					cell155.setCellValue(objFirstRFBColumns.getCwcwpieces());
					cell161.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell161.setCellType(HSSFCell.ENCODING_UTF_16);
					cell161.setCellValue(new BigDecimal(objRFBColumns
							.getCwcwgrossweight()).divide(new BigDecimal("1"),
							3, 4).toString());
					cell171.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell171.setCellType(HSSFCell.ENCODING_UTF_16);
					cell171.setCellValue(new BigDecimal(CorewaybillDemand
							.getVolumeweight(objRFBColumns.getCwcwcode())).divide(new BigDecimal("1"),
									3, 4).toString());
					cell18.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell18.setCellType(HSSFCell.ENCODING_UTF_16);
					cell18.setCellValue(new BigDecimal(objRFBColumns
							.getCwcwchargeweight()).divide(new BigDecimal("1"),
							3, 4).toString());
					cell19.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell19.setCellType(HSSFCell.ENCODING_UTF_16);
					cell19.setCellValue(objRFBColumns.getCddtdtname());
					cell110.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell110.setCellType(HSSFCell.ENCODING_UTF_16);
					cell110.setCellValue(freightValue.divide(
							new BigDecimal("1"), 3, 4).toString());
					cell1111.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell1111.setCellType(HSSFCell.ENCODING_UTF_16);
					cell1111.setCellValue(oilFee.divide(new BigDecimal("1"), 3,
							4).toString());//ȼ�ͷ�
					cell1112.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell1112.setCellType(HSSFCell.ENCODING_UTF_16);
					cell1112.setCellValue(strFkname);//�ڷ���Ŀ
					cell1113.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell1113.setCellType(HSSFCell.ENCODING_UTF_16);
					cell1113.setCellValue(!String.valueOf(objOtherFee).equals(
							"0") ? String.valueOf(objOtherFee.divide(
							new BigDecimal("1"), 3, 4)) : "");//���
					cell1114.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell1114.setCellType(HSSFCell.ENCODING_UTF_16);
				
					System.out.println("objTotal:"+objTotal.toString());
					cell1114.setCellValue(objTotal.toString());//����Ϊ�ϼƸ�Ϊ3λ��ЧС��.
//					cell1114.setCellValue(!String.valueOf(objTotal).equals(
//							"0") ? String.valueOf(objOtherFee.divide(
//							new BigDecimal("1"), 3, 4)) : "");
//					
					cell1115.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell1115.setCellType(HSSFCell.ENCODING_UTF_16);
					cell1115
							.setCellValue(objRFBColumns.getRvrvremark() != null ? objRFBColumns
									.getRvrvremark()
									: "");
				}
			}
			row = sheet.createRow(++temp);
			HSSFCell bwbTotalCell = row.createCell(15);
			bwbTotalCell.setCellType(HSSFCell.CELL_TYPE_STRING);
			bwbTotalCell.setCellType(HSSFCell.ENCODING_UTF_16);
			bwbTotalCell.setCellValue(bwbTotal.toString());
			File path = new File(outputFile);
			path.delete();
			FileOutputStream fout = new FileOutputStream(outputFile);
			workbook.write(fout);
			fout.flush();
			fout.close();
			response.getWriter().print(xlsName);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	
	
	/**
	 * �ʵ�����(����pdf)
	 */
	@SuppressWarnings("unchecked")
	public String downloadBillRecord() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String strBrid = request.getParameter("brBrid");
		BillrecordColumns objBRColumns = new BillrecordColumns();
		List<ReceivableforbillColumns> listRFBColumns = new ArrayList<ReceivableforbillColumns>();
		HashMap<String, List<ReceivableforbillColumns>> ForExprotRFBColumnsMap = new HashMap<String, List<ReceivableforbillColumns>>();
		if (!StringUtility.isNull(strBrid)) {
			ReceivableforbillCondition objRFBCondition = new ReceivableforbillCondition();
			objRFBCondition.setBrid(strBrid);
			objRFBCondition.setBkcode("A0101");
			try {
				objBRColumns = BillRecordDemand.load(strBrid);
				listRFBColumns = ReceivableDemand.queryForBill(objRFBCondition);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (objBRColumns == null || listRFBColumns == null
				|| listRFBColumns.size() < 1) {
			ServletActionContext.getRequest().getSession().setAttribute(
					"MESSAGEBEAN",
					new MessageBean(IBasicData.MSG_TYPE_ERROR, "��ѯ����",
							"��Ǹ��û�в�ѯ����ؽ����"));
			return ERROR;
		}

		for (int i = 0; i < listRFBColumns.size(); i++) {
			if (ForExprotRFBColumnsMap.containsKey(listRFBColumns.get(i)
					.getCwcwcustomerewbcode())) {
				List<ReceivableforbillColumns> listContains = (List<ReceivableforbillColumns>) ForExprotRFBColumnsMap
						.get(listRFBColumns.get(i).getCwcwcustomerewbcode());
				listContains.add(listRFBColumns.get(i));
				ForExprotRFBColumnsMap.put(listRFBColumns.get(i)
						.getCwcwcustomerewbcode(), listContains);
			} else {
				List<ReceivableforbillColumns> listNotContains = new ArrayList<ReceivableforbillColumns>();
				listNotContains.add(listRFBColumns.get(i));
				ForExprotRFBColumnsMap.put(listRFBColumns.get(i)
						.getCwcwcustomerewbcode(), listNotContains);
			}
		}
		Document doc = PdfUtil.buildDoc(true);
		PdfBean pdfBean = new PdfBean();
		String dirs = ServletActionContext.getServletContext().getRealPath(
				"download/finance");
		File file = new File(dirs);
		if (!file.exists())
			file.mkdirs();
		// dirs =
		// dirs+"\\"+objBRColumns.getCocosname()+DateUtility.getFileTimeStamp()+".pdf";
		dirs = dirs + "/" + objBRColumns.getCocosename() + "-"
				+ DateUtility.getFileTimeStamp() + ".pdf";
		// dirs =
		// dirs+"\\"+objBRColumns.getCoconame()+DateUtility.getFileTimeStamp()+".pdf";
		System.out.println("���ɵ�pdf�ļ�Ŀ¼Ϊ:" + dirs);
		// pdfBean.setHeader("��˶�����ʵ��������ο���");
		pdfBean.setHeader(objBRColumns.getCocosname() + "�����ʵ��������ο���");
		pdfBean.setFooter("Page��");
		pdfBean.setFileName(dirs);
		Table headTable = null;
		Font titleFont = ITextFontUtil.getCnBoldFont(8, Color.black);
		Font contentFont = ITextFontUtil.getCnFont(8, Color.black);
		try {
			headTable = new Table(6, 3);
			// headTable.setBorder(0);//�߿�Ϊ0
			headTable.setPadding(2);// ��Ԫ���ڱ߾�
			headTable.setWidth(110);
			/*
			 * float[] fTdwidth ={ 15f,15f,15f,15f,15f,15f };
			 * 
			 * headTable.setWidths(fTdwidth);
			 */

			/*
			 * int[] iTdwidth ={ 18,18,18,18,18,18 };
			 * 
			 * headTable.setWidths(iTdwidth);
			 */
			List<Cell> listCell = new ArrayList<Cell>();
			Cell cell01 = new Cell(PdfUtil.getChunk("�ʵ����", titleFont));
			Cell cell02 = new Cell(PdfUtil.getChunk(objBRColumns.getBrbrid()));
			Cell cell03 = new Cell(PdfUtil.getChunk("��˾���", titleFont));
			Cell cell04 = new Cell(PdfUtil.getChunk(
					objBRColumns.getCocosname(), contentFont));
			Cell cell05 = new Cell(PdfUtil.getChunk("�ʵ�����", titleFont));
			Cell cell06 = new Cell(PdfUtil.getChunk(objBRColumns.getBkbkname(),
					contentFont));
			Cell cell07 = new Cell(PdfUtil.getChunk("�ʵ�״̬", titleFont));
			Cell cell08 = new Cell(PdfUtil.getChunk(objBRColumns
					.getBrsbrsname(), contentFont));
			Cell cell09 = new Cell(PdfUtil.getChunk("�ʵ�����", titleFont));
			Cell cell10 = new Cell(PdfUtil.getChunk(objBRColumns
					.getBrbroccurdate()));
			Cell cell11 = new Cell(PdfUtil.getChunk("�ʵ����", titleFont));
			Cell cell12 = new Cell(PdfUtil
					.getChunk(objBRColumns.getBrbrtotal()));
			Cell cell13 = new Cell(PdfUtil.getChunk("����", titleFont));
			Cell cell14 = new Cell(PdfUtil.getChunk(objBRColumns.getCkckname(),
					contentFont));
			Cell cell15=new Cell(PdfUtil.getChunk("��������",
					titleFont));
			listCell.add(cell01);
			listCell.add(cell02);
			listCell.add(cell03);
			listCell.add(cell15);
			listCell.add(cell04);
			listCell.add(cell05);
			listCell.add(cell06);
			listCell.add(cell07);
			listCell.add(cell08);
			listCell.add(cell09);
			listCell.add(cell10);
			listCell.add(cell11);
			listCell.add(cell12);
			listCell.add(cell13);
			listCell.add(cell14);

			for (Cell cell : listCell) {
				cell.setBorder(0);
				cell.setHorizontalAlignment(Cell.ALIGN_LEFT);// ������
				cell.setVerticalAlignment(Cell.ALIGN_CENTER);// �������
				headTable.addCell(cell);
			}
		} catch (BadElementException e) {
			e.printStackTrace();
		}

		Table bodyTable = null;
		Font contentThFont = ITextFontUtil.getCnFont(7, Color.black);
		@SuppressWarnings("unused")
		Font numberFont = ITextFontUtil.getCnFont(6, Color.black);
		Font otherFont = ITextFontUtil.getCnFont(7, Color.black);
		try {
			bodyTable = new Table(17);
			bodyTable.setPadding(1);
			bodyTable.setWidth(110);
			// float[] fTdwidth = {10,2,8,5,4,8,8,8,6,8,8,6,8,8,8};
			// bodyTable.setWidths(fTdwidth);

			List<Cell> listThCell = new ArrayList<Cell>();// ��ͷ
			List<Cell> listTdCell = new ArrayList<Cell>();// ����
			List<Cell> listLastTr = new ArrayList<Cell>();// ���һ��

			Cell cell01 = new Cell(PdfUtil.getChunk("�˵���", titleFont));
			Cell cell21 = new Cell(PdfUtil.getChunk("��ǧ�˵���", titleFont));
			Cell cell22 = new Cell(PdfUtil.getChunk("ת����", titleFont));
			Cell cell23 = new Cell(PdfUtil.getChunk("��������", titleFont));
			Cell cell02 = new Cell(PdfUtil.getChunk("��Ʒ", titleFont));
			Cell cell03 = new Cell(PdfUtil.getChunk("��������", titleFont));
			Cell cell04 = new Cell(PdfUtil.getChunk("����", titleFont));
			Cell cell05 = new Cell(PdfUtil.getChunk("ʵ �أ�KG��", titleFont));
			Cell cell06 = new Cell(PdfUtil.getChunk("�Ļ���(KG)", titleFont));
			Cell cell07 = new Cell(PdfUtil.getChunk("�Ʒ���(KG)", titleFont));
			Cell cell08 = new Cell(PdfUtil.getChunk("Ŀ�ĵ�", titleFont));
			Cell cell09 = new Cell(PdfUtil.getChunk("Ӧ�շ���", titleFont));
			Cell cell10 = new Cell(PdfUtil.getChunk("�˷�", titleFont));
			Cell cell11 = new Cell(PdfUtil.getChunk("ȼ�ͷ�", titleFont));
			Cell cell12 = new Cell(PdfUtil.getChunk("�ӷ�", titleFont));
			Cell cell13 = new Cell(PdfUtil.getChunk("�ӷ���Ŀ", titleFont));
			Cell cell14 = new Cell(PdfUtil.getChunk("���", titleFont));
			Cell cell15 = new Cell(PdfUtil.getChunk("�۱�λ�ң�RMB��", titleFont));
			Cell cell16 = new Cell(PdfUtil.getChunk("��ע", titleFont));

			// ���ÿ�����
			cell01.setRowspan(3);

			cell21.setRowspan(3);
			cell22.setRowspan(3);
			cell23.setRowspan(3);
			cell02.setRowspan(3);
			cell03.setRowspan(3);
			cell04.setRowspan(3);
			cell05.setRowspan(3);
			cell06.setRowspan(3);
			cell07.setRowspan(3);
			cell08.setRowspan(3);
			cell09.setColspan(5);
			cell10.setRowspan(2);
			cell11.setRowspan(2);
			cell12.setColspan(2);
			cell15.setRowspan(2);
			cell16.setRowspan(3);

			// ��ӵ�Cell��
			listThCell.add(cell01);
			listThCell.add(cell21);
			listThCell.add(cell22);
			listThCell.add(cell23);
			listThCell.add(cell02);
			listThCell.add(cell03);
			listThCell.add(cell04);
			listThCell.add(cell05);
			listThCell.add(cell06);
			listThCell.add(cell07);
			listThCell.add(cell08);
			listThCell.add(cell09);
			listThCell.add(cell16);
			listThCell.add(cell10);
			listThCell.add(cell11);
			listThCell.add(cell12);
			listThCell.add(cell15);
			listThCell.add(cell13);
			listThCell.add(cell14);

			for (Cell cell : listThCell) {
				cell.setHorizontalAlignment(Cell.ALIGN_CENTER);// ������
				cell.setVerticalAlignment(Cell.ALIGN_CENTER);// �������
				cell.setBackgroundColor(new Color(16250623));
				// cell.setBorderWidth(1);
				bodyTable.addCell(cell);
			}

			BigDecimal objResultFee = new BigDecimal("0");// �ϼ�
			// BigDecimal objChengeResultFee = new BigDecimal("0");//�ϼ�(��λ��)
			List<ReceivableforbillColumns> listReceivableforbillColumns = new ArrayList<ReceivableforbillColumns>();
			int j = 0;
			for (Map.Entry<String, List<ReceivableforbillColumns>> entry : ForExprotRFBColumnsMap
					.entrySet()) {
				listReceivableforbillColumns = entry.getValue();
				ReceivableforbillColumns objFirstRFBColumns = listReceivableforbillColumns
						.get(0);
				BigDecimal objSubtotal = new BigDecimal("0");
				BigDecimal freight = new BigDecimal("0");
				BigDecimal oilFee = new BigDecimal("0");
				String strFkname = "";
				BigDecimal objOtherFee = new BigDecimal("0");
				for (ReceivableforbillColumns objRFBColumns : listReceivableforbillColumns) {
					if (objRFBColumns.getFkfkcode().equals("A0101")) {
						freight = freight.add(new BigDecimal(objRFBColumns
								.getRvrvactualtotal()));
					} else if (objRFBColumns.getFkfkcode().equals("A0102")) {
						oilFee = oilFee.add(new BigDecimal(objRFBColumns
								.getRvrvactualtotal()));
					} else {
						strFkname = objRFBColumns.getFkfkname();
						objOtherFee = objOtherFee.add(new BigDecimal(
								objRFBColumns.getRvrvactualtotal()));
					}
				}

				// С��
				objSubtotal = objSubtotal.add(freight);
				objSubtotal = objSubtotal.add(oilFee);
				objSubtotal = objSubtotal.add(objOtherFee);
				// �ϼ�
				objResultFee = objResultFee.add(objSubtotal);
				Cell cellTd01 = new Cell(PdfUtil.getChunk(objFirstRFBColumns
						.getCwcwcustomerewbcode()));
				Cell cellTd21 = new Cell(PdfUtil.getChunk(objFirstRFBColumns
						.getCwcwewbcode()));
				Cell cellTd22 = null;
				if (!StringUtility.isNull(objFirstRFBColumns
						.getPkpkshowserverewbcode())
						&& objFirstRFBColumns.getPkpkshowserverewbcode()
								.equals("N")) {
					cellTd22 = new Cell(PdfUtil.getChunk(objFirstRFBColumns
							.getCwcwewbcode()));
				} else {
					cellTd22 = new Cell(PdfUtil.getChunk(objFirstRFBColumns
							.getCwcwserverewbcode()));
				}
				Cell cellTd23 = new Cell(PdfUtil.getChunk(objFirstRFBColumns
						.getRvrvoccurdate(), otherFont));
				Cell cellTd02 = new Cell(PdfUtil.getChunk(objFirstRFBColumns
						.getPkpkname(), otherFont));
				Cell cellTd03 = new Cell(PdfUtil.getChunk(objFirstRFBColumns
						.getCtctname(), contentThFont));
				Cell cellTd04 = new Cell(PdfUtil.getChunk(objFirstRFBColumns
						.getCwcwpieces()));
				cellTd04.setHorizontalAlignment(Cell.ALIGN_RIGHT);
				Cell cellTd05 = new Cell(PdfUtil.getChunk(String
						.valueOf(new BigDecimal(objFirstRFBColumns
								.getCwcwgrossweight()).divide(new BigDecimal(
								"1"), 3, 4))));
				cellTd05.setHorizontalAlignment(Cell.ALIGN_RIGHT);
				Cell cellTd06 = new Cell(PdfUtil.getChunk(String
						.valueOf(new BigDecimal(CorewaybillDemand
								.getVolumeweight(objFirstRFBColumns
										.getCwcwcode())).divide(new BigDecimal(
								"1"), 3, 4))));
				cellTd06.setHorizontalAlignment(Cell.ALIGN_RIGHT);
				Cell cellTd07 = new Cell(PdfUtil.getChunk(String
						.valueOf(new BigDecimal(objFirstRFBColumns
								.getCwcwchargeweight()).divide(new BigDecimal(
								"1"), 3, 4))));
				cellTd07.setHorizontalAlignment(Cell.ALIGN_RIGHT);

				Cell cellTd08 = new Cell(PdfUtil.getChunk(
						!StringUtility.isNull(objFirstRFBColumns
								.getCddtdtname()) ? objFirstRFBColumns
								.getCddtdtname() : DistrictDemand
								.getDtnameByDtcode(objFirstRFBColumns
										.getSdtdtcode()), contentThFont));

				Cell cellTd09 = new Cell(PdfUtil.getChunk(String
						.valueOf(freight.divide(new BigDecimal("1"), 3, 4))));
				cellTd09.setHorizontalAlignment(Cell.ALIGN_RIGHT);
				Cell cellTd10 = new Cell(PdfUtil.getChunk(String.valueOf(oilFee
						.divide(new BigDecimal("1"), 3, 4))));
				cellTd10.setHorizontalAlignment(Cell.ALIGN_RIGHT);
				Cell cellTd11 = new Cell(PdfUtil.getChunk(strFkname,
						contentThFont));
				Cell cellTd12 = new Cell(PdfUtil
						.getChunk(String.valueOf(objOtherFee.divide(
								new BigDecimal("1"), 3, 4))));
				cellTd12.setHorizontalAlignment(Cell.ALIGN_RIGHT);
				Cell cellTd13 = new Cell(PdfUtil
						.getChunk(String.valueOf(objSubtotal.divide(
								new BigDecimal("1"), 3, 4))));
				cellTd13.setHorizontalAlignment(Cell.ALIGN_RIGHT);
				String strRemark = (objFirstRFBColumns.getRvrvremark() != null ? objFirstRFBColumns
						.getRvrvremark()
						: "");
				Cell cellTd14 = new Cell(PdfUtil.getChunk(strRemark,
						contentThFont));// null

				listTdCell.add(cellTd01);
				listTdCell.add(cellTd21);
				listTdCell.add(cellTd22);
				listTdCell.add(cellTd23);
				listTdCell.add(cellTd02);
				listTdCell.add(cellTd03);
				listTdCell.add(cellTd04);
				listTdCell.add(cellTd05);
				listTdCell.add(cellTd06);
				listTdCell.add(cellTd07);
				listTdCell.add(cellTd08);
				listTdCell.add(cellTd09);
				listTdCell.add(cellTd10);
				listTdCell.add(cellTd11);
				listTdCell.add(cellTd12);
				listTdCell.add(cellTd13);
				listTdCell.add(cellTd14);

				for (int i = 0; i < listTdCell.size(); i++) {
					Cell cell = listTdCell.get(i);
					/*
					 * cell.setBorderWidthLeft(0); cell.setBorderWidthRight(0);
					 */
					// cell.setHorizontalAlignment(Cell.ALIGN_LEFT);// ������

					// cell.setVerticalAlignment(Cell.ALIGN_CENTER);//�������
					if (j % 2 == 0)
						cell.setBackgroundColor(new Color(240, 240, 240));
					bodyTable.addCell(cell);
				}
				listTdCell.clear();
				j++;
			}
			// objChengeResultFee = objResultFee.multiply(new BigDecimal("1"));
			Cell cellLast01 = new Cell(PdfUtil.getChunk("�ϼ�(RMB)��"
					+ String.valueOf(objResultFee), titleFont));
			// Cell cellLast02 = new
			// Cell(PdfUtil.getChunk("�ϼƣ�"+String.valueOf(objChengeResultFee),numberFont));

			Cell cellLast00 = new Cell(PdfUtil.getChunk("", contentThFont));
			cellLast00.setColspan(11);
			cellLast01.setColspan(5);
			// cellLast02.setColspan(2);
			listLastTr.add(cellLast00);
			listLastTr.add(cellLast01);
			// listLastTr.add(cellLast02);

			for (Cell cell : listLastTr) {
				cell.setHorizontalAlignment(Cell.ALIGN_LEFT);// ������
				// cell.setVerticalAlignment(Cell.ALIGN_CENTER);//�������
				bodyTable.addCell(cell);
			}
		} catch (BadElementException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		List listElement = new ArrayList();
		listElement.add(headTable);
		Paragraph para = PdfUtil.getPara("", titleFont);
		listElement.add(para);
		listElement.add(bodyTable);

		pdfBean.setElementList(listElement);
		// ����pdf�ļ�
		PdfUtil.exprotPdf(doc, pdfBean);
		// contextPath => /xswlsz
		// String contextPath=
		// ServletActionContext.getServletContext().getContextPath();
		String strPath = ServletActionContext.getServletContext().getRealPath(
				"");
		String strName = "";
		if (strPath.lastIndexOf("\\") > 0) {
			strName = strPath.substring(strPath.lastIndexOf("\\"));
		} else if (strPath.lastIndexOf("/") > 0) {
			strName = strPath.substring(strPath.lastIndexOf("/"));
		} else {
			strName = strPath;
		}
		// ��:
		// \xswlsz
		// String strName = "/xsexpress";
		System.out.println("strPath:" + strPath);
		System.out.println("strName:" + strName);

		// String fileName =
		// pdfBean.getFileName().substring(pdfBean.getFileName().indexOf(contextPath.substring(contextPath.indexOf("/")+1))+contextPath.length());
		String fileName = pdfBean.getFileName().substring(
				pdfBean.getFileName().indexOf(strName) + strName.length());
		System.out.println("fileName:" + fileName);
		this.setFileName(fileName);
		return SUCCESS;
	}
	
	
	/**
	 * ����δ������ϸ����,
	 * ajax����ķ�����ͨ��struts.xml�����ҵ���
	 */
	@SuppressWarnings({ "unchecked", "deprecation" })
	public void importExcel() throws Exception {
		// List<ReceivableforbillColumns> listFRResults = null;
		String strCocode = (String) session.getAttribute("Cocode");//1
		if (StringUtility.isNull(strCocode)){
			//strCocode = "2";
			return ;
		}	
		String dateType = request.getParameter("dateType");//signindate
		String strStartdate = request.getParameter("strStartdate");
		String strEnddate = request.getParameter("strEnddate");
		String strAbwcode=request.getParameter("strAbwcode");

		HashMap<String, List<ReceivableforbillColumns>> RFBColumnsMap = new HashMap<String, List<ReceivableforbillColumns>>();
		// BillrecordColumns objBRColumns = null;
		List<ReceivableforbillColumns> listRFBColumns = null;
		ReceivableforbillCondition objRFBCondition = new ReceivableforbillCondition();
		objRFBCondition.setCcocode(strCocode);
		objRFBCondition.setBkcode("A0101");
		if(dateType!=null){
			if(dateType.equals("signindate")){
				objRFBCondition.setStarthwsignindate(strStartdate);
				objRFBCondition.setEndhwsignindate(strEnddate);
			}else if(dateType.equals("occurdate")){
				objRFBCondition.setStartrvoccurdate(strStartdate);
				objRFBCondition.setEndrvoccurdate(strEnddate);
			}
		}
		objRFBCondition.setAbwlabelcode(strAbwcode);
		// ����������δ���ˣ�
		objRFBCondition.setFscode("C");
		listRFBColumns = ReceivableDemand.queryForBill(objRFBCondition);
		request.setAttribute("startdate", strStartdate);

		for (int i = 0; i < listRFBColumns.size(); i++) {
			if (RFBColumnsMap.containsKey(listRFBColumns.get(i)
					.getCwcwcustomerewbcode())) {
				List<ReceivableforbillColumns> listContains = (List<ReceivableforbillColumns>) RFBColumnsMap
						.get(listRFBColumns.get(i).getCwcwcustomerewbcode());
				listContains.add(listRFBColumns.get(i));
				RFBColumnsMap.put(listRFBColumns.get(i)
						.getCwcwcustomerewbcode(), listContains);
			} else {
				List<ReceivableforbillColumns> listNotContains = new ArrayList<ReceivableforbillColumns>();
				listNotContains.add(listRFBColumns.get(i));
				RFBColumnsMap.put(listRFBColumns.get(i)
						.getCwcwcustomerewbcode(), listNotContains);
			}
		}
		try {
			String xlsName = strCocode + "_"
					+ DateFormatUtility.getFileNameSysdate() + "_bill.xls";
			session.setAttribute("getExcelPathName", xlsName);//1_160902_112217_bill.xls
			String outputFile = request
					.getRealPath("/download/accountsForBill/" + xlsName);//D:\tomcat\Apache Software Foundation\Tomcat 6.0\webapps\baiqianex\download\accountsForBill\1_160902_112217_bill.xls
			// ����һ��excel������
			HSSFWorkbook workbook = new HSSFWorkbook();
			// excel�������½�һ�¹�����
			HSSFSheet sheet = workbook.createSheet("Sheet1");
			// �����п��
			
			sheet.setColumnWidth(0, 6500);
			sheet.setColumnWidth(1, 4500);
			sheet.setColumnWidth(2, 4500);
			sheet.setColumnWidth(3, 8000);
			sheet.setColumnWidth(4, 4500);
			sheet.setColumnWidth(5, 3000);
			sheet.setColumnWidth(6, 3000);
			sheet.setColumnWidth(7, 3000);
			sheet.setColumnWidth(8, 3000);
			sheet.setColumnWidth(9, 3000);
			sheet.setColumnWidth(10, 3000);
			sheet.setColumnWidth(11, 8000);
			sheet.setColumnWidth(12, 3000);
			sheet.setColumnWidth(13, 8000);
			sheet.setColumnWidth(14, 3000);
			sheet.setColumnWidth(15, 3000);
			//sheet.setColumnWidth(15, 8000);
			// ��������
			HSSFFont font = workbook.createFont();
			font.setFontName("Verdana");
			font.setBoldweight((short) 100);
			font.setFontHeight((short) 300);
			font.setColor(HSSFColor.BLUE.index);
			// ���õ�Ԫ���ʽ
			HSSFCellStyle cellStyle = workbook.createCellStyle();
			cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
			// ���ñ߿�
			cellStyle.setBottomBorderColor(HSSFColor.RED.index);
			cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
			cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
			// ��������
			cellStyle.setFont(font);
			cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			cellStyle.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);
			cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);

			// ������0λ�ô�����(��һ��)
			HSSFRow row = sheet.createRow((short) 0);
			HSSFCell cell0 = row.createCell((short) 0);
			HSSFCell cell1 = row.createCell((short) 1);
			HSSFCell cell2 = row.createCell((short) 2);
			HSSFCell cell3 = row.createCell((short) 3);
			HSSFCell cell4 = row.createCell((short) 4);
			HSSFCell cell5 = row.createCell((short) 5);
			HSSFCell cell6 = row.createCell((short) 6);
			HSSFCell cell7 = row.createCell((short) 7);
			HSSFCell cell8 = row.createCell((short) 8);
			HSSFCell cell9 = row.createCell((short) 9);
			HSSFCell cell10 = row.createCell((short) 10);
			HSSFCell cell11 = row.createCell((short) 11);
			HSSFCell cell12 = row.createCell((short) 12);
			HSSFCell cell13 = row.createCell((short) 13);
			HSSFCell cell14 = row.createCell((short) 14);
			HSSFCell cell15 = row.createCell((short) 15);

			cell0.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell3.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell4.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell5.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell6.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell7.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell8.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell9.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell10.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell11.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell12.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell13.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell14.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell15.setCellType(HSSFCell.CELL_TYPE_STRING);

			cell0.setCellType(HSSFCell.ENCODING_UTF_16);
			cell1.setCellType(HSSFCell.ENCODING_UTF_16);
			cell2.setCellType(HSSFCell.ENCODING_UTF_16);
			cell3.setCellType(HSSFCell.ENCODING_UTF_16);
			cell4.setCellType(HSSFCell.ENCODING_UTF_16);
			cell5.setCellType(HSSFCell.ENCODING_UTF_16);
			cell6.setCellType(HSSFCell.ENCODING_UTF_16);
			cell7.setCellType(HSSFCell.ENCODING_UTF_16);
			cell8.setCellType(HSSFCell.ENCODING_UTF_16);
			cell9.setCellType(HSSFCell.ENCODING_UTF_16);
			cell10.setCellType(HSSFCell.ENCODING_UTF_16);
			cell11.setCellType(HSSFCell.ENCODING_UTF_16);
			cell12.setCellType(HSSFCell.ENCODING_UTF_16);
			cell13.setCellType(HSSFCell.ENCODING_UTF_16);
			cell14.setCellType(HSSFCell.ENCODING_UTF_16);
			cell15.setCellType(HSSFCell.ENCODING_UTF_16);

			cell0.setCellValue("��������");
			cell1.setCellValue("�˵���");
			cell2.setCellValue("��ǧ�˵���");
			cell3.setCellValue("ת����");
			cell4.setCellValue("��Ʒ");
			cell5.setCellValue("��������");
			cell6.setCellValue("����");
			cell7.setCellValue("ʵ��(KG)");
			cell8.setCellValue("�Ļ���(KG)");
			cell9.setCellValue("�Ʒ�����(KG)");
			cell10.setCellValue("Ŀ�ĵ�");
			cell11.setCellValue("Ӧ�շ���(�˷�)");
			cell12.setCellValue("ȼ�ͷ�");
			cell13.setCellValue("�ӷ�����Ŀ(�ӷ�)");
			cell14.setCellValue("���");
			cell15.setCellValue("��λ�Һϼ�");
			//cell16.setCellValue("��ע");

			//Iterator iter = listRFBColumns.iterator();
			int temp = 0;
			for (Map.Entry<String, List<ReceivableforbillColumns>> entry : RFBColumnsMap
					.entrySet()) {
				++temp;
				row = sheet.createRow((short) temp);
				HSSFCell cell00 = row.createCell((short) 0);
				HSSFCell cell111 = row.createCell((short) 1);
				HSSFCell cell112 = row.createCell((short) 2);
				HSSFCell cell122 = row.createCell((short) 3);
				HSSFCell cell133 = row.createCell((short) 4);
				HSSFCell cell144 = row.createCell((short) 5);
				HSSFCell cell155 = row.createCell((short) 6);
				HSSFCell cell161 = row.createCell((short) 7);
				HSSFCell cell17 = row.createCell((short) 8);
				HSSFCell cell18 = row.createCell((short) 9);
				HSSFCell cell19 = row.createCell((short) 10);
				HSSFCell cell110 = row.createCell((short) 11);
				HSSFCell cell1111 = row.createCell((short) 12);
				HSSFCell cell1112 = row.createCell((short) 13);
				HSSFCell cell1113 = row.createCell((short) 14);
				HSSFCell cell1114 = row.createCell((short) 15);
				//HSSFCell cell1115 = row.createCell((short) 15);

				List<ReceivableforbillColumns> listReceivableforbillColumns = new ArrayList<ReceivableforbillColumns>();
				if (!RFBColumnsMap.isEmpty() && RFBColumnsMap.size() > 0) {
					BigDecimal freightValue = new BigDecimal("0");
					BigDecimal oilFee = new BigDecimal("0");
					String strFkname = "";
					String objOtherFee2="";
					BigDecimal objOtherFee = new BigDecimal("0");
					listReceivableforbillColumns = entry.getValue();
					ReceivableforbillColumns objRFBColumns;
					objRFBColumns = listReceivableforbillColumns.get(0);
					if (StringUtility.isNull(objRFBColumns.getCddtdtname())) {
						objRFBColumns
								.setCddtdtname(DistrictDemand
										.getDtnameByDtcode(objRFBColumns
												.getSdtdtcode()));
					}
					for (ReceivableforbillColumns objLRFBColumns : listReceivableforbillColumns) {
						if (objLRFBColumns.getFkfkcode().equals("A0101")) {
							freightValue = freightValue.add(new BigDecimal(
									objLRFBColumns.getRvrvactualtotal()));
						} else if (objLRFBColumns.getFkfkcode().equals("A0102")) {
							oilFee = oilFee.add(new BigDecimal(objLRFBColumns
									.getRvrvactualtotal()));
						} else {
							strFkname += objLRFBColumns.getFkfkname()+",";
							objOtherFee = objOtherFee.add(new BigDecimal(
									objLRFBColumns.getRvrvactualtotal()));
							objOtherFee2 +=objLRFBColumns.getRvrvactualtotal()+",";
							//strFkname = objLRFBColumns.getFkfkname();
							//objOtherFee = objOtherFee.add(new BigDecimal(
									//objLRFBColumns.getRvrvactualtotal()));
						}
					}
					
					if(!StringUtility.isNull(strFkname)&&strFkname.endsWith(",")){
						strFkname=strFkname.substring(0,strFkname.length()-1);
					}
					if(!StringUtility.isNull(objOtherFee2)&&objOtherFee2.endsWith(",")){
						objOtherFee2=objOtherFee2.substring(0,objOtherFee2.length()-1);
						String[] objOther = objOtherFee2.split(",");
						//int intdou = objOtherFee2.indexOf(",");//-1����û��
						if(objOtherFee2.indexOf(",") != -1){
							//�������������
							objOtherFee2 = "";
							for(int index = 0; index <objOther.length ; index++){
								BigDecimal objbig = new BigDecimal(objOther[index]).divide(new BigDecimal("1"),3,4);
								
								objOtherFee2 += objbig.toString()+",";
							}
						}else{
							BigDecimal objbig = new BigDecimal(objOtherFee2).divide(new BigDecimal("1"),3,4);//0.5,0.81,�������ת��
							objOtherFee2 = objbig.toString();
						}
						
						
					}
					
					BigDecimal objTotal = new BigDecimal("0");
					objTotal = objTotal.add(freightValue);
					objTotal = objTotal.add(oilFee);
					objTotal = objTotal.add(objOtherFee);
					objTotal.setScale(3);//���ñ���Ϊ
					ReceivableforbillColumns objFirstRFBColumns = listReceivableforbillColumns
							.get(0);
					// objFirstRFBColumns = (ReceivableforbillColumns)
					// iter.next();
					
					cell00.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell00.setCellType(HSSFCell.ENCODING_UTF_16);
					cell00.setCellValue(objFirstRFBColumns.getRvrvoccurdate());
					cell111.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell111.setCellType(HSSFCell.ENCODING_UTF_16);
					cell111.setCellValue(objFirstRFBColumns
							.getCwcwcustomerewbcode());
					// �˴����Ӱ�ǧ�˵��� Cwcwewbcode
					cell112.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell112.setCellType(HSSFCell.ENCODING_UTF_16);
					cell112.setCellValue(objFirstRFBColumns.getCwcwewbcode());

					cell122.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell122.setCellType(HSSFCell.ENCODING_UTF_16);

					String strPkshowSEWBCode = objFirstRFBColumns
							.getPkpkshowserverewbcode();
					if (StringUtility.isNull(strPkshowSEWBCode))
						strPkshowSEWBCode = "Y";
					if (strPkshowSEWBCode.equals("N"))
						cell122.setCellValue(objFirstRFBColumns
								.getCwcwewbcode());
					else
						cell122.setCellValue(objFirstRFBColumns
								.getCwcwserverewbcode());

					cell133.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell133.setCellType(HSSFCell.ENCODING_UTF_16);
					cell133.setCellValue(objFirstRFBColumns.getPkpkname());
					cell144.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell144.setCellType(HSSFCell.ENCODING_UTF_16);
					cell144.setCellValue(objFirstRFBColumns.getCtctname());
					cell155.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell155.setCellType(HSSFCell.ENCODING_UTF_16);
					cell155.setCellValue(objFirstRFBColumns.getCwcwpieces());
					cell161.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell161.setCellType(HSSFCell.ENCODING_UTF_16);
					cell161.setCellValue(new BigDecimal(objRFBColumns
							.getCwcwgrossweight()).divide(new BigDecimal("1"),
							3, 4).toString());
					cell17.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell17.setCellType(HSSFCell.ENCODING_UTF_16);
					cell17.setCellValue(new BigDecimal(CorewaybillDemand
							.getVolumeweight(objRFBColumns.getCwcwcode())).divide(new BigDecimal("1"),3,4).toString());
					cell18.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell18.setCellType(HSSFCell.ENCODING_UTF_16);
					cell18.setCellValue(new BigDecimal(objRFBColumns
							.getCwcwchargeweight()).divide(new BigDecimal("1"),
							3, 4).toString());
					cell19.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell19.setCellType(HSSFCell.ENCODING_UTF_16);
					cell19.setCellValue(objRFBColumns.getCddtdtname());
					cell110.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell110.setCellType(HSSFCell.ENCODING_UTF_16);
					cell110.setCellValue(freightValue.divide(
							new BigDecimal("1"), 3, 4).toString());
					cell1111.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell1111.setCellType(HSSFCell.ENCODING_UTF_16);
					cell1111.setCellValue(oilFee.divide(new BigDecimal("1"), 3,
							4).toString());//ȼ�ͷ�
					cell1112.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell1112.setCellType(HSSFCell.ENCODING_UTF_16);
					cell1112.setCellValue(strFkname);//�ӷ���Ŀ
					cell1113.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell1113.setCellType(HSSFCell.ENCODING_UTF_16);
					//cell1113.setCellValue(!String.valueOf(objOtherFee).equals(
							//"0") ? String.valueOf(objOtherFee.divide(
							//new BigDecimal("1"), 2, 4)) : "");
					cell1113.setCellValue(objOtherFee2);//�ӷ�
					cell1114.setCellType(HSSFCell.CELL_TYPE_STRING);
					cell1114.setCellType(HSSFCell.ENCODING_UTF_16);
					cell1114.setCellValue(objTotal.divide(new BigDecimal("1"),3,4).toString());
					//cell1115.setCellType(HSSFCell.CELL_TYPE_STRING);
					//cell1115.setCellType(HSSFCell.ENCODING_UTF_16);
					//cell1115
							//.setCellValue(objRFBColumns.getRvrvremark() != null ? objRFBColumns
									//.getRvrvremark()
									//: "");
				}
			}

			File path = new File(outputFile);
			path.delete();
			FileOutputStream fout = new FileOutputStream(outputFile);
			workbook.write(fout);
			fout.flush();
			fout.close();
			//response.getWriter();//����PrintWriter()���󣬵���print������ֱ�������ajax��ת����������ģ�Ȼ����������
			response.getWriter().print(xlsName);//ajax���ܵ�����data
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	
}