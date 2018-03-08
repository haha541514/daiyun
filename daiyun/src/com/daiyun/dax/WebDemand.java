package com.daiyun.dax;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kyle.leis.fs.authoritys.gmenus.da.GmenusitemColumns;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemCondition;
import kyle.leis.fs.authoritys.gmenus.dax.GmenusItemDemand;

public class WebDemand {
	
	private static List<GmenusitemColumns> listGmenusitem;
	//查询所有菜单
    public static void SMqueryAll() throws Exception{
 	   GmenusitemCondition objGmenusitemCondition=new GmenusitemCondition();
 	   objGmenusitemCondition.setIskcode("LEWFDIS");
 	   objGmenusitemCondition.setGmgroupcode("A");
 	   objGmenusitemCondition.setGmstructurecode("01");
 	   objGmenusitemCondition.setUseCacheSign(true);
 	   List<GmenusitemColumns> l=GmenusItemDemand.query(objGmenusitemCondition);   	   
 	   listGmenusitem=l;
    } 
	
	//查询一级菜单
    public static String FMquery(String type) throws Exception{    	 
    	if(listGmenusitem==null){
    		SMqueryAll();
    	}
    	String listStr= ""; 
    	for(int i=0;i<listGmenusitem.size();i++){
    		GmenusitemColumns  gc=  listGmenusitem.get(i);
    		if("1".equals(gc.getGmgm_level())||"1"==gc.getGmgm_level()){
    			if(gc.getGmgm_structurecode().indexOf(String.valueOf(type)) != -1){
    				listStr = gc.getGmgm_name();
    			}
    		}
    	}
    	return listStr;
    }
    //查询二级菜单
    public static List SMquery(String type) throws Exception{
    	if(listGmenusitem==null){
    		SMqueryAll();
    	}
    	List<GmenusitemColumns> listGC= new ArrayList<GmenusitemColumns>(); 
    	for(int i=0;i<listGmenusitem.size();i++){
    		GmenusitemColumns  gc=  listGmenusitem.get(i);
    		if("2".equals(gc.getGmgm_level())||"2"==gc.getGmgm_level()){
    			if(gc.getGmgm_structurecode().indexOf(String.valueOf(type)) != -1){
    				listGC.add(gc);
    			}
    		}
    	}
    	return listGC;
    } 
    //查询二级菜单弟一个菜单code
    public static String SMFNquery(String type) throws Exception{
    	if(listGmenusitem==null){
    		SMqueryAll();
    	}
    	String listStr= ""; 
    	for(int i=0;i<listGmenusitem.size();i++){
    		GmenusitemColumns  gc=  listGmenusitem.get(i);
    		if(gc.getGmgm_structurecode().indexOf(String.valueOf(type)) != -1){
    			if(gc.getGmgm_structurecode().indexOf(String.valueOf("0101")) != -1){
    				listStr = gc.getGmgm_code();
    			}
    		}
    	}
    	return listStr; 
    }
      //标识符
      public static List<List<String>> getId(){
    	 List<String> list1=new ArrayList<String>();
//    	 list1.add("F");
//    	 list1.add("E");
//    	 list1.add("D");
//    	 list1.add("C");
//    	 list1.add("B");
//    	 list1.add("A");
      	 list1.add("J");
    	 list1.add("K");
    	 list1.add("L");
    	 list1.add("M");
    	 list1.add("N");
    	 List<String> list2=new ArrayList<String>();
    	 list2.add("queryCode"); 
    	 list2.add("productsCode");
    	 list2.add("newCode");
    	 list2.add("centerCode");
    	 list2.add("qyBygmcode");
    	 
    	 List<List<String>> infoIds =new ArrayList<List<String>>();
    	 infoIds.add(list1);
    	 infoIds.add(list2);   	 
    	
    	 
    	 return infoIds;
    	 
      }     
      //查询action
      public static Map<String,String> getAction() throws Exception{
    	  Map<String,String> map=new HashMap<String,String>();	  
    	  map.put(STquery("J0101"), "page/queryTrack");
    	  map.put(STquery("J0102"), "cityAccesspossTool");
    	  map.put(STquery("J0103"), "remoteDistrictTool");  
    	  map.put(STquery("J0105"), "airwayCompanyTool");
    	  map.put(STquery("J0107"), "gangkouQueryTool");
    	  return map;
      }
      //查询GMCODE值
      public static String STquery(String type) throws Exception{
    	  //   	   objGmenusitemCondition.setIskcode("LEWFDIS");
    	  //   	   objGmenusitemCondition.setGmstructurecode(type);
    	  //   	   objGmenusitemCondition.setUseCacheSign(true);
    	  if(listGmenusitem==null){
    		  SMqueryAll();
    	  }
    	  String listStr= ""; 
    	  for(int i=0;i<listGmenusitem.size();i++){
    		  GmenusitemColumns  gc=  listGmenusitem.get(i);
    		  if(gc.getGmgm_structurecode().indexOf(String.valueOf(type)) != -1){
    			  listStr = gc.getGmgm_code();
    		  }
    	  }
    	  return listStr; 
      } 
    public static void main(String[] args) {
		try {
			System.out.println(SMquery("J").size());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
