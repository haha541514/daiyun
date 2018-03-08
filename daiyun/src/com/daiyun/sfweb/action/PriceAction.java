package com.daiyun.sfweb.action;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.CollectionUtility;
import kyle.common.util.jlang.DateFormatUtility;
import kyle.leis.eo.billing.calculate.freight.bl.FreightSearch;
import kyle.leis.es.company.companys.da.CorporationdCondition;
import kyle.leis.es.company.companys.da.CorporationdQuery;
import kyle.leis.es.price.freightprice.da.FreightpriceColumns;
import kyle.leis.es.price.freightprice.da.FreightpriceCondition;
import kyle.leis.es.price.freightprice.da.FreightpricevalueColumns;
import kyle.leis.es.price.freightprice.dax.FreightPriceDemand;
import kyle.leis.es.price.freightprice.dax.LoadResult;
import kyle.leis.es.price.zone.da.ZonevalueColumns;
import kyle.leis.es.price.zone.dax.ZoneDemand;

/**
 * @date 2017/3/23
 * @author: wukq
 * @option: query Price
 * */
public class PriceAction extends ActionSupportEX {

	private static final long serialVersionUID = 1L;
	private FreightpriceColumns search;

	/** 
	 * ��ѯ�۸� 
	 * 
	 * */
	public String Price_Query() throws Exception {
		String coCode = (String) session.getAttribute("Cocode");
		String dtCode = request.getParameter("dtCode");// �ջ���
		String pkCode = request.getParameter("pkCode");// ��������
		String pmpmcode = request.getParameter("pmpmcode");// ���ѷ�ʽ
	
		String startdate = request.getParameter("startdate");
		String ctCtcode = request.getParameter("ctCtcode");
		FreightpriceCondition condition = new FreightpriceCondition();
	
		if (startdate != null) {
				if(!"".equals(request.getParameter("checkbox")) && request.getParameter("checkbox") != null){
					condition.setEpstartdate2(startdate);
					request.setAttribute("startdate", startdate);
				}
		}
		if(startdate != null){
			request.setAttribute("startdate", startdate);
		}else{
			request.setAttribute("startdate", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		}
		
		if (dtCode != null) {
			condition.setDtcode(dtCode);
			request.setAttribute("dtCode", dtCode);
		}
		condition.setPdcode("A02");
		condition.setPscode("R");//����״̬
		if (pmpmcode != null) {
			condition.setPmcode(pmpmcode);
			request.setAttribute("pmpmcode", pmpmcode);
		}
		if (pkCode != null) {
			condition.setPkcode(pkCode);
			request.setAttribute("pkCode", pkCode);
		}
		if (coCode != null) {
			condition.setCocode(coCode);
			request.setAttribute("coCode", coCode);
		}
		if (ctCtcode != null) {
			condition.setCtcode(ctCtcode);
			request.setAttribute("ctCtcode", ctCtcode);
		}
		
		FreightSearch serach = new FreightSearch();
		List<FreightpriceColumns> resultList = new ArrayList<FreightpriceColumns>();
		FreightpriceColumns objFreightpriceColumns =  serach.search(condition);
		resultList.add(objFreightpriceColumns);
		// ��ѯ�ͻ�����
		CorporationdQuery query = new CorporationdQuery();
		CorporationdCondition condtion = new CorporationdCondition();
		condtion.setCocode(coCode);
		query.setCondition(condition);
		kyle.leis.es.company.companys.da.CorporationdColumns columns = (kyle.leis.es.company.companys.da.CorporationdColumns) query
				.getResults().get(0);
		request.setAttribute("co_coname", columns.getCocosname());
		request.setAttribute("resultList", resultList);
		request.setAttribute("linkValue", 1);
		return SUCCESS;
	}

	/**
	 * �۸����
	 *
	 * */
	@SuppressWarnings("unchecked")
	public String Price_Manage() throws Exception {

		String strEpcode = request.getParameter("epcode");
		if (strEpcode != null) {
			LoadResult objLoadResult = FreightPriceDemand.load(strEpcode);
			
			List<FreightpricevalueColumns> freightValueColumns = objLoadResult.getFreightValueColumns();
			List freightPriceColumns = objLoadResult.getFreightPriceColumns();// �˷�ֵ
			FreightpriceColumns columns = (FreightpriceColumns) freightPriceColumns.get(0);
			List<List<String>>  objlist= CreateTableHead(columns.getZnzncode());
			List createTableHead =  objlist.get(0);
			List createTableHead2 =  objlist.get(1);
			List<Map<String,String>>  transFreightvalueList = (List<Map<String,String>>) TransFreightvalue(freightValueColumns,createTableHead);
	
			request.setAttribute("isexport", 1);
			request.setAttribute("createTableHead2", createTableHead2);
			request.setAttribute("transFreightvalueList", transFreightvalueList);
			request.setAttribute("columns", columns);
			session.setAttribute("transFreightvalueList", transFreightvalueList);
			session.setAttribute("createTableHead",createTableHead2);
			session.setAttribute("columns", columns);
		}
		request.setAttribute("linkValue", 2);
		return SUCCESS;
	}

	/**
	 * 
	 *  ���� 
	 * */
	public void exportPrice() throws Exception {
		List<String> createTableHead = (List<String>) session.getAttribute("createTableHead");
		List<Map<String,String>> list = (List<Map<String,String>>) session.getAttribute("transFreightvalueList");
		FreightpriceColumns columns = (FreightpriceColumns)session.getAttribute("columns");
		int length = createTableHead.size();
		if (CollectionUtility.isNull(list)) {
			return;
		}
		String xlsName = DateFormatUtility.getFileNameSysdate()
				+ "_PriceQuery.xls";
		String outputFile = request.getRealPath("/export_excel/" + xlsName);
		// ����һ��excel������
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet("Sheet1");
	
		for (int index = 0; index < length; index++) {
			sheet.setColumnWidth(index, 3000);
		}
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
		
		//��Ʊ�ͷ
		HSSFRow row0 = sheet.createRow(0);
		HSSFCell[] cell0 = new HSSFCell[8];
		for (int index = 0; index < 8; index++) {
			cell0[index] = row0.createCell((short) index);
			cell0[index].setCellType(HSSFCell.CELL_TYPE_STRING);
		}
		cell0[0].setCellValue("���۲�Ʒ");
		cell0[1].setCellValue(columns.getPkpkname());
		cell0[2].setCellValue("�������");
		cell0[3].setCellValue(columns.getCtctname());
		cell0[4].setCellValue("���ʽ");
		cell0[5].setCellValue(columns.getPmpmname());
		cell0[6].setCellValue("�۸����");
		cell0[7].setCellValue(columns.getFpepcode());
		HSSFRow row1 = sheet.createRow(1);
		HSSFCell[] cell1 = new HSSFCell[6];
		for (int index = 0; index < 6; index++) {
			cell1[index] = row1.createCell((short) index);
			cell1[index].setCellType(HSSFCell.CELL_TYPE_STRING);
		}
		cell1[0].setCellValue("��Ч����");
		cell1[1].setCellValue(columns.getEpepstartdate());
		cell1[2].setCellValue("ʧЧ����");
		cell1[3].setCellValue(columns.getEpependdate());
		cell1[4].setCellValue("��������");
		cell1[5].setCellValue(columns.getZnznname());
		HSSFRow row2 = sheet.createRow(2);
		HSSFCell[] cell2 = new HSSFCell[6];
		for (int index = 0; index < 6; index++) {
			cell2[index] = row2.createCell((short) index);
			cell2[index].setCellType(HSSFCell.CELL_TYPE_STRING);
		}
		cell2[0].setCellValue("����");
		cell2[1].setCellValue(columns.getCkckname());
		cell2[2].setCellValue("��λ");
		cell2[3].setCellValue(columns.getUtutname());
		cell2[4].setCellValue("�ջ���");
		cell2[5].setCellValue(columns.getDtdtname());
		
		// ������0λ�ô�����(��һ��)
		HSSFRow row = sheet.createRow((short) 4);
		HSSFCell[] cells = new HSSFCell[length];
		for (int index = 0; index < length; index++) {
			cells[index] = row.createCell((short) index);
			cells[index].setCellType(HSSFCell.CELL_TYPE_STRING);
		}
		//��ͷ
		for(int index = 0 ; index < length ; index++){
			cells[index].setCellValue(createTableHead.get(index));
		}
	
		int temp = 4;
		int size = list.size();
		HSSFCell[] hssfcell = new HSSFCell[5];
		for(int i  = 0 ; i < size ; i++ ){
			++temp;
			row = sheet.createRow((short) temp);
			Map<String,String> map = list.get(i);
			List<String> listvalue = new ArrayList<String>();
			Iterator objit = map.keySet().iterator();
			while(objit.hasNext()){
				String key = objit.next().toString();
				listvalue.add(map.get(key));
			}
			for (int index = 0; index < length; index++) {
				hssfcell[index] = row.createCell((short) index);
				hssfcell[index].setCellType(HSSFCell.CELL_TYPE_STRING);
				hssfcell[index].setCellType(HSSFCell.ENCODING_UTF_16);
			}
			for(int j = 0 ; j < listvalue.size() ; j++){
				hssfcell[j].setCellValue(listvalue.get(j));
			}
		
		}	
		
		File path = new File(outputFile);
		path.delete();
		FileOutputStream fout = new FileOutputStream(outputFile);
		workbook.write(fout);
		fout.flush();
		fout.close();
		response.getWriter().print(xlsName);
		return;
	}
	
	
	
	/**
	 * ����map key
	 * @throws Exception 
	 * */
	public List<List<String>> CreateTableHead(String zn_zncode) throws Exception{
		//������ͷ
		List<List<String>> list = new ArrayList<List<String>>();
		List<ZonevalueColumns> znZnList = ZoneDemand.loadZoneValue(zn_zncode);//��ѯ����
		List<String> tablehead = new ArrayList<String>();
		List<String> tablehead2 = new ArrayList<String>();
		tablehead.add("����ֵ");
		tablehead.add("�˷�����");
		tablehead.add("������λ");
		tablehead2.add("����ֵ");
		tablehead2.add("�˷�����");
		tablehead2.add("������λ");
		for(ZonevalueColumns column :znZnList){
			tablehead.add(column.getZnvcomp_idznvid());
			tablehead2.add(column.getZnvznvname());

		}
		list.add(tablehead);
		list.add(tablehead2);
		return list;
	}
	

	/**
	 * ����������
	 * ����ZNV_ID����������
	 * ÿһ�е�һ��columns��Ӧһ��FVT_CODE
	 * */
	public List<Map<String,String>> TransFreightvalue(List<FreightpricevalueColumns> objFreightpricevalueColumns,List<String> tablehead){
		//List<List<String>> list1 = new ArrayList<List<String>>();
	
		List<FreightpricevalueColumns> objList = objFreightpricevalueColumns;
		Set<String> set = new HashSet<String>();
		if(objList.size() > 0){
			for(int i = 0 ; i < objList.size() -1 ; i++){
				FreightpricevalueColumns columnsi = objList.get(i);
				set.add(columnsi.getFvtfvtcode());//������е�FVT_CODE
			}
		}
		Iterator<String> it =set.iterator();
		Map<String,List<FreightpricevalueColumns>> columnsMap = new HashMap<String,List<FreightpricevalueColumns>>();
		while(it.hasNext()){
			String fct_code = it.next();
			List<FreightpricevalueColumns> list = new ArrayList<FreightpricevalueColumns>(); 
			for(int i=  objList.size() -1; i >= 0 ; i--){//����FVT_CODE,���飬ȷ��ÿһ�е�ZNV_ID
				FreightpricevalueColumns columnsi = objList.get(i);
				if(fct_code.equals(columnsi.getFvtfvtcode())){
					list.add(columnsi);
				}
			}
			columnsMap.put(fct_code, list);
		}
		List<Map<String,String>> objlist = new ArrayList<Map<String,String>>();
	
		
			for(String str: columnsMap.keySet()){
				Map<String,String> objmap = (Map<String,String>)new ListOrderedMap();
				List<FreightpricevalueColumns> list2 = columnsMap.get(str);
				 FreightpricevalueColumns columns = list2.get(0);
				 for(int index = 0; index < tablehead.size(); index ++){
					 objmap.put(tablehead.get(index), null);
				 }
				 	objmap.put("����ֵ",columns.getFpvfpvweightgrade());
				 	objmap.put("�˷�����",columns.getFvtfvtname());
				 	objmap.put("������λ",columns.getFpvfpvweightunit());
				
				for(int i = 0 ;i < list2.size() ; i++){//����FVT_CODE��ͬ��list,ȡ����Ӧ��pricevalueֵ
					  FreightpricevalueColumns freightpricevalueColumns = list2.get(i);				
					  objmap.put(freightpricevalueColumns.getFpvznvid(), freightpricevalueColumns.getFpvfpvpricevalue());
				}
				objlist.add(objmap);
			}
			//��mapתΪlist
			/*List<String> listvalue = new ArrayList<String>();
			Iterator objit = objmap.keySet().iterator();
			while(objit.hasNext()){
				String key = objit.next().toString();
				listvalue.add(objmap.get(key));
			}
			list1.add(listvalue);*/
		
		return objlist;
	}
	
	
	
	
}
