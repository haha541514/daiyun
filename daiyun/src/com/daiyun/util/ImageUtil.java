package com.daiyun.util;

import java.awt.Image;
import java.io.File;

import javax.imageio.ImageIO;

public class ImageUtil {
	/** 
	    * 通过读取文件并获取其width及height的方式，来判断判断当前文件是否图片，这是一种非常简单的方式。 
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
