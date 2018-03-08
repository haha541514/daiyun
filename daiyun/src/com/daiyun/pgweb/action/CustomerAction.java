package com.daiyun.pgweb.action;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.email.EMail;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.es.company.companys.da.CorporationdColumns;
import kyle.leis.es.company.customer.bl.Customer;
import kyle.leis.es.company.customer.bl.CustomerRegsiter;
import kyle.leis.es.company.customer.da.CustomerColumns;
import kyle.leis.es.company.customer.da.CustomerCondition;
import kyle.leis.es.company.customer.da.SimplecustomerColumns;
import kyle.leis.es.company.customer.dax.CustomerDemand;
import kyle.leis.fs.authoritys.user.bl.User;
import kyle.leis.fs.authoritys.user.da.UserColumns;
import kyle.leis.fs.authoritys.user.da.UserCondition;
import kyle.leis.fs.authoritys.user.dax.UserDemand;
import kyle.leis.fs.dictionary.operator.bl.Operator;
import org.apache.struts2.ServletActionContext;

import com.daiyun.dax.CompanyDemand;
import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;
import com.daiyun.dax.WebUserDemand;
import com.daiyun.util.ImageAction;

public class CustomerAction extends ActionSupportEX {
	private CustomerColumns m_objCustomerColumns;
	private UserColumns m_objUserColumns;
	private CorporationdColumns objCorporationdColumns;
	private SimplecustomerColumns objSimplecustomerColumns;

	public SimplecustomerColumns getObjSimplecustomerColumns() {
		return objSimplecustomerColumns;
	}

	public void setObjSimplecustomerColumns(
			SimplecustomerColumns objSimplecustomerColumns) {
		this.objSimplecustomerColumns = objSimplecustomerColumns;
	}

	public CorporationdColumns getObjCorporationdColumns() {
		return objCorporationdColumns;
	}

	public void setObjCorporationdColumns(
			CorporationdColumns objCorporationdColumns) {
		this.objCorporationdColumns = objCorporationdColumns;
	}

	public CustomerAction() {
		m_objCustomerColumns = new CustomerColumns();
		m_objUserColumns = new UserColumns();
	}

	// 注册客户并保存
	public String saveCustomer() throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/jsp;charset=UTF-8");
		String sign = session.getAttribute("Cocode").toString();// 检测该customer是否存在，存在sign不为空,不存在为sign为空

		String name = request.getParameter("name").trim();
		String nike = request.getParameter("nickname").trim();
		String opcode = request.getParameter("opopCode").trim();
		String pwd = request.getParameter("pwd").trim();
		String email = request.getParameter("email").trim();
		String mobile = request.getParameter("mobilePhone").trim();
		String phone = request.getParameter("phone").trim();
		String address = request.getParameter("address").trim();
		String company = request.getParameter("company").trim();
		if (StringUtility.isNull(company)) {
			company = name + "_" + mobile;
		}
		String fccode = request.getParameter("fcCode");// 职能
		String psCode = request.getParameter("psCode");// 职位
		String dpCode = request.getParameter("dpCode");// 部门
		String opsex = request.getParameter("opsex");
		String ctCode = request.getParameter("ctCode");
		String invoicesign = request.getParameter("invoicesign");
		if (StringUtility.isNull(invoicesign)) {
			invoicesign = "N";
		}
		String odanoticesign = request.getParameter("danoticesign");
		if (StringUtility.isNull(odanoticesign)) {
			odanoticesign = "N";
		}
		String odaholdsign = request.getParameter("daholdsign");
		if (StringUtility.isNull(odaholdsign)) {
			odaholdsign = "N";
		}

		// 客户

		m_objCustomerColumns.setCoconame(company);// 公司名
		m_objCustomerColumns.setCocosname(company);
		m_objCustomerColumns.setCocosename(company);
		m_objCustomerColumns.setCocolabelcode(company);
		m_objCustomerColumns.setCoscscode("R");// 公司状态代码
		m_objCustomerColumns.setCstcstcode("C");// 客户服务商类型
		m_objCustomerColumns.setEeeecode("1");// 企业元素
		m_objCustomerColumns.setCtctcode(ctCode);// 客户类型
		m_objCustomerColumns.setCmcminvoicesign(invoicesign);// 是否需要发票
		m_objCustomerColumns.setCmcmodanoticesign(odanoticesign);// 是否通知客户
		m_objCustomerColumns.setCmcmodaholdsign(odaholdsign);// 是否扣件
		m_objCustomerColumns.setSsopopname(name);
		m_objCustomerColumns.setCocoaddress(address);

		// 用户
		// m_objUserColumns.setOpopid("");
		m_objUserColumns.setOpopename(nike);// 20
		m_objUserColumns.setOpopsname(name);// 10
		m_objUserColumns.setOpopname(name);// 10
		m_objUserColumns.setWord(pwd);// 30
		m_objUserColumns.setEeeecode("1");// 企业元素
		m_objUserColumns.setOpopsex(opsex);
		m_objUserColumns.setOpopcode(opcode);
		m_objUserColumns.setOpopemail(email);// 50
		m_objUserColumns.setOpopmobile(mobile);// 20
		m_objUserColumns.setOpoptelephone(phone);// 20
		m_objUserColumns.setOpopaddress(address);// 100
		if (!StringUtility.isNull(sign)) {
			m_objUserColumns.setCococode(sign);
		} else {
			m_objUserColumns.setCococode("");
		}

		m_objUserColumns.setFcfccode(fccode);
		m_objUserColumns.setPspscode(psCode);
		m_objUserColumns.setDpdpcode(dpCode);
		// 保存用户
		CustomerRegsiter reg = new CustomerRegsiter();
		reg.save(m_objCustomerColumns, m_objUserColumns, sign);
		return SUCCESS;
	}

	// 保存用户
	public String saveUser() throws Exception {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/jsp;charset=UTF-8");
		String sign = null;
		if (session.getAttribute("Cocode") != null)
			sign = session.getAttribute("Cocode").toString();// 检测该customer是否存在，存在sign不为空,不存在为sign为空
		String opid = request.getParameter("opid");
		String name = request.getParameter("name").trim();
		String nike = name;
		String opcode = request.getParameter("opopCode").trim();
		String pwd = request.getParameter("pwd").trim();
		String email = request.getParameter("email").trim();
		String mobile = request.getParameter("mobilePhone").trim();
		String phone = mobile;
		String opsex = request.getParameter("opsex");
		String fccode = request.getParameter("fcCode");// 职能
		String psCode = request.getParameter("psCode");// 职位
		String dpCode = request.getParameter("dpCode");// 部门

		// 用户
		m_objUserColumns.setOpopename(nike);// 20
		m_objUserColumns.setOpopsname(name);// 10
		m_objUserColumns.setOpopname(name);// 10
		m_objUserColumns.setWord(pwd);// 30
		m_objUserColumns.setEeeecode("1");// 企业元素
		m_objUserColumns.setOpopsex(opsex);
		m_objUserColumns.setOpopcode(opcode);
		m_objUserColumns.setOpopemail(email);// 50
		m_objUserColumns.setOpopmobile(mobile);// 20
		m_objUserColumns.setOpoptelephone(phone);// 20
		m_objUserColumns.setOpopaddress("");// 100
		if (!StringUtility.isNull(sign)) {
			m_objUserColumns.setCococode(sign);
		} else {
			m_objUserColumns.setCococode("");
		}
		m_objUserColumns.setFcfccode(fccode);
		m_objUserColumns.setPspscode(psCode);
		m_objUserColumns.setDpdpcode(dpCode);
		// 保存用户
		// 判断是添加还是保存
		User objUser = new User();
		if (!StringUtility.isNull(opid)) {
			m_objUserColumns.setOpopid(Long.valueOf(opid));
			objUser.save(sign, m_objUserColumns);
		} else {
			CustomerRegsiter reg = new CustomerRegsiter();
			reg.save(m_objCustomerColumns, m_objUserColumns, sign);
		}
		return SUCCESS;
	}

	public void CompanyExists() throws Exception {
		PrintWriter out = response.getWriter();
		// 检查公司是否已存在,存在则不允许注册
		String company = request.getParameter("company").trim();
		CustomerCondition objCustomerCondition = new CustomerCondition();
		objCustomerCondition.setConame(company);

		List customerList = CustomerDemand.query(objCustomerCondition);
		if (customerList.size() == 0) {
			out.print("NO");
			return;
		}
		out.print("YES");
	}

	// 查询公司信息
	public String queryCompanyByOpId() throws Exception {
		String opid = null;
		if ((session.getAttribute("OpId") != null)) {
			opid = session.getAttribute("OpId").toString();
		}
		if (opid == null) {
			opid = "1";
		}
		String cocoCode = null;
		if (session.getAttribute("Cocode") != null)
			cocoCode = session.getAttribute("Cocode").toString();
		CorporationdColumns m_objCorporationdColumns;
		if (!StringUtility.isNull(cocoCode)) {
			m_objCorporationdColumns = CompanyDemand.queryCompanyById(cocoCode);
		} else {
			m_objCorporationdColumns = new CorporationdColumns();
		}
		request
				.setAttribute("objCorporationdColumns",
						m_objCorporationdColumns);
		return SUCCESS;

	}

	public String saveCompany() throws Exception {
		String opid = null;
		if ((session.getAttribute("OpId") != null)) {
			opid = session.getAttribute("OpId").toString();
		}
		if (opid == null) {
			opid = "1";
		}

		// Companys objCompanys = new Companys();
		// String cocoCode=request.getParameter("coid");

		// objSimplecustomerColumns.setCmct_code(TcoCustomerDC.loadByKey(objSimplecustomerColumns.getCmco_code()).getTdiCustomertype().getCtCode());
		// String result=objCompanys.saveCorporation(objCorporationdColumns,
		// opid);
		// request.setAttribute("Cocode",result);
		// session.setAttribute("Cocode", result);
		Customer cus = new Customer();
		objSimplecustomerColumns.setCmct_code("AG");
		SimplecustomerColumns col = cus.save(objSimplecustomerColumns, opid);

		String result = col.getCmco_code();
		session.setAttribute("Cocode", result);
		if (!StringUtility.isNull(result))
			return SUCCESS;
		return ERROR;

	}

	// 修改密码
	public String modifyPassword() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String opid = null;
		if (request.getSession().getAttribute("OpId") != null) {
			opid = (String) request.getSession().getAttribute("OpId");
		}
		if (StringUtility.isNull(opid))
			opid = "1";
		// String strOperId = request.getParameter("OperId");
		// if(strOperId==null)
		// strOperId ="1";
		// String strOldPassword = request.getParameter("OldPassword");
		String strNewPassword = request.getParameter("NewPassword");
		if (StringUtility.isNull(opid) || StringUtility.isNull(strNewPassword)) {
			ServletActionContext.getRequest().getSession().setAttribute(
					"MESSAGEBEAN",
					new MessageBean(IBasicData.MSG_TYPE_ERROR, "修改密码出错",
							"抱歉，修改密码出错，请核对必填项！"));
			return ERROR;
		}
		Operator objOperator = new Operator();
		kyle.common.util.prompt.PromptUtility objPromptUtility = objOperator
				.modifyPassword(opid, "", strNewPassword);
		if (objPromptUtility != null) {
			ServletActionContext.getRequest().getSession().setAttribute(
					"MESSAGEBEAN",
					new MessageBean(IBasicData.MSG_TYPE_ERROR, "修改密码出错",
							objPromptUtility.getDescribtion()));
			return ERROR;
		}
		return SUCCESS;
	}

	// 修改手机号码
	public String modifyTelPhone() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		String opid = null;
		if (request.getSession().getAttribute("OpId") != null) {
			opid = (String) request.getSession().getAttribute("OpId");
		}
		if (StringUtility.isNull(opid))
			opid = "1";
		String strNewTel = request.getParameter("number_03");
		UserCondition objUserCondition = new UserCondition();
		objUserCondition.setOpid(opid);
		UserColumns objUserColumns = (UserColumns) UserDemand.query(
				objUserCondition).get(0);
		if (StringUtility.isNull(opid) || StringUtility.isNull(strNewTel)) {
			ServletActionContext.getRequest().getSession().setAttribute(
					"MESSAGEBEAN",
					new MessageBean(IBasicData.MSG_TYPE_ERROR, "修改手机号码出错",
							"抱歉，修改手机号码出错，请核对必填项！"));
			return ERROR;
		}
		Operator objOperator = new Operator();
		System.out.println(objUserColumns.getOpopmobile());
		kyle.common.util.prompt.PromptUtility objPromptUtility = objOperator
				.modifyPhoneNumber(opid, objUserColumns.getOpopmobile(),
						strNewTel);
		if (objPromptUtility != null) {
			ServletActionContext.getRequest().getSession().setAttribute(
					"MESSAGEBEAN",
					new MessageBean(IBasicData.MSG_TYPE_ERROR, "修改手机号码出错",
							objPromptUtility.getDescribtion()));
			return ERROR;
		}
		return SUCCESS;
	}

	// 发
	public String sendmodifyEmail() throws Exception {
		String opid = null;
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter pw = response.getWriter();
		if (request.getSession().getAttribute("OpId") != null) {
			opid = (String) request.getSession().getAttribute("OpId");
		}
		String path = request.getParameter("path");
		String email = request.getParameter("email");
		String url = path + "modifyEmail?";
		String vcode = ImageAction.proSixCode();
		HttpSession session = ServletActionContext.getRequest().getSession();
		session.setMaxInactiveInterval(3000);// 五分钟
		session.setAttribute("EmailVode", opid + vcode);
		System.out.println("session中的验证字段为:" + opid + vcode);
		url = url + "opid=" + opid + "&vcode=" + vcode;
		// 调用发邮件的方法
		String strContent = "点击下面连接进行邮箱验证" + url;
		try {
			EMail.sendMail("541514716@qq.com", email, "", "", "代运网邮箱验证",
					strContent, null);
		} catch (Exception e) {
			pw.write("0");
			pw.close();
		}
		pw.write("1");
		pw.close();
		System.out.println("用户要点击的链接是:" + url);
		return null;
	}

	// 验证
	public String modifyEmail() throws Exception {
		String opid = request.getParameter("opid");
		String vcode = request.getParameter("vcode");
		HttpSession session = ServletActionContext.getRequest().getSession();
		String EmailVode = (String) session.getAttribute("EmailVode");
		String rec = opid + vcode;
		if (EmailVode.equals(rec)) {
			System.out.println("验证成功");
			// 修改邮箱验证状态字段
			UserCondition objUserCondition = new UserCondition();
			objUserCondition.setOpid(opid);
			UserColumns objUserColumns = (UserColumns) UserDemand.query(
					objUserCondition).get(0);
			objUserColumns.setOpopemailconfirmsign("Y");
			User objUser = new User();
			objUser.save(opid, objUserColumns);
			request.setAttribute("result", "恭喜您的邮箱验证成功!");
			return SUCCESS;
		} else {
			System.out.println("验证超时");
			request.setAttribute("result", "很抱歉,该验证连接已失效!");
			return SUCCESS;
		}
	}

	// 后台管理查询指定用户
	public String queryUsersByCon() throws Exception {
		WebUserDemand demand = new WebUserDemand();
		UserCondition con = new UserCondition();
		String opid = request.getParameter("m_opid");
		
		
		if (!StringUtility.isNull(opid)) {
			con.setOpid(opid);
		}
		String opname = request.getParameter("m_opname");
		if (!StringUtility.isNull(opname)) {
			con.setOpname(opname);
		}
		String opcode = request.getParameter("m_opcode");
		if (!StringUtility.isNull(opcode)) {
			con.setOpcode(opcode);
		}
		String statue = request.getParameter("m_statue");
		if (!StringUtility.isNull(statue)) {
			con.setOpidnumberconfirmsign(statue);
		}
		String statue2 = request.getParameter("statue");
		if (!StringUtility.isNull(statue2)) {
			con.setOpidnumberconfirmsign(statue2);
		}
		m_objPageConfig.setMaxPageResultCount(8);
		con.setPageConfig(m_objPageConfig);
		UserColumns user = null;
		List<UserColumns> list = demand.queryAllUsers(con);
		if (list.size() == 1
				&& (!StringUtility.isNull(opname)
						|| !StringUtility.isNull(opid) || !StringUtility
						.isNull(opcode))) {
			user = list.get(0);
			request.setAttribute("user", user);
		} else {
			request.setAttribute("UserList", list);
		}

		return SUCCESS;
	}

	// 后台审核修改身份验证状态
	public String modifyIndentify() throws Exception {
		WebUserDemand demand = new WebUserDemand();
		UserCondition con = new UserCondition();
		UserCondition con2 = new UserCondition();
		String opid = request.getParameter("opid");
		String statue = request.getParameter("statue");
		if (!StringUtility.isNull(opid) || opid.equals("")) {
			con.setOpid(opid);
		}

		if (!StringUtility.isNull(statue)) {
			con.setOpidnumberconfirmsign(statue);
		}
	//	m_objPageConfig.setMaxPageResultCount(10);
	//	con.setPageConfig(m_objPageConfig);
		List<UserColumns> list = demand.queryAllUsers(con);
		// 修改实名认证后的用户状态
		UserCondition objUserCondition = new UserCondition();
		if (!StringUtility.isNull(opid) || opid.length() > 0) {
			objUserCondition.setOpid(opid);
			UserColumns objUserColumns = (UserColumns) UserDemand.query(
					objUserCondition).get(0);
			User objUser = new User();
			objUserColumns.setOpopidnumberconfirmsign(statue);
			UserColumns objUserReturn = objUser.save(opid, objUserColumns);
			request.setAttribute("user", objUserReturn);
		}
		request.setAttribute("UserList", list);
		return SUCCESS;
	}

}
