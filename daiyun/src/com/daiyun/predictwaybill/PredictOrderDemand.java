package com.daiyun.predictwaybill;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.billing.calculate.chargeweight.bl.Chargeweight;
import kyle.leis.eo.billing.calculate.chargeweight.dax.ChargeweightParameter;
import kyle.leis.eo.billing.calculate.chargeweight.dax.ChargeweightResult;
import kyle.leis.eo.billing.calculate.feecalculate.dax.FeeCalculateParameter;
import kyle.leis.eo.operation.cargoinfo.da.CargoinfoColumns;
import kyle.leis.eo.operation.channelsearch.bl.ChannelSearch;
import kyle.leis.eo.operation.channelsearch.dax.ChannelSearchResult;
import kyle.leis.eo.operation.corewaybillpieces.da.CorewaybillpiecesColumns;
import kyle.leis.eo.operation.housewaybill.da.BuildewbcodeseqColumns;
import kyle.leis.eo.operation.housewaybill.da.BuildewbcodeseqQuery;
import kyle.leis.eo.operation.housewaybill.da.ForinputallColumns;
import kyle.leis.eo.operation.predictwaybill.da.PredictwaybillColumns;
import kyle.leis.eo.operation.predictwaybill.da.PredictwaybillCondition;
import kyle.leis.eo.operation.predictwaybill.da.PredictwaybillQuery;
import kyle.leis.eo.operation.predictwaybill.dax.PredictwaybillDemand;
import kyle.leis.es.price.expressprice.dax.IExpressPriceBasicData;
import kyle.leis.es.price.freightprice.da.FreightpriceCondition;
import kyle.leis.es.systemproperty.dax.SystempropertyDemand;

public class PredictOrderDemand {
	
	
	public static void merge(PredictOrderColumnsEX objSourcePOCEX,
			PredictOrderColumnsEX objDestPOCEX) throws Exception {
	 // 虽然现在的预报件CargoList为空，但是为了少改动后面的程序，从PredictwaybillColumns
	//  提取出一个CargoinfoColumns出来放到CargoList里面
		List<CargoinfoColumns> listSourceCargoInfo = new ArrayList<CargoinfoColumns>();
		PredictwaybillColumns pwbColumns = objSourcePOCEX.getPredictwaybillColumns();
		BigDecimal objPieces = new BigDecimal(pwbColumns.getPwbpwb_cargopieces());
		BigDecimal objUnitprice = new BigDecimal(pwbColumns.getPwbpwb_cargoamount());
		BigDecimal objTotalprice = objUnitprice.multiply(objPieces).divide(new BigDecimal("1"), 2, 4);
		CargoinfoColumns cargoinfoColumns = new CargoinfoColumns();
		cargoinfoColumns.setCiciname(pwbColumns.getPwbpwb_cargoename());
		cargoinfoColumns.setCiciename(pwbColumns.getPwbpwb_cargoename());
		cargoinfoColumns.setCiciunitprice(objUnitprice);
		cargoinfoColumns.setCicipieces(objPieces.intValue());
		cargoinfoColumns.setCicitotalprice(objTotalprice);
		cargoinfoColumns.setCkckcode(pwbColumns.getPwbck_code());
		cargoinfoColumns.setCiciattacheinfo(pwbColumns.getPwbpwb_customremark());//attacheinfo==配货信息=CustomRemark=自定标签？
		listSourceCargoInfo.add(cargoinfoColumns);
		objSourcePOCEX.setListCargoInfo(listSourceCargoInfo);
		List<CargoinfoColumns> listDestCargoInfo = objDestPOCEX.getListCargoInfo();
		merge(listSourceCargoInfo, listDestCargoInfo);
	} 
	
	
	public static List rebuildWaybillpieces(List listWaybillPieces,
			String strCustomerChargeweight) {
		List<CorewaybillpiecesColumns> list = new ArrayList<CorewaybillpiecesColumns>();
		if (listWaybillPieces == null || listWaybillPieces.size() < 1)
			return list;
		for (int i = 0; i < listWaybillPieces.size(); i++) {
			CorewaybillpiecesColumns objCBPC = (CorewaybillpiecesColumns)listWaybillPieces.get(i);
			if (i == 0) {
				objCBPC.setCpcpgrossweight(new BigDecimal(strCustomerChargeweight));
			} else {
				objCBPC.setCpcpgrossweight(new BigDecimal("0"));
			}
			list.add(objCBPC);
		}
		return list;
	}	
	
	public static void merge(List<CargoinfoColumns> listSourceCargoInfo,
			List<CargoinfoColumns> listDestCargoInfo) {
		if (listSourceCargoInfo == null || listSourceCargoInfo.size() < 1)
			return;
		if (listDestCargoInfo == null || listDestCargoInfo.size() < 1) {
			listDestCargoInfo = listSourceCargoInfo;
			return;
		}
		for (CargoinfoColumns objCargoinfoColumns : listSourceCargoInfo) {
			merge(objCargoinfoColumns, listDestCargoInfo);
		}
	}	
	
	public static PredictwaybillColumns loadExistsRecord(String strCocode, 
			PredictOrderColumnsEX objPOCEX) throws Exception {
		PredictwaybillColumns objWFPC = objPOCEX.getPredictwaybillColumns();
		PredictwaybillCondition objWFPCondition = new PredictwaybillCondition();
		objWFPCondition.setCo_code_customer(strCocode);
		objWFPCondition.setPwb_orderid(objWFPC.getPwbpwb_orderid());
		objWFPCondition.setPwbs_code("CTS,CHU,CHP");
		List listResults = PredictwaybillDemand.query(objWFPCondition);
		if (listResults == null || listResults.size() < 1) {
			objWFPCondition.setCo_code_customer(strCocode);
			objWFPCondition.setPwb_orderid("");
			objWFPCondition.setPwbs_code("CTS,CHU,CHP");
			objWFPCondition.setPwb_consigneename(objWFPC.getPwbpwb_consigneename());
			listResults = PredictwaybillDemand.query(objWFPCondition);
			if (listResults == null || listResults.size() < 1) {			
				return null;
			}
		}
		return ((PredictwaybillColumns)listResults.get(0));		
	}
	
	public static void merge(CargoinfoColumns objSourceCC,
			List<CargoinfoColumns> listDestCargoInfo) {
		boolean isRepeat = false;
		for (CargoinfoColumns objCargoinfoColumns : listDestCargoInfo) {
			// 源
			String strScCienme = StringUtility.replaceWhenNull(objSourceCC.getCiciename(),
					"");
			
			String strScAttacheinfo = StringUtility.replaceWhenNull(objSourceCC.getCiciattacheinfo(),
					"");
			// 目的
			String strDestCienme = StringUtility.replaceWhenNull(objCargoinfoColumns.getCiciename(),
					"");
			String strDestAttacheinfo = StringUtility.replaceWhenNull(objCargoinfoColumns.getCiciattacheinfo(),
					"");
			if (strScCienme.equals(strDestCienme) &&
					strScAttacheinfo.equals(strDestAttacheinfo)) {
				int iSourcePieces = Integer.parseInt(objSourceCC.getCicipieces());
				int iPieces = Integer.parseInt(objCargoinfoColumns.getCicipieces());
				BigDecimal objUnitprice = new BigDecimal(objCargoinfoColumns.getCiciunitprice());
				BigDecimal objPieces = new BigDecimal(iSourcePieces + iPieces);
				BigDecimal objTotalprice = objUnitprice.multiply(objPieces).divide(new BigDecimal("1"), 2, 4);
				
				objCargoinfoColumns.setCicipieces(iSourcePieces + iPieces);
				objCargoinfoColumns.setCicitotalprice(objTotalprice);
				isRepeat = true;
			}
		}
		if (!isRepeat){
			BigDecimal objUnitprice = new BigDecimal(objSourceCC.getCiciunitprice());
			BigDecimal objPieces = new BigDecimal(objSourceCC.getCicipieces());
			BigDecimal objTotalprice = objUnitprice.multiply(objPieces).divide(new BigDecimal("1"), 2, 4);
			objSourceCC.setCicitotalprice(objTotalprice);
			listDestCargoInfo.add(objSourceCC);
		}
	}   
	/*
	public static void setDefaultinfo(String strCocode,
			List<PredictOrderColumnsEX> listWaybill) throws Exception {
		for (PredictOrderColumnsEX objPOCEX : listWaybill) {
		String strScname = objPOCEX.getPredictwaybillColumns().getHwhw_shippername();
			if (StringUtility.isNull(strScname)) {
				ShipperconsigneeColumns objSCColumns = ShipperconsigneeDemand.loadByCustomer(strCocode);
				setShipperInfo(objPOCEX, objSCColumns);
			}
			if (StringUtility.isNull(objPOCEX.getPredictwaybillColumns().getHwhw_consigneecompany())) {
			objPOCEX.getPredictwaybillColumns().setHwhw_consigneecompany(".");
			}			
		}
	}
	*/
	/*现在已经没有发件人信息
	public static void setShipperInfo(PredictOrderColumnsEX objPOCEX,
			ShipperconsigneeColumns objSCColumns) {
		objPOCEX.getPredictwaybillColumns().setHwhw_shipperaddress1(objSCColumns.getScscaddress1());
		objPOCEX.getPredictwaybillColumns().setHwhw_shipperaddress2(objSCColumns.getScscaddress2());
		objPOCEX.getPredictwaybillColumns().setHwhw_shipperaddress3(objSCColumns.getScscaddress3());
		objPOCEX.getPredictwaybillColumns().setHwhw_shippercompany(objSCColumns.getScsccompanyname());
		objPOCEX.getPredictwaybillColumns().setHwhw_shipperfax(objSCColumns.getScscfax());
		objPOCEX.getPredictwaybillColumns().setHwhw_shippername(objSCColumns.getScscname());
		objPOCEX.getPredictwaybillColumns().setHwhw_shipperpostcode(objSCColumns.getScscpostcode());
		objPOCEX.getPredictwaybillColumns().setHwhw_shippertelephone(objSCColumns.getScsctelephone());							
	}
	*/
	
	
	private static ChargeweightParameter transferToCWParameter(ForinputallColumns objFIC,
			List listWaybillPieces) 
	throws Exception {
		ChargeweightParameter objCWParameter = new ChargeweightParameter();
		
		objCWParameter.setDtcode(objFIC.getSidtcode());
		objCWParameter.setCocode(objFIC.getCocode());
		objCWParameter.setGrossWeight(objFIC.getCwgrossweight());
		objCWParameter.setPdcode(IExpressPriceBasicData.PRICEDOMAIN_SALES);
		objCWParameter.setPkcode(objFIC.getPk_code());
		objCWParameter.setPostcode(objFIC.getCwgrossweight());
		objCWParameter.setSearchDate(DateFormatUtility.getStandardSysdate());
		// 获得件数详细信息
		objCWParameter.setWaybillpiecesCollection(listWaybillPieces);
		
		return objCWParameter;
	}	
	
	public static FreightpriceCondition transferToFPCondition(ForinputallColumns objFIC) 
	throws Exception {
		FreightpriceCondition objFPCondition = new FreightpriceCondition();
		
		objFPCondition.setCtcode(objFIC.getCtcode());
		objFPCondition.setDtcode(objFIC.getDtcode_Cwodt());
		objFPCondition.setEecode(objFIC.getEecode());
        objFPCondition.setEpstartdate(DateFormatUtility.getStandardSysdate());
        objFPCondition.setEpstartdate2(DateFormatUtility.getStandardSysdate());

        objFPCondition.setPdcode("A02");
        objFPCondition.setPkcode(objFIC.getPk_code());
        objFPCondition.setPmcode(objFIC.getPmcode());
        objFPCondition.setPscode("R");
		
		return objFPCondition;
	}	
	
	public static FeeCalculateParameter transferToFeeCalParam(ForinputallColumns objFIC) 
	throws Exception {
		FeeCalculateParameter objFCP = new FeeCalculateParameter();
		
		objFCP.setBkcode("A0201");
		objFCP.setCtcode(objFIC.getCtcode());
		objFCP.setDtcode(objFIC.getSidtcode());
		objFCP.setGrossWeight(objFIC.getCwchargeweight());
		objFCP.setPieces(objFIC.getCwpieces());
		objFCP.setPmcode(objFIC.getPmcode());
		objFCP.setPostcode(objFIC.getCwpostcodedestination());
		objFCP.setVolumeWeight("0");
		objFCP.setOriginVolumerate("6000");
		
		return objFCP;
	}	
	
	public static void buildSBDAUChargeweightAndChannel(ForinputallColumns objFIAColumns) throws Exception {
		objFIAColumns.setChncode_Cwspchn("15941");
		objFIAColumns.setCwchargeweight(new BigDecimal(objFIAColumns.getCwgrossweight()));
		objFIAColumns.setCwserverchargeweight(new BigDecimal(objFIAColumns.getCwgrossweight()));
		objFIAColumns.setCwtransferchargeweight(new BigDecimal(objFIAColumns.getCwgrossweight()));
		objFIAColumns.setCwtransfergrossweight(new BigDecimal(objFIAColumns.getCwgrossweight()));
		objFIAColumns.setTransfervolumeweight(new BigDecimal("0"));
	}
	
	
	public static void buildChargeweightAndChannel(ForinputallColumns objFIAColumns,
			List listWaybillPieces) throws Exception {
		// 获得计费重量
		String strSystemPE = SystempropertyDemand.getEnterprise();
		// sbd澳洲专线为了加快速度，指定唯一渠道
		if (!StringUtility.isNull(strSystemPE) && strSystemPE.startsWith("SBD")) {
			if (objFIAColumns.getPk_code().equals("A0719")) {
				buildSBDAUChargeweightAndChannel(objFIAColumns);
				return;
			}
		}
		ChargeweightParameter objCWParameter = transferToCWParameter(objFIAColumns,
				listWaybillPieces);
		Chargeweight objChargeweight = new Chargeweight();
		ChargeweightResult objCWResult = objChargeweight.calculate(objCWParameter);

		objFIAColumns.setCwchargeweight(new BigDecimal(objCWResult.getChargeweight()));
		objFIAColumns.setCwserverchargeweight(new BigDecimal(objCWResult.getChargeweight()));
		objFIAColumns.setCwtransferchargeweight(new BigDecimal(objCWResult.getChargeweight()));
		objFIAColumns.setTransfervolumeweight(new BigDecimal("0"));
		// 获得服务渠道
		FreightpriceCondition objFPCondition = transferToFPCondition(objFIAColumns);
		FeeCalculateParameter objCalcFeeParameter = transferToFeeCalParam(objFIAColumns);
		ChannelSearch objChannelSearch = new ChannelSearch();
		List<ChannelSearchResult> listResults = objChannelSearch.searchChannels(objFPCondition, objCalcFeeParameter);
		if (listResults == null || listResults.size() < 1)
			return;
		for (int i = 0; i < listResults.size(); i++) {
			ChannelSearchResult objCSR = listResults.get(i);
			if (objCSR.getOptimalsign().equals("Y")) {
				objFIAColumns.setChncode_Cwspchn(objCSR.getChncode());
				objFIAColumns.setCwserverchargeweight(new BigDecimal(objCSR.getChargeweight()));
				objFIAColumns.setCwtransferchargeweight(new BigDecimal(objCSR.getChargeweight()));
				objFIAColumns.setCwtransfergrossweight(new BigDecimal(objCSR.getGrossweight()));
				objFIAColumns.setTransfervolumeweight(new BigDecimal("0"));
			}
		}
	}
	
	
	
	public static String buildEwbcode() throws Exception {
		BuildewbcodeseqQuery objBESQ = new BuildewbcodeseqQuery();
		List listResults = objBESQ.getResults();
		if (listResults == null || listResults.size() < 1)
			return "";
		BuildewbcodeseqColumns objBESC = (BuildewbcodeseqColumns)listResults.get(0);
		
		return DateFormatUtility.getCompactOnlyDateSysdate().substring(2) + StringUtility.buildLength(objBESC.getBuildewbseq(), 6);
	}
	
	
	public static List buildCargoinfo(PredictOrderColumnsEX objPOCEX,
			ForinputallColumns objFIAColumns) {
		List<CargoinfoColumns> listCargoInfo = objPOCEX.getListCargoInfo();
		
		if (listCargoInfo == null || listCargoInfo.size() < 1) {
			objFIAColumns.setCtcode("ADOX");
			return listCargoInfo;
		}
		
		int i = 1;
		for (CargoinfoColumns objCargoinfoColumns : listCargoInfo) {
			// 品名中明确标明为文件时，需设置运单的货物类型为文件
			if (objCargoinfoColumns.getCiciename().indexOf("DOC") >= 0)
				objFIAColumns.setCtcode("ADOX");
			String strCipieces = objCargoinfoColumns.getCicipieces();
			String strCiunitprice = objCargoinfoColumns.getCiciunitprice();
			if (StringUtility.isNull(strCipieces))
				strCipieces = "1";
			if (StringUtility.isNull(strCiunitprice))
				strCiunitprice = "0";
			objCargoinfoColumns.setCicomp_idciid(i);
			i++;
			objCargoinfoColumns.setCicitotalprice(new BigDecimal(strCipieces).multiply(new BigDecimal(strCiunitprice)));
	   }
		return listCargoInfo;
	}	
	
	
	
	public static List buildPiecesinfo(PredictOrderColumnsEX objPOCEX) {
		// 预报数据中包含有件信息数据则直接返回
//		if (objPOCEX.getListPieces() != null && 
//				objPOCEX.getListPieces().size() > 0)
//			return objPOCEX.getListPieces();
//		// 否则默认只有1件
		PredictwaybillColumns objWFPC = objPOCEX.getPredictwaybillColumns();
		int iPieces = 1;
		if (StringUtility.isNull(objWFPC.getPwbpwb_chargeweight()))
			objWFPC.setPwbpwb_chargeweight("0.5");
		List<CorewaybillpiecesColumns> listPiecesColumns = new ArrayList<CorewaybillpiecesColumns>();
		for (int i = 0; i < iPieces; i++) {
			CorewaybillpiecesColumns objCWPColumns = new CorewaybillpiecesColumns();
			objCWPColumns.setCpcomp_idcpid(i);
			//objCWPColumns.setCpcomp_idcwcode(Long.parseLong(objHWColumns.getHwcwcode()));
			if (i == 0) 
				objCWPColumns.setCpcpgrossweight(new BigDecimal(objWFPC.getPwbpwb_chargeweight()));
			else
				objCWPColumns.setCpcpgrossweight(new BigDecimal("0"));
			objCWPColumns.setCpcpheight(new BigDecimal("0"));
			objCWPColumns.setCpcpwidth(new BigDecimal("0"));
			objCWPColumns.setCpcplength(new BigDecimal("0"));
			listPiecesColumns.add(objCWPColumns);
		}
		return listPiecesColumns;
	}	
	
	
	
	public static PredictwaybillColumns loadForPredict(String strCwcode) throws Exception {
		if (StringUtility.isNull(strCwcode))
			return null;
		PredictwaybillCondition objWFPCondition = new PredictwaybillCondition();
		objWFPCondition.setCwcode(strCwcode);
		List listResults = PredictwaybillDemand.query(objWFPCondition);
		if(listResults == null || listResults.size() < 1)
			return null;
		return (PredictwaybillColumns)listResults.get(0);
	}	
	
	public  static String getPwbcodeByCwcode(String cwcode) throws Exception{
		PredictwaybillQuery query = new PredictwaybillQuery();
		query.setCwcode(cwcode);
		List<PredictwaybillColumns> list = (List<PredictwaybillColumns>) query.getResults();
		if(list.size() == 1)
		    return list.get(0).getPwbpwb_code();
		else 
			return null;
	}    
	
	public static List queryByOrderid(String strOrderid) throws Exception{
		PredictwaybillQuery objPWBQuery = new PredictwaybillQuery();
		objPWBQuery.setPwb_orderid(strOrderid);
		return objPWBQuery.getResults();
	}
}
