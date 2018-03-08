package com.daiyun.pgweb.action;

import java.util.List;



import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.fs.authoritys.gmenus.bl.GmenusItem;
import kyle.leis.fs.authoritys.gmenus.da.GmenusColumns;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemColumns;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemCondition;
import kyle.leis.fs.authoritys.gmenus.dax.GmenusItemDemand;


public class GmItemAction extends ActionSupportEX{
	
	private static final long serialVersionUID = 3193353022281437259L;
	
	/**
	 * 查询一级菜单
	 * @return
	 * @throws Exception
	 */
	public String queryFirstItem() throws Exception{
		GmenusitemCondition objGmenusitemCondition = new GmenusitemCondition();
		objGmenusitemCondition.setGmlevel("1");
		if(!StringUtility.isNull(request.getParameter("boolSystem"))){
			objGmenusitemCondition.setIskcode(request.getParameter("boolSystem"));
		}else{
			if(!StringUtility.isNull((String)session.getAttribute("iskCode"))){
				objGmenusitemCondition.setIskcode((String)session.getAttribute("iskCode"));
			}else{
			  objGmenusitemCondition.setIskcode("LEWFDIS");
			}
		}
		session.setAttribute("iskCode",objGmenusitemCondition.getIskcode());
		List itemlist=GmenusItemDemand.query(objGmenusitemCondition);
		request.setAttribute("fistItemList", itemlist);
		return SUCCESS;
	}
	
	/**
	 * 查询一级菜单下的子菜单
	 * @return
	 * @throws Exception
	 */
	public String querySubmenu() throws Exception{
		String gmcode=request.getParameter("gmcode");
		if(StringUtility.isNull(gmcode)&&!StringUtility.isNull(session.getAttribute("fagmcode").toString())){
			gmcode=session.getAttribute("fagmcode").toString();
		}if(StringUtility.isNull(gmcode)&&StringUtility.isNull(session.getAttribute("fagmcode").toString())){
			return null;
		}
		GmenusitemCondition gc=new GmenusitemCondition();
		gc.setGmcode(gmcode);
		GmenusitemColumns objgmcolumns=(GmenusitemColumns)GmenusItemDemand.query(gc).get(0);
		String structurecode=objgmcolumns.getGmgm_structurecode();
		GmenusitemCondition objGmenusitemCondition = new GmenusitemCondition();
		objGmenusitemCondition.setGmlevel("2");
		objGmenusitemCondition.setGmstructurecode(structurecode);
		objGmenusitemCondition.setIskcode("LEWFDIS");
		objGmenusitemCondition.setIskcode(objgmcolumns.getGmisk_code());
		List submenulist=GmenusItemDemand.query(objGmenusitemCondition);
		request.setAttribute("submenulist", submenulist);
		request.setAttribute("sc", structurecode);
		session.setAttribute("fagmcode", gmcode);
		return SUCCESS;
	}
	/**
	 * 根据gmcode查询父菜单
	 * @return
	 * @throws Exception
	 */
	public String queryByGmCode() throws Exception{
		String gmCode=request.getParameter("gmcode");	
		GmenusitemCondition objGmenusitemCondition = new GmenusitemCondition();
		objGmenusitemCondition.setGmcode(gmCode);
		List list=GmenusItemDemand.query(objGmenusitemCondition);
		GmenusitemColumns gmenusitem=(GmenusitemColumns)list.get(0);
		request.setAttribute("gmenusitem", gmenusitem);
		GmenusitemCondition objGmenusitemCondition2 = new GmenusitemCondition();
		objGmenusitemCondition2.setGmlevel("1");
		objGmenusitemCondition2.setIskcode((String)session.getAttribute("iskCode"));
		List itemlist=GmenusItemDemand.query(objGmenusitemCondition2);
		request.setAttribute("fistItemList", itemlist);
		return SUCCESS;
	}
	/**
	 * 根据gmcode查询子菜单
	 * @return
	 * @throws Exception
	 */
	public String querySubByGmCode() throws Exception{
		String gmCode=request.getParameter("gmcode");
		GmenusitemCondition objGmenusitemCondition = new GmenusitemCondition();
		objGmenusitemCondition.setGmcode(gmCode);
		List list=GmenusItemDemand.query(objGmenusitemCondition);
		GmenusitemColumns gmenusitem=(GmenusitemColumns)list.get(0);
		request.setAttribute("gmenusitem", gmenusitem);
		
		String structurecode=request.getParameter("sc");
		GmenusitemCondition objGmenusitemCondition2 = new GmenusitemCondition();
		objGmenusitemCondition2.setGmlevel("2");
		objGmenusitemCondition2.setGmstructurecode(structurecode);
		objGmenusitemCondition2.setIskcode((String)session.getAttribute("iskCode"));
		List submenulist=GmenusItemDemand.query(objGmenusitemCondition2);
		request.setAttribute("submenulist", submenulist);
		request.setAttribute("sc", structurecode);
		return SUCCESS;
	}
	
	public String AddAndUpdateGmItem() throws Exception{
		String gmcode=request.getParameter("gmcode");
		String gmname=request.getParameter("gmname");
		String gmstructuercode=request.getParameter("gmstructuercode");
		String gmlink=request.getParameter("gmlink");
		String gmparam=request.getParameter("gmsparameter");
		GmenusColumns objGmenusColumns=new GmenusColumns();
		objGmenusColumns.setGmgmcode(gmcode);
		objGmenusColumns.setGmgmname(gmname);
		objGmenusColumns.setGmgmparameter(gmparam);
		objGmenusColumns.setGosgoscode("M");
		objGmenusColumns.setIskiskcode((String)session.getAttribute("iskCode"));
		objGmenusColumns.setGmgmlink(gmlink);
		int level=Integer.parseInt(request.getParameter("level"));
		objGmenusColumns.setGmgmlevel(level);
		objGmenusColumns.setGmgmstructurecode(gmstructuercode);
		objGmenusColumns.setGmgmgroupcode("A");
		objGmenusColumns.setGmgmmaxusecount(1);
		objGmenusColumns.setGmgmshowtoolbar("N");				
		GmenusItem gi=new GmenusItem();
		if(level==1){
			gi.save(objGmenusColumns, "");
		}else{
			String content=request.getParameter("content");			
			gi.save(objGmenusColumns, content);
		}
		
		return SUCCESS;
	}
	public String DeleteGmItem() throws Exception{
		String gmcodes=request.getParameter("gmcodes");
		String[] gmcode=gmcodes.split(",");
		GmenusItem gi=new GmenusItem();
		for(int i=0;i<gmcode.length;i++){
			gi.delete(gmcode[i]);
		}
		return SUCCESS;
	}
	//查询单个内容
    public String queryBygmcode() throws Exception{
    	String gmcode=request.getParameter("code");
 	    GmenusitemCondition objGmenusitemCondition=new GmenusitemCondition();
 	    objGmenusitemCondition.setIskcode("LEWFDIS");
 	    objGmenusitemCondition.setGmcode(gmcode);
 	    List<GmenusitemColumns> l;
		  l = GmenusItemDemand.query(objGmenusitemCondition);
		  request.setAttribute("gmcode", gmcode);
		  request.setAttribute("content", l.get(0).getGmigmi_content());
		  request.setAttribute("title", l.get(0).getGmgm_name());
		  return SUCCESS;
    } 
   public String  searchTrack() throws Exception{
	   String gmcode = request.getParameter("code");
	   if(gmcode.equals("货物追踪"))
		   request.setAttribute("guide", "0");
	   return SUCCESS;
   }
	
}
