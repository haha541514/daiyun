package com.daiyun.opweb.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.fetcher.track.dp.FedexTrackDepositor;
import kyle.fetcher.track.dp.SingleTrackDepositor;
import kyle.fetcher.track.dp.UPSTrackDepositor;
import kyle.fetcher.track.dp.USPSTrackDepositor;
import kyle.leis.eo.customerservice.track.bl.Track;
import kyle.leis.eo.customerservice.track.da.WaybillfortrackColumns;
import kyle.leis.eo.customerservice.track.da.WaybillfortrackCondition;
import kyle.leis.eo.customerservice.track.da.WaybilltrackColumns;
import kyle.leis.eo.customerservice.track.da.WaybilltrackCondition;
import kyle.leis.eo.customerservice.track.da.WebaccesstrackColumns;
import kyle.leis.eo.customerservice.track.dax.TrackDemand;
import kyle.leis.eo.customerservice.track.tp.SaveWBTrackTransaction;
import kyle.leis.eo.operation.corewaybill.da.SimplecorewaybillColumns;
import kyle.leis.eo.operation.corewaybill.da.SimplecorewaybillCondition;
import kyle.leis.eo.operation.corewaybill.da.SimplecorewaybillQuery;
import kyle.leis.eo.operation.corewaybill.dax.CorewaybillDemand;
import kyle.leis.es.businessrule.channeltrackmapping.da.ChanneltrackmappingColumns;
import kyle.leis.es.businessrule.channeltrackmapping.dax.ChanneltrackmappingDemand;
import kyle.leis.es.company.customer.da.CustomerColumns;
import kyle.leis.es.company.customer.dax.CustomerDemand;
import kyle.leis.fs.dictionary.dictionarys.da.TchnChannelDC;
import kyle.leis.hi.TchnChannel;
import org.apache.struts2.ServletActionContext;
import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;
import com.opensymphony.xwork2.ActionSupport;

public class WaybillTrackAction extends ActionSupport {
	private static final long serialVersionUID = 3534713219973008032L;
	private static final int BUFFERSIZE = 2 * 1024;
	// 上传文件对象
	@SuppressWarnings("unused")
	private File uploadFile;
	// 上传文件名
	@SuppressWarnings("unused")
	private String fileName;
	//错误的运单
	private String customerewbcode="";
	public String getErrorCode(){
		return customerewbcode;
	}
	
	private WaybilltrackColumns objWBTColumns;
	
	public void setUploadFile(File uploadFile) {
		this.uploadFile = uploadFile;
	}

	public void setUploadFileFileName(String filename) {
		this.fileName = filename;
	}

	public WaybilltrackColumns getObjWBTColumns() {
		return objWBTColumns;
	}

	public void setObjWBTColumns(WaybilltrackColumns objWBTColumns) {
		this.objWBTColumns = objWBTColumns;
	}
	
	@SuppressWarnings("unchecked")
	public List<WebaccesstrackColumns> allEwbQueryTrack(String strQueryCode) throws Exception{			
		String [] astrCwewbcode = strQueryCode.split(",");		
		List<WaybillfortrackColumns> listWBFTColumns = new ArrayList<WaybillfortrackColumns>();
		List listWBTColumns = new ArrayList<WaybilltrackColumns>();
		List<WebaccesstrackColumns> listWATColumns = new ArrayList<WebaccesstrackColumns>();
		WebaccesstrackColumns objWATColumns = null;
		WaybillfortrackColumns objWBFTColumns = null;
		
		if(astrCwewbcode == null || astrCwewbcode.length < 1)
			return null;
		
		for(int i=0; i<astrCwewbcode.length; i++){						
			if(astrCwewbcode[i].equals("")) continue;
			WaybillfortrackCondition objWBFTCondition = new WaybillfortrackCondition();
			WaybilltrackCondition objWBTCondition = new WaybilltrackCondition();
			Track objTrack = new Track();
			
			SimplecorewaybillColumns simpleColumns = CorewaybillDemand.loadSimpleCorewaybill(astrCwewbcode[i], "", "C");
			if (simpleColumns != null) {
				objWBFTCondition.setCwcustomerewbcode(astrCwewbcode[i]);
			} else {
				simpleColumns = CorewaybillDemand.loadSimpleCorewaybill(astrCwewbcode[i], "", "S");
				if (simpleColumns != null) {
					objWBFTCondition.setCwserverewbcode(astrCwewbcode[i]);
				} else {
					objWBFTCondition.setCwewbcode(astrCwewbcode[i]);
				}
			}
			listWBFTColumns = (List<WaybillfortrackColumns>)TrackDemand.queryWaybillfortrack(objWBFTCondition);
			//运单号无对应的轨迹信息
			if(listWBFTColumns == null || listWBFTColumns.size()<1) {
				customerewbcode=customerewbcode+astrCwewbcode[i]+",";
				continue;
			}
			// index = 0 ;
			objWBFTColumns = listWBFTColumns.get(0);
			objWBTCondition.setCwcode(objWBFTColumns.getCwcwcode());
			
			List<WaybilltrackColumns> listWBTColumnsResult = new ArrayList<WaybilltrackColumns>();
			listWBTColumns = TrackDemand.queryTrack(objWBTCondition);
			//处理发生地点和轨迹描述为空的情况(如查发生地点为空地用发生城市，如果轨迹描述为空则用轨迹状态)
			for(int j = 0;j < listWBTColumns.size(); j++){
				WaybilltrackColumns objWaybilltrackColumns = (WaybilltrackColumns)listWBTColumns.get(j); 
				if(objWaybilltrackColumns.getWbtwbtlocation()== null){
					objWaybilltrackColumns.setWbtwbtlocation(objWaybilltrackColumns.getDtdthubcode());
				}
				if(objWaybilltrackColumns.getWbtwbtdescription() == null){
					objWaybilltrackColumns.setWbtwbtdescription(objWaybilltrackColumns.getWbtswbtsename());
				}
				listWBTColumnsResult.add(objWaybilltrackColumns);
			}
			//无轨迹信息				
			if(listWBTColumnsResult == null ||listWBTColumnsResult.size()<1){
				return null;
			}
			objWATColumns = objTrack.buildWebAccessTrackColumns(objWBFTColumns, listWBTColumnsResult);
			listWATColumns.add(objWATColumns);
		}
		if(listWATColumns.size()>0){				
			return listWATColumns;
		}
		return null;
	}	
	
	
	
	@SuppressWarnings("unchecked")
	public List<WebaccesstrackColumns> webQueryTrack(String strType,String strQueryCode,
			String strCocode) throws Exception{			
		String [] astrCwewbcode = strQueryCode.split(",");		
		List<WaybillfortrackColumns> listWBFTColumns = new ArrayList<WaybillfortrackColumns>();
		List listWBTColumns = new ArrayList<WaybilltrackColumns>();
		List<WebaccesstrackColumns> listWATColumns = new ArrayList<WebaccesstrackColumns>();
		WebaccesstrackColumns objWATColumns = null;
		WaybillfortrackColumns objWBFTColumns = null;
		
//		if (StringUtility.isNull(strType))
//			strType = "E";
		if(astrCwewbcode != null && astrCwewbcode.length>=1){
			for(int i=0;i<astrCwewbcode.length;i++){						
				if(astrCwewbcode[i].equals("")) continue;
				WaybillfortrackCondition objWBFTCondition = new WaybillfortrackCondition();
				WaybilltrackCondition objWBTCondition = new WaybilltrackCondition();
				Track objTrack = new Track();
				
				SimplecorewaybillColumns simpleColumns = CorewaybillDemand.loadSimpleCorewaybill(astrCwewbcode[i], strCocode, "C");
				if (simpleColumns != null) {
					objWBFTCondition.setCwcustomerewbcode(astrCwewbcode[i]);
				} else {
					simpleColumns = CorewaybillDemand.loadSimpleCorewaybill(astrCwewbcode[i], strCocode, "S");
					if (simpleColumns != null) {
						objWBFTCondition.setCwserverewbcode(astrCwewbcode[i]);
					} else {
						objWBFTCondition.setCwewbcode(astrCwewbcode[i]);
					}
				}
				
				objWBFTCondition.setCcocode(strCocode);
				listWBFTColumns = (List<WaybillfortrackColumns>)TrackDemand.queryWaybillfortrack(objWBFTCondition);
				//运单号无对应的轨迹信息
				if(listWBFTColumns == null || listWBFTColumns.size()<1) {
					customerewbcode=customerewbcode+astrCwewbcode[i]+",";
					continue;
				}
				// index = 0 ;
				objWBFTColumns = listWBFTColumns.get(0);
				objWBTCondition.setCwcode(objWBFTColumns.getCwcwcode());
				
				List<WaybilltrackColumns> listWBTColumnsResult = new ArrayList<WaybilltrackColumns>();
				listWBTColumns = TrackDemand.queryTrack(objWBTCondition);
				//处理发生地点和轨迹描述为空的情况(如查发生地点为空地用发生城市，如果轨迹描述为空则用轨迹状态)
				for(int j = 0;j < listWBTColumns.size(); j++){
					WaybilltrackColumns objWaybilltrackColumns = (WaybilltrackColumns)listWBTColumns.get(j); 
					if(objWaybilltrackColumns.getWbtwbtlocation()== null){
						objWaybilltrackColumns.setWbtwbtlocation(objWaybilltrackColumns.getDtdthubcode());
					}
					if(objWaybilltrackColumns.getWbtwbtdescription() == null){
						objWaybilltrackColumns.setWbtwbtdescription(objWaybilltrackColumns.getWbtswbtsename());
					}
					listWBTColumnsResult.add(objWaybilltrackColumns);
				}
				//无轨迹信息				
				if(listWBTColumnsResult == null ||listWBTColumnsResult.size()<1){
					return null;
				}
				objWATColumns = objTrack.buildWebAccessTrackColumns(objWBFTColumns,listWBTColumnsResult);
				listWATColumns.add(objWATColumns);
			}
			if(listWATColumns.size()>0){				
				return listWATColumns;
			}
		}
		return null;
	}
	
	/**
	 * 轨迹查询
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String queryTrack() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String strOpId = (String)session.getAttribute("OpId");
		String  strQueryCode = request.getParameter("queryCode");
		String strCocode = (String)session.getAttribute("Cocode");
		String validateCode = request.getParameter("validateCode");
		if (!StringUtility.isNull(validateCode))
			validateCode =  validateCode.toLowerCase();
		String sessionValidateCode = (String) session.getAttribute("CheckCodeImageAction");
		/*
		if (StringUtility.isNull(sessionValidateCode)) {
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
					new MessageBean(IBasicData.MSG_TYPE_ERROR, "登录失败","未取得验证码，请重新登陆!"));
			return ERROR;			
		}
		*/
		if (!StringUtility.isNull(validateCode) && 
				!StringUtility.isNull(sessionValidateCode) &&
				!validateCode.equals(sessionValidateCode.toLowerCase())) {
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
					new MessageBean(IBasicData.MSG_TYPE_ERROR, "查询失败","输入的验证码不一致!"));
			return ERROR;
		}
		
		String [] astrCwewbcode = null;
		if(strQueryCode.indexOf(",") != -1){
			 astrCwewbcode= strQueryCode.split(",");
		}
		else if(strQueryCode.indexOf("\r\n") != -1){
			astrCwewbcode = strQueryCode.split("\r\n");
		}
		else{
			astrCwewbcode = new String[1];
			astrCwewbcode[0] = strQueryCode;
		}
		List<WaybillfortrackColumns> listWBFTColumns = new ArrayList<WaybillfortrackColumns>();
		List listWBTColumns = new ArrayList();
		List<WebaccesstrackColumns> listWATColumns = new ArrayList<WebaccesstrackColumns>();
		WebaccesstrackColumns objWATColumns = null;
		WaybillfortrackColumns objWBFTColumns = null;
		if(astrCwewbcode != null && astrCwewbcode.length>=1){
			for(int i=0;i<astrCwewbcode.length;i++){
				System.out.println("cwewbcode is:--"+astrCwewbcode[i]+"--");
				//判断先输入豆号或回车后输入运单号(空数据)的情况				
				if(astrCwewbcode[i].equals("")) continue;
				WaybillfortrackCondition objWBFTCondition = new WaybillfortrackCondition();
				WaybilltrackCondition objWBTCondition = new WaybilltrackCondition();
				Track objTrack = new Track();
				
				SimplecorewaybillColumns objSCWC = null;
				objSCWC = CorewaybillDemand.loadSimpleCorewaybill(astrCwewbcode[i], strCocode, "C");
				if (objSCWC != null) 
					objWBFTCondition.setCwcustomerewbcode(astrCwewbcode[i]);
				else {
					objSCWC = CorewaybillDemand.loadSimpleCorewaybill(astrCwewbcode[i],strCocode, "S");
					if(objSCWC != null)
						objWBFTCondition.setCwserverewbcode(astrCwewbcode[i]);
					else {
						objSCWC = CorewaybillDemand.loadSimpleCorewaybill(astrCwewbcode[i],strCocode, "E");
						if(objSCWC != null)
							objWBFTCondition.setCwewbcode(astrCwewbcode[i]);
						else
							continue;
					}
				}

				// objWBFTCondition.setCcocode(strCocode);
				// objWBFTCondition.setPkcode("Y0085");
				
//				objWBFTCondition.setCwserverewbcode(astrCwewbcode[i]);
//				objWBFTCondition.setCwcustomerewbcode(astrCwewbcode[i]);
				if(StringUtility.isNull(strOpId)) {
					if (objSCWC != null) {
						CustomerColumns objCustomerColumns = CustomerDemand.load(objSCWC.getCwco_code_customer());
						if (objCustomerColumns != null && !StringUtility.isNull(objCustomerColumns.getCmcmwebtrackneedlogin()) && 
								objCustomerColumns.getCmcmwebtrackneedlogin().equals("Y"))
							continue;
						//objWBFTCondition.setNotccocode("198,338,295,1003483,382,260,18480,271,21940,22940,23700,24981,13000,14700,20700,42581,43601,42521,43081,43581,43961,43981,44241,44461");
					}
				}
				listWBFTColumns = (List<WaybillfortrackColumns>)TrackDemand.queryWaybillfortrack(objWBFTCondition);
				//运单号无对应的轨迹信息
				if(listWBFTColumns == null || listWBFTColumns.size()<1) continue;
				// index = 0 ;
				objWBFTColumns = listWBFTColumns.get(0);
				/*
				if (!objWBFTColumns.getPkpkcode().startsWith("Y00"))
					continue;				
				*/
				objWBTCondition.setCwcode(objWBFTColumns.getCwcwcode());
				listWBTColumns = TrackDemand.queryTrack(objWBTCondition);
				List<WaybilltrackColumns> listWBTColumnsResults = new ArrayList<WaybilltrackColumns>();
				//处理发生地点和轨迹描述为空的情况(如查发生地点为空地用发生城市，如果轨迹描述为空则用轨迹状态)
				for(int j=0; j < listWBTColumns.size(); j++){
					WaybilltrackColumns objWaybilltrackColumns = (WaybilltrackColumns)listWBTColumns.get(j);
					if(StringUtility.isNull(objWaybilltrackColumns.getWbtwbtlocation())){
						objWaybilltrackColumns.setWbtwbtlocation(objWaybilltrackColumns.getDtdthubcode());
					} else {
						String strLocation = rebuildLocation(objWBFTColumns.getSchnchncode(), 
								objWaybilltrackColumns.getWbtwbtlocation());
						objWaybilltrackColumns.setWbtwbtlocation(strLocation);
					}
					if(StringUtility.isNull(objWaybilltrackColumns.getWbtwbtdescription())){
						objWaybilltrackColumns.setWbtwbtdescription(objWaybilltrackColumns.getWbtswbtsename());
					} else if (StringUtility.isNull(objWaybilltrackColumns.getWbtswbtscode())) {
						ChanneltrackmappingColumns objCTMC = ChanneltrackmappingDemand.query(objWaybilltrackColumns.getWbtwbtdescription(), 
								true);
						if (objCTMC != null && !StringUtility.isNull(objCTMC.getWtswbtsename())) {
							objWaybilltrackColumns.setWbtwbtdescription(objCTMC.getWtswbtsename());
						}
					}
					listWBTColumnsResults.add(objWaybilltrackColumns);
				}
				//无轨迹信息				
				if(listWBTColumnsResults == null || listWBTColumnsResults.size()<1){
					ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", new MessageBean(IBasicData.MSG_TYPE_ERROR,"查询轨迹出错","抱歉，没有查询出相关轨迹信息！"));
					return ERROR;
				}
				objWATColumns = objTrack.buildWebAccessTrackColumns(objWBFTColumns, listWBTColumnsResults);
				listWATColumns.add(objWATColumns);
			}
			if(listWATColumns.size()>0){
				request.setAttribute("listWATColumns", listWATColumns);
				return SUCCESS;
			}
		}
		ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", new MessageBean(IBasicData.MSG_TYPE_ERROR,"查询轨迹出错","抱歉，没有查询出相关轨迹信息！"));
		return ERROR;
	}
	
	/**
	 * 添加轨迹
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String addSingleTrack() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		WaybilltrackColumns objWBTColumns = new WaybilltrackColumns();
		String strCustomerewbcode = request.getParameter("strCustomerewbcode");
		String strOccurDate = request.getParameter("strOccurDate");
		String strLocation = request.getParameter("strLocation");
		String strDescription = request.getParameter("strDescription");
		//获得CwCode
		SimplecorewaybillQuery objSimplecorewaybillQue = new SimplecorewaybillQuery();
		SimplecorewaybillCondition objSimplecorewaybillCon = new SimplecorewaybillCondition();
		objSimplecorewaybillCon.setCw_customerewbcode(strCustomerewbcode);
		objSimplecorewaybillQue.setCondition(objSimplecorewaybillCon);
		List objList = objSimplecorewaybillQue.getResults();
		System.out.println("The result size of query object by customerewbcode: "+objList.size());
		objWBTColumns.setWbbtcwcode(Long.valueOf(((SimplecorewaybillColumns)objList.get(0)).getCwcw_code()));
		System.out.println("strOccurDate: "+strOccurDate);
		objWBTColumns.setWbtwbtoccurdate(DateFormatUtility.getStandardDate(strOccurDate));
		objWBTColumns.setWbtwbtlocation(strLocation);
		objWBTColumns.setWbtwbtdescription(strDescription);
		
		objWBTColumns.setWbtwbtopensign("Y");
		objWBTColumns.setCococode((String)session.getAttribute("Cocode"));
		//objWBTColumns.setWbtswbtscode(strWbtscode);
		
		SaveWBTrackTransaction objSaveWBTrackTrans = new SaveWBTrackTransaction();
		objSaveWBTrackTrans.setParam(objWBTColumns, (String)session.getAttribute("OpId"), false);
		objSaveWBTrackTrans.execute();
		return SUCCESS;
	}
	
	public String deleteTrack() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		String strCwcode = request.getParameter("cwcwcode");
		String[] astrWbtid = request.getParameterValues("wbtwbtid");
		System.out.println(astrWbtid.length);
		if(StringUtility.isNull(strCwcode) || astrWbtid.length<1 || astrWbtid == null)
			return SUCCESS;
		Track objTrack = new Track();
		objTrack.delete(astrWbtid, strCwcode);
		return SUCCESS;
	}
	
	/**
	 * 批量上传轨迹
	 * @return
	 * @throws Exception
	 */
	/*public String addBatchTrack() throws Exception
	{
		List<WaybilltrackColumns> listWBTColumns = (List<WaybilltrackColumns>)ServletActionContext.getRequest().getAttribute("listWBTColumns");
		for(WaybilltrackColumns objWaybilltrackColumns:listWBTColumns)
		{
			SaveWBTrackTransaction objSaveWBTrackTrans = new SaveWBTrackTransaction();
			objSaveWBTrackTrans.setParam(objWaybilltrackColumns, (String)ServletActionContext.getRequest().getSession().getAttribute("OpId"), false);
			objSaveWBTrackTrans.execute();
		}
		return SUCCESS;
	}*/
	
	/**
	 * 保存轨迹(批量上传轨迹)
	 * @return
	 */
//	public String uploadBatchTracks() {
//		try {
//			fileName = DateUtility.getFileTimeStamp() + "_"
//					+ getFileName(fileName) + getExtention(fileName);
//			String dirs = ServletActionContext.getServletContext().getRealPath(
//					"UploadFiles/Tracks");
//			File dirsFile = new File(dirs);
//			if (!dirsFile.exists()) {
//				dirsFile.mkdirs();
//			}
//			File desFile = new File(dirs + "/" + fileName);
//			desFile.createNewFile();
//			System.out.println("文件保存在：        " + dirs + "/" + fileName);
//			copy(uploadFile, desFile);
//
//			// 读取Excel
//			Workbook book = Workbook.getWorkbook(desFile);
//			Sheet sheet = book.getSheet(0);
//			int rows = sheet.getRows();
//			System.out.println("行值为：" + rows);
//			int columns = sheet.getColumns();
//			System.out.println("列值为：" + columns);
//			List<WaybilltrackColumns> listWBTColumns = new ArrayList<WaybilltrackColumns>();
//			HttpSession session = ServletActionContext.getRequest().getSession();
//			for (int i = 1; i < rows; i++) {
//				WaybilltrackColumns objWBTColumns = new WaybilltrackColumns();
//				String[] arrayValues = new String[columns];
//				for (int j = 0; j < columns; j++) {
//					Cell cell = sheet.getCell(j,i);
//					String strValues;
//					if(cell.getType()==CellType.DATE && j!=2)
//					{
//						SimpleDateFormat sdfm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//						System.out.println("after format: "+sdfm.format(((DateCell)cell).getDate()));
//						
//						strValues = sdfm.format(((DateCell)cell).getDate());
//						arrayValues[j] = strValues;
//						continue;
//					}
//					strValues = cell.getContents();
//					if(StringUtility.isNull(strValues)) break;//列不为空,以防插入空数据。
//					arrayValues[j] = strValues;
//				}
//				
//				if(StringUtility.isNull(arrayValues[0]))break;//行不为空,以防插入空数据。
//				//获得CwCode
//				SimplecorewaybillQuery objSimplecorewaybillQue = new SimplecorewaybillQuery();
//				SimplecorewaybillCondition objSimplecorewaybillCon = new SimplecorewaybillCondition();
//				objSimplecorewaybillCon.setCw_customerewbcode(arrayValues[0]);
//				objSimplecorewaybillQue.setCondition(objSimplecorewaybillCon);
//				List objList = objSimplecorewaybillQue.getResults();
//				//System.out.println("The result size of query object by customerewbcode: "+objList.size());
//				objWBTColumns.setWbbtcwcode(Long.valueOf(((SimplecorewaybillColumns)objList.get(0)).getCwcw_code()));
//				String strTime = arrayValues[2];
//				if(strTime.length()<5)//当小时为个位数时前面加 0
//					strTime = "0"+strTime;
////				objWBTColumns.setWbtwbtoccurdate(DateFormatUtility.getStringDate(arrayValues[1].substring(0,10)+" "+strTime+":00","yyyy-MM-dd HH:mm:ss"));
//				objWBTColumns.setWbtwbtoccurdate(DateFormatUtility.getStandardDate(arrayValues[1].substring(0,10)+" "+strTime+":00"));
//				
//				objWBTColumns.setWbtwbtlocation(arrayValues[3]);
//				objWBTColumns.setWbtwbtdescription(arrayValues[4]);
//				
//				objWBTColumns.setWbtwbtopensign("Y");
//				objWBTColumns.setCococode((String)session.getAttribute("Cocode"));
//				//objWBTColumns.setWbtswbtscode(strWbtscode);
//				listWBTColumns.add(objWBTColumns);
//				//ServletActionContext.getRequest().setAttribute("listWBTColumns", listWBTColumns);
//			}
//			System.out.println("listWBTColumns.size is :   "
//					+ listWBTColumns.size());
//			//保存轨迹
//			for(WaybilltrackColumns objWaybilltrackColumns:listWBTColumns)
//			{
//				SaveWBTrackTransaction objSaveWBTrackTrans = new SaveWBTrackTransaction();
//				objSaveWBTrackTrans.setParam(objWaybilltrackColumns, (String)session.getAttribute("OpId"), false);
//				objSaveWBTrackTrans.execute();
//			}
//			return SUCCESS;
//		} catch (BiffException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		ServletActionContext.getRequest().getSession().setAttribute(IBasicData.MSG_TYPE_ERROR,"MESSAGEBEAN", new MessageBean(IBasicData.MSG_TYPE_ERROR,"添加轨迹出错","抱歉，批量添加轨迹失败！请确保格式正确！"));
//		return ERROR;
//	}

	/**
	 * 取后辍
	 * @param fileName
	 * @return
	 */
	@SuppressWarnings("unused")
	private static String getExtention(String fileName) {
		return fileName.substring(fileName.lastIndexOf("."));
	}

	/**
	 * 取文件名(除后辍后的文件名)
	 * @param fileName
	 * @return
	 */
	@SuppressWarnings("unused")
	private static String getFileName(String fileName) {
		return fileName.substring(0, fileName.lastIndexOf("."));
	}

	/**
	 * 把上传的文件复制到服务器
	 * @param src
	 * @param des
	 */
	@SuppressWarnings("unused")
	private static void copy(File src, File des) {
		try {
			InputStream in = null;
			OutputStream out = null;
			try {
				in = new BufferedInputStream(new FileInputStream(src),BUFFERSIZE);
				out = new BufferedOutputStream(new FileOutputStream(des),BUFFERSIZE);
				byte[] buffer = new byte[BUFFERSIZE];
				while (in.read(buffer) > 0) {
					out.write(buffer);
				}
			} finally {
				if (in != null) {
					in.close();
				}
				if (out != null) {
					out.close();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String rebuildLocation(String strChncode, 
			String strOriginLocation) {
		if (StringUtility.isNull(strChncode))
			return strOriginLocation;
		try {
			TchnChannel objTchnChannel = TchnChannelDC.loadByKey(strChncode);
			String strSsgcode = objTchnChannel.getTdiServerstructuregroup().getSsgCode();
			if (StringUtility.isNull(strSsgcode))
				return strOriginLocation;
			
			SingleTrackDepositor objSTD;
			if (strSsgcode.equals("FDX")) {
				objSTD = new FedexTrackDepositor();
				return objSTD.rebuildLocation(strOriginLocation);
			} else if (strSsgcode.equals("UPS")) {
				objSTD = new UPSTrackDepositor();
				return objSTD.rebuildLocation(strOriginLocation);			
			} else if (strSsgcode.equals("SAL")) {
				objSTD = new USPSTrackDepositor();
				return objSTD.rebuildLocation(strOriginLocation);					
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return strOriginLocation;
	}
	
}
