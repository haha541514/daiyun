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
	 * �������������
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
	 * ��Excel��һ������ת���ɱ�׼�к�ֵ��PredictwaybillColumns
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
			// ���Ծɵ�Ԥ�����ֶ�
			if ("W".equals(objPTVColumns.getTctccolumntype())
					&& !strColumnEname.startsWith("Hw")
					&& !strColumnEname.startsWith("Ci"))
				objIMT.setValue(strColumnEname, objPWBColumns, cellValue);
			else if (objPTVColumns.getTctccolumntype().equals("C")) { // ������Ϣ
				int iActualIndex = Integer.parseInt(objPTVColumns.getTctccolumngroup());
				if (iActualIndex != iCargoGroupIndex) {
					iCargoGroupIndex = iActualIndex;
					iCargoGroupID = 0;
					cargoinfoColumnsList.add(objCargoinfoColumns);
				}
				if (iCargoGroupIndex == iActualIndex && 
						iCargoGroupID == 0) {
					objCargoinfoColumns = new PredictcargoinfoColumns();
					objCargoinfoColumns.setPcick_code("USD");//����
				}
				if (iCargoGroupIndex == iActualIndex)
					iCargoGroupID = iCargoGroupID + 1;
					
				objIMT.setValue(strColumnEname, 
						objCargoinfoColumns, 
						cellValue);			
			}
			
			// �ͻ��˵���תΪ��д
			if (!StringUtility.isNull(objPWBColumns.getPwbpwb_orderid()))
				objPWBColumns.setPwbpwb_orderid(objPWBColumns
						.getPwbpwb_orderid().toUpperCase());
			if (!StringUtility.isNull(objPWBColumns.getPwbpwb_serverewbcode()))
				objPWBColumns.setPwbpwb_serverewbcode(objPWBColumns
						.getPwbpwb_serverewbcode().toUpperCase());
		}
		// ���һ��Cargo���뵽List��
		if (objCargoinfoColumns != null)
			cargoinfoColumnsList.add(objCargoinfoColumns);
		predictColumnsEX.setListPredictcargoinfo(cargoinfoColumnsList);//���û�����Ϣ

		// �������ò�Ʒ�Լ���������
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
	 * ����У��
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
								+ objTC.getTctccolumnname() + "ֻ�������� ");
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
			objPCEX.setPromptinfo(StringUtility.nullToEmpty(objPCEX.getPromptinfo())+ objTC.getTctccolumnname() + "����Ϊ��  ");
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
						+ objTC.getTctccolumnname() + "��󳤶Ȳ��ܴ���" + iMaxLength);
				return false;
			}
			if (strActualValue.length() < iMinLength) {
				objPCEX.setPromptinfo(StringUtility.nullToEmpty(objPCEX
						.getPromptinfo())
						+ objTC.getTctccolumnname() + "��С���Ȳ���С��" + iMinLength);
				return false;
			}
		}
		return true;
	}

	public PredictOrderColumnsEX checkAll(PredictOrderColumnsEX objPCEX,
			String cocode) throws Exception {
		//List listStandardTemplate = DictionaryDemand.queryPwStandardTemplate();
		if (listStandardTemplate == null || listStandardTemplate.size() < 1) {
			objPCEX.setPromptinfo("��׼ģ�廹û������");
			return objPCEX;
		}
		// �����ĳ���У��
		checkBases(objPCEX, listStandardTemplate);

		String stPkcode = objPCEX.getPredictwaybillColumns().getPkpk_code();
		if (StringUtility.isNull(stPkcode)) {
			objPCEX.setPromptinfo("�޷�ͨ������Ч�飬�߻�����Ϊ�ջ��޷�ӳ��");
			return objPCEX;
		} else {
			List<ProductkindColumns> listProductKind = null;
			// Ч���Ʒ
			if (s_hmCoProductMap.containsKey(cocode))
				listProductKind = s_hmCoProductMap.get(cocode);
			else { 
				listProductKind = ProductkindDemand.getCanUseProduct(cocode, "719", "1");
				s_hmCoProductMap.put(cocode, listProductKind);
			}
			boolean isContainPk = false;			
			for (ProductkindColumns pkc : listProductKind) {
				// �����ϴ����������洫��pkcode��һ�£������ϴ���ʱ���õ��Ǽ�ƣ���������ֱ���õ���pkcode
				if (stPkcode.equals(pkc.getPkpkename())
						|| stPkcode.equals(pkc.getPkpkcode())) {
					objPCEX.getPredictwaybillColumns().setPkpk_code(
							pkc.getPkpkcode());
					isContainPk = true;
					break;
				}
			}
			if (!isContainPk) {
				objPCEX.setPromptinfo("�޷�ͨ������Ч�飬�߻�����������˾δ��ͨ���߻�����");
				return objPCEX;
			}
		}
		// �������Ƿ��ظ�У��
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
	 * �����ݿ��м��ͻ��������Ƿ��ظ�
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
				return "ϵͳ�Ѿ�������ͬ�Ķ����Ų����Ѿ���ӡ��Label";
			}
			if (columns.getPwbspwbs_code().equals("CHU")) {
				objPOCEX.setOpermode("OVVRIDE|MERGE");
				return "ϵͳ�Ѿ�������ͬ�Ķ����Ų����Ѿ��걨";
			}
			if (columns.getPwbspwbs_code().equals("SI")
					|| columns.getPwbspwbs_code().equals("IP")
					|| columns.getPwbspwbs_code().equals("SO")) {
				return "ϵͳ�Ѿ�������ͬ�Ķ����Ų�����˾��ȷ���ջ���ϵͳ���Ὣ�ⲿ�ֶ��������ϴ�";
			}
			if (columns.getPwbspwbs_code().equals("CTS")) {
				objPOCEX.setOpermode("OVVRIDE|MERGE");
				if (columns.getPwbpwb_consigneename() != null
						&& pwbColumns.getPwbpwb_consigneename() != null
						&& pwbColumns.getPwbpwb_consigneename().equals(
								columns.getPwbpwb_consigneename()))
					return "ϵͳ�Ѿ�������ͬ�Ķ����Ŷ����ռ������ظ���ϵͳ�еĶ���Ϊ�Ƶ��ݴ�״̬";
				else
					return "ϵͳ�Ѿ�������ͬ�Ķ����Ų���Ϊ�Ƶ��ݴ�״̬";
			}
		}
		return "";
	}
}
