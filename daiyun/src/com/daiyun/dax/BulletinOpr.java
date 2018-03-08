package com.daiyun.dax;

import java.util.ArrayList;
import java.util.List;

import kyle.common.dbaccess.query.PageConfig;
import kyle.common.util.jlang.CollectionUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.es.bulletin.da.BulletinColumns;
import kyle.leis.es.bulletin.da.BulletinCondition;
import kyle.leis.es.bulletin.dax.BulletinDemand;

public class BulletinOpr {

	/**
	 * 按类型查询指定的前几行
	 * @param strBkcode
	 * @param strSize
	 * @return
	 * @throws Exception
	 */
	public static List queryByBkcode(String strBkcode,String strSize) throws Exception
	{
		BulletinCondition objBulletinCondition = new BulletinCondition();
		objBulletinCondition.setBkcode(strBkcode);
		if(!StringUtility.isNull(strSize))
		{
			PageConfig objPageConfig = new PageConfig();
			objPageConfig.setMaxPageResultCount(Integer.parseInt(strSize));
			objBulletinCondition.setPageConfig(objPageConfig);
		}
		return BulletinDemand.queryOrderEX(objBulletinCondition);
	}
	
	public static BulletinColumns queryByBlId(String strBlId) throws Exception
	{
		BulletinCondition objBulletinCondition = new BulletinCondition();
		objBulletinCondition.setBlid(strBlId);
		List objList = BulletinDemand.query(objBulletinCondition);
		if(!CollectionUtility.isNull(objList) && objList.size()==1)
			return (BulletinColumns)objList.get(0);
		return null;
	}
	
	//实现上一篇与下一篇
	public static List upDownBl(String bkcode,String blId) throws Exception{
		BulletinCondition objBulletinCondition = new BulletinCondition();
		objBulletinCondition.setBkcode(bkcode);
		List listBulletin=BulletinDemand.query(objBulletinCondition);
		BulletinColumns bc=null;
		int blIndex=-1;
		int upBl=0;
		int downBl=0;
		List<BulletinColumns> upDownList=null;
		BulletinColumns upBlColumns=null;
		BulletinColumns downBlColumns=null;
		if(listBulletin !=null && listBulletin.size()>0){
			for(int i=0;i<listBulletin.size();i++){
				bc=(BulletinColumns)listBulletin.get(i);
				if(bc.getBlblid().equals(blId)){
					blIndex=i;
					break;
				}
			}
			if(listBulletin.size()==2){
				if(blIndex==0){
					upBl=0;
					downBl=blIndex+1;
				}else{
					upBl=blIndex-1;
					downBl=blIndex;
				}
			}else if(listBulletin.size()>2){
				if(blIndex==0){
					upBl=0;
					downBl=blIndex+1;
				}else if(blIndex==(listBulletin.size()-1)){
					upBl=blIndex-1;
					downBl=blIndex;
				}else{
					upBl=blIndex-1;
					downBl=blIndex+1;
				}
			}
			upBlColumns=(BulletinColumns)listBulletin.get(upBl);
			downBlColumns=(BulletinColumns)listBulletin.get(downBl);
			upDownList=new ArrayList<BulletinColumns>();
			upDownList.add(upBlColumns);
			upDownList.add(downBlColumns);			
		}		
		return upDownList;		
	}
}
