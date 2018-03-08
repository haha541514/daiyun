package com.daiyun.opweb.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.NumberUtility;
import kyle.common.util.jlang.ObjectGenerator;
import kyle.common.util.jlang.StringUtility;
import kyle.common.util.prompt.PromptUtilityCollection;
import kyle.leis.eo.operation.cargoinfo.da.CargoinfoColumns;
import kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand;
import kyle.leis.eo.operation.cwbimportlog.bl.Cwbimportlog;
import kyle.leis.eo.operation.cwbimportlog.bl.Cwbimportrow;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportlogColumns;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportlogCondition;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportlogQuery;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportrowColumns;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportrowQuery;
import kyle.leis.eo.operation.housewaybill.bl.PredictOrderEX;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictColumns;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictCondition;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictQuery;
import kyle.leis.eo.operation.housewaybill.dax.PredictOrderCell;
import kyle.leis.eo.operation.housewaybill.dax.PredictOrderColumnsEX;
import kyle.leis.eo.operation.housewaybill.dax.PredictOrderRow;
import kyle.leis.eo.operation.predictwaybill.bl.MergeOvvredePredicOrder;
import kyle.leis.eo.operation.predictwaybill.da.PredictwaybillColumns;
import kyle.leis.es.company.predicttemplate.da.PredictordertemplateColumns;
import kyle.leis.es.company.predicttemplate.da.PredicttemplatevalueColumns;
import kyle.leis.es.company.predicttemplate.dax.PredicttemplateDemand;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeColumns;
import kyle.leis.es.company.shipperconsignee.dax.ShipperconsigneeDemand;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.ServletActionContext;
import com.daiyun.dax.AllThreadPool;
import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;
import com.daiyun.util.ExcelUtil;
import com.daiyun.util.ExcelUtilEX;

public class UploadAction extends ActionSupportEX implements Runnable {

	private static final long serialVersionUID = 1L;
	private File uploadFile;
	private String uploadFileFileName;
//	private List<PredictOrderRow> table;
//	private String[] titles;
//	private final String upLoadFilePath = ServletActionContext.getServletContext().getRealPath("/download") + File.separator;
//	private InputStream downloadInput;
//	private String downloadFilename;
	public static final String RESULT_TITLENAME = "XS系统结果";
	public static final String OPTYPE_TITLENAME = "XS系统操作类型";
	public static final String REMARK_TITLENAME = "XS系统备注";
	public File getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(File uploadFile) {
		this.uploadFile = uploadFile;
	}

	public String getUploadFileFileName() {
		return uploadFileFileName;
	}

	public void setUploadFileFileName(String uploadFileFileName) {
		this.uploadFileFileName = uploadFileFileName;
	}

	//上传Excel表
	private String strPath;
	private String check;
	private String temple;
	private String strAllowrepeataddress;
	private String result ;
    
	public String uploadExcel() throws Exception {
	
		  strPath = request.getParameter("path");
		  check = request.getParameter("checkFalg");
		  temple = request.getParameter("templeName");
		  strAllowrepeataddress = request.getParameter("allowrepeataddress");
		 // uploadFileFileName = request.getParameter("uploadFile");
		  if(!StringUtility.isNull(check)){
			  check="checked";
		  }
		  if(!StringUtility.isNull(strAllowrepeataddress)){
			  strAllowrepeataddress="checked";
		  }
 
		  System.out.println(uploadFileFileName+strAllowrepeataddress+temple+check);
		//保存前查询是否设置了发件人,没有弹出提示框
		String strCocode = (String) session.getAttribute("Cocode");
		boolean ishavaconsigneename = IsSetConsigneename(strCocode);
		if(ishavaconsigneename == false){
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
					new MessageBean(IBasicData.MSG_TYPE_ERROR, "未设置发件人","请在查询发件人信息里设置发件人!"));
			return ERROR;
		}
	 
	

			
		run();//线程
	    if(result.equals("error")){		
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",new MessageBean(IBasicData.MSG_TYPE_ERROR, "数据读取失败","请检查上传文件的内容!"));
			return ERROR;
	    }
			 
		if(result.equals("success")){
			//PrintWriter out = response.getWriter();
			 
			String directory = "/download";
			String targerDirectory = ServletActionContext.getServletContext()
					.getRealPath(directory);
			// 生成上传文件的对象
			File target = new File(targerDirectory, uploadFileFileName);
			// 如果文件已存在，则删除原有文件
			if (target.exists()) {
				target.delete();
			}
			// 复制file对象，实现上传
			try {
				FileUtils.copyFile(uploadFile, target);
				//out.print("文件上传成功");
			} catch (IOException e) {
				ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
						new MessageBean(IBasicData.MSG_TYPE_ERROR, "文件生成失败","请检查上传文件是否为正确的Excel文件!"));
				return ERROR;
			}
			
			return SUCCESS;
		}else{
			 return ERROR;
		}
		
	}

 

	/**
	 * 将Excel表读取出来
	 * poi用来解析excel
	 * @param uploadFileFileName
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String loadRoleInfo(String uploadFileFileName,String templeCode,
			String checkFalg,String strPath, 
			String strAllowrepeatAddress) throws Exception {

//		String directory = "/download";
//		String targerDirectory = ServletActionContext.getServletContext()
//				.getRealPath(directory);
//		// 生成上传文件的对象
//		File target = new File(targerDirectory, uploadFileFileName);
		List<PredictOrderRow> listPredictOrderRow = new ArrayList<PredictOrderRow>();
		FileInputStream fis = new FileInputStream(uploadFile);
		/*20160926,Start by wukq,兼容xlsx格式*/
		Workbook wb = null;
		Boolean ISExcel2003 = false;
		if (ExcelUtilEX.isExcel2003(uploadFileFileName)) {//如果是2003格式
			wb = new HSSFWorkbook(fis);
			ISExcel2003 = true;
		} else if(ExcelUtilEX.isExcel2007(uploadFileFileName)){//如果是2007格式
			wb = new XSSFWorkbook(fis);
			ISExcel2003 = false;
		}
		/*End*/
		
		/*20160927,Start by wukq*/
		int blankline = 0;	//空行记录
		Sheet sheet = wb.getSheetAt(0);
		int rowNum = sheet.getLastRowNum() + 1;
		for (int i = 1; i < rowNum; i++) {
			PredictOrderRow objPOR = new PredictOrderRow();
			Row row = sheet.getRow(i);
			Row firstRow = sheet.getRow(0);
			int cellNum = firstRow.getLastCellNum();
			
			
			if(ISExcel2003){
				HSSFRow  hssrow = (HSSFRow) sheet.getRow(i); 
				if(!ExcelUtil.isBlankRow2(hssrow,cellNum) || hssrow == null){
					blankline++;
					continue;
				}
			}else {
				XSSFRow  xssrow = (XSSFRow) sheet.getRow(i); 
				if(!ExcelUtilEX.isBlankRow2(xssrow,cellNum) || row == null){
					blankline++;
					continue;
				}
			}			
			for (int j = 0; j < cellNum; j++) {
				Cell cell = row.getCell(j);
				String cellValue = "";
				String columnsName = firstRow.getCell(j).toString();
				if (cell != null) {
					cellValue = cell.toString();
					if (!StringUtility.isNull(cellValue)) {
						cellValue = cellValue.trim();
						if (cellValue.indexOf("'") >= 0)
							cellValue = cellValue.replaceAll("'", " ");
					}
					/*20160926,Start by wukq*/
					if(cell.getCellType()== HSSFCell.CELL_TYPE_NUMERIC){
						 String str = cellValue.substring(cellValue.length()-2,cellValue.length());
						 if(str.equals(".0")){
							 cellValue = cellValue.substring(0,cellValue.length()-2);
						 }
						 cellValue = NumberUtility.toStandardstring(cellValue);
					}else if(cell.getCellType()== XSSFCell.CELL_TYPE_NUMERIC){
						 String str = cellValue.substring(cellValue.length()-2,cellValue.length());
						 if(str.equals(".0")){
							 cellValue = cellValue.substring(0,cellValue.length()-2);
						 }
						 cellValue = NumberUtility.toStandardstring(cellValue);
					}	
					/*End*/
				}
				objPOR.put(columnsName, cellValue);
			}
			listPredictOrderRow.add(objPOR);
		}
        //是否合并重复订单
		Boolean falg = false;
		if(!StringUtility.isNull(checkFalg)){
			falg = true;
		}
		
		boolean isAllowRepeatAddress = false;
		if(!StringUtility.isNull(strAllowrepeatAddress)){
			isAllowRepeatAddress = true;
		}		
		
		//模板类型
		PredictOrderEX objPOEX = new PredictOrderEX();
		String strCocode = (String) session.getAttribute("Cocode");
		String strOpid = (String) session.getAttribute("OpId");
		session.setAttribute("number2","120");	
		
		objPOEX.save(strCocode, templeCode, 
				listPredictOrderRow,strOpid,strPath,
				falg, isAllowRepeatAddress);//保存数据地方法
		//获取保存成功的数据.
		//网页直接迭代list
		List<PredictOrderColumnsEX> savelist = objPOEX.getSavedSeccess(strCocode);		
										
		Map<String, List<PredictOrderColumnsEX>> map = objPOEX.getSavedPromptEWB(strCocode);	
		int totalSize = rowNum - 1 - blankline;//减去空行数据
		int errorSize = 0;
		for(String str:map.keySet()){
			List<PredictOrderColumnsEX> objList = map.get(str);
			errorSize = errorSize + objList.size();//map中包含客户返回的错误信息	 
		}
		int normalSize = objPOEX.getSavedNormalSize(strCocode);
		int megreSize = totalSize - normalSize - errorSize;
		megreSize = megreSize>=0 ? megreSize : 0 ;	//判断megerSize是否大于0，合并条数不能为负
		
		session.setAttribute("number3","200");	 
		
		session.setAttribute("hashMap", map);
		session.setAttribute("strPath", strPath);
		request.setAttribute("map", map);
		request.setAttribute("totalSize", totalSize);
		request.setAttribute("normalSize", normalSize);
		request.setAttribute("errorSize", errorSize);
		request.setAttribute("megreSize", megreSize);
		request.setAttribute("strPath", strPath);
		request.setAttribute("savelist", savelist);//上传成功的数据
		
		 int success=savelist.size();
		
		
		//如果转换标准模板成功，上传有错误，保存上传错误记录
		//保存日志主表				
		Cwbimportlog objCwbimportlog=new Cwbimportlog();
		if(success==0){
			CwbimportlogColumns cwbimport=objCwbimportlog.saveLog(strOpid,listPredictOrderRow.size(),errorSize,strPath,"上传错误");	
			String cwlId=cwbimport.getToccwlid();
			int a=1;
			for(int b=0;b<listPredictOrderRow.size();b++){
				PredictOrderRow pr=listPredictOrderRow.get(b);
				
			for(String str:map.keySet()){//map中包含客户返回的错误信息
				List<PredictOrderColumnsEX> objList = map.get(str);
				PredictOrderColumnsEX pec=objList.get(b);
				Cwbimportrow cwt=new Cwbimportrow();
				CwbimportrowColumns cws=new CwbimportrowColumns();
				cws.setCwbrcomp_idcwbrid(new Long(a++));
				cws.setCwbrtopcwbimportlogcwlid(new Long(cwlId));
				cws.setCwbrcwbrremark("客户单号："+pec.getWaybillforpredict().getCwcw_customerewbcode()+","+str);
				cws.setCwbrcwbrsuccesssign("N");
				cwt.saveRow(cws);
			} 
			}
		}else{
			CwbimportlogColumns cwbimport=objCwbimportlog.saveLog(strOpid,listPredictOrderRow.size(),0,strPath,"上传成功");	
			String cwlId=cwbimport.getToccwlid();
			int a=1;
			for(PredictOrderColumnsEX str:savelist){//LIST中包含客户成功的信息
				Cwbimportrow cwt=new Cwbimportrow();
				CwbimportrowColumns cws=new CwbimportrowColumns();
				cws.setCwbrcomp_idcwbrid(new Long(a++));
				cws.setCwbrtopcwbimportlogcwlid(new Long(cwlId));
				cws.setCwbrcwbrremark(str.getWaybillforpredict().getCwcw_serverewbcode());
				cws.setCwbrcwbrsuccesssign("C");
				cwt.saveRow(cws);
			} 
		}
		
		
		session.setAttribute("number4","250");	 
		//	保存行数据
		Map<String, PredicttemplatevalueColumns> hmPredictColumns = PredicttemplateDemand.queryTemplatevalue(templeCode);
		List<PredictOrderCell> listCells = listPredictOrderRow.get(0).getListPredictOrdercell();
		if(map.size()>0){
			for(String str:map.keySet()){
				System.out.println(str);
				
				List<PredictOrderColumnsEX> list=map.get(str);
				for(PredictOrderColumnsEX pocEX:list){
					//objCwbimportlog.saveRow(pocEX.getIndex(), cwbimport.getToccwlid(), "N", pocEX.getOpermode(), pocEX.getPromptinfo().substring(0,10));
					//将数据保存在map中，去除重复列名称
					Map<String,String> saveMap=new HashMap<String,String>();
					for(int i=0;i<listCells.size();i++){
						PredictOrderCell objPOCell= listCells.get(i);
						if (!hmPredictColumns.containsKey(objPOCell.getCellname())){
							continue;
						}
						PredicttemplatevalueColumns objPTVColumns = hmPredictColumns.get(objPOCell.getCellname());						
						String strColumnEname = objPTVColumns.getTctccolumnename();
						if(StringUtility.isNull(strColumnEname)){
							continue;
						}
						String strColumnEvalue="";
						if (objPTVColumns.getTctccolumntype().equals("W")) {
							strColumnEvalue=ObjectGenerator.process("get" + strColumnEname, 
										pocEX.getWaybillforpredict(), 
										null);	
							saveMap.put(objPTVColumns.getTctccolumnname(), strColumnEvalue);
						}
						if (objPTVColumns.getTctccolumntype().equals("C")) {	
							int index=Integer.parseInt(objPTVColumns.getTctccolumngroup());
							if(index>pocEX.getListCargoInfo().size()){
								continue;
							}
							CargoinfoColumns cifc=pocEX.getListCargoInfo().get(index-1);
							strColumnEvalue=ObjectGenerator.process("get" + strColumnEname, 
									cifc, 
									null);
							saveMap.put(objPTVColumns.getTctccolumnname(), strColumnEvalue);
						}																							
					}			
					
					for(String s:saveMap.keySet()){
							if(StringUtility.isNull(s) || StringUtility.isNull(saveMap.get(s))){
								continue;
						}		
											
					
//						CwbimportdataColumns objCID=new CwbimportdataColumns();
//						objCID.setCwbdcomp_idcwbrid(new Long(pocEX.getIndex()));
//						objCID.setCwbdtopcwbimportrowtopcwbimportlogcwlid(Long.parseLong(cwbimport.getToccwlid()));
//						objCID.setCwbdcomp_idcwbdcolumnname(s);
//						objCID.setCwbdcwbdvalue(saveMap.get(s));
//						objCwbimportlog.saveData(objCID);
						
					}
					
				}
				
			}
		}
		
		return "success";

	}
	/**
	 * 获得线程池大小
	 * @param size
	 * @return
	 * @throws IOException
	 */
	private int getPoolSize(int size) throws IOException {
		int number=Runtime.getRuntime().availableProcessors()*2;//获得当前服务器CPU的数量
		int allSize;
		AllThreadPool atp =AllThreadPool.getInstance();
		Properties prop=atp.getProperties();
		if(size<=Integer.parseInt(prop.getProperty("dataSize1"))){
			number=Integer.parseInt(prop.getProperty("poolSize1"));
			allSize=number+atp.getAllSize();//判断要创建的线程加上当前总线程是否大于最大线程，不大于则返回要创建的线程，否则返回0
			if(allSize>atp.getMaxSize()){
				return 0;
			}
			AllThreadPool.getInstance().raiseSize(number);
			return number;
		}
		if(size<=Integer.parseInt(prop.getProperty("dataSize2"))){
			number=Integer.parseInt(prop.getProperty("poolSize2"));
			allSize=number+atp.getAllSize();
			if(allSize>atp.getMaxSize()){
				return 0;
			}
			AllThreadPool.getInstance().raiseSize(number);
			return number;
		}
		if(size<=Integer.parseInt(prop.getProperty("dataSize3"))){
			number=Integer.parseInt(prop.getProperty("poolSize3"));
			allSize=number+atp.getAllSize();
			if(allSize>atp.getMaxSize()){
				return 0;
			}
			AllThreadPool.getInstance().raiseSize(number);
			return number;
		}
		number=Integer.parseInt(prop.getProperty("poolSize4"));
		allSize=number+atp.getAllSize();
		if(allSize>atp.getMaxSize()){
			return 0;
		}
		AllThreadPool.getInstance().raiseSize(number);
		return number;
	}

	
	/**
	 * 拆包
	 * @return
	 * @throws Exception 
	 */
	public String parse() throws Exception {
		String strCwcode = request.getParameter("cwcode");		
		String strLength = request.getParameter("sel");//拆分为几个包裹
		String strCount = request.getParameter("count");//包含有几个商品
		String strOpid = (String) session.getAttribute("OpId");
		List<PredictOrderColumnsEX> list  = new ArrayList<PredictOrderColumnsEX> ();
		for(int i = 1;i<=Integer.parseInt(strLength);i++){
			PredictOrderColumnsEX objPOCEX = new PredictOrderColumnsEX();//一个包裹对应一条EX记录
			WaybillforpredictColumns objWayColumns = new WaybillforpredictColumns();//运单信息
			String strWeight = request.getParameter("weight"+i);
			if(!StringUtility.isNull(strWeight)){
				//System.out.println("包裹重量："+strWeight);
				objWayColumns.setCwcw_customerchargeweight(strWeight);	
			}				
			List<CargoinfoColumns> cargoList = new ArrayList<CargoinfoColumns>();//运单中单个商品信息
			
			for(int j = 1;j<=Integer.parseInt(strCount);j++){           
				String strPices = request.getParameter("rempack"+i+""+j);
				String strCargo = request.getParameter("cargoName"+(j-1));
				if(!StringUtility.isNull(strPices)){
					String[] strCargoInfo = strCargo.split(",");
					//System.out.println(strCargoInfo.length+"Name***");
					CargoinfoColumns cargoColumns = new CargoinfoColumns();
					cargoColumns.setCicomp_idcwcode(Long.parseLong(strCwcode));
					cargoColumns.setCiciename(strCargoInfo[0]);
					cargoColumns.setCiciunitprice(new BigDecimal(strCargoInfo[1]));
					cargoColumns.setCicitotalprice(new BigDecimal(strCargoInfo[2]));
					cargoColumns.setCkckcode(strCargoInfo[3].trim());
					cargoColumns.setCicipieces(Integer.parseInt(strPices));
					cargoColumns.setCiciname(strCargoInfo[4].trim());
					cargoColumns.setCicihscode(strCargoInfo[5].trim());
					cargoColumns.setCiciremark(strCargoInfo[6].trim());
					cargoColumns.setCiciattacheinfo(strCargoInfo[7].trim());
					cargoList.add(cargoColumns);
					//System.out.println(strCargoInfo.length+"Name***"+cargoColumns.getCiciname()+"info***"+cargoColumns.getCiciattacheinfo()+"mark***"+cargoColumns.getCiciremark()+"hscode***"+cargoColumns.getCicihscode()+"CK***"+cargoColumns.getCkckcode());
				}
			}
			objPOCEX.setWaybillforpredict(objWayColumns);
			objPOCEX.setListCargoInfo(cargoList);		
			list.add(objPOCEX);
		}
		PredictOrderEX objPOEX = new PredictOrderEX();
		objPOEX.parse(strCwcode,list,strOpid);
		return SUCCESS;
	}
	
	/**
	 * 合包
	 * @return
	 * @throws Exception 
	 */
	public String merge() throws Exception {
		String strOpid = (String) session.getAttribute("OpId");
		PredictOrderEX objPOEX = new PredictOrderEX();
		String strCwcode[] = request.getParameterValues("checkbox");
		objPOEX.merge(strCwcode, strOpid);
		return SUCCESS;
	}
	/**
	 * 合并，覆盖，扣件
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String OMH() throws Exception {
		//String strError = request.getParameter("error");//哪种问题类型
		String strID = request.getParameter("id");//序列号码
		String strMethod = request.getParameter("method");//调用哪种方法
		String strCocode = (String) session.getAttribute("Cocode");
		String strOpid = (String) session.getAttribute("OpId");
		PrintWriter out = response.getWriter();
		
		List<com.daiyun.predictwaybill.PredictOrderColumnsEX> pcList =(List<com.daiyun.predictwaybill.PredictOrderColumnsEX>)session.getAttribute("pocList");
		PredictwaybillColumns pc=new PredictwaybillColumns();
		if(pcList!=null&&pcList.size()>0){
			for(int i=0; 0<pcList.size();i++){
				if(Integer.parseInt(strID)==i){
						PredictwaybillColumns pcColumns=pcList.get(i).getPredictwaybillColumns();
						pc = pcColumns;
						break;
				}
			}
		}
		MergeOvvredePredicOrder  mopo =new MergeOvvredePredicOrder();
		if(strMethod.equals("merge")){
			PromptUtilityCollection objPU = mopo.merge(strCocode,pc,strOpid);
			if (objPU != null && !objPU.canGo(false)){
				out.print("合并失败");
			}else{
				out.print("合并成功");
			}
			
		}
		if(strMethod.equals("ovvride")){
			PromptUtilityCollection objPU = mopo.ovvride(strCocode,pc ,strOpid);
			if(objPU != null && !(objPU.canGo(false))){
				out.print("覆盖失败");
			}else{
				out.print("覆盖成功");
			}
			
		}
		
//		PredictOrderColumnsEX objPOCEX = new PredictOrderColumnsEX();
//		Map<String, List<PredictOrderColumnsEX>> map = (Map<String, List<PredictOrderColumnsEX>>) session.getAttribute("hashMap");
//		List<PredictOrderColumnsEX> list = map.get(strError);
//		for(int k = 0;k<list.size();k++){
//			PredictOrderColumnsEX objColumns = list.get(k);
//			if(Integer.parseInt(strID) == objColumns.getIndex()){
//				objPOCEX = objColumns;
//				break;
//			}
//		}	
//		//System.out.println("测试Map："+objPOCEX.getIndex());
//		PredictOrderEX objPOEX = new PredictOrderEX();
//		if(strMethod.equals("merge")){
//			PromptUtilityCollection objPU = objPOEX.merge(strCocode,objPOCEX ,strOpid);
//			
//			if (objPU != null && !objPU.canGo(false)){
//				out.print("合并失败");
//			}else{
//				out.print("合并成功");
//			}
//			
//		}
//		if(strMethod.equals("ovvride")){
//			PromptUtilityCollection objPU = objPOEX.ovvride(strCocode,objPOCEX ,strOpid);
//			if(objPU != null && !(objPU.canGo(false))){
//				out.print("覆盖失败");
//			}else{
//				out.print("覆盖成功");
//			}
//			
//		}
//		if(strMethod.equals("hold")){
//			objPOEX.merge(strCocode,objPOCEX ,strOpid);
//			out.print("扣件成功");
//		}
//		if(strMethod.equals("save")){
//			InputAllQReturn objIAQ = objPOEX.save(strCocode,objPOCEX ,strOpid, "");
//			PromptUtilityCollection objPU = objIAQ.getPromptUtilityCollection();
//			if(objPU != null && !objPU.canGo(false)){
//				out.print("保存失败" + objPU.toString());
//				
//			}else{
//				out.print("保存成功");
//			}
//			
//		}
		
		return null;
	}
	
	/**
	 * 拆分
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	public String remove() throws Exception {		
		String strCwcode[] = request.getParameterValues("checkbox");
		WaybillforpredictQuery objQuery = new WaybillforpredictQuery();
		WaybillforpredictCondition objCondition = new WaybillforpredictCondition();
		objCondition.setCwcode(strCwcode[0]);
		objQuery.setCondition(objCondition);
		
		
		WaybillforpredictColumns objColumns = (WaybillforpredictColumns) objQuery.getResults().get(0);
		List<CargoinfoColumns> cargoList = CargoInfoDemand.queryByCwCode(strCwcode[0]);		
		request.setAttribute("list",cargoList);
		request.setAttribute("waybillforpredictColumns",objColumns);
		request.setAttribute("cwcode",strCwcode);
		request.setAttribute("pksename",objColumns.getPkpk_sename());
		request.setAttribute("Cwcw_customerchargeweight",objColumns.getCwcw_customerchargeweight());
		request.setAttribute("chargeWeight",objColumns.getCwcw_chargeweight());
		return SUCCESS;
	}
    
	/**
	 * 跳转到上传页面
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String upload() throws Exception {
		String strCocode = (String) session.getAttribute("Cocode");
		List<PredictordertemplateColumns> payList = PredicttemplateDemand.queryPredict("", 
				"",
				true);
		List<PredictordertemplateColumns> objList = PredicttemplateDemand.queryPredict("",
				strCocode,
				true);
		request.setAttribute("payList", payList);
		request.setAttribute("objList", objList);
		return SUCCESS;
	}

	/**
	 * 跳转至查询上传日志页面
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String showLog() throws Exception{
		String strOpid = (String) session.getAttribute("OpId");
		String begindate=request.getParameter("begindate");
		String enddate=request.getParameter("enddate");
		String totalRecode=request.getParameter("totalRecode");
		//分页参数
		int pageCount=0;
		if(StringUtility.isNull(request.getParameter("customInputCount")) ||
				"".equals(request.getParameter("customInputCount"))){
			pageCount=9;
		}else{
			pageCount=Integer.parseInt(request.getParameter("customInputCount"));
		}
		//传回页面的值
		request.setAttribute("pageCount", pageCount);		
		
		CwbimportlogCondition logCondition=new CwbimportlogCondition();
		m_objPageConfig.setMaxPageResultCount(pageCount);
		logCondition.setPageConfig(m_objPageConfig);
		logCondition.setOpid(strOpid);
		logCondition.setBegindate(begindate);
		logCondition.setEnddate(enddate);
		logCondition.setTotalrecords(totalRecode);
		CwbimportlogQuery clogq=new CwbimportlogQuery();
		clogq.setCondition(logCondition);
		List<CwbimportlogColumns> objCwbimportLog=clogq.getResults();
		request.setAttribute("cwbimportLogList", objCwbimportLog);
		
		request.setAttribute("begindate", begindate);
		request.setAttribute("enddate", enddate);
		request.setAttribute("totalRecode",totalRecode);
		return SUCCESS;
		
	}
	/**
	 * 显示行数据页面
	 * @throws Exception
	 */
	public String showRowAndData() throws Exception{
		String cwlId=request.getParameter("cwlId");
		request.setAttribute("cwlId", cwlId);
		
		request.setAttribute("importLog", getLogFileInfoByCwlid(cwlId));
		
		CwbimportrowQuery query = new CwbimportrowQuery();
		query.setCwlid(cwlId);
		List<CwbimportrowColumns> results = query.getResults();
		request.setAttribute("results", results);

		return SUCCESS;
	}

 

	@SuppressWarnings("unchecked")
	private CwbimportlogColumns getLogFileInfoByCwlid(String cwlId) {
		CwbimportlogQuery clogq = new CwbimportlogQuery();
		clogq.setCwlid(cwlId);
		List<CwbimportlogColumns> objCwbimportLog = null;
		try {
			objCwbimportLog = clogq.getResults();
		} catch (Exception e) {
			e.printStackTrace();
		}
		CwbimportlogColumns cwbimportlogColumns = objCwbimportLog.get(0);
		return cwbimportlogColumns;
	}
	/**查询是否设置了发件人**/
	public  boolean  IsSetConsigneename(String strCocode){
		ShipperconsigneeColumns objSCColumns = null;
		try {	
			objSCColumns = ShipperconsigneeDemand.loadByCustomer(strCocode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(objSCColumns == null){
			return false;
		}else{
			return true;
		}
	}

	public void run() {
		try {
			 session.setAttribute("number1","50");
			 result=loadRoleInfo(uploadFileFileName,temple,check,strPath,strAllowrepeataddress);
			 
		} catch (Exception e) {
		     result="error";
		}
 
	}
	 
}
