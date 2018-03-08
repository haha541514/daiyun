package com.daiyun.dax;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import kyle.common.util.jlang.StringUtility;

public class AllThreadPool {
	private int maxSize;//总线程池的最大数量
	private int allSize=0;// 总线程池的当前数量
	private Properties prop =null; 
	private static AllThreadPool allThreadPool=new AllThreadPool();
	private AllThreadPool(){}
	//这种单例比较安全
	public static AllThreadPool getInstance(){
		
		return allThreadPool;
	}
	/**
	 * 添加总线程池大小
	 * @param number
	 */
	public void raiseSize(int number){
		allSize +=number;
	}
	
	/**
	 * 减少总线程池大小 
	 * @param number
	 */
	public void decreaseSize(int number){
		if(allSize>number){
			allSize -=number;
			return ;
		}
		allSize=0;
	}
	
	public int getAllSize(){		
		return allSize;
	}
	
	public int getMaxSize(){
		if(!StringUtility.isNull(prop.getProperty("maxSize"))){
			maxSize=Integer.parseInt(prop.getProperty("maxSize"));
		}
		return maxSize;
	}
	
	public Properties getProperties() throws IOException{
		
		if(prop==null){
			InputStream is = AllThreadPool.class.getResourceAsStream("/ThreadPool.properties");
			prop=new Properties();
	        try{    
	            prop.load(is);
	            is.close();
	            return prop;
	        }catch(IOException e) {    
	            e.printStackTrace();  
	            return null;
	        }finally{
	        	if(is!=null){
	        		is.close();
	        	}
	        } 
		}
		return prop;
	}
	
}
