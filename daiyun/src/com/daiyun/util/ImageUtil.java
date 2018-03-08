package com.daiyun.util;

import java.awt.Image;
import java.io.File;

import javax.imageio.ImageIO;

public class ImageUtil {
	/** 
	    * ͨ����ȡ�ļ�����ȡ��width��height�ķ�ʽ�����ж��жϵ�ǰ�ļ��Ƿ�ͼƬ������һ�ַǳ��򵥵ķ�ʽ�� 
	    *  
	    * @param imageFile 
	    * @return 
	    */  
	   public static boolean isImage(File imageFile) {  
	       if (!imageFile.exists()) {  
	           return false;  
	       }  
	       Image img = null;  
	       try {  
	           img = ImageIO.read(imageFile);  
	           if (img == null || img.getWidth(null) <= 0 || img.getHeight(null) <= 0) {  
	               return false;  
	           }  
	           return true;  
	       } catch (Exception e) {  
	           return false;  
	       } finally {  
	           img = null;  
	       }  
	   }
}
