package com.daiyun.sfweb.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;

import net.sf.json.JSONObject;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.DateUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.common.util.prompt.PromptUtilityCollection;
import kyle.leis.eo.operation.cwbimportlog.bl.Cwbimportlog;
import kyle.leis.eo.operation.cwbimportlog.bl.Cwbimportrow;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportlogColumns;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportlogCondition;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportlogQuery;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportlogQueryEX;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportrowColumns;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportrowQuery;
import kyle.leis.eo.operation.cwbimportlog.dax.CwbimportlogDemand;
import kyle.leis.eo.operation.predictwaybill.baseorderimport.ApiWebAuthor;
import kyle.leis.eo.operation.predictwaybill.baseorderimport.ApiWebManager;
import kyle.leis.eo.operation.predictwaybill.baseorderimport.ApiWebToken;
import kyle.leis.eo.operation.predictwaybill.baseorderimport.AuthUrlResult;
import kyle.leis.eo.operation.predictwaybill.baseorderimport.IsAuthorizedResult;
import kyle.leis.eo.operation.predictwaybill.baseorderimport.OrderImportResult;
import kyle.leis.eo.operation.predictwaybill.baseorderimport.OrderImportor;
import kyle.leis.eo.operation.predictwaybill.baseorderimport.RedirectParam;
import kyle.leis.eo.operation.predictwaybill.da.PredictcargoinfoColumns;
import kyle.leis.eo.operation.predictwaybill.da.PredictwaybillColumns;
import kyle.leis.eo.operation.predictwaybill.mabang.ApiAcquireMBDate;
import kyle.leis.eo.operation.predictwaybill.mabang.ApiLinkEntity;
import kyle.leis.eo.operation.predictwaybill.mabang.ERPEntity;
import kyle.leis.eo.operation.predictwaybill.mabang.MabangUtil;
import kyle.leis.es.company.customer.bl.CustomerApiWeb;
import kyle.leis.es.company.customer.da.CustomerapiwebtokenColumns;
import kyle.leis.es.company.customer.da.CustomerapiwebtokenCondition;
import kyle.leis.es.company.customer.dax.CustomerApiWebDemand;

public class ApiDatadoImport extends ActionSupportEX {
	
	private static final long serialVersionUID = 1L;
	private static final String REDIRECT_URI = "/order/addStoreUI";
	private String authUrl;

	/**
	 * 马帮订单导入
	 * @return
	 * @throws Exception 
	 */
	
	@SuppressWarnings("unchecked")
	public String doMabangImport() throws Exception{
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String pkCode = request.getParameter("pkCode");
		String apiwebType = request.getParameter("apiwebType");
		String cawtId = request.getParameter("store");
		String coCode = (String) session.getAttribute("Cocode");
		String opId = (String) session.getAttribute("OpId");
		//默认设定好apiAccountId和apiKey.
//		CustomerapiwebtokenCondition tokenCondition = new CustomerapiwebtokenCondition();
//		tokenCondition.setCococode(coCode);
//		tokenCondition.setCawtcawtid(cawtId);
//		tokenCondition.setCapwtcapwtcode(apiwebType);
//		CustomerapiwebtokenColumns tokenColumns =(CustomerapiwebtokenColumns)CustomerApiWebDemand.query(tokenCondition).get(0);
//		String token = tokenColumns.getCawtcawttoken();
//		String[] tokenStr = token.split("\\|"); 
		CustomerapiwebtokenCondition tokenCondition = new CustomerapiwebtokenCondition();
		tokenCondition.setCococode(coCode);
		tokenCondition.setCawtcawtid(cawtId);
		tokenCondition.setCapwtcapwtcode(apiwebType);
		CustomerapiwebtokenColumns tokenColumns =(CustomerapiwebtokenColumns)CustomerApiWebDemand.query(tokenCondition).get(0);
		//将token替换为用户标识
		String userCode = tokenColumns.getCawtcawttoken();
		
			String api = "api.biaoju.order.find";
			//正式版的api
			String apiAccountId ="487";
			String apiKey = "ffed2a6a36d57019c697088d034e5c57";
			//测试版的api
//			String apiAccountId ="156";
//			String apiKey = "8d7fa684fcf5717df8d09d3549c27ac4";
			
			//获取数据的主要地址
			String mainUrl = "http://www.i8956.com/interface/index.php";
			//测试地址
//			String mainUrl = "http://www.sandbox.i8956.com/interface/index.php";
			//json参数
			String jsonParams = MabangUtil.getParams(startdate,enddate);
			ApiAcquireMBDate ad =new ApiAcquireMBDate();
			ApiLinkEntity linkEntity = new ApiLinkEntity();
			linkEntity.setApi(api);
			linkEntity.setApiAccountId(apiAccountId);
			linkEntity.setApiKey(apiKey);
			linkEntity.setMainUrl(mainUrl);
			linkEntity.setJsonParams(jsonParams);
			String data = ad.linkData(linkEntity);
			JSONObject jsonData =  JSONObject.fromObject(data);
			String isErrorCode = jsonData.getString("ErrorCode");
			
			if(isErrorCode.equals("1014")){
				addActionMessage("<script>alert('API账号和秘匙有误,请联系客户人员!');</script>"); 
				request.setAttribute("cawtId", cawtId);
				return SUCCESS;
			}else if(isErrorCode.equals("1015")){
				addActionMessage("<script>alert('API方法已过期,请联系客户人员!');</script>"); 
				return SUCCESS;
			}
//			System.out.println(data);
			Map<String,Object> map = ad.getSaveDataColumns(data, opId, pkCode, coCode,linkEntity);
			List<List<PredictcargoinfoColumns>> listlsInfo =null;
			List<PredictwaybillColumns> listPwbc =null;
			List<ERPEntity> listErp =null;
			if(map!=null){
				listPwbc =(List<PredictwaybillColumns>)map.get("listPwbc");
				listlsInfo =(List<List<PredictcargoinfoColumns>>)map.get("listlsInfo");
				listErp =ad.doImport(listPwbc,listlsInfo,opId);
			}
			//修改
//	      	PredictOrderEX objPredictOrderEX = new PredictOrderEX(true);
//        	InputAllQReturn objIAQR = objPredictOrderEX.save(objUserColumns.getCococode(), 
//        			objPredictOrderColumnsEX, 
//        			opId, 
//        			true,
//        			false);
			//修改
			if(listErp==null || listErp.size() == 0){
				addActionMessage("<script>alert('没有需要导入的订单!');</script>"); 
				return SUCCESS;
			}
			
			List<CwbimportrowColumns> cwbimportrowColumns = new ArrayList<CwbimportrowColumns>(); // 记录日志信息
			int totalSize = 0;
			int normalSize = 0;
			totalSize=listErp.size();
			long rowNumber = 0;
			linkEntity.setApi("api.biaoju.order.update");
			for (int i=0;i<listErp.size();i++){
				CwbimportrowColumns rowColumns = new CwbimportrowColumns();
				rowColumns.setCwbrcomp_idcwbrid(++rowNumber);
				StringBuilder remarkSb = new StringBuilder("客户单号：" + listPwbc.get(i).getPwbpwb_orderid()+ "。");
				ERPEntity erp =listErp.get(i);
				if (erp.isIsSuccess()) {
//				if (listIAR.get(i).getPromptUtilityCollection()==null) {
					normalSize++;
					rowColumns.setCwbrcwbrsuccesssign("Y");
					String acceptParams = MabangUtil.getAcceptParams(erp);
					linkEntity.setJsonParams(acceptParams);
					ad.linkData(linkEntity);
				} else {
					rowColumns.setCwbrcwbrsuccesssign("N");
					remarkSb.append(erp.getErrorMessage() + "。");
					String exceptionParams = MabangUtil.getExceptionParams(erp);
					linkEntity.setJsonParams(exceptionParams);
					ad.linkData(linkEntity);
				}
				rowColumns.setCwbrcwbrremark(remarkSb.toString());
				cwbimportrowColumns.add(rowColumns);
				
			}
		// 插入日志
		Cwbimportlog cwbimportlog = new Cwbimportlog();
		CustomerapiwebtokenCondition condition = new CustomerapiwebtokenCondition();
		condition.setCawtcawtid(cawtId);
		CustomerapiwebtokenColumns customerapiweb = CustomerApiWebDemand.query(condition).get(0);
		String remark = "网店类型：" + customerapiweb.getCapwtcapwtname() + "，店铺名称：" 
		+ customerapiweb.getCawtcawtusername() +  "，开始时间：" + startdate + "，结束时间：" + enddate;
		CwbimportlogColumns cwbimportlogColumns = cwbimportlog.saveLog(opId, totalSize, 
				totalSize - normalSize, "", remark, null, new java.util.Date());
		Long cwlId = Long.valueOf(cwbimportlogColumns.getToccwlid());
		Cwbimportrow cwbimportrow = new Cwbimportrow();
		for (CwbimportrowColumns cwbrColumns : cwbimportrowColumns) {
			cwbrColumns.setCwbrtopcwbimportlogcwlid(cwlId);
			cwbimportrow.saveRow(cwbrColumns);
		}

		request.setAttribute("totalSize", totalSize);
		request.setAttribute("normalSize", normalSize);
		request.setAttribute("errorSize", totalSize - normalSize);

		return SUCCESS;
	}
	/**
	 * 马帮保存店铺
	 * @return
	 * @throws Exception 
	 */
	public String getERPStoreName() throws Exception{
//		String code = request.getParameter("code");
//		String apiId = request.getParameter("apiId");
//		String apiKey = request.getParameter("apiKey");

		// 判断账号秘匙是否已使用
		String coCode = (String) session.getAttribute("Cocode");
		CustomerapiwebtokenCondition condition = new CustomerapiwebtokenCondition();
//		condition.setCococode(coCode);
//		condition.setCawtcawttoken(toKey);
//		if (!CustomerApiWebDemand.query(condition).isEmpty()) {
//			addActionMessage("<script>alert('该标识已经存在!');</script>"); 
//			return SUCCESS;
//		}

		CustomerApiWeb customerApiWeb = new CustomerApiWeb();
		// 重新授权
//		String cawtId = request.getParameter("cawtId");
//		String reAuth = request.getParameter("reAuth");
//		if (!StringUtility.isNull(cawtId) && "0".equals(reAuth)) {
//			customerApiWeb.updateToken(cawtId, toKey);
//			response.getWriter().write("{\"status\": 0, \"msg\": \"恭喜你，网店重新授权成功!\"}");
//			return SUCCESS;
//		}
		// 店铺名称是否已被占用
		String storeName = request.getParameter("storeName");
		condition = new CustomerapiwebtokenCondition();
		condition.setCococode(coCode);
		condition.setCawtcawtusername(storeName);
		if (!CustomerApiWebDemand.query(condition).isEmpty()) {
			addActionMessage("<script>alert('店铺名称[" + storeName + "]已被占用!');</script>"); 
			return SUCCESS;
		}
		// 保存店铺
		String apiwebType = request.getParameter("apiwebType");
		CustomerapiwebtokenColumns customerapiwebtokenColumns = new CustomerapiwebtokenColumns();
		customerapiwebtokenColumns.setCococode(coCode);
		customerapiwebtokenColumns.setCapwtcapwtcode(apiwebType);
		customerapiwebtokenColumns.setCawtcawtusername(storeName);
//		customerapiwebtokenColumns.setCawtcawttoken(toKey);
		customerApiWeb.save(customerapiwebtokenColumns);
		addActionMessage("<script>alert('恭喜你，网店保存成功!');</script>"); 
		return SUCCESS;
	}

	/**
	 * 修改商铺API
	 * @return
	 * @throws Exception 
	 */
	public String updateStore() throws Exception{
		String apiId = request.getParameter("apiId");
		String apiKey = request.getParameter("apiKey");
		String cawtId = request.getParameter("cawtId");
		String toKey = apiId+"|"+apiKey;
		
		//检验重置账号是否与原来重复
		CustomerapiwebtokenCondition tokenCondition = new CustomerapiwebtokenCondition();
		tokenCondition.setCawtcawtid(cawtId);
		CustomerapiwebtokenColumns tokenColumns =(CustomerapiwebtokenColumns)CustomerApiWebDemand.query(tokenCondition).get(0);
		String cawttoken = tokenColumns.getCawtcawttoken();
		if(cawttoken.equals(toKey)){
			addActionMessage("<script>alert('请勿重复输入原账号和秘匙!');</script>"); 
			return "error";
		}
		
		String coCode = (String) session.getAttribute("Cocode");
		CustomerapiwebtokenCondition condition = new CustomerapiwebtokenCondition();
		condition.setCococode(coCode);
		condition.setCawtcawttoken(toKey);
		// 判断账号秘匙是否已使用
		if (!CustomerApiWebDemand.query(condition).isEmpty()) {
			addActionMessage("<script>alert('该api账号和秘匙已经使用!');</script>"); 
			return "error";
		}
		CustomerApiWeb customerApiWeb = new CustomerApiWeb();
		customerApiWeb.updateToken(cawtId, toKey);
		addActionMessage("<script>alert('api账号和秘匙修改成功!');</script>");
		return SUCCESS;
	}

	/**
	 * 添加店铺UI
	 * @return
	 * @throws Exception
	 * 速卖通跳转回界面
	 */
	public String addStoreUI() throws Exception{
		String state = request.getParameter("state");
		if (!StringUtility.isNull(state)) {
			String jsonString = new String(Base64.decodeBase64(state.getBytes()));
			System.out.println(jsonString);
			JSONObject jsonObject = JSONObject.fromObject(jsonString);
			request.setAttribute("cawtId", jsonObject.get("	"));
			request.setAttribute("reAuth", jsonObject.get("reAuth"));
			request.setAttribute("apiwebType", jsonObject.get("apiwebType"));
			request.setAttribute("storeName", jsonObject.get("storeName"));
		}
		return SUCCESS;//又一次跳转至添加界面?
	}

	/**
	 * 速卖通保存店铺
	 * @throws Exception
	 * update by wukq,2016-12-15
	 */
	public void addStore() throws Exception{
		response.setContentType("application/json; charset=utf-8");
		String apiwebType = request.getParameter("apiwebType");
		String clientID = request.getParameter("clientID");
		String appSecret = request.getParameter("appSecret");
		String tempAuthCode = (String)session.getAttribute("tempAuthCode");
		session.removeAttribute("tempAuthCode");
		String formalToken = null;
		try{
			ApiWebToken apiWebToken = ApiWebManager.getApiWebToken(apiwebType);
			formalToken = apiWebToken.getTokenFromWS(tempAuthCode, clientID, appSecret);
		}
		catch (Exception e){
			e.printStackTrace();
			response.getWriter().write((new StringBuilder("{\"status\": 1, \"msg\": \"")).append(e.getMessage()).append("\"}").toString());
			return;
		}
		String cawtId = request.getParameter("cawtId");
		String reAuth = request.getParameter("reAuth");
		CustomerApiWeb customerApiWeb = new CustomerApiWeb();
		if (!StringUtility.isNull(cawtId) && "0".equals(reAuth)){
			customerApiWeb.updateToken(cawtId, formalToken);
			response.getWriter().write("{\"status\": 0, \"msg\": \"恭喜你，网店重新授权成功!\"}");
			return;
		}
		String coCode = (String)session.getAttribute("Cocode");
		ApiWebAuthor apiWebAuthor = ApiWebManager.getApiWebAuthor(apiwebType);
		IsAuthorizedResult authorized = apiWebAuthor.isAuthorized(coCode, formalToken, clientID, appSecret);
		if (authorized.isAuthorized()){
			response.getWriter().write("{\"status\": 2, \"msg\": \"该网店已经授权，您可以选择其他网店授权!\"}");
			return;
		}
		String storeName = request.getParameter("storeName");
		CustomerapiwebtokenCondition condition = new CustomerapiwebtokenCondition();
		condition.setCococode(coCode);
		condition.setCawtcawtusername(storeName);
		if (!CustomerApiWebDemand.query(condition).isEmpty()){
			response.getWriter().write((new StringBuilder("{\"status\": 3, \"msg\": \"店铺名称[")).append(storeName).append("]已被占用!\"}").toString());
			return;
		} else{
			CustomerapiwebtokenColumns customerapiwebtokenColumns = new CustomerapiwebtokenColumns();
			customerapiwebtokenColumns.setCococode(coCode);
			customerapiwebtokenColumns.setCapwtcapwtcode(apiwebType);
			customerapiwebtokenColumns.setCawtcawtusername(storeName);
			customerapiwebtokenColumns.setCawtcawttoken(formalToken);
			customerapiwebtokenColumns.setCawtcawtpassword(authorized.getStoreID());
			customerApiWeb.save(customerapiwebtokenColumns);
			response.getWriter().write("{\"status\": 0, \"msg\": \"恭喜你，网店授权成功!\"}");
			return;
		}
	}

	/**
	 * 根据网店类型加载店铺
	 * @return
	 * @throws Exception
	 */
	public String loadStores() throws Exception{
		String coCode = (String) session.getAttribute("Cocode");
		String apiwebType = request.getParameter("apiwebType");
		CustomerapiwebtokenCondition condition = new CustomerapiwebtokenCondition();
		condition.setCapwtcapwtcode(apiwebType);
		condition.setCococode(coCode);
		List<CustomerapiwebtokenColumns> list = CustomerApiWebDemand.query(condition);
		request.setAttribute("stores", list);
		return SUCCESS;
	}

	/**
	 * 速卖通导入UI
	 * @return
	 * @throws IOExceptio] 
	 * update by wukq,2016-12-15
	 */
	@SuppressWarnings("unchecked")
	public String aliexpressImportUI() throws Exception{
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String pkCode = request.getParameter("pkCode");
		if (StringUtility.isNull(startdate))
			startdate = DateUtility.getMoveDate(-3);
		if (StringUtility.isNull(enddate))
			enddate = DateFormatUtility.getStandardDate(new Date(System.currentTimeMillis()));
		CwbimportlogQuery query = new CwbimportlogQueryEX();
		query.setOpid((String)session.getAttribute("OpId"));
		m_objPageConfig.setMaxPageResultCount(1);
		query.setPageConfig(m_objPageConfig);
		List cwbimportlogs = query.getResults();
		if (!cwbimportlogs.isEmpty()){
			CwbimportlogColumns cwbimportlogColumns = (CwbimportlogColumns)cwbimportlogs.get(0);
			request.setAttribute("lastLog", cwbimportlogColumns);
		}
		request.setAttribute("startdate", startdate);
		request.setAttribute("enddate", enddate);
		request.setAttribute("pkCode", pkCode);
		
		return SUCCESS;
	}

	/**
	 * 速卖通,易贝,导入订单
	 * @return
	 * @throws Exception 
	 * update by wukq,2016-12-15
	 */
	@SuppressWarnings("unchecked")
	public String doAliexpressImport() throws Exception{
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String pkCode = request.getParameter("pkCode");
		String apiwebType = request.getParameter("apiwebType");
		String cawtId = request.getParameter("store");
		String coCode = (String)session.getAttribute("Cocode");
		String opId = (String)session.getAttribute("OpId");
		ApiWebToken apiWebToken = ApiWebManager.getApiWebToken(apiwebType);
		if (apiWebToken == null){
			request.setAttribute("apiWebNotOpen", Integer.valueOf(0));
			return "success";
		}
		String accessToken = null;
		try{
			accessToken = apiWebToken.getTokenFromLocal(cawtId);
		}
		catch (Exception e){
			e.printStackTrace();
			request.setAttribute("tokenFailure", Integer.valueOf(0));
			request.setAttribute("cawtId", cawtId);
			return "success";
		}
		OrderImportor importor = ApiWebManager.getOrderImportor(apiwebType);
		OrderImportResult importResult = importor.doImport(startdate, enddate, accessToken, pkCode, coCode, opId, cawtId);
		PromptUtilityCollection promptUtilities = importResult.getPromptUtilities();
		if (promptUtilities != null && !promptUtilities.canGo(false)){
			request.setAttribute("error", promptUtilities.toString());
			return "success";
		}
		List cwbimportrowColumns = importResult.getCwbimportrowColumns();
		int totalSize = cwbimportrowColumns.size();
		int normalSize = importResult.getSuccessCount();
		Cwbimportlog cwbimportlog = new Cwbimportlog();
		CustomerapiwebtokenCondition condition = new CustomerapiwebtokenCondition();
		condition.setCawtcawtid(cawtId);
		CustomerapiwebtokenColumns customerapiweb = (CustomerapiwebtokenColumns)CustomerApiWebDemand.query(condition).get(0);
		String remark = (new StringBuilder("网店类型：")).append(customerapiweb.getCapwtcapwtname()).append("，店铺名称：").append(customerapiweb.getCawtcawtusername()).append("，开始时间：").append(startdate).append("，结束时间：").append(enddate).toString();
		CwbimportlogColumns cwbimportlogColumns = cwbimportlog.saveLog(opId, totalSize, totalSize - normalSize, "", remark, null, new java.util.Date());
		Long cwlId = Long.valueOf(cwbimportlogColumns.getToccwlid());
		Cwbimportrow cwbimportrow = new Cwbimportrow();
		CwbimportrowColumns cwbrColumns;
		for (Iterator iterator = cwbimportrowColumns.iterator(); iterator.hasNext(); cwbimportrow.saveRow(cwbrColumns)){
			cwbrColumns = (CwbimportrowColumns)iterator.next();
			cwbrColumns.setCwbrtopcwbimportlogcwlid(cwlId);
		}

		request.setAttribute("totalSize", Integer.valueOf(totalSize));
		request.setAttribute("normalSize", Integer.valueOf(normalSize));
		request.setAttribute("errorSize", Integer.valueOf(totalSize - normalSize));

		return SUCCESS;
	}
	
	/**
	 * 订单导入日志
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String aliImportLog() throws Exception{
		String strOpid = (String) session.getAttribute("OpId");
		String begindate=request.getParameter("startdate");
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
		CwbimportlogQuery clogq=new CwbimportlogQueryEX();
		clogq.setCondition(logCondition);
		List objCwbimportLog=clogq.getResults();
		request.setAttribute("cwbimportLogList", objCwbimportLog);

		request.setAttribute("startdate", begindate);
		request.setAttribute("enddate", enddate);
		request.setAttribute("totalRecode",totalRecode);
		return SUCCESS;
	}

	/**
	 * 日志详情
	 * @return
	 * @throws Exception
	 */
	public String aliImportLogDetail() throws Exception{
		String cwlId = request.getParameter("cwlId");

		CwbimportlogColumns importLog = CwbimportlogDemand.load(Long.valueOf(cwlId));
		request.setAttribute("importLog", importLog);

		CwbimportrowQuery query = new CwbimportrowQuery();
		query.setCwlid(cwlId);
		List<?> results = query.getResults();
		request.setAttribute("results", results);
		return SUCCESS;
	}
	
	/**
	 * 获取授权
	 * getAuthorizationUrl
	 * */
	public String getAuthorizationUrl() throws Exception{
		String cawtId = request.getParameter("cawtId");  
		String reAuth = request.getParameter("reAuth"); 
		String apiwebType = request.getParameter("apiwebType");
		String clientID = request.getParameter("clientID");//key
		String appSecret = request.getParameter("appSecret");//签名串
		if (!StringUtility.isNull(cawtId) && "0".equals(reAuth)) {
			CustomerapiwebtokenCondition condition = new CustomerapiwebtokenCondition();
			condition.setCawtcawtid(cawtId);
			CustomerapiwebtokenColumns apiwebtoken = CustomerApiWebDemand.query(condition).get(0);
			apiwebType = apiwebtoken.getCapwtcapwtcode();
			String appAcount = apiwebtoken.getCawtcawtpassword();
			if (!StringUtility.isNull(appAcount) && appAcount.contains(",")) {
				String[] appKey = appAcount.split(",");
				clientID = appKey[0];
				appSecret = appKey[1];
			}
		}
		String storeName = request.getParameter("storeName");
		session.setAttribute("storeName", storeName);
		ApiWebAuthor authUrlObj = ApiWebManager.getApiWebAuthor(apiwebType);
		if (authUrlObj == null) {
			response.setContentType("text/html; charset=utf-8");
			response.getWriter().write("抱歉，该网店尚未开通！");
			return null;
		}
		RedirectParam param = new RedirectParam(cawtId, reAuth, apiwebType, storeName);
		param.setClientID(clientID);
		param.setAppSecret(appSecret);
		String redirectURL = "http://" + request.getServerName();
		if (request.getServerPort() != 80) {
			redirectURL += ":" + request.getServerPort();
		}
		redirectURL += request.getContextPath() + REDIRECT_URI;
		AuthUrlResult authUrlResult = authUrlObj.getAuthUrl(redirectURL, param);
		authUrl = authUrlResult.getUrl();
		session.setAttribute("tempAuthCode", authUrlResult.getTempAuthCode());
		
		return SUCCESS;
	}
	
	
	public String getAuthUrl() {
		return authUrl;
	}

	public void setAuthUrl(String authUrl) {
		this.authUrl = authUrl;
	}
	
}
