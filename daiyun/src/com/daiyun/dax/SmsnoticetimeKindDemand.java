package com.daiyun.dax;

import java.util.List;

import kyle.leis.fs.cachecontainer.da.MessagenoticekindColumns;
import kyle.leis.fs.cachecontainer.da.MessagenoticekindQuery;
import kyle.leis.fs.cachecontainer.da.SmsnoticekindColumns;
import kyle.leis.fs.cachecontainer.da.SmsnoticekindQuery;
import kyle.leis.fs.cachecontainer.da.SmsnoticetimetypeColumns;
import kyle.leis.fs.cachecontainer.da.SmsnoticetimetypeQuery;




public class SmsnoticetimeKindDemand {
	/**
	 * ����֪ͨʱ������
	 * @throws Exception 
	 * */
	@SuppressWarnings("unchecked")
	public static List<SmsnoticetimetypeColumns> getSmsnoticetimetype() throws Exception{
		List<SmsnoticetimetypeColumns> resultlist= new SmsnoticetimetypeQuery().getResults();
		return resultlist;
	}
	/**
	 * ��������
	 * */
	@SuppressWarnings("unchecked")
	public static List<SmsnoticekindColumns> getSmsnoticekind() throws Exception{
		List<SmsnoticekindColumns> resultlist = new SmsnoticekindQuery().getResults();
		return resultlist;
	}
	/**
	 * ��Ϣ����
	 * */
	@SuppressWarnings("unchecked")
	public static List<MessagenoticekindColumns> getMessagenoticekind() throws Exception{
		List<MessagenoticekindColumns> resultlist =  new MessagenoticekindQuery().getResults();
		return resultlist;
	}
	
}
