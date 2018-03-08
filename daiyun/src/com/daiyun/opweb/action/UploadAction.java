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
	public static final String RESULT_TITLENAME = "XSϵͳ���";
	public static final String OPTYPE_TITLENAME = "XSϵͳ��������";
	public static final String REMARK_TITLENAME = "XSϵͳ��ע";
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

	//�ϴ�Excel��
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
		//����ǰ��ѯ�Ƿ������˷�����,û�е�����ʾ��
		String strCocode = (String) session.getAttribute("Cocode");
		boolean ishavaconsigneename = IsSetConsigneename(strCocode);
		if(ishavaconsigneename == false){
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
					new MessageBean(IBasicData.MSG_TYPE_ERROR, "δ���÷�����","���ڲ�ѯ��������Ϣ�����÷�����!"));
			return ERROR;
		}
	 
	

			
		run();//�߳�
	    if(result.equals("error")){		
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",new MessageBean(IBasicData.MSG_TYPE_ERROR, "���ݶ�ȡʧ��","�����ϴ��ļ�������!"));
			return ERROR;
	    }
			 
		if(result.equals("success")){
			//PrintWriter out = response.getWriter();
			 
			String directory = "/download";
			String targerDirectory = ServletActionContext.getServletContext()
					.getRealPath(directory);
			// �����ϴ��ļ��Ķ���
			File target = new File(targerDirectory, uploadFileFileName);
			// ����ļ��Ѵ��ڣ���ɾ��ԭ���ļ�
			if (target.exists()) {
				target.delete();
			}
			// ����file����ʵ���ϴ�
			try {
				FileUtils.copyFile(uploadFile, target);
				//out.print("�ļ��ϴ��ɹ�");
			} catch (IOException e) {
				ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
						new MessageBean(IBasicData.MSG_TYPE_ERROR, "�ļ�����ʧ��","�����ϴ��ļ��Ƿ�Ϊ��ȷ��Excel�ļ�!"));
				return ERROR;
			}
			
			return SUCCESS;
		}else{
			 return ERROR;
		}
		
	}

 

	/**
	 * ��Excel���ȡ����
	 * poi��������excel
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
//		// �����ϴ��ļ��Ķ���
//		File target = new File(targerDirectory, uploadFileFileName);
		List<PredictOrderRow> listPredictOrderRow = new ArrayList<PredictOrderRow>();
		FileInputStream fis = new FileInputStream(uploadFile);
		/*20160926,Start by wukq,����xlsx��ʽ*/
		Workbook wb = null;
		Boolean ISExcel2003 = false;
		if (ExcelUtilEX.isExcel2003(uploadFileFileName)) {//�����2003��ʽ
			wb = new HSSFWorkbook(fis);
			ISExcel2003 = true;
		} else if(ExcelUtilEX.isExcel2007(uploadFileFileName)){//�����2007��ʽ
			wb = new XSSFWorkbook(fis);
			ISExcel2003 = false;
		}
		/*End*/
		
		/*20160927,Start by wukq*/
		int blankline = 0;	//���м�¼
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
        //�Ƿ�ϲ��ظ�����
		Boolean falg = false;
		if(!StringUtility.isNull(checkFalg)){
			falg = true;
		}
		
		boolean isAllowRepeatAddress = false;
		if(!StringUtility.isNull(strAllowrepeatAddress)){
			isAllowRepeatAddress = true;
		}		
		
		//ģ������
		PredictOrderEX objPOEX = new PredictOrderEX();
		String strCocode = (String) session.getAttribute("Cocode");
		String strOpid = (String) session.getAttribute("OpId");
		session.setAttribute("number2","120");	
		
		objPOEX.save(strCocode, templeCode, 
				listPredictOrderRow,strOpid,strPath,
				falg, isAllowRepeatAddress);//�������ݵط���
		//��ȡ����ɹ�������.
		//��ҳֱ�ӵ���list
		List<PredictOrderColumnsEX> savelist = objPOEX.getSavedSeccess(strCocode);		
										
		Map<String, List<PredictOrderColumnsEX>> map = objPOEX.getSavedPromptEWB(strCocode);	
		int totalSize = rowNum - 1 - blankline;//��ȥ��������
		int errorSize = 0;
		for(String str:map.keySet()){
			List<PredictOrderColumnsEX> objList = map.get(str);
			errorSize = errorSize + objList.size();//map�а����ͻ����صĴ�����Ϣ	 
		}
		int normalSize = objPOEX.getSavedNormalSize(strCocode);
		int megreSize = totalSize - normalSize - errorSize;
		megreSize = megreSize>=0 ? megreSize : 0 ;	//�ж�megerSize�Ƿ����0���ϲ���������Ϊ��
		
		session.setAttribute("number3","200");	 
		
		session.setAttribute("hashMap", map);
		session.setAttribute("strPath", strPath);
		request.setAttribute("map", map);
		request.setAttribute("totalSize", totalSize);
		request.setAttribute("normalSize", normalSize);
		request.setAttribute("errorSize", errorSize);
		request.setAttribute("megreSize", megreSize);
		request.setAttribute("strPath", strPath);
		request.setAttribute("savelist", savelist);//�ϴ��ɹ�������
		
		 int success=savelist.size();
		
		
		//���ת����׼ģ��ɹ����ϴ��д��󣬱����ϴ������¼
		//������־����				
		Cwbimportlog objCwbimportlog=new Cwbimportlog();
		if(success==0){
			CwbimportlogColumns cwbimport=objCwbimportlog.saveLog(strOpid,listPredictOrderRow.size(),errorSize,strPath,"�ϴ�����");	
			String cwlId=cwbimport.getToccwlid();
			int a=1;
			for(int b=0;b<listPredictOrderRow.size();b++){
				PredictOrderRow pr=listPredictOrderRow.get(b);
				
			for(String str:map.keySet()){//map�а����ͻ����صĴ�����Ϣ
				List<PredictOrderColumnsEX> objList = map.get(str);
				PredictOrderColumnsEX pec=objList.get(b);
				Cwbimportrow cwt=new Cwbimportrow();
				CwbimportrowColumns cws=new CwbimportrowColumns();
				cws.setCwbrcomp_idcwbrid(new Long(a++));
				cws.setCwbrtopcwbimportlogcwlid(new Long(cwlId));
				cws.setCwbrcwbrremark("�ͻ����ţ�"+pec.getWaybillforpredict().getCwcw_customerewbcode()+","+str);
				cws.setCwbrcwbrsuccesssign("N");
				cwt.saveRow(cws);
			} 
			}
		}else{
			CwbimportlogColumns cwbimport=objCwbimportlog.saveLog(strOpid,listPredictOrderRow.size(),0,strPath,"�ϴ��ɹ�");	
			String cwlId=cwbimport.getToccwlid();
			int a=1;
			for(PredictOrderColumnsEX str:savelist){//LIST�а����ͻ��ɹ�����Ϣ
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
		//	����������
		Map<String, PredicttemplatevalueColumns> hmPredictColumns = PredicttemplateDemand.queryTemplatevalue(templeCode);
		List<PredictOrderCell> listCells = listPredictOrderRow.get(0).getListPredictOrdercell();
		if(map.size()>0){
			for(String str:map.keySet()){
				System.out.println(str);
				
				List<PredictOrderColumnsEX> list=map.get(str);
				for(PredictOrderColumnsEX pocEX:list){
					//objCwbimportlog.saveRow(pocEX.getIndex(), cwbimport.getToccwlid(), "N", pocEX.getOpermode(), pocEX.getPromptinfo().substring(0,10));
					//�����ݱ�����map�У�ȥ���ظ�������
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
	 * ����̳߳ش�С
	 * @param size
	 * @return
	 * @throws IOException
	 */
	private int getPoolSize(int size) throws IOException {
		int number=Runtime.getRuntime().availableProcessors()*2;//��õ�ǰ������CPU������
		int allSize;
		AllThreadPool atp =AllThreadPool.getInstance();
		Properties prop=atp.getProperties();
		if(size<=Integer.parseInt(prop.getProperty("dataSize1"))){
			number=Integer.parseInt(prop.getProperty("poolSize1"));
			allSize=number+atp.getAllSize();//�ж�Ҫ�������̼߳��ϵ�ǰ���߳��Ƿ��������̣߳��������򷵻�Ҫ�������̣߳����򷵻�0
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
	 * ���
	 * @return
	 * @throws Exception 
	 */
	public String parse() throws Exception {
		String strCwcode = request.getParameter("cwcode");		
		String strLength = request.getParameter("sel");//���Ϊ��������
		String strCount = request.getParameter("count");//�����м�����Ʒ
		String strOpid = (String) session.getAttribute("OpId");
		List<PredictOrderColumnsEX> list  = new ArrayList<PredictOrderColumnsEX> ();
		for(int i = 1;i<=Integer.parseInt(strLength);i++){
			PredictOrderColumnsEX objPOCEX = new PredictOrderColumnsEX();//һ��������Ӧһ��EX��¼
			WaybillforpredictColumns objWayColumns = new WaybillforpredictColumns();//�˵���Ϣ
			String strWeight = request.getParameter("weight"+i);
			if(!StringUtility.isNull(strWeight)){
				//System.out.println("����������"+strWeight);
				objWayColumns.setCwcw_customerchargeweight(strWeight);	
			}				
			List<CargoinfoColumns> cargoList = new ArrayList<CargoinfoColumns>();//�˵��е�����Ʒ��Ϣ
			
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
	 * �ϰ�
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
	 * �ϲ������ǣ��ۼ�
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String OMH() throws Exception {
		//String strError = request.getParameter("error");//������������
		String strID = request.getParameter("id");//���к���
		String strMethod = request.getParameter("method");//�������ַ���
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
				out.print("�ϲ�ʧ��");
			}else{
				out.print("�ϲ��ɹ�");
			}
			
		}
		if(strMethod.equals("ovvride")){
			PromptUtilityCollection objPU = mopo.ovvride(strCocode,pc ,strOpid);
			if(objPU != null && !(objPU.canGo(false))){
				out.print("����ʧ��");
			}else{
				out.print("���ǳɹ�");
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
//		//System.out.println("����Map��"+objPOCEX.getIndex());
//		PredictOrderEX objPOEX = new PredictOrderEX();
//		if(strMethod.equals("merge")){
//			PromptUtilityCollection objPU = objPOEX.merge(strCocode,objPOCEX ,strOpid);
//			
//			if (objPU != null && !objPU.canGo(false)){
//				out.print("�ϲ�ʧ��");
//			}else{
//				out.print("�ϲ��ɹ�");
//			}
//			
//		}
//		if(strMethod.equals("ovvride")){
//			PromptUtilityCollection objPU = objPOEX.ovvride(strCocode,objPOCEX ,strOpid);
//			if(objPU != null && !(objPU.canGo(false))){
//				out.print("����ʧ��");
//			}else{
//				out.print("���ǳɹ�");
//			}
//			
//		}
//		if(strMethod.equals("hold")){
//			objPOEX.merge(strCocode,objPOCEX ,strOpid);
//			out.print("�ۼ��ɹ�");
//		}
//		if(strMethod.equals("save")){
//			InputAllQReturn objIAQ = objPOEX.save(strCocode,objPOCEX ,strOpid, "");
//			PromptUtilityCollection objPU = objIAQ.getPromptUtilityCollection();
//			if(objPU != null && !objPU.canGo(false)){
//				out.print("����ʧ��" + objPU.toString());
//				
//			}else{
//				out.print("����ɹ�");
//			}
//			
//		}
		
		return null;
	}
	
	/**
	 * ���
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
	 * ��ת���ϴ�ҳ��
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
	 * ��ת����ѯ�ϴ���־ҳ��
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String showLog() throws Exception{
		String strOpid = (String) session.getAttribute("OpId");
		String begindate=request.getParameter("begindate");
		String enddate=request.getParameter("enddate");
		String totalRecode=request.getParameter("totalRecode");
		//��ҳ����
		int pageCount=0;
		if(StringUtility.isNull(request.getParameter("customInputCount")) ||
				"".equals(request.getParameter("customInputCount"))){
			pageCount=9;
		}else{
			pageCount=Integer.parseInt(request.getParameter("customInputCount"));
		}
		//����ҳ���ֵ
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
	 * ��ʾ������ҳ��
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
	/**��ѯ�Ƿ������˷�����**/
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
