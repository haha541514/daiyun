package com.daiyun.opweb.action;

import java.io.BufferedInputStream;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.struts2.ServletActionContext;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.customerservice.issue.bl.Issue;
import kyle.leis.eo.customerservice.issue.da.IssueColumns;
import kyle.leis.eo.customerservice.issue.da.IssueCondition;
import kyle.leis.eo.customerservice.issue.da.IssueactionColumns;
import kyle.leis.eo.customerservice.issue.dax.IssueDemand;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictColumns;

import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;
import com.daiyun.util.FileUtil;
import com.daiyun.util.ImageUtil;

public class IssueAction extends ActionSupportEX{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private File uploadFile;
	private String uploadFileFileName;
	private File uploadFileTwo;
	private String uploadFileTwoFileName;
	private File uploadFileThree;
	private String uploadFileThreeFileName;
	
	public File getUploadFileTwo() {
		return uploadFileTwo;
	}

	public void setUploadFileTwo(File uploadFileTwo) {
		this.uploadFileTwo = uploadFileTwo;
	}

	public String getUploadFileTwoFileName() {
		return uploadFileTwoFileName;
	}

	public void setUploadFileTwoFileName(String uploadFileTwoFileName) {
		this.uploadFileTwoFileName = uploadFileTwoFileName;
	}

	public File getUploadFileThree() {
		return uploadFileThree;
	}

	public void setUploadFileThree(File uploadFileThree) {
		this.uploadFileThree = uploadFileThree;
	}

	public String getUploadFileThreeFileName() {
		return uploadFileThreeFileName;
	}

	public void setUploadFileThreeFileName(String uploadFileThreeFileName) {
		this.uploadFileThreeFileName = uploadFileThreeFileName;
	}
 
	public File getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(File uploadFile) {
		this.uploadFile = uploadFile;
	}

	public String getUploadFileFileName() {
		return uploadFileFileName;
	}

	public void setUploadFileFileName(String uploadFileFileName) {
		this.uploadFileFileName = uploadFileFileName;
	}
	/*
	 * ��ѯ�����
	 */
	@SuppressWarnings("unchecked")
	public String queryIssueByParams() {
		List<IssueColumns> listIssueColumns = new ArrayList<IssueColumns>();
		IssueCondition objIssueCondition = new IssueCondition();				
		
		objIssueCondition.setCocode((String) session.getAttribute("Cocode"));
		
		objIssueCondition.setIsuscode("AS,DL");// ��ѯָ�ɺʹ���
		//��ҳ����
		int pageCount=0;
		if(StringUtility.isNull(request.getParameter("customInputCount")) || "".equals(request.getParameter("customInputCount"))){
			pageCount=8;
		}else{
			pageCount=Integer.parseInt(request.getParameter("customInputCount"));
		}
		request.setAttribute("pageCount", pageCount);
		//String pageFlag = request.getParameter("pageFlag");
		String strStartdate = request.getParameter("startdate");
		String strEnddate = request.getParameter("enddate");
		
		String strCustomerewbcode = request.getParameter("customerewbcode");
		String ctcode = request.getParameter("ctcode");
		String isutcode = request.getParameter("isutcode");
		if(!StringUtility.isNull(ctcode)){
			objIssueCondition.setCtcode(ctcode);
		}
		if(!StringUtility.isNull(isutcode)){
			objIssueCondition.setIsutcode(isutcode);
		}
		if(!StringUtility.isNull(strCustomerewbcode));
		{
			objIssueCondition.setCwcustomerewbcode(strCustomerewbcode);
		}

		 
		//�Ƿ����ѯδ�ظ������
		String allNoReplay=request.getParameter("noReplay");
		if(!StringUtility.isNull(allNoReplay)){
			if(allNoReplay.equals("Y")){
				objIssueCondition.setTiaequalsign("Y");
				request.setAttribute("allNoReplay", "Y");
			}
		}
		
		//�ۼ�״̬
		String ihscode=request.getParameter("ihscode");
		if(ihscode=="temp"){
			objIssueCondition.setIhscode("RH");
		}
		objIssueCondition.setIhscode(ihscode);
		request.setAttribute("ihscode", ihscode);
		//����Ƿ�ѵ����
		objIssueCondition.setIsutcode("");
		 /**
        * �޸ģ������������ѡ��"����"���򴫹�����Ϊ"A",�����ݿ���ֻ��AWPX,ADOX��������,дһ���ж��������ΪA���丳ֵ
        * �գ���ѯʱ������������ѯ����,����ģʽ����ĵط���ͬ
        */
//		if(strPmcode.equals("A")){
//			strPmcode="";
//		}
       /**
        * ������ѯʱû�г�������Ϊ���в�Ʒ���Ǹ������ǲ�ѯ������һ����Ϊ�գ��������������Ϊ���ˣ��ǵĸ�ֵ�����û��ִ�У�Ĭ�ϸ���
        * ��ֵΪnull�����ڷ�ҳ��������������ֵ��ֵΪnull�Ļ����丳ֵΪ��1�������������˵Ļ���ʼ����ʱ�ᱨnull�Ĵ�������Ҫ�ж�
        */
//		if(pageFlag==null||pageFlag.equals("")){
//			pageFlag="1";
//		}
		//��ҳ
		 
		m_objPageConfig.setMaxPageResultCount(pageCount);
		objIssueCondition.setStartmodifydate(strStartdate);
		objIssueCondition.setEndmodifydate(strEnddate);
		
		objIssueCondition.setPageConfig(m_objPageConfig);		
		request.setAttribute("startdate", strStartdate);
		request.setAttribute("enddate", strEnddate);

		try {
			listIssueColumns = IssueDemand.query(objIssueCondition);
			 
			if (listIssueColumns != null) {
				request.setAttribute("listIssueColumns", listIssueColumns);
				//IssueactionQuery
				return SUCCESS;
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("MESSAGEBEAN",new MessageBean(IBasicData.MSG_TYPE_ERROR, "��ѯ�����쳣","��ѯ�����쳣����˶Բ�ѯ��������ϵ����Ա��"));
			return ERROR;
		}
		request.getSession().setAttribute
		("MESSAGEBEAN",new MessageBean(IBasicData.MSG_TYPE_ERROR, "��ѯ����","��Ǹ��û�в�ѯ����ؽ����"));
		return ERROR;
	}
	
	/*
	 * ��Ҫ���ӻظ������������Ϣ�������ϻظ�ҳ��
	 */
	public String queryIssueById(){
		String issuid=request.getParameter("isuid");
		
		IssueColumns issueColumns=null;
		try {
			issueColumns = IssueDemand.loadIssueById(issuid);
		} catch (Exception e) {
			 
			e.printStackTrace();
		}
		
		request.setAttribute("issueColumns", issueColumns);
		return SUCCESS;
	}
	/*
	 * ���ϻظ�
	 */
	public String customerReplay() throws Exception{   
		
		String strIsuid=request.getParameter("isuid");
		String strIsacontent=request.getParameter("isacontent");
		String strIsacontent1=null;
		String strIsacontent2=null;
		String strIsacontent3=null;
		
		IssueColumns objIssueColumns=IssueDemand.loadIssueById(strIsuid);
		try {
			if(!StringUtility.isNull(uploadFileFileName)){
				if(ImageUtil.isImage(uploadFile)){  //�ж��Ƿ�ΪͼƬ
					strIsacontent1=uploadFileFileName;
					FileUtil.UploadFile(strIsacontent1,"/download", uploadFile);
				}
			}
			if(!StringUtility.isNull(uploadFileTwoFileName)){
				if(ImageUtil.isImage(uploadFileTwo)){  
				    strIsacontent2=uploadFileTwoFileName;
				    FileUtil.UploadFile(strIsacontent2,"/download", uploadFileTwo);
				}
			}
			if(!StringUtility.isNull(uploadFileThreeFileName)){
				if(ImageUtil.isImage(uploadFileThree)){   
					    strIsacontent3=uploadFileThreeFileName;
					    FileUtil.UploadFile(strIsacontent3,"/download", uploadFileThree);
				}
			}
		} catch (Exception e) {
			session.setAttribute("MESSAGEBEAN",new MessageBean(IBasicData.MSG_TYPE_ERROR, "���ӳ����쳣","�����ļ���ʽ�Ƿ�ΪͼƬ��ʽ��"));
			return ERROR;
		}  
 
		String strOperId=session.getAttribute("OpId").toString();
		Issue issue=new Issue();
		String sign="N";
		try {
			if(!StringUtility.isNull(strIsacontent)){
				issue.addIssueAction("CWR", strIsuid, strIsacontent, strOperId);
			}
			if(!StringUtility.isNull(uploadFileFileName)){
				issue.addIssueAction("AU", strIsuid, strIsacontent1, strOperId);
			}
			if(!StringUtility.isNull(uploadFileTwoFileName)){
				issue.addIssueAction("AU", strIsuid, strIsacontent2, strOperId);
			}
			if(!StringUtility.isNull(uploadFileThreeFileName)){
				issue.addIssueAction("AU", strIsuid, strIsacontent3, strOperId);	
			}
			issue.modifyIsuCustomerreplysign(strIsuid,sign);
		} catch (Exception e) {			
			e.printStackTrace();
			session.setAttribute("MESSAGEBEAN",new MessageBean(IBasicData.MSG_TYPE_ERROR, "��������쳣","����ϵͳ��"));
			return ERROR;
		}
		session.setAttribute("isuid",strIsuid);
		request.setAttribute("issueColumns", objIssueColumns);
		return SUCCESS;
	}
	/*
	 * �жϸ����Ƿ����
	 */
	public void FileIsEx() throws Exception{
		String fileName=request.getParameter("fileName");
		String EX=FileUtil.fileEX(request.getParameter("path"), fileName);
		PrintWriter out=null;
		try{
			out=response.getWriter();
			out.print(EX);
		}catch(IOException e){
			e.printStackTrace();
		}finally{
			if(out!=null){
				out.close();
			}
		}
		
	}
	/*
	 * ���ظ���
	 *
	 */
	public void downloadFile() throws IOException{
		String fileName=new String(request.getParameter("fileName").getBytes("ISO8859-1"),"utf-8");
		String path=request.getParameter("path");
		String targerDirectory = ServletActionContext.getServletContext()
		.getRealPath(path);
		
		  File file = new File(targerDirectory+"/"+fileName);
		  if(!file.exists()){
				return;
		  }
		  OutputStream os =null;
		  InputStream fis=null;
		  try{
		    fis = new BufferedInputStream(new FileInputStream(targerDirectory+"/"+fileName));
		    byte[] buffer = new byte[fis.available()];
		    fis.read(buffer);
		    response.reset();
		    response.setContentType("application/octet-stream");
		    response.addHeader("Content-Disposition", "attachment;filename=" + new String(fileName.replaceAll(" ", "").getBytes("utf-8"),"iso8859-1"));
		    response.addHeader("Content-Length", "" + file.length());
		    os = new BufferedOutputStream(response.getOutputStream());
		    os.write(buffer);
		    os.flush();
		    }catch(IOException e){
				e.printStackTrace();
			}finally{
				if(fis!=null)
				 fis.close();
				response.getOutputStream().close();
				if(os!=null)
				  os.close();
				
			}
		//return SUCCESS; 
	}
	/*
	 * �鿴������ظ�
	 */
	@SuppressWarnings("unchecked")
	public String queryIssueAllReplay() throws Exception{
		String strIsuid=request.getParameter("isuid");
		if(StringUtility.isNull(strIsuid)){
			strIsuid=session.getAttribute("isuid").toString();
		}
		List isaContentlist=IssueDemand.loadIssueaction(strIsuid, "CWR,AU,BWR,FWR");
	 
		request.setAttribute("isacontentlist", isaContentlist);
		request.setAttribute("issueColumns", IssueDemand.loadIssueById(strIsuid));	
		return SUCCESS;
	}
	/**
	 * ���������
	 * @throws Exception 
	 * */
	@SuppressWarnings("unchecked")
	public void exportIssue() throws Exception{
		String strAkcode = request.getParameter("strAkcode");
		String strisucode= request.getParameter("isucode");
		List<IssueColumns> listIssueColumns = new ArrayList<IssueColumns>();
		IssueCondition objIssueCondition = new IssueCondition();
		String isucode[] = strisucode.split(",");
		for(int index = 0 ; index < isucode.length ;index ++ ){
			objIssueCondition.setIsuid(isucode[index]);
			IssueColumns listIssueColumn = (IssueColumns) IssueDemand.query(objIssueCondition).get(0);;//�����ѯû��content
			listIssueColumns.add(listIssueColumn);
		}
	
		//String strCocode = (String) session.getAttribute("Cocode");
		String xlsName =  DateFormatUtility.getFileNameSysdate() + "_issue.xls";
		String outputFile = request.getRealPath("/export_excel/" + xlsName);
		// ����һ��excel������
		HSSFWorkbook workbook = new HSSFWorkbook();
		// excel�������½�һ�¹�����
		HSSFSheet sheet = workbook.createSheet("Sheet1");
		
		// �����п�ȣ�7��
		sheet.setColumnWidth(0, 4500);
		sheet.setColumnWidth(1, 4500);
		sheet.setColumnWidth(2, 3000);
		sheet.setColumnWidth(3, 4500);
		sheet.setColumnWidth(4, 8000);
		sheet.setColumnWidth(5, 6000);
		sheet.setColumnWidth(6, 6000);

		// ��������
		HSSFFont font = workbook.createFont();
		font.setFontName("Verdana");
		font.setBoldweight((short) 100);
		font.setFontHeight((short) 300);
		font.setColor(HSSFColor.BLUE.index);
		// ���õ�Ԫ���ʽ
		HSSFCellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
		// ���ñ߿�
		cellStyle.setBottomBorderColor(HSSFColor.RED.index);
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		// ��������
		cellStyle.setFont(font);
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);
		cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		// ������0λ�ô�����(��һ��)
		HSSFRow row = sheet.createRow((short) 0);
		HSSFCell cell1 = row.createCell((short) 0);
		HSSFCell cell2 = row.createCell((short) 1);
		HSSFCell cell3 = row.createCell((short) 2);
		HSSFCell cell4 = row.createCell((short) 3);
		HSSFCell cell5 = row.createCell((short) 4);
		HSSFCell cell6 = row.createCell((short) 5);
		HSSFCell cell7 = row.createCell((short) 6);


		cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell3.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell4.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell5.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell6.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell7.setCellType(HSSFCell.CELL_TYPE_STRING);
		

		cell1.setCellType(HSSFCell.ENCODING_UTF_16);
		cell2.setCellType(HSSFCell.ENCODING_UTF_16);
		cell3.setCellType(HSSFCell.ENCODING_UTF_16);
		cell4.setCellType(HSSFCell.ENCODING_UTF_16);
		cell5.setCellType(HSSFCell.ENCODING_UTF_16);
		cell6.setCellType(HSSFCell.ENCODING_UTF_16);
		cell7.setCellType(HSSFCell.ENCODING_UTF_16);
	

		cell1.setCellValue("������");
		cell2.setCellValue("�ۼ�״̬");
		cell3.setCellValue("�������");
		cell4.setCellValue("��������");
		cell5.setCellValue("����ʱ��");
		cell6.setCellValue("�ظ����");
		cell7.setCellValue("�ظ�����");
	

		Iterator iter = listIssueColumns.iterator();
		int temp = 0;
		while (iter.hasNext()) {
			++temp;
			row = sheet.createRow((short) temp);
			HSSFCell cell15 = row.createCell((short) 0);
			HSSFCell cell16 = row.createCell((short) 1);
			HSSFCell cell17 = row.createCell((short) 2);
			HSSFCell cell18 = row.createCell((short) 3);
			HSSFCell cell19 = row.createCell((short) 4);
			HSSFCell cell20 = row.createCell((short) 5);
			HSSFCell cell21 = row.createCell((short) 6);


			IssueColumns IssueColumns = (IssueColumns) iter.next();
			cell15.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell15.setCellType(HSSFCell.ENCODING_UTF_16);
			cell15.setCellValue(IssueColumns.getCwcwcustomerewbcode());
			cell16.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell16.setCellType(HSSFCell.ENCODING_UTF_16);
			cell16.setCellValue(IssueColumns.getIhsihsname());
			cell17.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell17.setCellType(HSSFCell.ENCODING_UTF_16);
			cell17.setCellValue(IssueColumns.getIsutisutname());
			cell18.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell18.setCellType(HSSFCell.ENCODING_UTF_16);
			cell18.setCellValue(IssueColumns.getIsuiscontent());
			cell19.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell19.setCellType(HSSFCell.ENCODING_UTF_16);
			cell19.setCellValue(IssueColumns.getIsuisucreatedate());
			
			cell20.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
			cell20.setCellType(HSSFCell.ENCODING_UTF_16);
			String content ="";
			try {
				content = com.daiyun.dax.IuessDemand.queryIsacontent(IssueColumns.getIsuisuid(), strAkcode);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(content == ""){
				cell20.setCellValue("δ�ظ�");
			}else{
				cell20.setCellValue("�ѻظ�");
			}
			
			cell21.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
			cell21.setCellType(HSSFCell.ENCODING_UTF_16);
			cell21.setCellValue(content);


			
									
		}
		File path = new File(outputFile);
		path.delete();
		FileOutputStream fout = new FileOutputStream(outputFile);
		workbook.write(fout);
		fout.flush();
		fout.close();
		response.getWriter().print(xlsName);
		
		//return SUCCESS;
	}
	
	
	
	
	
	
	
	
}
