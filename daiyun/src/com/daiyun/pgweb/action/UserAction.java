package com.daiyun.pgweb.action;

import java.io.File;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.StringUtility;

import kyle.leis.es.company.companys.bl.Companys;
import kyle.leis.es.company.companys.da.CorporationdColumns;
import kyle.leis.es.company.companys.da.CorporationdCondition;
import kyle.leis.es.company.companys.da.CorporationdQuery;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeColumns;
import kyle.leis.es.smsservice.da.SmsreceiveruleColumns;
import kyle.leis.es.smsservice.da.SmsreceiveruleCondition;
import kyle.leis.es.smsservice.dax.SmsserviceDemand;
import kyle.leis.es.smsservice.tp.DeleteSmsReceiveruleTrans;
import kyle.leis.es.smsservice.tp.SaveSmsReceiveruleTrans;
import kyle.leis.fs.authority.bl.Authority;
import kyle.leis.fs.authority.da.RolemenusColumns;
import kyle.leis.fs.authority.dax.RoleMenusReturn;
import kyle.leis.fs.authoritys.user.bl.User;
import kyle.leis.fs.authoritys.user.da.UserColumns;
import kyle.leis.fs.authoritys.user.da.UserCondition;
import kyle.leis.fs.authoritys.user.dax.UserDemand;

import kyle.leis.fs.dictionary.dictionarys.da.TcoCorporationDC;
import kyle.leis.fs.dictionary.operator.bl.Operator;
import kyle.leis.hi.TcoCorporation;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;
import com.daiyun.util.FileUtil;
import com.daiyun.util.ImageUtil;
import com.daiyun.util.tag.TreeNode;

public class UserAction extends ActionSupportEX {

	/**
	 * 
	 */
	private static final long serialVersionUID = -8542289874267902226L;

	private List m_listShipperInfo;
	private String m_strSccode;

	private ShipperconsigneeColumns m_objSCColumns;


	public ShipperconsigneeColumns getM_objSCColumns() {
		return m_objSCColumns;
	}

	public void setM_objSCColumns(ShipperconsigneeColumns m_objSCColumns) {
		this.m_objSCColumns = m_objSCColumns;
	}

	public List getListShipperInfo() {
		return m_listShipperInfo;
	}

	public void setListShipperInfo(List shipperInfo) {
		m_listShipperInfo = shipperInfo;
	}
	
	public String getSccode() {
		return m_strSccode;
	}
	
	public void setSccode(String strSccode) {
		m_strSccode = strSccode;
	}		
	
	public UserColumns webLogin(String strOpcode,String strPass) throws Exception {
		UserColumns objULReturn = null;
		// ...提示信息
		if (!StringUtility.isNull(strOpcode)
				&& !StringUtility.isNull(strPass)) {
			User objUser = new User();
			objULReturn = objUser.login(strOpcode, strPass);
		}
		return objULReturn;
	}
	
	public String login() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String strOperCode = request.getParameter("OperCode");
		String strWord = request.getParameter("Word");
		System.out.println(strWord);
		
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
					new MessageBean(IBasicData.MSG_TYPE_ERROR, "登录失败","输入的验证码不一致!"));
			return ERROR;
		}
		UserColumns objULReturn = null;
		// ...提示信息
		if (!StringUtility.isNull(strOperCode)&& !StringUtility.isNull(strWord)) {
			User objUser = new User();
			objULReturn = objUser.login(strOperCode, strWord);
		}
		if (objULReturn != null) {
			session.setAttribute("Eecode", objULReturn.getEeeecode());
			session.setAttribute("OpId", objULReturn.getOpopid());
			session.setAttribute("Opname", objULReturn.getOpopname());
			session.setAttribute("Opemail", objULReturn.getOpopemail());
			// 只做拦截器用
			kyle.baiqian.fs.authoritys.user.da.UserColumns obj = new kyle.baiqian.fs.authoritys.user.da.UserColumns();
			obj.setOpopid(Long.parseLong(objULReturn.getOpopid()));
			session.setAttribute("loginuser", obj);
			
			// 取得用户的职能，如果职能是G或者以GFI开头就放到session里
			String strFC_Code = objULReturn.getFcfccode();
			session.removeAttribute("FC_Code");
			session.removeAttribute("limit");
			if ("G".equals(strFC_Code) || strFC_Code.startsWith("GFI")) {
				session.setAttribute("FC_Code", strFC_Code);
			}else if("GOP".equals(strFC_Code)||"GCS".equals(strFC_Code)){
				session.setAttribute("limit","false");
			}else{
				ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
						new MessageBean(IBasicData.MSG_TYPE_ERROR, "登录失败","无效的用户职能，无法登录!"));
				return ERROR;
			}
			
			String strCocode = objULReturn.getCococode();
			if (StringUtility.isNull(strCocode))
				strCocode = "338";
			session.setAttribute("Cocode", strCocode);
			// 查找公司状态
			TcoCorporation objTcoCorporation = TcoCorporationDC.loadByKey(strCocode);
			if (!objTcoCorporation.getTdiCorporationstatus().getCsCode().equals("R")) {
				ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
						new MessageBean(IBasicData.MSG_TYPE_ERROR, "登录失败","我司正在审核，请耐心等待!"));
				return ERROR;					
			}
			request.setAttribute("objWebUserColumns", objULReturn);
			/**********************add by zzj***start**********************************/
			//获取用户菜单
			Authority authority = new Authority();
			RoleMenusReturn menusReturn = authority.queryGUIMenu(strOperCode, "LEWMIS", false);
			List<TreeNode> list = new ArrayList<TreeNode>();
			boolean b = (session.getAttribute("limit") == null);
			if (!menusReturn.isContainException()) {
				List<RolemenusColumns> rolemenusColumns = menusReturn.getRoleMenus();
				for (RolemenusColumns column : rolemenusColumns) {
					TreeNode node = new TreeNode();
					String gmCode = column.getGmstructurecode();
					node.setId(gmCode);
					if (gmCode.length() >= 3) {
						String pGmCode = gmCode.substring(0, gmCode.length() - 2);
						node.setpId(pGmCode);
					}
					node.setName(column.getGmname());
					node.setLink(column.getGmlink());
					if (gmCode.startsWith("B")) {
						if (b) {
							list.add(node);
						}
					} else {
						list.add(node);
					}
				}
			}
			session.setAttribute("menu", list);
			/**********************add by zzj***end**********************************/
			return SUCCESS;
		}
		ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
						new MessageBean(IBasicData.MSG_TYPE_ERROR, "登录失败","用户不存在或密码出错"));
		return ERROR;
	}
	 //保存用户信息
	public String save() {
		User objUser = new User();
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		// session 不为空则为当前用户新建新员工
		String strOperId = "";
		String regFlag = request.getParameter("regFlag");
		
		if (session.getAttribute("OpId") != null){
			strOperId = (String) session.getAttribute("OpId");
			objWebUserColumns.setOpopid(Long.valueOf(strOperId));
		}
		objWebUserColumns.setOpopid(Long.valueOf(strOperId));
		objWebUserColumns.setEeeecode("1");
		objWebUserColumns.setCococode((String)session.getAttribute("Cocode"));
		//objWebUserColumns.setCococode("1");
		
		
		System.out.println(objWebUserColumns.getDpdpcode());
		UserColumns objUserReturn = objUser.save(strOperId, objWebUserColumns);
		if (objUserReturn != null) {
			request.setAttribute("objWebUserColumns", objUserReturn);
			if (!StringUtility.isNull(regFlag) && regFlag.equals("0"))
				return INPUT;
			return SUCCESS;
		}
		ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
				new MessageBean(IBasicData.MSG_TYPE_ERROR, "保存用户出错","抱歉，保存用户失败！"));
		return ERROR;
	}

	public String modifyPassword() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		//String strOperId = request.getParameter("OperId");
		HttpSession session = request.getSession();
		String strOpId = null;
		if (!StringUtility.isNull(request.getParameter("OpId")))
			strOpId = request.getParameter("OpId");
		else if (!StringUtility.isNull((String) session.getAttribute("OpId")))
			strOpId = (String) session.getAttribute("OpId");
		else {
			strOpId = "1";
//			
//			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
//					new MessageBean(IBasicData.MSG_TYPE_ERROR, "查询出错","抱歉，查询用户出错！"));
//			return ERROR;
		}
		String strNewPassword = request.getParameter("NewPassword");
		if (StringUtility.isNull(strOpId)||StringUtility.isNull(strNewPassword)) {
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
					new MessageBean(IBasicData.MSG_TYPE_ERROR, "修改密码出错","抱歉，修改密码出错，请核对必填项！"));
			return ERROR;
		}
		Operator objOperator = new Operator();
		kyle.common.util.prompt.PromptUtility objPromptUtility = objOperator
				.modifyPassword(strOpId, "", strNewPassword);
		if (objPromptUtility != null) {
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
				new MessageBean(IBasicData.MSG_TYPE_ERROR, "修改密码出错",objPromptUtility.getDescribtion()));
			return ERROR;
		}
		return SUCCESS;
	}

	public String queryByOpId() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		UserColumns objUrReturn = null;
		String strOpId = null;
		if (!StringUtility.isNull(request.getParameter("OpId")))
			strOpId = request.getParameter("OpId");
		else if (!StringUtility.isNull((String) session.getAttribute("OpId")))
			strOpId = (String) session.getAttribute("OpId");
		else {
			strOpId = "1";
//			
//			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
//					new MessageBean(IBasicData.MSG_TYPE_ERROR, "查询出错","抱歉，查询用户出错！"));
//			return ERROR;
		}
		
		String coCode = (String)session.getAttribute("Cocode");
		CorporationdCondition condition = new CorporationdCondition();
		condition.setCocode(coCode);
		CorporationdQuery query = new CorporationdQuery();
		query.setCondition(condition);
		CorporationdColumns objCorporationdColumns =  (CorporationdColumns)query.getResults().get(0);;
		String strCobusipicurl = request.getContextPath()+"/download"+"/"+objCorporationdColumns.getCocobusinesspicurl();
		objCorporationdColumns.setCocobusinesspicurl(strCobusipicurl);
		request.setAttribute("objCorporationdColumns", objCorporationdColumns);
		
		UserCondition objUserCondition = new UserCondition();
		objUserCondition.setOpid(strOpId);
		objUrReturn = (UserColumns) UserDemand.query(objUserCondition).get(0);
		if (objUrReturn != null) {
			request.setAttribute("objWebUserColumns", objUrReturn);
//			System.out.println(objUrReturn.getOpopidnumberconfirmsign());
			return SUCCESS;
		}
		ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
				new MessageBean(IBasicData.MSG_TYPE_ERROR, "查询出错","抱歉，查询用户出错！"));
		return ERROR;
	}
	//查询当前用户下的用户列表
	public String queryUsersByCocode() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String strOpId = null;
		if (!StringUtility.isNull(request.getParameter("OpId"))){
			strOpId = request.getParameter("OpId");
		}
		else if (!StringUtility.isNull((String) session.getAttribute("OpId")))
			strOpId = (String) session.getAttribute("OpId");
		else {
			strOpId = "1";
		}
		String cocode=(String)session.getAttribute("Cocode");
		UserCondition objUserCondition = new UserCondition();
		m_objPageConfig.setMaxPageResultCount(8);
		objUserCondition.setPageConfig(m_objPageConfig);
		objUserCondition.setCocode(cocode);
		m_objPageConfig.setMaxPageResultCount(14);
		objUserCondition.setPageConfig(m_objPageConfig);
		List<UserColumns> list= UserDemand.query(objUserCondition);
		request.setAttribute("objWebUserList", list);
	
		request.setAttribute("pagevalue", 0);
		return SUCCESS;
		
	}
	
	
	
	
	
	//修改用户状态
	public String modifyCustomerStatues() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		String statues = null;
		String sOpid=null;
		statues=request.getParameter("statues");
		sOpid=request.getParameter("sOpid");
		Operator objOperator = new Operator();
		kyle.common.util.prompt.PromptUtility objPromptUtility= objOperator.modifyStatusNumber(sOpid, statues);
		if (objPromptUtility != null) {
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
				new MessageBean(IBasicData.MSG_TYPE_ERROR, "修改状态出错",objPromptUtility.getDescribtion()));
			return ERROR;
		}
		return SUCCESS;
	}
	
	//接受用户上传的身份证图片
	public String uploadIdMemberPic() throws Exception{
		String strOpId = null;
		if (!StringUtility.isNull(request.getParameter("OpId")))
			strOpId = request.getParameter("OpId");
		else if (!StringUtility.isNull((String) session.getAttribute("OpId")))
			strOpId = (String) session.getAttribute("OpId");
		else {
			strOpId = "1";			
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
					new MessageBean(IBasicData.MSG_TYPE_ERROR, "查询出错","抱歉，查询用户出错！"));
			return ERROR;
		}
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String path=request.getParameter("path");

		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String filestr = format.format(new Date());
		String imgtype1=uploadFile1FileName.substring(uploadFile1FileName.length()-3, uploadFile1FileName.length());
		String imgtype2=uploadFile2FileName.substring(uploadFile2FileName.length()-3, uploadFile2FileName.length());
		uploadFile1FileName=filestr+strOpId+"a."+imgtype1;
		uploadFile2FileName=filestr+strOpId+"b."+imgtype2;	
		if(StringUtility.isNull(uploadFile2FileName)||StringUtility.isNull(uploadFile1FileName))
			return null;	
		if(!StringUtility.isNull(uploadFile2FileName)){
		    if(ImageUtil.isImage(uploadFile2)){  //判断是否为图片
		
			FileUtil.UploadFile(uploadFile2FileName,"/download", uploadFile2);
			}else{
				return "上传图片异常!!请检查文件格式!!!";
			}
		}
		
		if(!StringUtility.isNull(uploadFile1FileName)){
		    if(ImageUtil.isImage(uploadFile1)){  //判断是否为图片
		
			FileUtil.UploadFile(uploadFile1FileName,"/download", uploadFile1);
			}else{
				return "上传图片异常!!请检查文件格式!!!";
			}
		}
		
		UserCondition objUserCondition = new UserCondition();
		objUserCondition.setOpid(strOpId);
		UserColumns objUserColumns = (UserColumns) UserDemand.query(objUserCondition).get(0);
		
		String fileUrl1=path+"download/"+uploadFile1FileName;
		String fileUrl2=path+"download/"+uploadFile2FileName;
		if(!StringUtility.isNull(uploadFile1FileName)){
		objUserColumns.setOpopidnumberpicurl(fileUrl1);
		}
		if(!StringUtility.isNull(uploadFile2FileName)){
		objUserColumns.setOpopidnumberrpicurl(fileUrl2);
		}
		if(!StringUtility.isNull(objWebUserColumns.getOpopidnumber())){
			objUserColumns.setOpopidnumber(objWebUserColumns.getOpopidnumber());
		}
		String realName = request.getParameter("realName");
		if(!StringUtility.isNull(realName)){
			objUserColumns.setOpopname(realName);
		}
		User objUser = new User();
		HttpServletResponse response =ServletActionContext.getResponse();
		objUserColumns.setOpopidnumberconfirmsign("Z");
		UserColumns objUserReturn = objUser.save(strOpId, objUserColumns);
		PrintWriter pw=response.getWriter();
		 pw.write("101");
		 pw.close();
		 return null;
	}
	/**
	 * 营业执照验证
	 * corporation
	 * @throws Exception 
	 * */
	public String BusinessLicenseValidate() throws Exception{
		String strOpId = null;
		String coName = request.getParameter("CompanyName");
		if (!StringUtility.isNull(request.getParameter("OpId")))
			strOpId = request.getParameter("OpId");
		else if (!StringUtility.isNull((String) session.getAttribute("OpId")))
			strOpId = (String) session.getAttribute("OpId");
		else {
			strOpId = "1";			
			ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
					new MessageBean(IBasicData.MSG_TYPE_ERROR, "查询出错","抱歉，查询用户出错！"));
			return ERROR;
		}
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String path=request.getParameter("path");
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String filestr = format.format(new Date());
		String imgtype1=uploadFile1FileName.substring(uploadFile1FileName.length()-3, uploadFile1FileName.length());
		uploadFile1FileName=coName+filestr+"_"+"BUS"+"."+imgtype1;
		if(StringUtility.isNull(uploadFile1FileName)){
			return null;	
		}
		
		if(!StringUtility.isNull(uploadFile1FileName)){
		    if(ImageUtil.isImage(uploadFile1)){  //判断是否为图片
		
			FileUtil.UploadFile(uploadFile1FileName,"/download", uploadFile1);//上传文件
			}else{
				return "上传图片异常!!请检查文件格式!!!";
			}
		}
		String coCode = (String)session.getAttribute("Cocode");
		CorporationdCondition condition = new CorporationdCondition();
		condition.setCocode(coCode);
		CorporationdQuery query = new CorporationdQuery();
		query.setCondition(condition);
		CorporationdColumns objCorporationcolumns =  (CorporationdColumns)query.getResults().get(0);;

		String fileUrl1=path+"download/"+uploadFile1FileName;
		if(!StringUtility.isNull(uploadFile1FileName)){
			objCorporationcolumns.setCocobusinesspicurl(uploadFile1FileName);//存路径长度不够，改存文件名
		}
		if(!StringUtility.isNull(coName)){//设置营业公司名
			objCorporationcolumns.setCoconame(coName);
		}
		objCorporationcolumns.setCocobpicconfirmsign("N");//营业执照未认证
		Companys companys = new Companys();
		companys.saveCorporation(objCorporationcolumns, strOpId);
		
		//request.setAttribute("objCorporationdColumns", columns);
		JSONObject json = new JSONObject();
		String returnStr =coName;
		json.accumulate("coName", coName);
		json.accumulate("Cocobusinesspicurl", fileUrl1);
		response.getWriter().print(json.toString());//上传成功标记
		return null;
		
	}
	
	/**
	 * 根据员工加载消息设置类型
	 * @return 
	 * @throws Exception
	 * */
	public String MessageSetting() throws Exception{
		String cocode = (String)session.getAttribute("Cocode");
		String strOpId = request.getParameter("opid");
		String opopname = request.getParameter("opname");
		if(strOpId == "" || strOpId == null){
			return SUCCESS;
		}
		//查询消息规则
		SmsreceiveruleCondition objSmsRuleCondition = new SmsreceiveruleCondition();
		objSmsRuleCondition.setCocode(cocode);
		objSmsRuleCondition.setOpid(strOpId);
		
		List smslist = SmsserviceDemand.querySmsreceiverule(objSmsRuleCondition);
		request.setAttribute("smslist", smslist);
		//JSONObject json = new JSONObject();
	
		//json.accumulate("smslist", smslist);
		//response.getWriter().write(json.toString());
		request.setAttribute("pagevalue", 1);
		request.setAttribute("opopname", opopname);
		request.setAttribute("opid", strOpId);
		return SUCCESS;
	
	}
	/**
	 * 新增或修改消息规则
	 * @throws Exception 
	 * */
	public String AddMessageSetting() throws Exception{
		opname = request.getParameter("opopname");
		opid  = request.getParameter("opid");
		String cocode = (String)session.getAttribute("Cocode");
		String[] mnkcode  =request.getParameterValues("mnkcode");
		String[] snkcode = request.getParameterValues("snkcode");
		String[] snott = request.getParameterValues("snott");
		String[] addstartdate = request.getParameterValues("addstartdate");
		String[] addenddate = request.getParameterValues("addenddate");
		//遍历snk_code,不能相同
		for(int i = 0 ;i< snkcode.length ;i++){
			for(int j = i+1; j <  snkcode.length;j++){
				if(snkcode[i] == snkcode[j]){
					return SUCCESS;
				}
			}
		}
		List<SmsreceiveruleColumns> listSmsrColumns = new ArrayList<SmsreceiveruleColumns>();
			for(int index = 0; index < mnkcode.length ; index ++){
				if(mnkcode[index] != "" && snkcode[index] !="" && snott[index] != ""){
					SmsreceiveruleColumns columns = new SmsreceiveruleColumns();
					columns.setMnkmnkcode(mnkcode[index]);
					columns.setSmsrcomp_idsnkcode(snkcode[index]);
					columns.setSnttsnttcode(snott[index]);
					
					if(snott[index] == "SNTT2"){//限制时间
						columns.setSnttsnttstarttime(addstartdate[index]);
						columns.setSnttsnttendtime(addenddate[index]);
					}
					columns.setSropid(Long.valueOf(opid));
					listSmsrColumns.add(columns);
			}
		}
		
		
		SaveSmsReceiveruleTrans objSaveSmsReceiveruleTrans = new SaveSmsReceiveruleTrans();
		
		objSaveSmsReceiveruleTrans.setParam(listSmsrColumns,cocode);
		objSaveSmsReceiveruleTrans.execute();

		return SUCCESS;//界面跳转，刷新
	}
	/**
	 * 删除选中的消息设置,LIST
	 * @throws Exception 
	 * */
	public String DeleteMessageSetting() throws Exception{
		
		opname = request.getParameter("opopname");
		opid  = request.getParameter("opid");
		if (!("".equals(request.getParameterValues("checkbox")) || request
				.getParameterValues("checkbox") == null)) {
			String[] strSnkCode= request.getParameterValues("checkbox");
			DeleteSmsReceiveruleTrans objDeleteSmsrrTrans = new DeleteSmsReceiveruleTrans();
			for(int index = 0 ; index < strSnkCode.length ;index ++ ){
				objDeleteSmsrrTrans.setParam(opid, strSnkCode[index]);
				objDeleteSmsrrTrans.execute();
			}
		
		}
		return SUCCESS;
	}

	
	private String opid;
	private String opname;
	private File uploadFile1;
	private File uploadFile2;
	private String uploadFile1FileName;
	
	private String uploadFile2FileName;
	
	
	public String getOpid() {
		return opid;
	}

	public void setOpid(String opid) {
		this.opid = opid;
	}

	public String getOpname() {
		return opname;
	}

	public void setOpname(String opname) {
		this.opname = opname;
	}

	public File getUploadFile1() {
		return uploadFile1;
	}

	public void setUploadFile1(File uploadFile1) {
		this.uploadFile1 = uploadFile1;
	}

	public File getUploadFile2() {
		return uploadFile2;
	}

	public void setUploadFile2(File uploadFile2) {
		this.uploadFile2 = uploadFile2;
	}

	
	public String getUploadFile1FileName() {
		return uploadFile1FileName;
	}

	public void setUploadFile1FileName(String uploadFile1FileName) {
		this.uploadFile1FileName = uploadFile1FileName;
	}

	public String getUploadFile2FileName() {
		return uploadFile2FileName;
	}

	public void setUploadFile2FileName(String uploadFile2FileName) {
		this.uploadFile2FileName = uploadFile2FileName;
	}
	public UserColumns objWebUserColumns;

	public UserColumns getObjWebUserColumns() {
		return objWebUserColumns;
	}

	public void setObjWebUserColumns(UserColumns objWebUserColumns) {
		this.objWebUserColumns = objWebUserColumns;
	}
	
	
	
	
	
}
