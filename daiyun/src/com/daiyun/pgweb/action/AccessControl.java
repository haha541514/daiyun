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

	//�û���ɫ����
    public String userRole() throws Exception{
    	UserCondition objUserCondition=new UserCondition();
    	//userCondition.setIsnull("null");
    	objUserCondition.setCocode(session.getAttribute("Cocode").toString());
    	//�û���Ϣ��ѯ
		List<UserColumns> listUserColumns=UserDemand.query(objUserCondition);
		
		List<String>userList=new ArrayList<String>();
		List<String>functionList=new ArrayList<String>();
		List<String>departmentList=new ArrayList<String>();
		for(int i=0;i<listUserColumns.size();i++){
			userList.add(listUserColumns.get(i).getOpopname());
			functionList.add(listUserColumns.get(i).getFcfcname());
			departmentList.add(listUserColumns.get(i).getDpdpname());
		}
		//�û�
		request.setAttribute("userList", userList);
		//ְ��
		request.setAttribute("functionList", AccessControl.deleteRepeat(functionList));
		//����
		request.setAttribute("departmentList", AccessControl.deleteRepeat(departmentList));
		
			//��ɫ
			Role role=new Role();
			RoleCondition roleCondition=new RoleCondition();
			roleCondition.setIsk_code("LEWMIS");
			List<RoleColumns>roleList=role.query(roleCondition);
			request.setAttribute("roleList", roleList);
			//�˵�
			GmenusQuery GmenusQuery =new GmenusQuery();
			GmenusQuery.setIskcode("LEWMIS");
			List<GmenusColumns>menuList =GmenusQuery.getResults();
			//��ɫ����ת����josn����
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
			/*��ѯ����*/
			//�û�����
			String userCode=request.getParameter("userCode");
			//�û�����
			String user=request.getParameter("user");
			//�û�ְ��
			String function=request.getParameter("function");
			//��������
			String department=request.getParameter("department");
			//��ʼʱ��
			String strStartdate=request.getParameter("startdate");
			//����ʱ��
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
			//�޸Ľ�ɫ
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
    //ȥ��
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
