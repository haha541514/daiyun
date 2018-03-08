package com.daiyun.dax;

import java.util.List;

import kyle.common.util.jlang.StringUtility;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemColumns;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemCondition;
import kyle.leis.fs.authoritys.gmenus.dax.GmenusItemDemand;
import kyle.leis.fs.authoritys.role.bl.Role;

public class MenuDemand {
   public static List queryMenuByIsk(){
	   Role roler = new Role();
	   return null;
   }
   //����isk��ѯһ���˵�
   public static List queryFirstLevelMenu(String iskCode) throws Exception{
	   GmenusitemCondition con = new GmenusitemCondition();
	   con.setGmlevel("1");
	   con.setIskcode(iskCode);
	   List<GmenusitemColumns> list = GmenusItemDemand.query(con);
	   return list;
   }
   //��������Ų�ѯ�����˵�
   public static List querySubmenu(String strucCode) throws Exception{
		GmenusitemCondition con = new GmenusitemCondition();
		con.setGmlevel("2");
		con.setGmstructurecode(strucCode);
		List submenulist=GmenusItemDemand.query(con);
		List<GmenusitemColumns> list = GmenusItemDemand.query(con);
		return list;
	}
   
}
