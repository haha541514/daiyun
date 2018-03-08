package com.daiyun.pgweb.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.fs.authoritys.gmenus.da.GmenusColumns;
import kyle.leis.fs.authoritys.gmenus.da.GmenusQuery;
import kyle.leis.fs.authoritys.role.bl.Role;
import kyle.leis.fs.authoritys.role.da.RoleColumns;
import kyle.leis.fs.authoritys.role.da.RoleCondition;
import kyle.leis.fs.authoritys.rolegmenus.bl.RoleGmenus;
import kyle.leis.fs.authoritys.rolegmenus.da.RolegmenusColumns;
import kyle.leis.fs.authoritys.rolegmenus.dax.QueryByStructurecodeReturn;
import kyle.leis.fs.authoritys.user.da.UserColumns;
import kyle.leis.fs.authoritys.user.da.UserCondition;
import kyle.leis.fs.authoritys.user.dax.UserDemand;
import kyle.leis.fs.authoritys.userrole.bl.UserRole;
import kyle.leis.fs.authoritys.userrole.da.UserroleColumns;


public class AccessControl extends ActionSupportEX{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static JSONArray  rolejsonArray = null;
	private static JSONArray  menujsonArray = null;

	//用户角色管理
    public String userRole() throws Exception{
    	UserCondition objUserCondition=new UserCondition();
    	//userCondition.setIsnull("null");
    	objUserCondition.setCocode(session.getAttribute("Cocode").toString());
    	//用户信息查询
		List<UserColumns> listUserColumns=UserDemand.query(objUserCondition);
		
		List<String>userList=new ArrayList<String>();
		List<String>functionList=new ArrayList<String>();
		List<String>departmentList=new ArrayList<String>();
		for(int i=0;i<listUserColumns.size();i++){
			userList.add(listUserColumns.get(i).getOpopname());
			functionList.add(listUserColumns.get(i).getFcfcname());
			departmentList.add(listUserColumns.get(i).getDpdpname());
		}
		//用户
		request.setAttribute("userList", userList);
		//职能
		request.setAttribute("functionList", AccessControl.deleteRepeat(functionList));
		//部门
		request.setAttribute("departmentList", AccessControl.deleteRepeat(departmentList));
		
			//角色
			Role role=new Role();
			RoleCondition roleCondition=new RoleCondition();
			roleCondition.setIsk_code("LEWMIS");
			List<RoleColumns>roleList=role.query(roleCondition);
			request.setAttribute("roleList", roleList);
			//菜单
			GmenusQuery GmenusQuery =new GmenusQuery();
			GmenusQuery.setIskcode("LEWMIS");
			List<GmenusColumns>menuList =GmenusQuery.getResults();
			//角色集合转换成josn集合
			int lg=0;
			for(int i=0;i<roleList.size();i++){
				if(lg<roleList.get(i).getRlrlstructurecode().length())
				lg=roleList.get(i).getRlrlstructurecode().length();
			}
			request.setAttribute("lg",lg);
			rolejsonArray =JSONArray.fromObject(roleList);
			menujsonArray=JSONArray.fromObject(menuList);
			request.setAttribute("jsonArray",rolejsonArray);
			request.setAttribute("menujsonArray", menujsonArray);
			/*查询功能*/
			//用户工号
			String userCode=request.getParameter("userCode");
			//用户名称
			String user=request.getParameter("user");
			//用户职能
			String function=request.getParameter("function");
			//部门名称
			String department=request.getParameter("department");
			//起始时间
			String strStartdate=request.getParameter("startdate");
			//截至时间
			String strenddate=request.getParameter("enddate");
			if(!StringUtility.isNull(userCode)){
				objUserCondition.setOpcode(userCode);
				request.setAttribute("userCode", userCode);
			}
			if(!StringUtility.isNull(user)){
				objUserCondition.setOpname(user);
				request.setAttribute("user", user);
			}
			if(!StringUtility.isNull(function)){
				objUserCondition.setFcname(function);
				request.setAttribute("function", function);
			}
			if(!StringUtility.isNull(department)){
				objUserCondition.setDpname(department);
				request.setAttribute("department", department);
			}
			if(!StringUtility.isNull(strStartdate)){
				objUserCondition.setStartcreatedate(strStartdate);
			}
			if(!StringUtility.isNull(strenddate)){
				objUserCondition.setEndcreatedate(strenddate);
			}
			List<UserColumns> UserColumnslist=UserDemand.query(objUserCondition);
			request.setAttribute("listUserColumns", UserColumnslist);
			//修改角色
			String[] userrole=request.getParameterValues("role");
			try {
				String[]rCode=request.getParameterValues("rCode");
				UserRole ur=new UserRole();
				for(int i=0;i<userrole.length;i++){
					ur.save(userrole[i], rCode, "LEWMIS");
				}
			} catch (Exception e) {
				// TODO: handle exception
			}
		 
    	return SUCCESS;
    }
    //去重
    public static List deleteRepeat(List list){
    	for(int i=0;i<list.size()-1;i++){
    		for(int j=list.size()-1;j>i;j--){
    			if(list.get(i).equals(list.get(j))){
    				 list.remove(j);
    			}
    		}
    	}
    	return list;
    }
    public void queryByUrIskCode() throws Exception{
    	UserRole userRole=new UserRole();
    	List<UserroleColumns>roleCodes=userRole.queryByUrIskCode(request.getParameter("user"), "LEWMIS");
    	List roleCode=new ArrayList();
    	for(int i=0;i<roleCodes.size();i++){
    		roleCode.add(roleCodes.get(i).getRlrlstructurecode());
    	}
    	PrintWriter out=null;
    	out=response.getWriter();
    	out.print(JSONArray.fromObject(roleCode));
    	out.close();
    }
    public void queryByStructurecode() throws Exception{
       RoleGmenus roleGmenus =new RoleGmenus();
  	   QueryByStructurecodeReturn r=new QueryByStructurecodeReturn();
  	   r=roleGmenus.queryByStructurecode(request.getParameter("rs"), "LEWMIS");
  	   List <RolegmenusColumns>l=r.getM_listFatherRolegmenusColumns();
  	   List <RolegmenusColumns>roleMenuList=r.getM_listSelfRolegmenusColumns();
  	   roleMenuList.addAll(l);
  	   PrintWriter out=null;
	   out=response.getWriter();
	   out.print(JSONArray.fromObject(roleMenuList));
	   out.close();
    }
}
