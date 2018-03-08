package com.daiyun.sfweb.action;

import java.io.File;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;
import net.sf.json.JSONObject;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import com.daiyun.util.TimeUtil;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.CollectionUtility;
import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.billing.receivable.da.ReceivableColumns;
import kyle.leis.eo.billing.receivable.dax.ReceivableDemand;
import kyle.leis.eo.operation.housewaybill.da.WaybillforbillColumns;
import kyle.leis.eo.operation.housewaybill.da.WaybillforbillCondition;
import kyle.leis.eo.operation.housewaybill.dax.HousewaybillDemand;

/**
 *费用查询
 * */
public class CostAction extends ActionSupportEX {
	
	private static final long serialVersionUID = 1L;

	/**
	 * 费用查询
	 * @throws Exception 
	 * */
	@SuppressWarnings("unchecked")
	public String CostOFQuery() throws Exception{
	
		String cocode = (String)session.getAttribute("Cocode");
		String cw_customerewbcode =  request.getParameter("cw_customerewbcode");//客户单号
		String cw_serverewbcode = request.getParameter("cw_serverewbcode");//服务商单号
		String cw_ewbcode = request.getParameter("cw_ewbcode");//公司单号
		String cws_code = request.getParameter("Cwscwscode");//运单状态
		String payment = (String)request.getAttribute("payment");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		//String ddt_code = request.getParameter("ddt_code");//目的城市
		
		WaybillforbillCondition objWBFBCondition = new WaybillforbillCondition();
		//WaybillforexportCondition objWBFBCondition = new WaybillforexportCondition();
		if(!StringUtility.isNull(cw_customerewbcode)){
			objWBFBCondition.setCw_customerewbcode(cw_customerewbcode);
			request.setAttribute("cw_customerewbcode", cw_customerewbcode);
		}
		if(!StringUtility.isNull(cw_serverewbcode)){
			objWBFBCondition.setCw_serverewbcode(cw_serverewbcode);
			request.setAttribute("cw_serverewbcode", cw_serverewbcode);
		}
		if(!StringUtility.isNull(cws_code)){
			objWBFBCondition.setCws_code(cws_code);
			request.setAttribute("cws_code", cws_code);
		}
		if(!StringUtility.isNull(startdate)){
			objWBFBCondition.setStartadddate(startdate);
			request.setAttribute("startdate", startdate);
		}else{
			objWBFBCondition.setStartadddate(TimeUtil.getWeekStartTime());
			request.setAttribute("startdate",TimeUtil.getWeekStartTime());
		}
		if(!StringUtility.isNull(enddate)){
			objWBFBCondition.setEndadddate(enddate);
			request.setAttribute("enddate", enddate);
		}else{
			objWBFBCondition.setEndadddate(TimeUtil.getWeekEndTime());
			request.setAttribute("enddate",TimeUtil.getWeekEndTime());
		}
		
		
		if(!StringUtility.isNull(cw_ewbcode)){
			objWBFBCondition.setCw_ewbcode(cw_ewbcode);
			request.setAttribute("cw_ewbcode", cw_ewbcode);
		}
		if(!StringUtility.isNull(payment)){
			objWBFBCondition.setPm_code(payment);
		}
		objWBFBCondition.setCo_code_customer(cocode);
		objWBFBCondition.setCws_code("SI,IP,SO");//收货状态的订单
		List<WaybillforbillColumns> objList = (List<WaybillforbillColumns>)HousewaybillDemand.queryForBill(objWBFBCondition);
		session.setAttribute("listWaybillforbillColumns", objList);
		request.setAttribute("objList", objList);
		request.setAttribute("costvalue", 1);//界面切换
		return SUCCESS;
	}
	/**
	 * 费用管理
	 * @throws Exception 
	 * */
	public String CostOFManager() throws Exception{
		String customerewbcode = request.getParameter("customerewbcode");
		String cwCw_code = request.getParameter("cwcode");
		String cocode = (String)session.getAttribute("Cocode");
		if(customerewbcode == null){
			request.setAttribute("costvalue", 2);//界面切换
			return SUCCESS;
		}
		WaybillforbillCondition objWBFBCondition = new WaybillforbillCondition();
		objWBFBCondition.setCw_customerewbcode(customerewbcode);
		objWBFBCondition.setCo_code_customer(cocode);
		objWBFBCondition.setCws_code("SI,IP,SO");//收货状态的订单
		List<WaybillforbillColumns> ListWaybillforbillColumns = (List<WaybillforbillColumns>)HousewaybillDemand.queryForBill(objWBFBCondition);
		if(!CollectionUtility.isNull(ListWaybillforbillColumns)){
			WaybillforbillColumns waybillforbillColumns = ListWaybillforbillColumns.get(0);
			request.setAttribute("objWaybillforbillColumns", waybillforbillColumns);
		}
		//查询费用
		if(!StringUtility.isNull(cwCw_code)){			
			List<ReceivableColumns> resturnlist = (List<ReceivableColumns>)ReceivableDemand.load(cwCw_code);
			if(!CollectionUtility.isNull(resturnlist)){
				request.setAttribute("receiveList", resturnlist);												
			}
		}
		request.setAttribute("costvalue", 2);//界面切换
		return SUCCESS;
	}
	
	
	/**
	 * 导出费用查询
	 * +显示费用明细
	 * @throws Exception 
	 * */
	@SuppressWarnings("unchecked")
	public void exportCostExcel() throws Exception{
		List<WaybillforbillColumns> listWaybillforbillColumns = (List<WaybillforbillColumns>) session.getAttribute("listWaybillforbillColumns");
		if(CollectionUtility.isNull(listWaybillforbillColumns)){
			response.getWriter().print("N");
			return ;
		}
		String xlsName =  DateFormatUtility.getFileNameSysdate() + "_CostOfQuery.xls";
		String outputFile = request.getRealPath("/export_excel/" + xlsName);
		// 创建一新excel工作簿
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet("Sheet1");
		
		for(int index = 0 ; index < 27 ; index++){
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
		// 在索引0位置创建行(第一行)
		HSSFRow row = sheet.createRow((short) 0);
		HSSFCell [] cells = new HSSFCell[27];
		for(int index = 0 ; index < 27 ; index++){
			cells[index] = row.createCell((short) index);
			cells[index].setCellType(HSSFCell.CELL_TYPE_STRING);
		}
		cells[0].setCellValue("分拨中心");
		cells[1].setCellValue("收货时间");
		cells[2].setCellValue("运单状态");
		cells[3].setCellValue("客户运单号");
		cells[4].setCellValue("服务商单号");
		cells[5].setCellValue("公司运单号");
		cells[6].setCellValue("件数");
		cells[7].setCellValue("计费重");
		cells[8].setCellValue("实重");
		cells[9].setCellValue("收货国家");
		cells[10].setCellValue("提货点");
		cells[11].setCellValue("付费模式");
		cells[12].setCellValue("到货主单");
		cells[13].setCellValue("应收费用(HKD)");
		cells[14].setCellValue("应收费用(RMB)");
		cells[15].setCellValue("应收费用 (USD)");
		cells[16].setCellValue("运费");
		cells[17].setCellValue("币种");
		
		cells[18].setCellValue("燃油费");
		cells[19].setCellValue("币种");
		cells[20].setCellValue("挂号费");
		cells[21].setCellValue("币种");
		
		cells[22].setCellValue("操作费");
		cells[23].setCellValue("币种");
		cells[24].setCellValue("杂费项目");
		cells[25].setCellValue("杂费金额(RMB)");
		cells[26].setCellValue("本币为合计(RMB)");
		
		Iterator iter = listWaybillforbillColumns.iterator();
		int temp = 0;
		HSSFCell [] hssfcell =  new HSSFCell[27];
		while (iter.hasNext()) {
			++temp;
			row = sheet.createRow((short) temp);
			WaybillforbillColumns objWaybillforbillColumns = (WaybillforbillColumns) iter.next();
			for(int index = 0 ; index < 27 ; index++){
				hssfcell[index] = row.createCell((short) index);
				hssfcell[index].setCellType(HSSFCell.CELL_TYPE_STRING);
				hssfcell[index].setCellType(HSSFCell.ENCODING_UTF_16);
			}
			
			hssfcell[0].setCellValue(objWaybillforbillColumns.getEeee_sname());
			hssfcell[1].setCellValue(objWaybillforbillColumns.getBwadd_date());
			hssfcell[2].setCellValue(objWaybillforbillColumns.getCwscws_name());
			hssfcell[3].setCellValue(objWaybillforbillColumns.getCwcw_customerewbcode());
			hssfcell[4].setCellValue(objWaybillforbillColumns.getCwcw_serverewbcode());
			hssfcell[5].setCellValue(objWaybillforbillColumns.getCwcw_ewbcode());
			hssfcell[6].setCellValue(objWaybillforbillColumns.getCwcw_pieces());
			hssfcell[7].setCellValue(objWaybillforbillColumns.getCwcw_grossweight());
			hssfcell[8].setCellValue(objWaybillforbillColumns.getCwcw_chargeweight());
			hssfcell[9].setCellValue(objWaybillforbillColumns.getSdtdt_hubcode());
			hssfcell[10].setCellValue(objWaybillforbillColumns.getOdtdt_hubcode());
			hssfcell[11].setCellValue(objWaybillforbillColumns.getPmpm_name());
			hssfcell[12].setCellValue(objWaybillforbillColumns.getBwbw_labelcode());
			hssfcell[13].setCellValue(objWaybillforbillColumns.getRvtotal());
			hssfcell[14].setCellValue(objWaybillforbillColumns.getRvrmbtotal());
			hssfcell[15].setCellValue(objWaybillforbillColumns.getRvusdtotal());
			//查询杂费项目并输出
			JSONObject jsonFee = getFeeName(objWaybillforbillColumns.getCwcw_code(),objWaybillforbillColumns.getCwcw_customerewbcode(),objWaybillforbillColumns.getCoco_code());
			hssfcell[16].setCellValue(jsonFee.optString("YunFee"));
			hssfcell[17].setCellValue(jsonFee.optString("YunFeeCkname"));
			hssfcell[18].setCellValue(jsonFee.optString("OilFee"));
			hssfcell[19].setCellValue(jsonFee.optString("OilCkname"));
			hssfcell[20].setCellValue(jsonFee.optString("GuahaoFee"));
			hssfcell[21].setCellValue(jsonFee.optString("GuahaoFeeCkname"));
			hssfcell[22].setCellValue(jsonFee.optString("CaozuoFee"));
			hssfcell[23].setCellValue(jsonFee.optString("CaozuoFeeCkname"));
			hssfcell[24].setCellValue(jsonFee.optString("ZaFeename"));//杂费项目
			hssfcell[25].setCellValue(jsonFee.optString("incidentfee"));
			hssfcell[26].setCellValue(jsonFee.optString("Allfee"));		//本币为合计			
		}
		File path = new File(outputFile);
		path.delete();
		FileOutputStream fout = new FileOutputStream(outputFile);
		workbook.write(fout);
		fout.flush();
		fout.close();
		response.getWriter().print(xlsName);
	}
	
	/**
	 * @return 
	 * @throws Exception 
	 * 得到各种费用并计算乘以汇率后的RMB金额
	 * */
	public  JSONObject getFeeName(String cwCw_code,String customerewbcode,String cocode) throws Exception{
		BigDecimal incidentfee = new BigDecimal("0").setScale(3);
		BigDecimal Allfee = new BigDecimal("0").setScale(3);
		WaybillforbillCondition objWBFBCondition = new WaybillforbillCondition();
		objWBFBCondition.setCw_customerewbcode(customerewbcode);
		objWBFBCondition.setCo_code_customer(cocode);
		objWBFBCondition.setCws_code("SI,IP,SO");//收货状态的订单
		//查询费用
		JSONObject json = new JSONObject();
		String	ZaFeename = "";
	
		if(!StringUtility.isNull(cwCw_code)){			
			List<ReceivableColumns> resturnlist = (List<ReceivableColumns>)ReceivableDemand.load(cwCw_code);
			
			if(!CollectionUtility.isNull(resturnlist)){
			
				for(ReceivableColumns columns:resturnlist){//求出杂费项目名字
				
					if("A0101".equals(columns.getFkfkcode())){
						String YunFee = columns.getRvrvactualtotal();
						Allfee = Allfee.add(new BigDecimal(YunFee)).multiply(new BigDecimal(columns.getRvrvcurrencyrate()));
						json.accumulate("YunFee", YunFee);
						json.accumulate("YunFeeCkname", columns.getCkckname());
					}else if("A0102".equals(columns.getFkfkcode())){
						String OilFee = columns.getRvrvactualtotal();
						Allfee = Allfee.add(new BigDecimal(OilFee)).multiply(new BigDecimal(columns.getRvrvcurrencyrate()));
						json.accumulate("OilFee", OilFee);
						json.accumulate("OilCkname", columns.getCkckname());
					}else if("A1006".equals(columns.getFkfkcode())){
						String GuahaoFee = columns.getRvrvactualtotal();
						Allfee = Allfee.add(new BigDecimal(GuahaoFee)).multiply(new BigDecimal(columns.getRvrvcurrencyrate()));
						json.accumulate("GuahaoFee", GuahaoFee);
						json.accumulate("GuahaoFeeCkname", columns.getCkckname());
					}else if("A1023".equals(columns.getFkfkcode())){
						String CaozuoFee = columns.getRvrvactualtotal();
						Allfee = Allfee.add(new BigDecimal(CaozuoFee)).multiply(new BigDecimal(columns.getRvrvcurrencyrate()));
						json.accumulate("CaozuoFee", CaozuoFee);
						json.accumulate("CaozuoFeeCkname", columns.getCkckname());
					}else{
						if(columns.getRvrvactualtotal() != null && columns.getRvrvactualtotal() !="" ){
							ZaFeename += columns.getRvrvactualtotal()+columns.getCkckcode()+",";
							incidentfee = incidentfee.add((new BigDecimal(columns.getRvrvactualtotal())).multiply(new BigDecimal(columns.getRvrvcurrencyrate())));
							json.accumulate("ZaFeename", ZaFeename);
							json.accumulate("incidentfee", incidentfee.toString());
						}
					}
				}
				json.accumulate("Allfee", Allfee.toString());
			}
		}
		
		return json;
	}
	
	
	
	
	
}