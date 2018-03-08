package com.daiyun.dax;

import java.util.List;

import kyle.leis.fs.dictionary.packagetype.da.PackagetypeQuery;


public class PackagetypeDemand {
   public static List queryAllType(){
	   PackagetypeQuery query = new PackagetypeQuery();
	   List list= null;
		   try {
			 list = query.getResults();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	return list;	
   }
  
}
