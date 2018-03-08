package com.daiyun.dax;

import java.util.ArrayList;
import java.util.List;

import kyle.leis.fs.cachecontainer.da.PaymentmodeColumns;
import kyle.leis.fs.cachecontainer.da.PaymentmodeQuery;

public class PaymentmodeDemand {
	/*
	 * ?¥è????ä»?´¹æ¨¡å?

	 */
	public static List<PaymentmodeColumns> queryAllPaymentmodes()throws Exception
	{
		PaymentmodeQuery objPMQuery = new PaymentmodeQuery();
		List<PaymentmodeColumns> listPMColumns = objPMQuery.getResults();
		
		listPMColumns.remove(0);
		listPMColumns.remove(2);
		return listPMColumns;
	}
}
