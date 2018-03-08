package com.daiyun.util.pdf;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kyle.common.explorer.HttpExplorer;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictColumns;

public class BarcodeUtil {

	/**����������*/
	public static List<BufferedImage> createBarcode(HttpServletRequest req,WaybillforpredictColumns wayBills,
			String servletName) throws Exception {
		HttpExplorer explorer = new HttpExplorer();
		String url = req.getRequestURL().toString();
			 //url = url.substring(0, url.indexOf("PrintPDFLableServlet2.sv"));
		url = url.substring(0, url.indexOf(servletName));
		String requestUrl1 = null;
		String requestUrl2 = null;
		BufferedImage image = null;
		BufferedImage image2 = null;
		List<BufferedImage> list = new ArrayList<BufferedImage>();
		String selflablecode=wayBills.getChnchn_customerlabel();
		String serverewbcode=wayBills.getCwcw_serverewbcode();
		String customerewbcode=wayBills.getCwcw_customerewbcode();
		String ewbcode=wayBills.getCwcw_ewbcode();
        //�жϱ�ǩ�������ɶ�Ӧ��������
		if(!StringUtility.isNull(selflablecode) && "C_SWGH".equals(selflablecode)){ 	
			requestUrl1 = url + "barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg="+ewbcode+"&height=5";
			//��ʿ����request.contextPath
		} else if(!StringUtility.isNull(selflablecode) &&("C_SWISS".equals(selflablecode) || "C_ORSWISS".equals(selflablecode))){
			//������
			requestUrl1 =url+ "barcode.br?hrsize=0mm&type=code39&ewbcode_type=&msg="+serverewbcode+"&height=5";
			//С����
			requestUrl2 =url+"barcode.br?hrsize=0mm&type=code39&ewbcode_type=&msg="+customerewbcode+"&height=5";   
			image2 = explorer.getResponseImageByGetMethod(requestUrl2, null); 
			//�������+�¹�+������͵¹�����+UDF�¹�+UDF�¹����⣩ƽ��
		}else if(!StringUtility.isNull(selflablecode) &&
				("C_PL".equals(selflablecode)||
						"C_PG".equals(selflablecode)||
						"C_PO".equals(selflablecode)||
						"C_UDFDEP".equals(selflablecode)||
						"C_UDFORP".equals(selflablecode))){
			requestUrl1 =url +"barcode.br?hrsize=0mm&&ori=90&type=code128&ewbcode_type=&msg="+serverewbcode+"&height=5";	
		} else if ("C_DGMP".equals(selflablecode)){
			requestUrl1 =url +"barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg="+customerewbcode+"&height=5";		
		}else if ("C_DGMG".equals(selflablecode)){
			requestUrl1 =url +"barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg="+serverewbcode+"&height=5";	
			requestUrl2 =url +"barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg="+customerewbcode+"&height=5";
			image2 = explorer.getResponseImageByGetMethod(requestUrl2, null);
		} else if(!StringUtility.isNull(selflablecode) && "C_OTS".equals(selflablecode)){
			requestUrl1 =url +"barcode.br?hrsize=0mm&ewbcode_type=BQ&msg="+ewbcode+"&height=5";	
		}else{
			requestUrl1 =url +"barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg="+serverewbcode+"&height=5";
		}
		if("C_SZPG".equals(selflablecode) || "C_SZPE".equals(selflablecode)){
			requestUrl2 = url+"barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg="+customerewbcode+"&height=5";
			image2 = explorer.getResponseImageByGetMethod(requestUrl2, null);
		}
		if("C_SZEUB".equals(selflablecode) || "C_JNEUB".equals(selflablecode)){
			requestUrl2 = url+"barcode.br?hrsize=0mm&type=code128&ewbcode_type=&msg="+customerewbcode+"&height=5";
			image2 = explorer.getResponseImageByGetMethod(requestUrl2, null);
		}
		
		try {
			image = explorer.getResponseImageByGetMethod(requestUrl1, null); 
		/*	//����ԭͼ�ϴ�����ת��ͼƬ��С�����������pdf�ļ���С
			Image scaledImage = image.getScaledInstance(600, 400,Image.SCALE_DEFAULT);
			BufferedImage outputImage = new BufferedImage(600, 400,BufferedImage.TYPE_INT_BGR);
			outputImage.createGraphics().drawImage(scaledImage, 0, 0, null);
			list.add(outputImage);
			
			if(image2!=null){
				Image scaledImage2 = image2.getScaledInstance(600, 400,Image.SCALE_DEFAULT);
				BufferedImage outputImage2 = new BufferedImage(600, 400,BufferedImage.TYPE_INT_BGR);
				outputImage2.createGraphics().drawImage(scaledImage2, 0, 0, null);
				list.add(outputImage2);
			}
			else{
				list.add(image2);
			}*/
			
			list.add(image);
			list.add(image2);
			return list;
		} catch (Exception ex) {
			ex.printStackTrace();
			System.out.println("print error!!!"  + requestUrl1);
			if (image != null)
				image.flush();
			if (image2 != null)
				image2.flush();
		}
		
		
		return list;
	}

}
