package com.daiyun.sfweb.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.operation.cwbimportlog.bl.Cwbimportlog;
import kyle.leis.eo.operation.cwbimportlog.bl.Cwbimportrow;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportlogColumns;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportrowColumns;
import kyle.leis.eo.operation.predictwaybill.da.PredictcargoinfoColumns;
import kyle.leis.eo.operation.predictwaybill.da.PredictwaybillColumns;
import kyle.leis.eo.operation.predictwaybill.mabang.ERPEntity;
import kyle.leis.eo.operation.predictwaybill.tongtool.ApiTongToolDate;
import kyle.leis.es.company.customer.bl.CustomerApiWeb;
import kyle.leis.es.company.customer.da.CustomerapiwebtokenColumns;
import kyle.leis.es.company.customer.da.CustomerapiwebtokenCondition;
import kyle.leis.es.company.customer.dax.CustomerApiWebDemand;
import kyle.leis.fs.authoritys.user.da.UserColumns;
import kyle.leis.fs.authoritys.user.da.UserCondition;
import kyle.leis.fs.authoritys.user.dax.UserDemand;

public class ApiTongTooldoImport extends ActionSupportEX {
	
	//设置通途获取数据的主要路径，目前用的测试地址。
	// "112.74.27.18:8180";
	private final String mainUrl = "openapi.tongtool.com";
	//共用一个token
	private final String toKen = "9c362a49d4d34019a622f52ee8dc1bcd";
	
	/**
	 * 通途订单导入
	 * @return
	 * @throws Exception 
	 */
	public String doTongToolImport()throws Exception{
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String pkCode = request.getParameter("pkCode");
		String apiwebType = request.getParameter("apiwebType");
		String cawtId = request.getParameter("store");
		String coCode = (String) session.getAttribute("Cocode");
		String opId = (String) session.getAttribute("OpId");
		
//		CustomerapiwebtokenCondition tokenCondition = new CustomerapiwebtokenCondition();
//		tokenCondition.setCococode(coCode);
//		tokenCondition.setCawtcawtid(cawtId);
//		tokenCondition.setCapwtcapwtcode(apiwebType);
//		CustomerapiwebtokenColumns tokenColumns =(CustomerapiwebtokenColumns)CustomerApiWebDemand.query(tokenCondition).get(0);
		//获取存放在数据库里的token
//		String toKen = tokenColumns.getCawtcawttoken();
		
		
		ApiTongToolDate tt=new ApiTongToolDate();
		//查询的起始时间
		String since= startdate;
		
		/*通途订单状态
		 * WAIT_UPLOAD 等待在物流商系统下单
		 * WAIT_CONFIRM 等待在物流商系统交运
		 * CONFIRM客户已经交运但是没有发货
		 * WAIT_CANCEL等待在物流商系统取消
		 * FAILURE物流商系统处理失败
		 * 
		 * 为空时获取所有状态
		 */
		String orderStatus ="WAIT_UPLOAD";
		//分页返回的一页最大限制数量，可以传入1到500的值，默认为50
		String limit="";
		//物流渠道参数
		//因目前还没有对接，所以先不添加
		//对接之后可以传pkCode获取相对应的服务渠道。
		String shippingMethodCode = pkCode;
		
		List<PredictwaybillColumns> listPwbc =new ArrayList<PredictwaybillColumns>();
		List<List<PredictcargoinfoColumns>> listlsInfo =new ArrayList<List<PredictcargoinfoColumns>>();
		
		UserCondition objUserCondition = new UserCondition();
		objUserCondition.setOpid(opId);
		UserColumns objUrReturn = (UserColumns) UserDemand.query(objUserCondition).get(0);
		//校验订单时需要当前用户的用户名
		String userName = objUrReturn.getOpopcode();
		String password=objUrReturn.getWord();
		
		boolean isNextToken = true;
		String nextToken = "";
		while (isNextToken) {
		String data = "";
		if(!StringUtility.isNull(nextToken)){
			data = tt.getDate(mainUrl, toKen, "", "", "", "",nextToken);
			if(StringUtility.isNull(data)){
				addActionMessage("<script>alert('获取第二页数据失败！');</script>"); 
				return SUCCESS;
			}
		}else{
			data = tt.getDate(mainUrl, toKen, since, orderStatus, limit, shippingMethodCode,"");
			if(StringUtility.isNull(data)){
			addActionMessage("<script>alert('获取数据失败！');</script>"); 
			return SUCCESS;
			}
		}
		
		//可以添加错误验证
		JSONObject result =  JSONObject.fromObject(data);
		String ack = result.getString("ack");
		if("Failure".equals(ack)){
			String errorMessage = result.getString("errorMessage");
			addActionMessage("<script>alert('"+errorMessage+"');</script>"); 
			return SUCCESS;
		}
		JSONArray jsData =  JSONArray.fromObject(result.get("data"));
		nextToken =jsData.getJSONObject(0).getString("nextToken");
		if(StringUtility.isNull(nextToken)||"null".equals(nextToken)){ 
			isNextToken = false;
		}
		Map<String,Object> map = tt.getPredictwaybillColumns(data,opId, pkCode, coCode,userName);
		List<List<PredictcargoinfoColumns>> listInfo =null;
		List<PredictwaybillColumns> listPc =null;
		List<ERPEntity> listErp =null;
		if(map!=null){
			listPc =(List<PredictwaybillColumns>)map.get("listPwbc");
			listInfo =(List<List<PredictcargoinfoColumns>>)map.get("listlsInfo");
		}
//		List<PredictwaybillColumns> listPc = tt.getPredictwaybillColumns(data,opId, pkCode, coCode,userName);
//		List<List<PredictcargoinfoColumns>> listInfo = tt.getPredictcargoinfoColumns(data,userName);
		//将每次解析出来的数据统一保存起来，再一起提交导入。
		for(int i=0;i<listPc.size();i++){
			listPwbc.add(listPc.get(i));
			listlsInfo.add(listInfo.get(i));
		}
		}
		
		if(listPwbc == null || listPwbc.size()==0){
		addActionMessage("<script>alert('没有需要导入的订单!');</script>"); 
		return SUCCESS;
		}
		
		List<ERPEntity> listErp = tt.doImport(listPwbc,listlsInfo,opId);

		List<CwbimportrowColumns> cwbimportrowColumns = new ArrayList<CwbimportrowColumns>(); // 记录日志信息
		int totalSize = 0;
		int normalSize = 0;
		totalSize=listErp.size();
		long rowNumber = 0;
		for (int i=0;i<listErp.size();i++){
			ERPEntity erp =listErp.get(i);
			CwbimportrowColumns rowColumns = new CwbimportrowColumns();
			rowColumns.setCwbrcomp_idcwbrid(++rowNumber);
			StringBuilder remarkSb = new StringBuilder("客户单号：" + listPwbc.get(i).getPwbpwb_orderid()+ "。");
			String ttPacketId = listPwbc.get(i).getPwbpwb_orderid();
			if (erp.isIsSuccess()) {
				normalSize++;
				rowColumns.setCwbrcwbrsuccesssign("Y");
				//回写订单
				tt.returnOrder(mainUrl, toKen, ttPacketId, "C" ,userName,password, erp.getCode(), erp.getServiceNumber(), "");
			} else {
				rowColumns.setCwbrcwbrsuccesssign("N");
				remarkSb.append(erp.getErrorMessage()+ "。");
				tt.returnOrder(mainUrl, toKen, ttPacketId, "E" ,"","", erp.getCode(), "", erp.getErrorMessage());
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
	 * 保存通途店铺
	 * @return
	 * @throws Exception
	 */
	public String saveTTStore()throws Exception{
//		String apiId = request.getParameter("apiId");
//		String apiKey = request.getParameter("apiKey");
		/**
		 * 通途还未写好API接口获取token,所以暂时手动输入。
		 * 届时再通过账户密码获取相应的token,保存进数据库。
		 */
		//暂时手动输入token
//		String token = apiKey;
		// 判断账号秘匙是否已使用
		String coCode = (String) session.getAttribute("Cocode");
//		CustomerapiwebtokenCondition condition = new CustomerapiwebtokenCondition();
//		condition.setCococode(coCode);
//		condition.setCawtcawttoken(token);
//		if (!CustomerApiWebDemand.query(condition).isEmpty()) {
//			addActionMessage("<script>alert('该token已经使用!');</script>"); 
//			return SUCCESS;
//		}
		CustomerApiWeb customerApiWeb = new CustomerApiWeb();
		// 店铺名称是否已被占用
		String storeName = request.getParameter("storeName");
		CustomerapiwebtokenCondition condition = new CustomerapiwebtokenCondition();
		condition.setCococode(coCode);
		condition.setCawtcawtusername(storeName);
		if (!CustomerApiWebDemand.query(condition).isEmpty()) {
			addActionMessage("<script>alert('店铺名称[" + storeName + "]已被占用!');</script>"); 
			return SUCCESS;
		}
//		String operationType = "A";
//		List<ProductkindColumnsEX> list = ProductkindDemand.getAllProduct();
//		String shippingMethodName = "";
//		String shippingMethodCode = "";
//		ApiTongToolDate attd = new ApiTongToolDate();
//		String data = "";
//		for(int i = 0;i<list.size();i++){
//			shippingMethodCode = list.get(i).getPkcode();
//			shippingMethodName =list.get(i).getPkname();
//			data = attd.setLogistics(mainUrl, toKen, operationType, shippingMethodName, shippingMethodCode);
//			//校验token
//			JSONObject result =  JSONObject.fromObject(data);
//			String ack = result.getString("ack");
//			if("Failure".equals(ack)){
//				String errorCode = result.getString("errorCode");
//				if(errorCode.equals("0002")){
//					addActionMessage("<script>alert('"+"token有误!请联系通途客服获取正确的token。"+"');</script>"); 
//				}else{
//					String errorMessage = result.getString("errorMessage");
//					addActionMessage("<script>alert('"+errorMessage+"');</script>"); 
//				}
//				return SUCCESS;
//			}
//		}
		
		// 保存店铺
		String apiwebType = request.getParameter("apiwebType");
		CustomerapiwebtokenColumns customerapiwebtokenColumns = new CustomerapiwebtokenColumns();
		customerapiwebtokenColumns.setCococode(coCode);
		customerapiwebtokenColumns.setCapwtcapwtcode(apiwebType);
		customerapiwebtokenColumns.setCawtcawtusername(storeName);
//		customerapiwebtokenColumns.setCawtcawttoken(token);
		customerApiWeb.save(customerapiwebtokenColumns);
		
		addActionMessage("<script>alert('恭喜你，网店保存成功!');</script>"); 
		
		return SUCCESS;
	}
	/**
	 * 添加店铺
	 * @return
	 * @throws Exception
	 */
	public String addTongtool(){
		String apiwebType = request.getParameter("apiwebType");
		String storeName = request.getParameter("storeName");
		request.setAttribute("apiwebType",apiwebType);
		request.setAttribute("storeName", storeName);
		return SUCCESS;
	}
}
