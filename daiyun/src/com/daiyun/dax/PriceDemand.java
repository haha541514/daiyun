package com.daiyun.dax;

import java.util.List;

import kyle.leis.fs.cachecontainer.da.PaymentmodeColumns;
import kyle.leis.fs.cachecontainer.da.PaymentmodeQuery;
import kyle.leis.fs.cachecontainer.da.PricegroupColumns;
import kyle.leis.fs.cachecontainer.da.PricegroupQuery;
import kyle.leis.fs.cachecontainer.da.PricestatusColumns;
import kyle.leis.fs.cachecontainer.da.PricestatusQuery;

/**
 * @date 2017/3/23
 * @author wukq
 * @version 1.0
 * */
public class PriceDemand {

	
	/*获得产品组*/
	public static List<PricegroupColumns> getPriceGroup() throws Exception{
		PricegroupQuery query = new PricegroupQuery();
		List<PricegroupColumns> results = query.getResults();
		return results;
		
	}
	
	/*产品状态*/
	public static List<PricestatusColumns> getPriceStatus() throws Exception{
		PricestatusQuery query = new PricestatusQuery();
		List<PricestatusColumns> results = query.getResults();
		return results;
		
	}
	
	public static List<PaymentmodeColumns> getPaymentmode() throws Exception{
		PaymentmodeQuery query =new PaymentmodeQuery();
		List<PaymentmodeColumns> results = query.getResults();
		return results;
		
	}
	
}
