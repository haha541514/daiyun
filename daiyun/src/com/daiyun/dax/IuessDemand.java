package com.daiyun.dax;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import kyle.leis.eo.customerservice.issue.da.IssueactionColumns;
import kyle.leis.eo.customerservice.issue.da.IssueactionCondition;
import kyle.leis.eo.customerservice.issue.da.IssueactionQuery;
import kyle.leis.fs.cachecontainer.da.IssuetypeColumns;
import kyle.leis.fs.cachecontainer.da.IssuetypeQuery;

/**
 * 查询所有问题类型
 * @param objIssueCondition
 * @return
 * @throws Exception
 */
public class IuessDemand {
	public static List<IssuetypeColumns> query() throws Exception {
		IssuetypeQuery objIssuetypeQuery = new IssuetypeQuery();
		List<IssuetypeColumns> listIscolumns=objIssuetypeQuery.getResults();
		return listIscolumns;
	}
	/**
	 * 查询所有问题类型
	 * @param objIssueCondition
	 * @return
	 * @throws Exception
	 */
	public static String queryIsacontent(String strIsuid,String strAkcode) throws Exception {
		IssueactionQuery objIssueactionQuery = new IssueactionQuery();
		IssueactionCondition issueactionCondition= new IssueactionCondition();
		issueactionCondition.setIsuid(strIsuid);
		issueactionCondition.setAkcode(strAkcode);
		objIssueactionQuery.setCondition(issueactionCondition);
		if(objIssueactionQuery.getResults().size() >0){
			String isacontent = ((IssueactionColumns)objIssueactionQuery.getResults().get(0)).getIsaisacontent();
			return  isacontent;
		}else{			
			return "";
		}
	} 
	public static HashMap<String,String> queryContent(String strIsuid) throws Exception{
		IssueactionQuery objIssueactionQuery = new IssueactionQuery();
		IssueactionCondition issueactionCondition= new IssueactionCondition();
		issueactionCondition.setIsuid(strIsuid);
		issueactionCondition.setAkcode("CWR");
		objIssueactionQuery.setCondition(issueactionCondition);
		List<IssueactionColumns> list=objIssueactionQuery.getResults();
		HashMap<String,String> map=new HashMap<String,String>();
		String content="";
		int i=1;
		long time=0;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmm");
		if(list.size()==0){
			map.put("content", "");
		}else{
			for(IssueactionColumns columns:list){
				if(i==1){
					String date=columns.getIsaisacreatedate();
				    time = sdf.parse(date).getTime();//毫秒
				    content=columns.getIsaisacontent();
					i++;
				}else{
					String date2=columns.getIsaisacreatedate();
					long time2 = sdf.parse(date2).getTime();
					if(time2>=time){
						 content=columns.getIsaisacontent();
					}else{
						break;
					}
				}
			} 
			map.put("content", content);
		}
		IssueactionQuery objIssueactionQuery2 = new IssueactionQuery();
		IssueactionCondition issueactionCondition2= new IssueactionCondition();
		issueactionCondition2.setIsuid(strIsuid);
		issueactionCondition2.setAkcode("BWR");
		objIssueactionQuery2.setCondition(issueactionCondition2);
		List<IssueactionColumns> list2=objIssueactionQuery2.getResults();
		 
		String content2=""; 
		long times=0;
		int a=1;
		if(list2.size()==0){
			map.put("bwr", "");
		}else{
			for(IssueactionColumns columns:list2){
				if(a==1){
					String date=columns.getIsaisacreatedate();
				    times = sdf.parse(date).getTime();//毫秒
				    content2=columns.getIsaisacontent();
					a++;
				}else{
					String date2=columns.getIsaisacreatedate();
					long time2 = sdf.parse(date2).getTime();
					if(time2>=times){
						 content2=columns.getIsaisacontent();
					}else{
						break;
					}
				}
			} 
			map.put("bwr", content2);
		}
		return map;
	}
}
