package com.daiyun.sfweb.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.dbaccess.cache.QueryCache;
import kyle.common.util.jlang.CollectionUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.billing.receivable.da.ReceivableforbillColumns;
import kyle.leis.eo.finance.dunning.da.FinancestatisticsColumns;

import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictColumns;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictCondition;
import kyle.leis.eo.operation.housewaybill.dax.HousewaybillDemand;

import kyle.leis.es.company.customer.bl.Customer;
import kyle.leis.es.company.customer.da.SimplecustomerColumns;
import kyle.leis.fs.authoritys.user.da.UserColumns;
import kyle.leis.fs.authoritys.user.tp.SaveUserTransaction;

import org.apache.struts2.ServletActionContext;
import com.daiyun.sfweb.da.PersonalcorewaybillColumns;
import com.daiyun.sfweb.da.PersonalcorewaybillCondition;
import com.daiyun.sfweb.da.PersonalcorewaybillQuery;
import com.daiyun.sfweb.da.SaveUserTransactionEX;
import com.daiyun.sfweb.da.UserConditionPlus;
import com.daiyun.sfweb.da.UserQueryPlus;

import com.daiyun.util.FinanceUtil;
import com.daiyun.util.TimeUtil;

/**
 * 20161115,
 * 用户注册，用户登录 支持手机号，
 * 邮件，姓名，公司名
 *  by wukq
 * */
@SuppressWarnings("serial")
public class LoginAction extends ActionSupportEX {
	/**
	 * 支持邮箱，手机号，用户名登录。
	 * @throws Exception 
	 * */
	@SuppressWarnings("unchecked")
	public String userLogin() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String opname = request.getParameter("username").toUpperCase();
		String password = request.getParameter("userpssword");
		String msg  = null;
		//验证码
		String validateCode = request.getParameter("validateCode");
		if (!StringUtility.isNull(validateCode))
			validateCode =  validateCode.toLowerCase();
		String sessionValidateCode = (String) session.getAttribute("CheckCodeImageAction");
		if (!StringUtility.isNull(validateCode) && 
				!StringUtility.isNull(sessionValidateCode) &&
				!validateCode.equals(sessionValidateCode.toLowerCase())) {
				msg = "errorPassword";
				printMsg(msg);
				return null;
		}
		UserColumns objULReturn = null;
		// ...提示信息
		if (!StringUtility.isNull(opname)&& !StringUtility.isNull(password)) {
			
			UserQueryPlus query = new UserQueryPlus();
			UserConditionPlus condition = new UserConditionPlus();
			List<UserColumns> results = new ArrayList<UserColumns>();
			
			Pattern p = Pattern.compile("^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$");//手机号
			Matcher m = p.matcher(opname);
			boolean IsPhoneNumber = m.matches();
			
			/**判断前台输入的用户名格式*/
			if(opname.indexOf("@") != -1){//邮箱
				condition.setOpemail(opname);
				query.setCondition(condition);
			}else if(IsPhoneNumber){
					condition.setOpmobile(opname);
					query.setCondition(condition);
			}else{
					condition.setOpcode(opname);//opCode
					query.setCondition(condition);
			}
			
			//没有用户名
			query.setUseCachesign(true);//使用缓冲
			results = query.getResults();
			if(results.size() == 0){
				//msg = "nouser";
				msg = "errorPassword";
				printMsg(msg);
				return null;
			}
			objULReturn  = results.get(0);
			if(!password.equals(objULReturn.getWord())){
				msg = "errorPassword";
				printMsg(msg);
				return null;
			}
		}	
		if (objULReturn != null) {
			
			sessionHelp(objULReturn);
			// 取得用户的职能，如果职能是G或者以GFI开头就放到session里
			String strFC_Code = objULReturn.getFcfccode();
			session.removeAttribute("FC_Code");
			session.removeAttribute("limit");
						
			if ("G".equals(strFC_Code) || strFC_Code.startsWith("GFI")) {
				session.setAttribute("FC_Code", strFC_Code);
			}else if("GOP".equals(strFC_Code)||"GCS".equals(strFC_Code) || "GSS".equals(strFC_Code)){
				session.setAttribute("limit","false");
			}else{
				//ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
				//		new MessageBean(IBasicData.MSG_TYPE_ERROR, "登录失败","无效的用户职能，无法登录!"));
				msg = "invalidFunciton";
				printMsg(msg);
				return null;
			}
			/*String strCocode = objULReturn.getCococode();
			if (StringUtility.isNull(strCocode))
				strCocode = "2";
			session.setAttribute("Cocode", strCocode);*/
			/*
			// 查找公司状态
			TcoCorporation objTcoCorporation = TcoCorporationDC.loadByKey(strCocode);
			if (!objTcoCorporation.getTdiCorporationstatus().getCsCode().equals("R")) {
				//ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN",
				//		new MessageBean(IBasicData.MSG_TYPE_ERROR, "登录失败","我司正在审核，请耐心等待!"));
				msg = "checking";
				printMsg(msg);
				return null;					
			}*/
			request.setAttribute("objWebUserColumns", objULReturn);
		
		}
		msg = "1";//登录成功
		printMsg(msg);
		return null;

		
	}
	
	/**
	 * indexlogin
	 * */
	@SuppressWarnings("unchecked")
	public String indexlogin(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String opname = request.getParameter("u_name").toUpperCase();
		String password = request.getParameter("u_pssword");
		String msg = "";
		
		UserColumns objULReturn = null;
	if (!StringUtility.isNull(opname)&& !StringUtility.isNull(password)) {
			UserQueryPlus query = new UserQueryPlus();
			UserConditionPlus condition = new UserConditionPlus();
			List<UserColumns> results = new ArrayList<UserColumns>();
			Pattern p = Pattern.compile("^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$");//手机号
			Matcher m = p.matcher(opname);
			boolean IsPhoneNumber = m.matches();
			
			/**判断前台输入的用户名格式*/
			if(opname.indexOf("@") != -1){//邮箱
				condition.setOpemail(opname);
				query.setCondition(condition);
			}else if(IsPhoneNumber){
					condition.setOpmobile(opname);
					query.setCondition(condition);
			}else{
					condition.setOpcode(opname);//opCode
					query.setCondition(condition);
			}
			
			//没有用户名
			query.setUseCachesign(true);//使用缓冲
			try {
				results = query.getResults();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(results.size() == 0){
				//msg = "nouser";
				msg = "errorPassword";
				printMsg(msg);
				return null;
			}
			objULReturn  = results.get(0);
			if(!password.equals(objULReturn.getWord())){
				msg = "errorPassword";
				printMsg(msg);
				return null;
			}
		}

	if (objULReturn != null) {

		sessionHelp(objULReturn);
		// 取得用户的职能，如果职能是G或者以GFI开头就放到session里
		String strFC_Code = objULReturn.getFcfccode();
		session.removeAttribute("FC_Code");
		session.removeAttribute("limit");
					
		if ("G".equals(strFC_Code) || strFC_Code.startsWith("GFI")) {
			session.setAttribute("FC_Code", strFC_Code);
		}else if("GOP".equals(strFC_Code)||"GCS".equals(strFC_Code) || "GSS".equals(strFC_Code)){
			session.setAttribute("limit","false");
		}else{
			msg = "invalidFunciton";
			printMsg(msg);
			return null;
		}
		
		/*String strCocode = objULReturn.getCococode();
		if (StringUtility.isNull(strCocode))
			strCocode = "2";
		session.setAttribute("Cocode", strCocode);*/
		// 查找公司状态
		/*TcoCorporation objTcoCorporation = null;
		try {
			objTcoCorporation = TcoCorporationDC.loadByKey(strCocode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (!objTcoCorporation.getTdiCorporationstatus().getCsCode().equals("R")) {
			msg = "checking";
			printMsg(msg);
			return null;					
		}*/
		request.setAttribute("objWebUserColumns", objULReturn);
	
	}
	msg = "1";//登录成功
	printMsg(msg);
	return null;
		
	}
	
	/**
	 * 注册
	 * @throws Exception 
	 * */
	public String register() throws Exception {
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		System.out.println(request.getCharacterEncoding());//tomcat设置了编码UTF-8
		
		String opcode = request.getParameter("r_username");
		String uname = request.getParameter("r_name");
		String passWord = request.getParameter("r_password");
		String userPhone = request.getParameter("r_tel");
		Date currentTime = new Date();
		
		UserColumns objUserColumns = new UserColumns();
		objUserColumns.setOpopcode(opcode.trim());
		objUserColumns.setOpopname(uname.trim());
		objUserColumns.setOpopmobile(userPhone.trim());
		objUserColumns.setWord(passWord.trim());
		//性别，sname,创建人，创建日期，修改人，修改日期，默认EE_CODE,FC_CODE,DP_CODE
		objUserColumns.setOpopcreatedate(currentTime);
		objUserColumns.setOpopidcreator(0);
		objUserColumns.setOpopidmodifier(0);
		objUserColumns.setOpopmodifydate(currentTime);
		objUserColumns.setOpopsex("M");//默认性别男
		objUserColumns.setOpopsname(uname.trim());
		objUserColumns.setEeeecode("1");//默认1,pscode=CL(员工),dpcode=SA(销售)
		objUserColumns.setFcfccode("GSS");//FCCODE=GSS(销售)
		objUserColumns.setDpdpcode("SA");
		objUserColumns.setPspscode("CL");
		//objUserColumns.setCococode("222");//默认code
		objUserColumns.setCococode("");
		SaveUserTransaction objSUTrans=new SaveUserTransaction();
		String strOperId = "0";
		objSUTrans.setParam(strOperId, objUserColumns);
		objSUTrans.execute();//添加用户
		QueryCache objQueryCache = new QueryCache();
		objQueryCache.reset();
		
		saveConpanyInfo(userPhone);
		request.setAttribute("isregister", "isregister");
		request.setAttribute("username", opcode);
		request.setAttribute("name", uname);
		request.setAttribute("phone", userPhone);
		request.setAttribute("passWord", passWord);
		return SUCCESS;
		
	}

	/**
	 *2016-11-15, 判断用户名是否被注册
	 *jQuery validate onblur触发的用户名检查
	 * @throws Exception
	 * */
	@SuppressWarnings("unchecked")
	public String checkUsername() throws Exception {
		String opCode = request.getParameter("r_username").toUpperCase();//大小写相同的也不能注册 
		
		UserQueryPlus query = new UserQueryPlus();
		UserConditionPlus condition = new UserConditionPlus();
		condition.setOpcode(opCode);
		query.setCondition(condition);
		List objList = query.getResults();
		
		
		if (!CollectionUtility.isNull(objList)) {// 用户名重复。
			String msg = "false";
			printMsg(msg);
		} else {
			//String msg = opCode;
			String msg = "true";
			printMsg(msg);
		}

		return null;
	}
	/**
	 * 2016-12-01,by wukq
	 * 校验手机号是否存在
	 * */
	@SuppressWarnings("unchecked")
	public String checkPhone(){
		String userPhone = request.getParameter("r_tel");// 用户名。
		
		UserQueryPlus query = new UserQueryPlus();
		UserConditionPlus condition = new UserConditionPlus();	
		condition.setOpmobile(userPhone);
		query.setCondition(condition);
		
		List objList = null;
		try {
			objList = query.getResults();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (!CollectionUtility.isNull(objList)) {// 用户名重复。
			String msg = "false";
			printMsg(msg);
		} else {
			//String msg = userPhone;
			String msg = "true";
			printMsg(msg);
		}
		
		return null;
	}
	
	
	/**
	 * 输出信息
	 * */
	public void printMsg(String msg){
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}	
		out.print(msg);
		out.flush();
		out.close();
	}

	/**
	 * 个人中心
	 * **/
	
	@SuppressWarnings("unchecked")
	public String userInfo(){
		HttpSession session = request.getSession();
		session.getAttribute("OpId");
		String cocode = (String)session.getAttribute("Cocode");
				
		//一周内订单+当天订单
		PersonalcorewaybillQuery coreQuery = new PersonalcorewaybillQuery(); 
		PersonalcorewaybillCondition coreCondition = new PersonalcorewaybillCondition();
		Date currentTime  = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");	
		String dateString = sf.format(currentTime);
	
		request.setAttribute("currentTime", dateString);//当前登录时间 
	
		coreCondition.setEndcreatedate(TimeUtil.getWeekEndTime());
		coreCondition.setStartcreatedate(TimeUtil.getWeekStartTime());
		coreCondition.setCwcocodecustomer(cocode);
		
		coreQuery.setCondition(coreCondition);
		List<PersonalcorewaybillColumns> resultlist  = null;
		
		try {
			resultlist = coreQuery.getResults();
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		if(resultlist.size()> 0){
			for(int index = 0 ;index <resultlist.size() ; index++){
				if(("小包").equals(resultlist.get(index).getHaha().trim())){
					PersonalcorewaybillColumns xiaobaoColumns = resultlist.get(index);
					request.setAttribute("xiaobao", xiaobaoColumns);
				}else if(("快递").equals(resultlist.get(index).getHaha().trim())){
					PersonalcorewaybillColumns expressColumns = resultlist.get(index);
					request.setAttribute("express", expressColumns);
				}else if(("专线").equals(resultlist.get(index).getHaha().trim())){
					PersonalcorewaybillColumns zhuanxianColumns  = resultlist.get(index);
					request.setAttribute("zhuanxian", zhuanxianColumns);
				}
				
			}
		}
		//求当天订单
		WaybillforpredictCondition objWaybillforpredictCondition = new WaybillforpredictCondition();;
		String field= "cw.cw_createdate";
		String sort = "DESC";
		List<WaybillforpredictColumns> queryForpredict = null;
		objWaybillforpredictCondition.setStartcreatedate(TimeUtil.getStartTime());
		objWaybillforpredictCondition.setEndcreatedate(TimeUtil.getEndTime());
		objWaybillforpredictCondition.setCocodecustomer(cocode);
		int pageCount = 5;//分页参数
		m_objPageConfig.setMaxPageResultCount(pageCount);
		objWaybillforpredictCondition.setPageConfig(m_objPageConfig);
		
		try {
			queryForpredict = HousewaybillDemand.queryForPredict(objWaybillforpredictCondition, field, sort);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("currentList", queryForpredict);
		
		//认证情况

		//账户余额
		//t_co_financialstatistics
		if(cocode != "" && cocode != null){
			FinancestatisticsColumns queryFinaceReport = FinanceUtil.getQueryFinaceReport(cocode);
			if(queryFinaceReport!=null){
				String bal = queryFinaceReport.getFsfsbalanceamount();
				BigDecimal balance = new BigDecimal(bal).divide(new BigDecimal("1"),3,4);
				request.setAttribute("balance",balance);
			}else{
				request.setAttribute("balance","0.000");
			}
			
			
		}
		
		//待支付账单
		BigDecimal total = new BigDecimal("0.000");
		List<ReceivableforbillColumns> returnList = FinanceUtil.getNotAccountMoney(cocode);
		for(ReceivableforbillColumns receCloumns: returnList){
			String rvrvactualtotal = receCloumns.getRvrvactualtotal();
			BigDecimal rvrvactual = new BigDecimal(rvrvactualtotal).divide(new BigDecimal("1"),3,4);
			total  = total.add(rvrvactual);
		}
		request.setAttribute("total", total);
		
		
		
		
		
		return SUCCESS;
	}
	
	/**
	 * 2016-11-28
	 * 退出登录
	 * */
	@SuppressWarnings("unchecked")
	public String loginout(){
		HttpServletRequest request = ServletActionContext.getRequest();
		//清除session
		Enumeration<String> em  = request.getSession().getAttributeNames();
		while(em.hasMoreElements()){
			request.getSession().removeAttribute(em.nextElement().toString());
		}
		request.getSession().invalidate();//invalidate(),注销  调用该方法 会清空所有已定义的session
		
		return SUCCESS;
		
		
	}
	
	/**
	 * 手机验证码判断
	 * */
    public String  checkMobileValiteCodeEx() throws Exception{
    	String validateCode=request.getParameter("mobileValidateCode");
    	String sessionValidateCode = (String) session.getAttribute("mobileValidateCode");
    	String result="false";
    	if (!StringUtility.isNull(validateCode))
			validateCode =  validateCode.toLowerCase();
    	if (!StringUtility.isNull(validateCode) && 
				!StringUtility.isNull(sessionValidateCode) &&
				validateCode.equals(sessionValidateCode.toLowerCase())){
    		result="true";
		}
    	response.getWriter().write(result);
    	return null;
    }
    /**
     * 根据用户名发送验证码,
     * 查找用户名对应的手机号
     * @throws Exception 
     * */
    public void  sendMobileValidateCodebyName() throws Exception{
    	//String opCode=request.getParameter("r_usename");
    	String opmobie = request.getParameter("tel");
    	UserQueryPlus query = new UserQueryPlus();
		UserConditionPlus condition = new UserConditionPlus();
		
		condition.setOpmobile(opmobie);
		query.setCondition(condition);
		List objList = query.getResults();
    	
		if(!CollectionUtility.isNull(objList)){//找到用户名
			UserColumns columns = (UserColumns) objList.get(0);
			String msg = columns.getOpopmobile();
			session.setAttribute("updatePassUser", columns);
			printMsg(msg);
		}else{//找不到用户名
			String msg = "false";
			printMsg(msg);	
		}
    	
    }
    /**
     * 查询添加的用户
     * @throws Exception 
     * **/
    public String queryUser() throws Exception{
    	String opcode = request.getParameter("opcode");
    	UserQueryPlus query = new UserQueryPlus();
		UserConditionPlus condition = new UserConditionPlus();
		condition.setOpcode(opcode.toUpperCase());
		query.setCondition(condition);
		List objList= query.getResults();
		if(!CollectionUtility.isNull(objList)){
			
		UserColumns objULReturn  = (UserColumns) objList.get(0);
		String cocode = (String)session.getAttribute("cocode");
		objULReturn.setCococode(cocode);
		
		
		sessionHelp(objULReturn);
			//新添加公司重新赋值一遍Cocode
			//CorporationdColumns ObjCorporationdColumns = CompanyDemand.queryCompanyByOpId(objULReturn.getOpopid());
			//session.setAttribute("Cocode", ObjCorporationdColumns.getCococode());	
		 }	
		return SUCCESS;
    }
    /**
     * 修改密码
     * @throws Exception 
     * */
    public String updatePass() throws Exception{
    	String newPass = request.getParameter("r_newpass");

    	UserColumns objULReturn = (UserColumns)session.getAttribute("updatePassUser");
    	objULReturn.setWord(newPass);
    	SaveUserTransactionEX objSUTrans=new SaveUserTransactionEX();
    	objSUTrans.setParam(objULReturn.getOpopid(), objULReturn);
    	objSUTrans.execute();
    	String updateValue = "updatePass";
    	request.setAttribute("updateValue", updateValue);
    	sessionHelp(objULReturn);
    	
    	return SUCCESS;
    }
    
    
    public void sessionHelp(UserColumns objULReturn ){
    	session.setAttribute("Eecode", objULReturn.getEeeecode());
		session.setAttribute("OpId", objULReturn.getOpopid());
		session.setAttribute("Opname", objULReturn.getOpopname());
		session.setAttribute("Opemail", objULReturn.getOpopemail());
		session.setAttribute("Opmobile", objULReturn.getOpopmobile());
		session.setAttribute("Cocode", objULReturn.getCococode());
		session.setAttribute("Opcode", objULReturn.getOpopcode());
		//只做拦截器使用
		kyle.baiqian.fs.authoritys.user.da.UserColumns obj = new kyle.baiqian.fs.authoritys.user.da.UserColumns();
		obj.setOpopid(Long.parseLong(objULReturn.getOpopid()));
		session.setAttribute("loginuser", obj);
		try {
			setCustomerService(objULReturn.getCococode());
		} catch (Exception e) {
			e.printStackTrace();
		}
    	
    }
    
    public void saveConpanyInfo(String phone) throws Exception{
    	UserQueryPlus objquery = new UserQueryPlus();
		UserConditionPlus objcondition = new UserConditionPlus();
		objcondition.setOpmobile(phone);
		objquery.setCondition(objcondition);
		List results = objquery.getResults();
		UserColumns objULReturn = null;
		if(!CollectionUtility.isNull(results)){
			objULReturn = (UserColumns) results.get(0);
			SimplecustomerColumns objSimplecustomerColumns = new SimplecustomerColumns();
			objSimplecustomerColumns.setCmct_code("AG");
			objSimplecustomerColumns.setCoco_name(objULReturn.getOpopname());
			objSimplecustomerColumns.setCoco_sname(objULReturn.getOpopname());
			
			Customer cus = new Customer();
			SimplecustomerColumns columns= cus.save(objSimplecustomerColumns, objULReturn.getOpopid());
			session.setAttribute("cocode", columns.getCmco_code());
			//保存用户的code
			objULReturn.setCococode(columns.getCmco_code());
			SaveUserTransaction objSUTrans=new SaveUserTransaction();
			objSUTrans.setParam(objULReturn.getOpopid(), objULReturn);
			objSUTrans.execute();//添加用户
			QueryCache objQueryCache = new QueryCache();
			objQueryCache.reset();
		}
	
    }
    
    public void setCustomerService(String cocode) throws Exception{
    
    
    	UserColumns GCSColumns = CustomerService(cocode,"GCS");
    	UserColumns GFIColumns = CustomerService(cocode,"GFI");	
    	UserColumns GSSColumns = CustomerService(cocode,"GSS");	
    	if(GCSColumns != null){
    		session.setAttribute("GCSQQ", GCSColumns.getOpopqqnumber());
    		session.setAttribute("GCSmobie", GCSColumns.getOpopmobile());
    	}
    	if(GFIColumns != null ){
    		session.setAttribute("GFIQQ", GFIColumns.getOpopqqnumber());
    		session.setAttribute("GFImobie", GFIColumns.getOpopmobile());
    	}
    	if(GSSColumns!= null){
    		session.setAttribute("GSSQQ", GSSColumns.getOpopqqnumber());
    		session.setAttribute("GSSmobie", GSSColumns.getOpopmobile());
    	}
    }
    
    
    /**
     * 查询销售，客服，财务
     * @throws Exception 
     * */
    public UserColumns CustomerService(String cocode,String fcocode) throws Exception{
    		 
    	UserQueryPlus query = new UserQueryPlus();
    	UserConditionPlus condition = new UserConditionPlus();
    	condition.setCocode(cocode);
    	condition.setFccode(fcocode);
    	query.setCondition(condition);
    	List results = query.getResults();
    	if(CollectionUtility.isNull(results)){
    		return null;
    	}else{
    		UserColumns objUserColumns  = 	(UserColumns)results.get(0);
    		return objUserColumns;
    		
    	}
    	
    	
    }
    
    
    
	/**
	 * check login
	 * */
/*	public String checkLogin(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String code = (String)session.getAttribute("code");
		String opName = (String)session.getAttribute("Opname");
		
		if(opName == "" || opName == null){
			request.setAttribute("ISLogin", false);
			return SUCCESS;
		
		}else{
			request.setAttribute("ISlogin", true);
			request.setAttribute("Opname", opName);
			
			return SUCCESS;
		}
		
	}*/
	
	/*public UserColumns login(String opname,String password,String msg){
			UserColumns objULReturn = null;
		// ...提示信息
		if (!StringUtility.isNull(opname)&& !StringUtility.isNull(password)) {
			
			UserQueryPlus query = new UserQueryPlus();
			UserConditionPlus condition = new UserConditionPlus();
			List<UserColumns> results = new ArrayList<UserColumns>();
			
			Pattern p = Pattern.compile("^(13[0-9]|14[5|7]|15[0|1|2|3|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$");//手机号
			Matcher m = p.matcher(opname);
			boolean IsPhoneNumber = m.matches();
			
			*//**判断前台输入的用户名格式*//*
			if(opname.indexOf("@") != -1){//邮箱
				condition.setOpemail(opname);
				query.setCondition(condition);
			}else if(IsPhoneNumber){
					condition.setOpmobile(opname);
					query.setCondition(condition);
			}else{
					condition.setOpcode(opname);//opCode
					query.setCondition(condition);
			}
			
			//没有用户名
			query.setUseCachesign(true);//使用缓冲
			try {
				results = query.getResults();
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(results.size() == 0){
				msg = "nouser";
				printMsg(msg);
				return null;
			}
			objULReturn  = results.get(0);
			if(!password.equals(objULReturn.getWord())){
				msg = "errorPassword";
				printMsg(msg);
				return null;
			}else{
				msg = "1";
				printMsg(msg);
				return objULReturn;
				
			}	
		}
		printMsg(msg);
		return null;
		
	}*/
	
	
}