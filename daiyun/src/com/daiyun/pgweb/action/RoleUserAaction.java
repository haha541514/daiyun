package com.daiyun.pgweb.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;

import com.daiyun.dax.MenuDemand;
import com.daiyun.dax.RoleDemand;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.fs.authority.da.UserroleColumns;
import kyle.leis.fs.authority.da.UserroleCondition;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemColumns;
import kyle.leis.fs.authoritys.role.da.RoleColumns;
import kyle.leis.fs.authoritys.role.da.RoleCondition;
import kyle.leis.fs.authoritys.role.da.RoleQuery;
import kyle.leis.fs.authoritys.user.da.UserColumns;
import kyle.leis.fs.authoritys.user.da.UserCondition;
import kyle.leis.fs.authoritys.user.dax.UserDemand;
import kyle.leis.fs.authoritys.userrole.bl.UserRole;

public class RoleUserAaction extends ActionSupportEX {
	public String queryFirstMenu() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String iskCode = request.getParameter("iskCode");
		System.out.println("iskCode=" + iskCode);
		List<GmenusitemColumns> listResults = MenuDemand
				.queryFirstLevelMenu(iskCode);
		JSONArray JsonArray = JSONArray.fromObject(listResults);
		String jsonData = JsonArray.toString();
		out.print(jsonData);
		return null;
	}

	public String querySecMenu() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String strcCode = request.getParameter("strcCode");
		System.out.println("strcCode=" + strcCode);
		List<GmenusitemColumns> listResults = MenuDemand.querySubmenu(strcCode);
		JSONArray JsonArray = JSONArray.fromObject(listResults);
		String jsonData = JsonArray.toString();
		out.print(jsonData);
		return null;
	}
	//分配员工角色
	public String queryRoleByCode() throws Exception {
		RoleDemand demand = new RoleDemand();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String Ur_usercode = request.getParameter("opopcode");
		UserroleCondition con = new UserroleCondition();
		con.setUr_usercode(Ur_usercode);
		UserroleColumns columns = null;
		List<UserroleColumns> list = demand.queryAllRoleUser(con);
		if (list.size() != 0 && !StringUtility.isNull(Ur_usercode)) {
			request.setAttribute("RoleList", list);
		}
		request.setAttribute("usercode", Ur_usercode);
		return SUCCESS;
	}
       //查询公司员工信息
	public String queryRoleByOpCode()throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		String cocode=(String)session.getAttribute("Cocode");
		UserCondition objUserCondition = new UserCondition();
		m_objPageConfig.setMaxPageResultCount(8);
		objUserCondition.setPageConfig(m_objPageConfig);
		objUserCondition.setCocode(cocode);
		m_objPageConfig.setMaxPageResultCount(14);
		objUserCondition.setPageConfig(m_objPageConfig);
		List<UserColumns> list= UserDemand.query(objUserCondition);
		request.setAttribute("objWebUserList", list);	
		return SUCCESS;	
	}
	public String saveUserRole() throws Exception {
		String usercode = request.getParameter("ur_usercode");
		String rlrlcode = request.getParameter("rlcode");
		rlrlcode = rlrlcode.substring(1);
		String[] rlcode = rlrlcode.split(",");
		List<String> li = new ArrayList<String>();
		List<String> li2 = new ArrayList<String>();
		for (int i = 0; i < rlcode.length; i++) {
			RoleQuery query = new RoleQuery();
			RoleCondition con = new RoleCondition();
			con.setRlcode(rlcode[i]);
			query.setCondition(con);
			List list = query.getResults();
			RoleColumns columns = (RoleColumns) list.get(0);
			String iskcode = columns.getIskiskcode();
			if (iskcode.equals("LEWFDIS")) {
				li.add(rlcode[i]);
			} else {
				li2.add(rlcode[i]);
			}
		}
		UserRole userrole = new UserRole();
		// 执行保存之前先删除该用户所有角色，再重新添加
		userrole.delete(usercode, "LEDIS");
		userrole.delete(usercode, "LEWFDIS");
		if (li.size() > 0) {
			String[] str = li.toArray(new String[li.size()]);
			userrole.save(usercode, str, "LEWFDIS");
		}
		if (li2.size() > 0) {
			String[] str2 = li2.toArray(new String[li2.size()]);
			userrole.save(usercode, str2, "LEDIS");
		}
		PrintWriter rs = response.getWriter();
		rs.write("OK");
		return null;
	}
}
