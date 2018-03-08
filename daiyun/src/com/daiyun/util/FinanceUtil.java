package com.daiyun.util;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kyle.common.util.jlang.CollectionUtility;
import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.billing.receivable.da.ReceivableforbillColumns;
import kyle.leis.eo.billing.receivable.da.ReceivableforbillCondition;
import kyle.leis.eo.billing.receivable.dax.ReceivableDemand;
import kyle.leis.eo.finance.dunning.da.FinancestatisticsColumns;
import kyle.leis.eo.finance.dunning.da.FinancestatisticsCondition;
import kyle.leis.eo.finance.dunning.dax.DunningDemand;
import kyle.leis.fs.dictionary.district.dax.DistrictDemand;

public class FinanceUtil {
	/**
	 * 待支付账单 = 未出账金额
	 * */
	public static List<ReceivableforbillColumns> getNotAccountMoney(String strCocode){
		BigDecimal sumWeight = new BigDecimal("0.000");
		//String op=request.getParameter("op");
		//String strCocode = (String) session.getAttribute("Cocode");
	
		if (StringUtility.isNull(strCocode))
			strCocode = "0";
		//String dateType = request.getParameter("dateType");//日期类型
	//	String strStartdate = request.getParameter("strStartdate");
	//	String strEnddate = request.getParameter("strEnddate");
	//	String strAbwcode=request.getParameter("strAbwcode");
	//	System.out.println(strAbwcode);
	///	if(op==null){
	//		op="";
	//	}
		//得到当前时间与两个月前的时间
	//	if(op.equals("op")){		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar cal=Calendar.getInstance();
			cal.add(Calendar.MONTH, -2);  
			long date = cal.getTimeInMillis();
			format.setLenient(false);
			String strStartdate=format.format(new Date(date));
			String strEnddate=DateFormatUtility.getStandardSysdate();			
	
		
		HashMap<String, List<ReceivableforbillColumns>> RFBColumnsMap = new HashMap<String, List<ReceivableforbillColumns>>();
		// BillrecordColumns objBRColumns = null;
		List<ReceivableforbillColumns> listRFBColumns = null;
		ReceivableforbillCondition objRFBCondition = new ReceivableforbillCondition();
		objRFBCondition.setCcocode(strCocode);
		objRFBCondition.setBkcode("A0101");

		//objRFBCondition.setAbwlabelcode(strAbwcode);
		
		// 设置条件（未出账）
		objRFBCondition.setFscode("C");
		try {
			listRFBColumns = ReceivableDemand.queryForBill(objRFBCondition);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//request.setAttribute("startdate", strStartdate);
	
		
		//request.setAttribute("startdate", strStartdate);
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
					try {
						objRFBColumns.setCddtdtname(DistrictDemand
								.getDtnameByDtcode(objRFBColumns.getSdtdtcode()));
					} catch (Exception e) {
						e.printStackTrace();
					}
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
					int intdou = objOtherFee2.indexOf(",");//-1代表没有
					if(objOtherFee2.indexOf(",") != -1){
						//如果含有两个数
						objOtherFee2 = "";
						for(int index = 0; index <objOther.length ; index++){
							BigDecimal objbig = new BigDecimal(objOther[index]).divide(new BigDecimal("1"),3,4);
							
							objOtherFee2 += objbig.toString()+",";
						}
					}else{
						BigDecimal objbig = new BigDecimal(objOtherFee2).divide(new BigDecimal("1"),3,4);//0.5,0.81,这个不好转。
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
				objTotal = objTotal.setScale(3);//保留三位小数，默认四舍五入
				
				ReceivableforbillColumns objFirstRFBColumns = listReceivableforbillColumns.get(0);
				//实重
				//objFirstRFBColumns.setCwcwgrossweight(new BigDecimal(objFirstRFBColumns.getCwcwgrossweight()).divide(new BigDecimal("1"),3,4));
				//计费重
				//objFirstRFBColumns.setCwcwchargeweight(new BigDecimal(objFirstRFBColumns.getCwcwchargeweight()).divide(new BigDecimal("1"),3,4));
				//
				//体积重		listRFBColumns
				//BigDecimal strObjVolumeweight = new BigDecimal(CorewaybillDemand.getVolumeweight(objFirstRFBColumns.getCwcwcode())).divide(new BigDecimal("1"),3,4);
				//String objVolumeweight=CorewaybillDemand.getVolumeweight(objFirstRFBColumns.getCwcwcode());
				//request.setAttribute("objVolumeweight", strObjVolumeweight.toString());
				BigDecimal addWeight = new BigDecimal(objFirstRFBColumns.getCwcwchargeweight()).divide(new BigDecimal("1"),3,4);
				//sumWeight = sumWeight.add(addWeight);
				
				
				objFirstRFBColumns.getCwcwcustomerewbcode();
				// 此处增加百千运单号 Cwcwewbcode
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
				// 运费
				objFirstRFBColumns.setRvrvunitnumber(freightValue.divide(new BigDecimal("1"), 3, 4));
				// 燃油费
				objFirstRFBColumns.setRvrvunitprice(oilFee.divide(new BigDecimal("1"), 3, 4));
				// 本位币合计
				objFirstRFBColumns.setRvrvactualtotal(objTotal);
				// 杂费项目
				objFirstRFBColumns.setPmpmname(strFkname);
				// 杂费金额
				objFirstRFBColumns.setRvrvtotal(new BigDecimal(!String.valueOf(
						objOtherFee).equals("0") ? String.valueOf(objOtherFee
						.divide(new BigDecimal("1"), 3, 4)) : "0"));
				objFirstRFBColumns.setPmpmcode(objOtherFee2);
				listRFBColumns1.add(objFirstRFBColumns);
			}
		}
		
	
		return listRFBColumns1;
	
	}
	
	
	/**
	 * 2016-12-1
	 * 查询余额,默认两个月内的
	 * **/
	public static FinancestatisticsColumns getQueryFinaceReport(String strCocode){
		//List<FinanceReportResults> listFRResults = new ArrayList<FinanceReportResults>();
		// 设置查询条件
		FinancestatisticsCondition objFSCondition = new FinancestatisticsCondition();
		if (StringUtility.isNull(strCocode)){
			strCocode = "0";
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar cal=Calendar.getInstance();
		cal.add(Calendar.MONTH, -2);  
		long date = cal.getTimeInMillis();
		format.setLenient(false);
		String strStartdate=format.format(new Date(date));
		String strEnddate=DateFormatUtility.getStandardSysdate();	
		objFSCondition.setCocode(strCocode);
		objFSCondition.setStartdate(strStartdate);
		objFSCondition.setEnddate(strEnddate);
		FinancestatisticsColumns objFinancestatisticsColumns = null;
		if (!StringUtility.isNull(strCocode)
				&& !StringUtility.isNull(strStartdate)
				&& !StringUtility.isNull(strEnddate)) {
			try {
			//	objFinancestatisticsColumns = (FinancestatisticsColumns) DunningDemand
			//			.query(objFSCondition).get(0);
				List resulList = DunningDemand.query(objFSCondition);
				if(!CollectionUtility.isNull(resulList)){
					objFinancestatisticsColumns =	(FinancestatisticsColumns) resulList.get(0);
				}else {
					objFinancestatisticsColumns = null;
				}
				
			} catch (Exception e1) {
				e1.printStackTrace();
			}
			
			
		}
		return objFinancestatisticsColumns;
	}
	
	
	
	
	
	
	
	
}
