package com.daiyun.pgweb.action;

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
import kyle.leis.eo.operation.corewaybill.da.SimplecorewaybillColumns;
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
	private File uploadFile;
	// 上传文件名
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
	

	/**
	 * 轨迹查询
	 * @return
	 * @throws Exception
	 */
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
	 * 取文件名(除后辍后的文件名)
	 * @param fileName
	 * @return
	 */
	private static String getFileName(String fileName) {
		return fileName.substring(0, fileName.lastIndexOf("."));
	}

	/**
	 * 把上传的文件复制到服务器
	 * @param src
	 * @param des
	 */
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
