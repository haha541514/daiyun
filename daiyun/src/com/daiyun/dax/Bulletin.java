package com.daiyun.dax;

import java.util.List;

import kyle.common.dbaccess.query.PageConfig;
import kyle.common.util.jlang.CollectionUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.es.bulletin.da.BulletinColumns;
import kyle.leis.es.bulletin.da.BulletinCondition;
import kyle.leis.es.bulletin.dax.BulletinDemand;

public class Bulletin {

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
		return BulletinDemand.query(objBulletinCondition);
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
}
