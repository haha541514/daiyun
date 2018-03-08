package com.daiyun.predictwaybill;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kyle.common.util.jlang.ObjectGenerator;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.operation.cwbimportlog.bl.Cwbimportrow;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportrowColumns;
import kyle.leis.eo.operation.housewaybill.dax.PredictOrderCell;
import kyle.leis.eo.operation.housewaybill.dax.PredictOrderRow;
import kyle.leis.eo.operation.predictwaybill.da.PredictcargoinfoColumns;
import kyle.leis.eo.operation.predictwaybill.da.PredictwaybillColumns;
import kyle.leis.eo.operation.predictwaybill.da.PredictwaybillCondition;
import kyle.leis.eo.operation.predictwaybill.dax.PredictwaybillDemand;
import kyle.leis.es.company.predicttemplate.bl.IColumnMappingType;
import kyle.leis.es.company.predicttemplate.bl.cmt.ColumnmappingtypeFactory;
import kyle.leis.es.company.predicttemplate.da.PredicttemplatevalueColumns;
import kyle.leis.es.company.predicttemplate.dax.PredicttemplateDemand;
import kyle.leis.fs.dictionary.dictionarys.da.TemplatecolumnColumns;
import kyle.leis.fs.dictionary.dictionarys.dax.DictionaryDemand;
import kyle.leis.fs.dictionary.district.dax.DistrictDemand;
import kyle.leis.fs.dictionary.productkind.da.ProductkindColumns;
import kyle.leis.fs.dictionary.productkind.dax.ProductkindDemand;

public class PredictwaybillBaseCheck {

	private PredictOrderMap m_objPredictOrderMap;
	private List<PredictOrderColumnsEX> m_listFilterRepeatWaybill;
	private static Map<String, List<ProductkindColumns>> s_hmCoProductMap=null;
	private static List listStandardTemplate=null;
	public PredictwaybillBaseCheck() {
		if (s_hmCoProductMap == null)
			s_hmCoProductMap = new HashMap<String, List<ProductkindColumns>>();
		if(listStandardTemplate==null){
			try {
				listStandardTemplate=DictionaryDemand.queryPwStandardTemplate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void setPredictOrderMap(PredictOrderMap objPredictOrderMap) {
		m_objPredictOrderMap = objPredictOrderMap;
	}

	public List<PredictOrderColumnsEX> getFilterRepeatwaybill() {
		return m_listFilterRepeatWaybill;
	}

	/**
	 * 保存错误行数据
	 * 
	 * @param rowid
	 * @param remark
	 * @param logid
	 * @throws Exception
	 */
	public void saveCwbimportrowColumns(int rowid, String remark, String logid)
			throws Exception {
		CwbimportrowColumns cwbrColumns = new CwbimportrowColumns();
		cwbrColumns.setCwbrcomp_idcwbrid(Long.parseLong(rowid + ""));
		cwbrColumns.setCwbrcwbrsuccesssign("N");
		cwbrColumns.setCwbrcwbrremark(remark);
		cwbrColumns.setCwbrtopcwbimportlogcwlid(Long.parseLong(logid));
		new Cwbimportrow().saveRow(cwbrColumns);
	}

	/**
	 * 将Excel的一行数据转换成标准列后赋值给PredictwaybillColumns
	 * 
	 * @param row
	 * @param cocode
	 * @param opId
	 * @param strTemplate
	 * @return
	 * @throws Exception
	 */
	public PredictOrderColumnsEX RowToColumns( PredictOrderRow row,
			String cocode, String opId, String strTemplate) throws Exception {
		
		PredictOrderColumnsEX predictColumnsEX = new PredictOrderColumnsEX();
		List<PredictcargoinfoColumns> cargoinfoColumnsList = new ArrayList<PredictcargoinfoColumns>();
		Map<String, PredicttemplatevalueColumns> hmPredictColumns = PredicttemplateDemand.queryTemplatevalue(strTemplate);
		
		if (hmPredictColumns == null || hmPredictColumns.size() < 1){
			return predictColumnsEX;
		}
		PredictwaybillColumns objPWBColumns = new PredictwaybillColumns();
		
		objPWBColumns.setCoco_code(cocode);
		objPWBColumns.setDopop_id(opId);
		List<PredictOrderCell> cellList = row.getListPredictOrdercell();
		
		PredictcargoinfoColumns objCargoinfoColumns = null;
		int iCargoGroupIndex = 1;
		int iCargoGroupID = 0;
		
		for (PredictOrderCell cell : cellList) {
			
			String cellName = cell.getCellname().trim();
			String cellValue = StringUtility.isNull(cell.getCellvalue()) ? ""
					: cell.getCellvalue().trim();
			
			if (!hmPredictColumns.containsKey(cellName))
				continue;
			PredicttemplatevalueColumns objPTVColumns = hmPredictColumns.get(cellName);
			String strDmkcode = objPTVColumns.getDmkdmkcode();
			IColumnMappingType objIMT = ColumnmappingtypeFactory.createMappingtype(objPTVColumns.getCmtcmtcode());
			if (!StringUtility.isNull(strDmkcode)
					&& !StringUtility.isNull(cellValue))
				cellValue = PredicttemplateDemand.getMappingvalue(strTemplate,
						cellValue, strDmkcode);
			String strColumnEname = objPTVColumns.getTctccolumnename();
			if (StringUtility.isNull(strColumnEname)
					|| StringUtility.isNull(cellValue))
				continue;
			// 忽略旧的预报件字段
			if ("W".equals(objPTVColumns.getTctccolumntype())
					&& !strColumnEname.startsWith("Hw")
					&& !strColumnEname.startsWith("Ci"))
				objIMT.setValue(strColumnEname, objPWBColumns, cellValue);
			else if (objPTVColumns.getTctccolumntype().equals("C")) { // 货物信息
				int iActualIndex = Integer.parseInt(objPTVColumns.getTctccolumngroup());
				if (iActualIndex != iCargoGroupIndex) {
					iCargoGroupIndex = iActualIndex;
					iCargoGroupID = 0;
					cargoinfoColumnsList.add(objCargoinfoColumns);
				}
				if (iCargoGroupIndex == iActualIndex && 
						iCargoGroupID == 0) {
					objCargoinfoColumns = new PredictcargoinfoColumns();
					objCargoinfoColumns.setPcick_code("USD");//币种
				}
				if (iCargoGroupIndex == iActualIndex)
					iCargoGroupID = iCargoGroupID + 1;
					
				objIMT.setValue(strColumnEname, 
						objCargoinfoColumns, 
						cellValue);			
			}
			
			// 客户运单号转为大写
			if (!StringUtility.isNull(objPWBColumns.getPwbpwb_orderid()))
				objPWBColumns.setPwbpwb_orderid(objPWBColumns
						.getPwbpwb_orderid().toUpperCase());
			if (!StringUtility.isNull(objPWBColumns.getPwbpwb_serverewbcode()))
				objPWBColumns.setPwbpwb_serverewbcode(objPWBColumns
						.getPwbpwb_serverewbcode().toUpperCase());
		}
		// 最后一个Cargo加入到List中
		if (objCargoinfoColumns != null)
			cargoinfoColumnsList.add(objCargoinfoColumns);
		predictColumnsEX.setListPredictcargoinfo(cargoinfoColumnsList);//设置货物信息

		// 重新设置产品以及国家数据
		String strPkcode = "";
		ProductkindColumns objPKC = ProductkindDemand.queryBypkEname(objPWBColumns.getPkpk_code());
		if (objPKC != null)
			strPkcode = objPKC.getPkpkcode();
		if (StringUtility.isNull(strPkcode)) {
			objPKC = ProductkindDemand.queryBypkCode(objPWBColumns.getPkpk_code());
			if (objPKC != null)
				strPkcode = objPKC.getPkpkcode();
		}
		if (StringUtility.isNull(strPkcode)) {
			//strPkcode = "Y0001";
			strPkcode = "E0101";
		}
		objPWBColumns.setPkpk_code(strPkcode);
		String strSignInDtcode = DistrictDemand.getDtcodeByHubcode(objPWBColumns.getDtdt_code());
		objPWBColumns.setDtdt_code(strSignInDtcode);
		//
		predictColumnsEX.setPredictwaybillColumns(objPWBColumns);
		predictColumnsEX.setExcelRowIndex(row.getExcelRowIndex());
		
		return predictColumnsEX;
	}

	/**
	 * 基本校验
	 * 
	 * @param objPCEX
	 * @param listStandardTemplate
	 * @return
	 * @throws Exception
	 */
	private boolean checkBases(PredictOrderColumnsEX objPCEX,
			List listStandardTemplate) throws Exception {
		boolean isPassCheck = true;
		for (int i = 0; i < listStandardTemplate.size(); i++) {
			TemplatecolumnColumns objTC = (TemplatecolumnColumns) listStandardTemplate
					.get(i);
			String strColumnEname = objTC.getTctccolumnename();
			String strValue = "";
			if (objTC.getTctccolumntype().equals("W")
					&& !strColumnEname.startsWith("Hw")
					&& !strColumnEname.startsWith("Ci")) {
				strValue = ObjectGenerator.process("get" + strColumnEname,objPCEX.getPredictwaybillColumns(), null);
				if (!checkBases(objTC, strValue, objPCEX))
					isPassCheck = false;
				String[] mustNumberField = { "Pwbpwb_chargeweight",
						"Pwbpwb_cargopieces", "Pwbpwb_cargoamount" };
				if (Arrays.asList(mustNumberField).contains(strColumnEname)) {
					if (!StringUtility.isNull(strValue) && !isNumber(strValue)) {
						objPCEX.setPromptinfo(StringUtility.nullToEmpty(objPCEX
								.getPromptinfo())
								+ objTC.getTctccolumnname() + "只能是数字 ");
						isPassCheck = false;
					}
				}
			}
		}
		return isPassCheck;
	}

	private boolean checkBases(TemplatecolumnColumns objTC,
			String strActualValue, PredictOrderColumnsEX objPCEX) {
		if (objTC.getTctcallownullsign().equals("N") && StringUtility.isNull(strActualValue)) {
			objPCEX.setPromptinfo(StringUtility.nullToEmpty(objPCEX.getPromptinfo())+ objTC.getTctccolumnname() + "不能为空  ");
			return false;
		}
		if (!checkLength(strActualValue, objTC, objPCEX))
			return false;
		return true;
	}

	private boolean checkLength(String strActualValue,
			TemplatecolumnColumns objTC, PredictOrderColumnsEX objPCEX) {
		if (!StringUtility.isNull(strActualValue)) {
			int iMaxLength = Integer.parseInt(objTC.getTctcmaxlength());
			int iMinLength = Integer.parseInt(objTC.getTctcminlength());
			if (strActualValue.length() > iMaxLength) {
				objPCEX.setPromptinfo(StringUtility.nullToEmpty(objPCEX
						.getPromptinfo())
						+ objTC.getTctccolumnname() + "最大长度不能大于" + iMaxLength);
				return false;
			}
			if (strActualValue.length() < iMinLength) {
				objPCEX.setPromptinfo(StringUtility.nullToEmpty(objPCEX
						.getPromptinfo())
						+ objTC.getTctccolumnname() + "最小长度不能小于" + iMinLength);
				return false;
			}
		}
		return true;
	}

	public PredictOrderColumnsEX checkAll(PredictOrderColumnsEX objPCEX,
			String cocode) throws Exception {
		//List listStandardTemplate = DictionaryDemand.queryPwStandardTemplate();
		if (listStandardTemplate == null || listStandardTemplate.size() < 1) {
			objPCEX.setPromptinfo("标准模板还没有设置");
			return objPCEX;
		}
		// 基本的长度校验
		checkBases(objPCEX, listStandardTemplate);

		String stPkcode = objPCEX.getPredictwaybillColumns().getPkpk_code();
		if (StringUtility.isNull(stPkcode)) {
			objPCEX.setPromptinfo("无法通过基本效验，走货渠道为空或无法映射");
			return objPCEX;
		} else {
			List<ProductkindColumns> listProductKind = null;
			// 效验产品
			if (s_hmCoProductMap.containsKey(cocode))
				listProductKind = s_hmCoProductMap.get(cocode);
			else { 
				listProductKind = ProductkindDemand.getCanUseProduct(cocode, "719", "1");
				s_hmCoProductMap.put(cocode, listProductKind);
			}
			boolean isContainPk = false;			
			for (ProductkindColumns pkc : listProductKind) {
				// 批量上传跟订单保存传的pkcode不一致，批量上传的时候用的是简称，订单保存直接用的是pkcode
				if (stPkcode.equals(pkc.getPkpkename())
						|| stPkcode.equals(pkc.getPkpkcode())) {
					objPCEX.getPredictwaybillColumns().setPkpk_code(
							pkc.getPkpkcode());
					isContainPk = true;
					break;
				}
			}
			if (!isContainPk) {
				objPCEX.setPromptinfo("无法通过基本效验，走货渠道错误，我司未开通此走货渠道");
				return objPCEX;
			}
		}
		// 订单号是否重复校验
		/*String strRepeat = checkRepeatCustomerEWB(cocode, objPCEX);
		if (!StringUtility.isNull(strRepeat)) {
			objPCEX.setPromptinfo(strRepeat);
		}*/
		return objPCEX;
	}

	public boolean isNumber(String args) {
		String regex = "^[0-9]+([.]{1}[0-9]+){0,1}$";
		if (args.matches(regex))
			return true;
		else
			return false;
	}

	/**
	 * 从数据库中检查客户订单号是否重复
	 * 
	 * @param strCocode
	 * @param objPOCEX
	 * @return
	 * @throws Exception
	 */
	public String checkRepeatCustomerEWB(String strCocode,
			PredictOrderColumnsEX objPOCEX) throws Exception {
		PredictwaybillColumns pwbColumns = objPOCEX.getPredictwaybillColumns();
		PredictwaybillCondition objPWCondition = new PredictwaybillCondition();
		objPWCondition.setCo_code_customer(pwbColumns.getCoco_code());
		objPWCondition.setPwbs_code("CTS,CHU,CHP,SI,IP,SO");
		objPWCondition.setPwb_orderid(pwbColumns.getPwbpwb_orderid());
		List listResults = PredictwaybillDemand.query(objPWCondition);
		if (listResults != null && listResults.size() > 0) {
			PredictwaybillColumns columns = (PredictwaybillColumns) listResults
					.get(0);
			if (columns.getPwbspwbs_code().equals("CHP")) {
				objPOCEX.setOpermode("OVVRIDE|HOLD");
				return "系统已经存在相同的订单号并且已经打印了Label";
			}
			if (columns.getPwbspwbs_code().equals("CHU")) {
				objPOCEX.setOpermode("OVVRIDE|MERGE");
				return "系统已经存在相同的订单号并且已经申报";
			}
			if (columns.getPwbspwbs_code().equals("SI")
					|| columns.getPwbspwbs_code().equals("IP")
					|| columns.getPwbspwbs_code().equals("SO")) {
				return "系统已经存在相同的订单号并且我司已确认收货，系统不会将这部分订单重新上传";
			}
			if (columns.getPwbspwbs_code().equals("CTS")) {
				objPOCEX.setOpermode("OVVRIDE|MERGE");
				if (columns.getPwbpwb_consigneename() != null
						&& pwbColumns.getPwbpwb_consigneename() != null
						&& pwbColumns.getPwbpwb_consigneename().equals(
								columns.getPwbpwb_consigneename()))
					return "系统已经存在相同的订单号而且收件人名重复，系统中的订单为制单暂存状态";
				else
					return "系统已经存在相同的订单号并且为制单暂存状态";
			}
		}
		return "";
	}
}
