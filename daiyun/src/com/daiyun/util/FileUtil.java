package com.daiyun.util;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

public class FileUtil {
	/*
	 * �����ļ��ϴ�
	 */
	public static void UploadFile(String fileName, String path,File file) {
		String targerDirectory = ServletActionContext.getServletContext()
				.getRealPath(path);
		System.out.println(targerDirectory);
		// �����ϴ��ļ��Ķ���
		File target = new File(targerDirectory, fileName);
		// ����file����ʵ���ϴ�
		try {
			FileUtils.copyFile(file, target);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/*
	 * �ж��ļ��Ƿ����
	 */
	public static String fileEX(String path,String fileName){
		String targerDirectory = ServletActionContext.getServletContext()
		.getRealPath(path);
        String filepath=targerDirectory+"/"+fileName;
        File file=new File(filepath);
        System.out.println(filepath);
        String EX="";
        if(file.exists())
        	EX="yes";
       else
    	   EX="no";
		return EX;
	}
}
