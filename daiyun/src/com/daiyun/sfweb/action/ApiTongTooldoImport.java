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
	
	//����ͨ;��ȡ���ݵ���Ҫ·����Ŀǰ�õĲ��Ե�ַ��
	// "112.74.27.18:8180";
	private final String mainUrl = "openapi.tongtool.com";
	//����һ��token
	private final String toKen = "9c362a49d4d34019a622f52ee8dc1bcd";
	
	/**
	 * ͨ;��������
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
		//��ȡ��������ݿ����token
//		String toKen = tokenColumns.getCawtcawttoken();
		
		
		ApiTongToolDate tt=new ApiTongToolDate();
		//��ѯ����ʼʱ��
		String since= startdate;
		
		/*ͨ;����״̬
		 * WAIT_UPLOAD �ȴ���������ϵͳ�µ�
		 * WAIT_CONFIRM �ȴ���������ϵͳ����
		 * CONFIRM�ͻ��Ѿ����˵���û�з���
		 * WAIT_CANCEL�ȴ���������ϵͳȡ��
		 * FAILURE������ϵͳ����ʧ��
		 * 
		 * Ϊ��ʱ��ȡ����״̬
		 */
		String orderStatus ="WAIT_UPLOAD";
		//��ҳ���ص�һҳ����������������Դ���1��500��ֵ��Ĭ��Ϊ50
		String limit="";
		//������������
		//��Ŀǰ��û�жԽӣ������Ȳ����
		//�Խ�֮����Դ�pkCode��ȡ���Ӧ�ķ���������
		String shippingMethodCode = pkCode;
		
		List<PredictwaybillColumns> listPwbc =new ArrayList<PredictwaybillColumns>();
		List<List<PredictcargoinfoColumns>> listlsInfo =new ArrayList<List<PredictcargoinfoColumns>>();
		
		UserCondition objUserCondition = new UserCondition();
		objUserCondition.setOpid(opId);
		UserColumns objUrReturn = (UserColumns) UserDemand.query(objUserCondition).get(0);
		//У�鶩��ʱ��Ҫ��ǰ�û����û���
		String userName = objUrReturn.getOpopcode();
		String password=objUrReturn.getWord();
		
		boolean isNextToken = true;
		String nextToken = "";
		while (isNextToken) {
		String data = "";
		if(!StringUtility.isNull(nextToken)){
			data = tt.getDate(mainUrl, toKen, "", "", "", "",nextToken);
			if(StringUtility.isNull(data)){
				addActionMessage("<script>alert('��ȡ�ڶ�ҳ����ʧ�ܣ�');</script>"); 
				return SUCCESS;
			}
		}else{
			data = tt.getDate(mainUrl, toKen, since, orderStatus, limit, shippingMethodCode,"");
			if(StringUtility.isNull(data)){
			addActionMessage("<script>alert('��ȡ����ʧ�ܣ�');</script>"); 
			return SUCCESS;
			}
		}
		
		//������Ӵ�����֤
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
		//��ÿ�ν�������������ͳһ������������һ���ύ���롣
		for(int i=0;i<listPc.size();i++){
			listPwbc.add(listPc.get(i));
			listlsInfo.add(listInfo.get(i));
		}
		}
		
		if(listPwbc == null || listPwbc.size()==0){
		addActionMessage("<script>alert('û����Ҫ����Ķ���!');</script>"); 
		return SUCCESS;
		}
		
		List<ERPEntity> listErp = tt.doImport(listPwbc,listlsInfo,opId);

		List<CwbimportrowColumns> cwbimportrowColumns = new ArrayList<CwbimportrowColumns>(); // ��¼��־��Ϣ
		int totalSize = 0;
		int normalSize = 0;
		totalSize=listErp.size();
		long rowNumber = 0;
		for (int i=0;i<listErp.size();i++){
			ERPEntity erp =listErp.get(i);
			CwbimportrowColumns rowColumns = new CwbimportrowColumns();
			rowColumns.setCwbrcomp_idcwbrid(++rowNumber);
			StringBuilder remarkSb = new StringBuilder("�ͻ����ţ�" + listPwbc.get(i).getPwbpwb_orderid()+ "��");
			String ttPacketId = listPwbc.get(i).getPwbpwb_orderid();
			if (erp.isIsSuccess()) {
				normalSize++;
				rowColumns.setCwbrcwbrsuccesssign("Y");
				//��д����
				tt.returnOrder(mainUrl, toKen, ttPacketId, "C" ,userName,password, erp.getCode(), erp.getServiceNumber(), "");
			} else {
				rowColumns.setCwbrcwbrsuccesssign("N");
				remarkSb.append(erp.getErrorMessage()+ "��");
				tt.returnOrder(mainUrl, toKen, ttPacketId, "E" ,"","", erp.getCode(), "", erp.getErrorMessage());
			}
			rowColumns.setCwbrcwbrremark(remarkSb.toString());
			cwbimportrowColumns.add(rowColumns);
			
		}
		// ������־
		Cwbimportlog cwbimportlog = new Cwbimportlog();
		CustomerapiwebtokenCondition condition = new CustomerapiwebtokenCondition();
		condition.setCawtcawtid(cawtId);
		CustomerapiwebtokenColumns customerapiweb = CustomerApiWebDemand.query(condition).get(0);
		String remark = "�������ͣ�" + customerapiweb.getCapwtcapwtname() + "���������ƣ�" 
		+ customerapiweb.getCawtcawtusername() +  "����ʼʱ�䣺" + startdate + "������ʱ�䣺" + enddate;
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
	 * ����ͨ;����
	 * @return
	 * @throws Exception
	 */
	public String saveTTStore()throws Exception{
//		String apiId = request.getParameter("apiId");
//		String apiKey = request.getParameter("apiKey");
		/**
		 * ͨ;��δд��API�ӿڻ�ȡtoken,������ʱ�ֶ����롣
		 * ��ʱ��ͨ���˻������ȡ��Ӧ��token,��������ݿ⡣
		 */
		//��ʱ�ֶ�����token
//		String token = apiKey;
		// �ж��˺��س��Ƿ���ʹ��
		String coCode = (String) session.getAttribute("Cocode");
//		CustomerapiwebtokenCondition condition = new CustomerapiwebtokenCondition();
//		condition.setCococode(coCode);
//		condition.setCawtcawttoken(token);
//		if (!CustomerApiWebDemand.query(condition).isEmpty()) {
//			addActionMessage("<script>alert('��token�Ѿ�ʹ��!');</script>"); 
//			return SUCCESS;
//		}
		CustomerApiWeb customerApiWeb = new CustomerApiWeb();
		// ���������Ƿ��ѱ�ռ��
		String storeName = request.getParameter("storeName");
		CustomerapiwebtokenCondition condition = new CustomerapiwebtokenCondition();
		condition.setCococode(coCode);
		condition.setCawtcawtusername(storeName);
		if (!CustomerApiWebDemand.query(condition).isEmpty()) {
			addActionMessage("<script>alert('��������[" + storeName + "]�ѱ�ռ��!');</script>"); 
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
//			//У��token
//			JSONObject result =  JSONObject.fromObject(data);
//			String ack = result.getString("ack");
//			if("Failure".equals(ack)){
//				String errorCode = result.getString("errorCode");
//				if(errorCode.equals("0002")){
//					addActionMessage("<script>alert('"+"token����!����ϵͨ;�ͷ���ȡ��ȷ��token��"+"');</script>"); 
//				}else{
//					String errorMessage = result.getString("errorMessage");
//					addActionMessage("<script>alert('"+errorMessage+"');</script>"); 
//				}
//				return SUCCESS;
//			}
//		}
		
		// �������
		String apiwebType = request.getParameter("apiwebType");
		CustomerapiwebtokenColumns customerapiwebtokenColumns = new CustomerapiwebtokenColumns();
		customerapiwebtokenColumns.setCococode(coCode);
		customerapiwebtokenColumns.setCapwtcapwtcode(apiwebType);
		customerapiwebtokenColumns.setCawtcawtusername(storeName);
//		customerapiwebtokenColumns.setCawtcawttoken(token);
		customerApiWeb.save(customerapiwebtokenColumns);
		
		addActionMessage("<script>alert('��ϲ�㣬���걣��ɹ�!');</script>"); 
		
		return SUCCESS;
	}
	/**
	 * ��ӵ���
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
