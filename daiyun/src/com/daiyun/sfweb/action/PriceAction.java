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
	 * 查询价格 
	 * 
	 * */
	public String Price_Query() throws Exception {
		String coCode = (String) session.getAttribute("Cocode");
		String dtCode = request.getParameter("dtCode");// 收货点
		String pkCode = request.getParameter("pkCode");// 物流渠道
		String pmpmcode = request.getParameter("pmpmcode");// 付费方式
	
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
		condition.setPscode("R");//发布状态
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
		// 查询客户名称
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
	 * 价格管理
	 *
	 * */
	@SuppressWarnings("unchecked")
	public String Price_Manage() throws Exception {

		String strEpcode = request.getParameter("epcode");
		if (strEpcode != null) {
			LoadResult objLoadResult = FreightPriceDemand.load(strEpcode);
			
			List<FreightpricevalueColumns> freightValueColumns = objLoadResult.getFreightValueColumns();
			List freightPriceColumns = objLoadResult.getFreightPriceColumns();// 运费值
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
	 *  导出 
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
		// 创建一新excel工作簿
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet("Sheet1");
	
		for (int index = 0; index < length; index++) {
			sheet.setColumnWidth(index, 3000);
		}
		// 设置字体
		HSSFFont font = workbook.createFont();
		font.setFontName("Verdana");
		font.setBoldweight((short) 100);
		font.setFontHeight((short) 300);
		font.setColor(HSSFColor.BLUE.index);
		// 设置单元格格式
		HSSFCellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
		// 设置边框
		cellStyle.setBottomBorderColor(HSSFColor.RED.index);
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		// 设置字体
		cellStyle.setFont(font);
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);
		cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		
		//设计表头
		HSSFRow row0 = sheet.createRow(0);
		HSSFCell[] cell0 = new HSSFCell[8];
		for (int index = 0; index < 8; index++) {
			cell0[index] = row0.createCell((short) index);
			cell0[index].setCellType(HSSFCell.CELL_TYPE_STRING);
		}
		cell0[0].setCellValue("销售产品");
		cell0[1].setCellValue(columns.getPkpkname());
		cell0[2].setCellValue("快件类型");
		cell0[3].setCellValue(columns.getCtctname());
		cell0[4].setCellValue("付款方式");
		cell0[5].setCellValue(columns.getPmpmname());
		cell0[6].setCellValue("价格编码");
		cell0[7].setCellValue(columns.getFpepcode());
		HSSFRow row1 = sheet.createRow(1);
		HSSFCell[] cell1 = new HSSFCell[6];
		for (int index = 0; index < 6; index++) {
			cell1[index] = row1.createCell((short) index);
			cell1[index].setCellType(HSSFCell.CELL_TYPE_STRING);
		}
		cell1[0].setCellValue("生效日期");
		cell1[1].setCellValue(columns.getEpepstartdate());
		cell1[2].setCellValue("失效日期");
		cell1[3].setCellValue(columns.getEpependdate());
		cell1[4].setCellValue("分区名称");
		cell1[5].setCellValue(columns.getZnznname());
		HSSFRow row2 = sheet.createRow(2);
		HSSFCell[] cell2 = new HSSFCell[6];
		for (int index = 0; index < 6; index++) {
			cell2[index] = row2.createCell((short) index);
			cell2[index].setCellType(HSSFCell.CELL_TYPE_STRING);
		}
		cell2[0].setCellValue("币种");
		cell2[1].setCellValue(columns.getCkckname());
		cell2[2].setCellValue("单位");
		cell2[3].setCellValue(columns.getUtutname());
		cell2[4].setCellValue("收货点");
		cell2[5].setCellValue(columns.getDtdtname());
		
		// 在索引0位置创建行(第一行)
		HSSFRow row = sheet.createRow((short) 4);
		HSSFCell[] cells = new HSSFCell[length];
		for (int index = 0; index < length; index++) {
			cells[index] = row.createCell((short) index);
			cells[index].setCellType(HSSFCell.CELL_TYPE_STRING);
		}
		//表头
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
	 * 构建map key
	 * @throws Exception 
	 * */
	public List<List<String>> CreateTableHead(String zn_zncode) throws Exception{
		//构建表头
		List<List<String>> list = new ArrayList<List<String>>();
		List<ZonevalueColumns> znZnList = ZoneDemand.loadZoneValue(zn_zncode);//查询分区
		List<String> tablehead = new ArrayList<String>();
		List<String> tablehead2 = new ArrayList<String>();
		tablehead.add("重量值");
		tablehead.add("运费类型");
		tablehead.add("总量单位");
		tablehead2.add("重量值");
		tablehead2.add("运费类型");
		tablehead2.add("总量单位");
		for(ZonevalueColumns column :znZnList){
			tablehead.add(column.getZnvcomp_idznvid());
			tablehead2.add(column.getZnvznvname());

		}
		list.add(tablehead);
		list.add(tablehead2);
		return list;
	}
	

	/**
	 * 构建表数据
	 * 根据ZNV_ID来构建数据
	 * 每一行的一个columns对应一个FVT_CODE
	 * */
	public List<Map<String,String>> TransFreightvalue(List<FreightpricevalueColumns> objFreightpricevalueColumns,List<String> tablehead){
		//List<List<String>> list1 = new ArrayList<List<String>>();
	
		List<FreightpricevalueColumns> objList = objFreightpricevalueColumns;
		Set<String> set = new HashSet<String>();
		if(objList.size() > 0){
			for(int i = 0 ; i < objList.size() -1 ; i++){
				FreightpricevalueColumns columnsi = objList.get(i);
				set.add(columnsi.getFvtfvtcode());//获得所有的FVT_CODE
			}
		}
		Iterator<String> it =set.iterator();
		Map<String,List<FreightpricevalueColumns>> columnsMap = new HashMap<String,List<FreightpricevalueColumns>>();
		while(it.hasNext()){
			String fct_code = it.next();
			List<FreightpricevalueColumns> list = new ArrayList<FreightpricevalueColumns>(); 
			for(int i=  objList.size() -1; i >= 0 ; i--){//根据FVT_CODE,分组，确定每一行的ZNV_ID
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
				 	objmap.put("重量值",columns.getFpvfpvweightgrade());
				 	objmap.put("运费类型",columns.getFvtfvtname());
				 	objmap.put("总量单位",columns.getFpvfpvweightunit());
				
				for(int i = 0 ;i < list2.size() ; i++){//遍历FVT_CODE相同的list,取出对应的pricevalue值
					  FreightpricevalueColumns freightpricevalueColumns = list2.get(i);				
					  objmap.put(freightpricevalueColumns.getFpvznvid(), freightpricevalueColumns.getFpvfpvpricevalue());
				}
				objlist.add(objmap);
			}
			//将map转为list
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
