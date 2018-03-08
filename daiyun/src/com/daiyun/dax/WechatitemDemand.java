package com.daiyun.dax;

import java.util.ArrayList;
import java.util.List;

import kyle.leis.es.bulletin.da.WechatitemColumns;
import kyle.leis.es.bulletin.da.WechatitemCondition;
import kyle.leis.es.bulletin.da.WechatitemQuery;

public class WechatitemDemand {
	/**
	 * 查询微信项目
	 * @param condition
	 * @return
	 */
	public static List<?> query(WechatitemCondition condition){
		WechatitemQuery query = new WechatitemQuery();
		query.setCondition(condition);
		try {
			return query.getResults();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ArrayList<WechatitemColumns>();
	}
}
