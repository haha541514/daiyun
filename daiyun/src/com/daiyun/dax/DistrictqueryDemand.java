package com.daiyun.dax;

import java.util.List;

import kyle.leis.fs.dictionary.district.da.DicdistrictColumns;
import kyle.leis.fs.dictionary.district.da.DicdistrictCondition;
import kyle.leis.fs.dictionary.district.dax.DistrictDemand;

public class DistrictqueryDemand {
   public static List queryStartDistrict() throws Exception{
	   DicdistrictCondition con = new DicdistrictCondition();
	   con.setDtstartcitysign("Y");
	   List<DicdistrictColumns> list=DistrictDemand.query(con);
	   return list;
   }
}
