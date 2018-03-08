package com.daiyun.dax;

import java.util.List;

import kyle.leis.fs.cachecontainer.da.CargotypeColumns;
import kyle.leis.fs.cachecontainer.da.CargotypeQuery;

public class CargoTypeDemand {
	/*
	 * 查询所有货物类型	 */
	public static List<CargotypeColumns> queryAllCargotypes()throws Exception
	{
		CargotypeQuery objCTQuery = new CargotypeQuery();
		List<CargotypeColumns> listCTColumns = objCTQuery.getResults();
		for(int i=0;i<listCTColumns.size();i++){
			if("A".equals(listCTColumns.get(i).getCtctcode())){
				listCTColumns.remove(i);
			}
				
		}
		return listCTColumns;
	}
}
