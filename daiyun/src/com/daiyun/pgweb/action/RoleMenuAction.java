package com.daiyun.pgweb.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.daiyun.dax.MenuDemand;
import com.daiyun.dax.RoleDemand;

import kyle.common.util.jlang.StringUtility;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.leis.fs.authority.da.RolemenusColumns;
import kyle.leis.fs.authoritys.gmenus.bl.Gmenus;
import kyle.leis.fs.authoritys.gmenus.bl.GmenusItem;
import kyle.leis.fs.authoritys.gmenus.da.GmenusColumns;
import kyle.leis.fs.authoritys.gmenus.da.GmenusCondition;
import kyle.leis.fs.authoritys.gmenus.da.GmenusQuery;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemColumns;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemCondition;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemQuery;
import kyle.leis.fs.authoritys.gmenus.dax.GmenusItemDemand;
import kyle.leis.fs.authoritys.role.bl.Role;
import kyle.leis.fs.authoritys.role.da.RoleColumns;
import kyle.leis.fs.authoritys.role.da.RoleCondition;
import kyle.leis.fs.authoritys.role.da.RoleQueryPX;

public class RoleMenuAction extends ActionSupportEX {
	public String queryFirstMenu() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String iskCode = request.getParameter("iskCode");
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
		List<GmenusitemColumns> listResults = MenuDemand.querySubmenu(strcCode);
		JSONArray JsonArray = JSONArray.fromObject(listResults);
		String jsonData = JsonArray.toString();
		out.print(jsonData);
		return null;
	}

	public String saveRoleMenu() throws Exception {
		String name = request.getParameter("userName");
		String ename = request.getParameter("useEname");
		String iskCode = request.getParameter("iskCode");
		String strGmcode = request.getParameter("strGmcode");
		String strucode = request.getParameter("strucode");
		String rlcode = request.getParameter("rlcode");
		Role role = new Role();
		RoleColumns objRoleColumns = new RoleColumns();
		objRoleColumns.setRlrlstructurecode(strucode);
		objRoleColumns.setRlrlcode(rlcode);
		objRoleColumns.setIskiskcode(iskCode);
		objRoleColumns.setRlrlname(name);
		objRoleColumns.setRlrlename(ename);
		objRoleColumns.setRlrladministratorsign("N");
		if (!StringUtility.isNull(strGmcode)) {
			strGmcode = strGmcode.substring(1);
		}
		String strOperId = (String) ServletActionContext.getRequest()
				.getSession().getAttribute("OpId");
		RoleDemand demand = new RoleDemand();
		demand.saveRoleAndMenu(strOperId, objRoleColumns, strGmcode.split(","));
		PrintWriter rs = response.getWriter();
		rs.write("XXX");
		return null;
	}

	public String queryRoleMenuByRlcode() throws Exception {
		String rlcode = request.getParameter("rlcode");
		RoleColumns objRoleColumns = RoleDemand.queryRoleByRlcode(rlcode);
		request.setAttribute("objRoleColumns", objRoleColumns);
		List<RolemenusColumns> listRolemenusColumns = RoleDemand
				.queryRolemenusByRlcode(rlcode);
		request.setAttribute("listRolemenusColumns", listRolemenusColumns);
		return SUCCESS;
	}

	// 功能树
	public String buildGNTree() throws Exception {
		GmenusitemCondition con = new GmenusitemCondition();
		con.setIskcode("LEWFDIS");
		con.setGmgroupcode("A");
		List<GmenusitemColumns> list = GmenusItemDemand.query(con);
		JSONObject firstItem = new JSONObject();
		List<JSONObject> firstItemattr = new ArrayList<JSONObject>();
		JSONObject secItem = new JSONObject();
		List<JSONObject> secItemattr = new ArrayList<JSONObject>();
		JSONObject TirdItem = new JSONObject();
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getGmgm_structurecode().length() == 1) {
				// 第一层
				firstItem.put("name", list.get(i).getGmgm_name());
				firstItem.put("userLevel", "");
			} else if (list.get(i).getGmgm_structurecode().length() == 3) {
				if (secItemattr.size() != 0) {
					// 每次初始化第二层之前先把第三层的职位数据放入对象中
					secItem.put("list", secItemattr);
					// 把第二层的数据放入第一层的list数组中
					firstItemattr.add(secItem);
					secItemattr.clear();
				}
				// 第二层(功能类型)
				secItem = new JSONObject();
				secItem.put("name", list.get(i).getGmgm_name());
				secItem.put("userLevel", "");
				// secItem.put("url", "javaScript:void(0);");
				secItem.put("code", list.get(i).getGmgm_code());
			} else if (list.get(i).getGmgm_structurecode().length() == 5) {
				// 第三层(具体功能)
				TirdItem = new JSONObject();
				TirdItem.put("name", list.get(i).getGmgm_name());
				TirdItem.put("userLevel", "");
				TirdItem.put("url", "javaScript:void(0);");
				TirdItem.put("code", list.get(i).getGmgm_code());
				secItemattr.add(TirdItem);
			}
		}
		// 最后一次循环手动设置
		secItem.put("list", secItemattr);
		firstItemattr.add(secItem);
		firstItem.put("list", firstItemattr);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		JSONArray JsonArray = JSONArray.fromObject(firstItem);
		String jsonData = JsonArray.toString();
		out.print(jsonData);
		return null;
	}

	// 角色树
	public String buildTree() throws Exception {
		JSONObject firstItem = new JSONObject();
		List<JSONObject> firstItemattr = new ArrayList<JSONObject>();
		JSONObject secItem = new JSONObject();
		List<JSONObject> secItemattr = new ArrayList<JSONObject>();
		JSONObject TirdItem = new JSONObject();
		RoleQueryPX query = new RoleQueryPX();
		RoleCondition con = new RoleCondition();
		con.setRlstructurecode("B");
		query.setCondition(con);
		List<RoleColumns> list = query.getResults();
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getRlrlstructurecode().length() == 1) {
				// 第一层
				firstItem.put("name", list.get(i).getRlrlname());
				firstItem.put("userLevel", "");
			} else if (list.get(i).getRlrlstructurecode().length() == 3) {
				if (secItemattr.size() != 0) {
					// 每次初始化第二层之前先把第三层的职位数据放入对象中
					secItem.put("list", secItemattr);
					// 把第二层的数据放入第一层的list数组中
					firstItemattr.add(secItem);
					secItemattr.clear();
				}
				// 第二层(部门)
				secItem = new JSONObject();
				secItem.put("name", list.get(i).getRlrlname());
				secItem.put("userLevel", "");
				secItem.put("url", "javaScript:void(0);");
				secItem.put("code", list.get(i).getRlrlcode());
			} else if (list.get(i).getRlrlstructurecode().length() == 5) {
				// 第三层(具体职位)
				TirdItem = new JSONObject();
				TirdItem.put("name", list.get(i).getRlrlname());
				TirdItem.put("userLevel", "");
				TirdItem.put("url", "javaScript:void(0);");
				TirdItem.put("code", list.get(i).getRlrlcode());
				secItemattr.add(TirdItem);
			}
		}
		// 最后一次循环手动设置
		secItem.put("list", secItemattr);
		firstItemattr.add(secItem);
		firstItem.put("list", firstItemattr);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		JSONArray JsonArray = JSONArray.fromObject(firstItem);
		String jsonData = JsonArray.toString();
		out.print(jsonData);
		return null;
	}

	public String queryMenuAjax() throws Exception {
		String rlcode = request.getParameter("rlcode");
		List<RolemenusColumns> listRolemenusColumns = RoleDemand
				.queryRolemenusByRlcode(rlcode);
		request.setAttribute("listRolemenusColumns", listRolemenusColumns);
		JSONArray objJSONArray = JSONArray.fromObject(listRolemenusColumns);
		String jsonData = objJSONArray.toString();
		PrintWriter rs = response.getWriter();
		rs.print(jsonData);
		return null;
	}

	public String queryRoleAjax() throws Exception {
		String rlcode = request.getParameter("rlcode");
		RoleColumns objRoleColumns = RoleDemand.queryRoleByRlcode(rlcode);
		request.setAttribute("objRoleColumns", objRoleColumns);
		JSONObject objJSONObject = JSONObject.fromObject(objRoleColumns);
		String jsonData = objJSONObject.toString();
		PrintWriter rs = response.getWriter();
		rs.print(jsonData);
		return null;
	}

	public String buildStrucode() throws Exception {
		String strcode = request.getParameter("strcode");
		if (strcode.length() < 3)
			return null;
		strcode = strcode.substring(0, 3);
		RoleQueryPX query = new RoleQueryPX();
		RoleCondition con = new RoleCondition();
		con.setRlstructurecode(strcode);
		query.setCondition(con);
		List<RoleColumns> list = query.getResults();
		String strReturn;
		if (list.size() == 1) {
			// 为1时,说明该部门下面没有角色
			strReturn = list.get(0).getRlrlstructurecode() + "01";
		} else {
			// 生成新的排序号
			String str = list.get(list.size() - 1).getRlrlstructurecode();
			String str2 = str.substring(3, 5);
			int c = Integer.parseInt(str2) + 1;
			if (c < 10) {
				strReturn = strcode + "0" + c;
			} else {
				strReturn = strcode + c;
			}
		}
		PrintWriter rs = response.getWriter();
		rs.print(strReturn);
		return null;
	}

	// 生成新功能排序号
	public String buildGmstrucode() throws Exception {
		String gmstrcode = request.getParameter("gmstrucode");
		if (gmstrcode.length() < 3)
			return null;
		gmstrcode = gmstrcode.substring(0, 3);
		GmenusitemQuery query = new GmenusitemQuery();
		GmenusitemCondition con = new GmenusitemCondition();
		con.setGmstructurecode(gmstrcode);
		query.setCondition(con);
		List<GmenusitemColumns> list = query.getResults();
		String strReturn;
		if (list.size() == 1) {
			// 为1时,说明该功能菜单没有子菜单
			strReturn = list.get(0).getGmgm_structurecode() + "01";
		} else {
			// 生成新的排序号
			String str = list.get(list.size() - 1).getGmgm_structurecode();
			String str2 = str.substring(3, 5);
			int c = Integer.parseInt(str2) + 1;
			if (c < 10) {
				strReturn = gmstrcode + "0" + c;
			} else {
				strReturn = gmstrcode + c;
			}
		}
		PrintWriter rs = response.getWriter();
		rs.print(strReturn);
		return null;
	}

	public String queryGmenuByCode() throws Exception {
		String gmcode = request.getParameter("code");
		GmenusColumns columns = new GmenusColumns();
		GmenusQuery query = new GmenusQuery();
		GmenusCondition con = new GmenusCondition();
		con.setGmcode(gmcode);
		query.setCondition(con);
		GmenusColumns objColumns = RoleDemand.queryGmenusByRlcode(gmcode);
		request.setAttribute("objColumns", objColumns);
		JSONObject objJSONObject = JSONObject.fromObject(objColumns);
		String jsonData = objJSONObject.toString();
		PrintWriter rs = response.getWriter();
		rs.print(jsonData);
		return null;
	}

	public String saveNewMenu() throws Exception {
		// String gmcode=request.getParameter("gmcode");//主键自动生成，不需要手动设置
		String gmname = request.getParameter("gmname");
		String gmstrucode = request.getParameter("gmstrucode");
		String gmgmlink = request.getParameter("gmgmlink");
		String gmparameter = request.getParameter("gmparameter");
		String gosgoscode = request.getParameter("gosgoscode");
		String iskcode = request.getParameter("iskiskcode");
		String gmgmlevel = request.getParameter("gmgmlevel");
		String gmmaxusecount = request.getParameter("gmmaxusecount");
		String gmshowtoolbar = request.getParameter("gmshowtoolbar");
		String gmgmgroupcode = request.getParameter("gmgmgroupcode");

		GmenusColumns columns = new GmenusColumns();
		GmenusQuery query = new GmenusQuery();
		GmenusCondition con = new GmenusCondition();
		// columns.setGmgmcode(gmcode);
		columns.setGmgmname(gmname);
		columns.setGmgmparameter(gmparameter);
		columns.setGosgoscode(gosgoscode);
		columns.setIskiskcode(iskcode);
		columns.setGmgmlink(gmgmlink);
		columns.setGmgmlevel(Integer.parseInt(gmgmlevel));
		columns.setGmgmstructurecode(gmstrucode);
		columns.setGmgmgroupcode(gmgmgroupcode);
		columns.setGmgmmaxusecount(Integer.parseInt(gmmaxusecount));
		columns.setGmgmshowtoolbar(gmshowtoolbar);

		GmenusItem gi = new GmenusItem();
		PrintWriter rs = response.getWriter();
		try {
			gi.save(columns, "");
			rs.write("OK");
		} catch (Exception e) {
			rs.write("ERROR");
		}
		return null;
	}

	// 删除功能(删除t_fs_guimenu中的功能
	public String deleteGuimenu() throws Exception {
		String gmcode = request.getParameter("gmcodes");
		String[] gmcodes = gmcode.substring(1).split(",");
		GmenusItem gi = new GmenusItem();
		PrintWriter rs = response.getWriter();
		try {
			for (int i = 0; i < gmcodes.length; i++) {
				gi.delete(gmcodes[i]);
			}
			rs.write("OK");
		} catch (Exception e) {
			rs.write("ERROR");
		}
		return null;
	}

	// 删除t_fs_role 中的角色
	public String DeleteRole() throws Exception {
		String rlcode = request.getParameter("rlcode");
		PrintWriter rs = response.getWriter();
		try {
			Role role = new Role();
			role.delete(rlcode);
			rs.write("OK");
		} catch (Exception e) {
			rs.write("ERROR");
		}
		return null;
	}
}
