package com.daiyun.dax;

import java.util.List;
import kyle.leis.fs.cachecontainer.da.CargokindQuery;

public class CargokindDemand {
    public static List queryAll() throws Exception{
    CargokindQuery a = new CargokindQuery();
    List list =	a.getResults();
    	
    return list;
    }
    
    public static void main(String[] args) {
    	try {
    		System.out.println(queryAll().size());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
