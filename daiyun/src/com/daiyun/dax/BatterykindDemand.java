package com.daiyun.dax;

import java.util.List;
import kyle.leis.fs.dictionary.batterykind.da.BatterykindQuery;

public class BatterykindDemand {
   public static List getAllBatterykind() throws Exception{
	   BatterykindQuery query = new BatterykindQuery();
	   List list = query.getResults();
	   return list;
   }
   public static void main(String[] args) {
	try {
		System.out.println(getAllBatterykind().size());
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}
}
