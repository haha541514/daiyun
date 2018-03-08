package com.daiyun.dax;

import java.util.List;

import kyle.leis.fs.authority.da.RolemenusColumns;
import kyle.leis.fs.authority.da.RolemenusCondition;
import kyle.leis.fs.authority.da.RolemenusQuery;
import kyle.leis.fs.authority.da.RolemenusQueryPX;
import kyle.leis.fs.authority.da.UserroleCondition;
import kyle.leis.fs.authority.da.UserroleQuery;
import kyle.leis.fs.authoritys.gmenus.bl.Gmenus;
import kyle.leis.fs.authoritys.gmenus.da.GmenusColumns;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemColumns;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemCondition;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemQuery;
import kyle.leis.fs.authoritys.role.bl.Role;
import kyle.leis.fs.authoritys.role.da.RoleColumns;
import kyle.leis.fs.authoritys.rolegmenus.bl.RoleGmenus;

public class RoleDemand {
	//�����ɫ���Լ��˵���
   public static String saveRoleAndMenu(String strOperId,RoleColumns objRoleColumns,String[] astrMenus_code) throws Exception{
	   Role objRole =  new Role();
	   //��ɫ��
	   RoleColumns objReturn = objRole.save(strOperId, objRoleColumns);
	   String rlcode=objReturn.getRlrlcode();
	   //��ɫ-�˵���
	   RoleGmenus objRoleGmenus = new RoleGmenus();
	   String[] astrRole_code = {rlcode};
	   objRoleGmenus.save(astrRole_code, astrMenus_code, strOperId);  
	   return null;
   }
   //����rlcode���ɫ
   public static RoleColumns queryRoleByRlcode(String strRlcode) throws Exception{
	   Role objRole =  new Role();
	   RoleColumns objReturn=(RoleColumns) objRole.queryRoleByRoleCode(strRlcode).get(0);
	   return objReturn;
	   
   }
   //����gmcode�鹦��
   public static GmenusColumns queryGmenusByRlcode(String gmcode) throws Exception{
   Gmenus gmenus=new Gmenus();
   GmenusColumns objReturn=(GmenusColumns)gmenus.queryGmenusByGmode(gmcode).get(0);
	   return objReturn;
   }
   
   //����rlcode��ѯ����
   public static List<RolemenusColumns> queryRolemenusByRlcode(String strRlcode) throws Exception{
	   RolemenusQueryPX query = new RolemenusQueryPX();
	   RolemenusCondition con = new RolemenusCondition();
	   con.setRlcode(strRlcode);
	   query.setCondition(con);
	   List<RolemenusColumns> list = query.getResults();
	   return list;   
   }

    public static String queryStrCode(String gm_name,String iskCode)throws Exception{
	   GmenusitemColumns columns=null;  
		GmenusitemCondition con=new GmenusitemCondition();
		GmenusitemQuery query=new GmenusitemQuery();   
		con.setGmname(gm_name);
		con.setIskcode(iskCode);
		con.setGmlevel("1");
		query.setCondition(con);
		List<GmenusitemColumns> list=query.getResults();
			columns=list.get(0);
			String strucCode=columns.getGmgm_structurecode();
			System.out.println("strucCodeΪ��"+strucCode);
			con.setGmstructurecode(strucCode);
		return strucCode;
   }
   public List queryAllRoleUser(UserroleCondition con)throws Exception{
	   UserroleQuery query=new UserroleQuery();
	   query.setCondition(con);
	   return query.getResults();   
   }
   
   
}

