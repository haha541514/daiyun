package com.daiyun.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * 获取时间类
 * 
 * @date 2016-11-30 by wukq
 * */
public class TimeUtil {
	/**
	 * 获得当天的开始时间
	 * 
	 * @date 2016-11-30 by wukq
	 * @param TimeUtil
	 * @return String
	 * @version 1.0
	 */
	public static String  getStartTime() {
		Calendar todayStart = Calendar.getInstance();
		todayStart.set(Calendar.HOUR, 0);
		todayStart.set(Calendar.MINUTE, 0);
		todayStart.set(Calendar.SECOND, 0);
		todayStart.set(Calendar.MILLISECOND, 0);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sf.format(todayStart.getTime());
		
	}

	/***
	 *获得当天的结束时间
	 * 
	 * @date 2016-11-30 by wukq
	 * @param TimeUtil
	 * @return String
	 * @version 1.0
	 * */
	public static String getEndTime() {
		Calendar todayEnd = Calendar.getInstance();
		todayEnd.set(Calendar.HOUR, 23);
		todayEnd.set(Calendar.MINUTE, 59);
		todayEnd.set(Calendar.SECOND, 59);
		todayEnd.set(Calendar.MILLISECOND, 999);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sf.format(todayEnd.getTime());
	}
	
	
	/**
	 * 获得当前周的开始时间
	 * 
	 * @date 2016-11-30 by wukq
	 * @param TimeUtil
	 * @return String
	 * @version 1.0
	 */
	public static String  getWeekStartTime() {
		 Calendar currentDate = new GregorianCalendar();   
		 currentDate.setFirstDayOfWeek(Calendar.MONDAY);  
		           
		 currentDate.set(Calendar.HOUR_OF_DAY, 0);  
		 currentDate.set(Calendar.MINUTE, 0);  
		 currentDate.set(Calendar.SECOND, 0);  
		 currentDate.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);  
		 Date clone = (Date) currentDate.getTime().clone(); 
		 SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 return sf.format(clone.getTime());

		
	}

	/***
	 *获得当前周的结束时间
	 * 
	 * @date 2016-11-30 by wukq
	 * @param TimeUtil
	 * @return String
	 * @version 1.0
	 * */
	public static String getWeekEndTime() {
		Calendar currentDate = new GregorianCalendar();   
		currentDate.setFirstDayOfWeek(Calendar.MONDAY);  
		currentDate.set(Calendar.HOUR_OF_DAY, 23);  
		currentDate.set(Calendar.MINUTE, 59);  
		currentDate.set(Calendar.SECOND, 59);  
		currentDate.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);  
		Date clone = (Date) currentDate.getTime().clone(); 
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sf.format(clone.getTime());

		
	}
	
	
	
}
