package com.daiyun.dax;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import kyle.common.util.jlang.StringUtility;

public class AllThreadPool {
	private int maxSize;//���̳߳ص��������
	private int allSize=0;// ���̳߳صĵ�ǰ����
	private Properties prop =null; 
	private static AllThreadPool allThreadPool=new AllThreadPool();
	private AllThreadPool(){}
	//���ֵ����Ƚϰ�ȫ
	public static AllThreadPool getInstance(){
		
		return allThreadPool;
	}
	/**
	 * ������̳߳ش�С
	 * @param number
	 */
	public void raiseSize(int number){
		allSize +=number;
	}
	
	/**
	 * �������̳߳ش�С 
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
