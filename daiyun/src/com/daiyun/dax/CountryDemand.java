package com.daiyun.dax;

import java.util.List;

import kyle.leis.fs.dictionary.district.da.CountryColumns;
import kyle.leis.fs.dictionary.district.da.CountryQuery;
import kyle.leis.fs.dictionary.district.dax.CountryQueryEX;

public class CountryDemand {
	@SuppressWarnings("unchecked")
	public static List<CountryColumns> queryAllCountry() throws Exception {
		CountryQuery objCountryQuery = new CountryQuery();
		List<CountryColumns> listCountryColumns = (List<CountryColumns>) objCountryQuery.getResults();
		return listCountryColumns;
	}

	// 根据二字代码得到国家编号
	@SuppressWarnings("unchecked")
	public static List<CountryColumns> queryDtcodeByHubcode(String dthubcode)
			throws Exception {
		CountryQuery objCountryQuery = new CountryQuery();
		objCountryQuery.setDthubcode(dthubcode);
		List<CountryColumns> listCountryColumns = (List<CountryColumns>) objCountryQuery.getResults();
		return listCountryColumns;
	}

	public static String getDtcodeByHubcode(String strDthubcode)
			throws Exception {

		if (strDthubcode == null || strDthubcode == "") {
			return "";
		}
		CountryQuery objCountryQuery = new CountryQuery();
		objCountryQuery.setUseCachesign(true);
		objCountryQuery.setDthubcode(strDthubcode);
		List objList = objCountryQuery.getResults();

		if (objList == null || objList.size() < 1)
			return "";
		return ((CountryColumns) objList.get(0)).getDtdt_ename();

	}

	// 根据国家名字得到二字代码
	@SuppressWarnings("unchecked")
	public static List<CountryColumns> queryDtHubCodeByCountry(String dtname)
			throws Exception {
		CountryQueryEX objCountryQuery = new CountryQueryEX();
		objCountryQuery.setDtname(dtname);
		List<CountryColumns> listCountryColumns = (List<CountryColumns>) objCountryQuery.getResults();
		return listCountryColumns;
	}

}
