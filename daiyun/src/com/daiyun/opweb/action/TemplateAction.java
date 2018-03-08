package com.daiyun.opweb.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.StringUtility;
import kyle.common.util.web.MessageBean;
import kyle.leis.es.company.predicttemplate.bl.PredictdicMapping;
import kyle.leis.es.company.predicttemplate.bl.Predicttemplate;
import kyle.leis.es.company.predicttemplate.da.ColumnstemplateColumns;
import kyle.leis.es.company.predicttemplate.da.PredictdicmappingColumns;
import kyle.leis.es.company.predicttemplate.da.PredictdicmappingCondition;
import kyle.leis.es.company.predicttemplate.da.PredicttemplateColumns;
import kyle.leis.es.company.predicttemplate.da.PredicttemplateCondition;
import kyle.leis.es.company.predicttemplate.da.PredicttemplatevalueColumns;
import kyle.leis.es.company.predicttemplate.dax.PredicttemplateDemand;
import kyle.leis.es.company.predicttemplate.dax.PreictorderdicmappingDemand;
import kyle.leis.fs.dictionary.dictionarys.da.TdiColumnmappingtypeDC;
import kyle.leis.fs.dictionary.dictionarys.da.TemplatecolumnColumns;
import kyle.leis.hi.TdiColumnmappingtype;
import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.struts2.ServletActionContext;
import com.daiyun.dax.IBasicData;

public class TemplateAction extends ActionSupportEX {
	private static final long serialVersionUID = 1L;
	private File templateFile;
	private String templateFileFileName;
	private PredictdicmappingColumns objPredictdicmappingColumns;

	public PredictdicmappingColumns getObjPredictdicmappingColumns() {
		return objPredictdicmappingColumns;
	}

	public void setObjPredictdicmappingColumns(
			PredictdicmappingColumns objPredictdicmappingColumns) {
		this.objPredictdicmappingColumns = objPredictdicmappingColumns;
	}

	public File getTemplateFile() {
		return templateFile;
	}

	public void setTemplateFile(File templateFile) {
		this.templateFile = templateFile;
	}

	public String getTemplateFileFileName() {
		return templateFileFileName;
	}

	public void setTemplateFileFileName(String templateFileFileName) {
		this.templateFileFileName = templateFileFileName;
	}

	// 上传Excel表
	public String templateExcel() throws Exception {
		 
		PrintWriter out = response.getWriter();
		String directory = "/downFiles/upload";
		String targerDirectory = ServletActionContext.getServletContext()
				.getRealPath(directory);
		System.out.println(targerDirectory);
		System.out.println(templateFileFileName);
		// 生成上传文件的对象
		File target = new File(targerDirectory, templateFileFileName);
		// 如果文件已存在，则删除原有文件
		if (target.exists()) {
			target.delete();
		}
		// 复制file对象，实现上传
		try {
			FileUtils.copyFile(templateFile, target);
			out.print("文件上传成功");
		} catch (IOException e) {
			e.printStackTrace();
		}
		loadRoleInfo(templateFileFileName);

		return SUCCESS;
	}

	/**
	 * 读取客户模板标题行
	 * 
	 * @param uploadFileFileName
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void loadRoleInfo(String uploadFileFileName) throws Exception {
		String directory = "/downFiles/upload";
		String targerDirectory = ServletActionContext.getServletContext()
				.getRealPath(directory);
		// 生成上传文件的对象
		File target = new File(targerDirectory, uploadFileFileName);
		FileInputStream fis = new FileInputStream(target);
		Workbook wb = new HSSFWorkbook(fis);
		Sheet sheet = wb.getSheetAt(0);
		Row firstRow = sheet.getRow(0);
		int cellNum = firstRow.getLastCellNum();
		List POTVList = new ArrayList();
		for (int j = 0; j < cellNum; j++) {
			PredicttemplatevalueColumns objColumns = new PredicttemplatevalueColumns();
			objColumns.setPotvcomp_idpotvid(j + 1);
			objColumns.setPotvpotvcolumnname(firstRow.getCell(j).toString());
			POTVList.add(objColumns);
			// System.out.print(columnsName+"----");
		}
		// 标准模板列表
		List templateList = PredicttemplateDemand.queryTemplate();

		String[] arrIndex = new String[templateList.size()];// 映射列
		String[] arrCmt = new String[templateList.size()];// 映射方式
		request.setAttribute("pathName", templateFileFileName);
		session.setAttribute("excelList", POTVList);
		session.setAttribute("templateList", templateList);
		session.setAttribute("arrIndex", arrIndex);
		session.setAttribute("arrCmt", arrCmt);
	}

	/**
	 * 保存映射
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String saveData() throws Exception {
		List<PredicttemplatevalueColumns> POTVList = (List<PredicttemplatevalueColumns>) session
				.getAttribute("excelList");
		String strFileName = request.getParameter("uploadFile");
		String arrPotvid[] = request.getParameterValues("customerCheck");
		String strTcid = request.getParameter("templateCheck");
		String strCmt = request.getParameter("cmtCode");
		String strDmk = request.getParameter("dmkCode");
		String strCmtName = "";
		if (!StringUtility.isNull(strCmt)) {
			TdiColumnmappingtype objTCMT = TdiColumnmappingtypeDC
					.loadByKey(strCmt);
			strCmtName = objTCMT.getCmtName();
		} else {
			if (arrPotvid.length > 1) {
				strCmt = "AD";
				strCmtName = "追加";
			} else {
				strCmt = "CP";
				strCmtName = "复制";
			}
		}
		String strIndex = arrPotvid[0];
		for (int i = 0; i < arrPotvid.length; i++) {
			if (i >= 1) {
				strIndex = strIndex + "," + arrPotvid[i];
				strCmt = "AD";
				strCmtName = "追加";
			}
			for(int j=0;j<POTVList.size();j++){
				PredicttemplatevalueColumns objColumns = POTVList.get(j);
				if(objColumns.getPotvcomp_idpotvid().equals(arrPotvid[i])){
					objColumns.setTctcid(strTcid);// 标准列模板ID
					objColumns.setCmtcmtcode(strCmt);// 映射方式
					objColumns.setDmkdmkcode(strDmk);
					// tesList.add(objColumns);
				}
			}						
		}

		List<TemplatecolumnColumns> templateList = (List<TemplatecolumnColumns>) session
				.getAttribute("templateList");
		String[] arrIndex = (String[]) session.getAttribute("arrIndex");// 映射列
		String[] arrCmt = (String[]) session.getAttribute("arrCmt");// 映射方式

		for (int m = 0; m < templateList.size(); m++) {
			TemplatecolumnColumns objColumns = templateList.get(m);
			if (objColumns.getTctcid().equals(strTcid)) {
				if (StringUtility.isNull(arrIndex[Integer.parseInt(strTcid)-1])) {
					arrIndex[Integer.parseInt(strTcid)-1] = strIndex;
				} else {
					arrIndex[Integer.parseInt(strTcid)-1] = arrIndex[Integer.parseInt(strTcid)-1] + "," + strIndex;
					strCmtName = "追加";
				}
				arrCmt[Integer.parseInt(strTcid)-1] = strCmtName;
			}
		}
		request.setAttribute("pathName", strFileName);
		session.setAttribute("POTVList", POTVList);
		session.setAttribute("arrIndex", arrIndex);
		session.setAttribute("arrCmt", arrCmt);
		// session.setAttribute("templateList",templateList);
		return SUCCESS;
	}

	/**
	 * 撤销映射
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String removeData() throws Exception {
		String[] strTcid = request.getParameterValues("templateCheck");
		String strFileName = request.getParameter("uploadFile");
		List<TemplatecolumnColumns> templateList = (List<TemplatecolumnColumns>) session
				.getAttribute("templateList");
		List<PredicttemplatevalueColumns> tesList = (List<PredicttemplatevalueColumns>) session
				.getAttribute("POTVList");
		String[] arrIndex = (String[]) session.getAttribute("arrIndex");
		String[] arrCmt = (String[]) session.getAttribute("arrCmt");// 映射方式
		for (int n = 0; n < strTcid.length; n++) {
			String strIndex = "";
			for (int m = 0; m < templateList.size(); m++) {
				TemplatecolumnColumns objColumns = templateList.get(m);
				if (objColumns.getTctcid().equals(strTcid[n])) {
					int index=Integer.parseInt(strTcid[n])-1;
					strIndex = arrIndex[index];
					arrIndex[index] = "";
					arrCmt[index] = "";
				}
			}
			if (!StringUtility.isNull(strIndex)) {
				String arrPotvid[] = strIndex.split(",");
				for (int i = 0; i < arrPotvid.length; i++) {
					for(int j=0;j<tesList.size();j++){
						PredicttemplatevalueColumns objColumns = tesList
						.get(j);
						if(objColumns.getPotvcomp_idpotvid().equals(arrPotvid[i])){
							objColumns.setTctcid("");
							objColumns.setCmtcmtcode("");
							objColumns.setDmkdmkcode("");
						}
					}					
				}
			}
		}

		request.setAttribute("pathName", strFileName);
		session.setAttribute("POTVList", tesList);
		session.setAttribute("arrIndex", arrIndex);
		session.setAttribute("arrCmt", arrCmt);
		// session.setAttribute("templateList",templateList);
		return SUCCESS;
	}

	/**
	 * 保存映射模板
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String save() throws Exception {
		PredicttemplateColumns objColumns = new PredicttemplateColumns();
		String strCocode = (String) session.getAttribute("Cocode");
		String strOpid = (String) session.getAttribute("OpId");
		String strName = request.getParameter("uploadFile");
		String strPotid = request.getParameter("potId");
		objColumns.setCopopid(Long.parseLong(strCocode));
		objColumns.setCopopid(Long.parseLong(strOpid));
		objColumns.setMopopid(Long.parseLong(strOpid));
		objColumns.setPotpotname(strName);
		objColumns.setCococode(strCocode);
		if (!StringUtility.isNull(strPotid)) {
			objColumns.setPotpotid(Long.parseLong(strPotid));
		}
		List<PredicttemplatevalueColumns> objPOTVList = (List<PredicttemplatevalueColumns>) session
				.getAttribute("excelList");
		Predicttemplate objTemplate = new Predicttemplate();
		objTemplate.save(objColumns, objPOTVList);
		return SUCCESS;
	}

	/**
	 * 修改映射模板
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String updateTemplate() throws Exception {
		String strPotid = request.getParameter("potId");
		String strCocode = request.getParameter("cocode");
		List templateList = PredicttemplateDemand.queryTemplate();// 标准模板
		List predictList = null;// 客户模板
		
		if(!StringUtility.isNull(strCocode)) {
			String strName ="";
		//if(strPotid.equals("1")){
			//如果要修改的是标准模板，那么客户模板为标准模板
			//System.out.println("*********");
			//predictList=PredicttemplateDemand.queryTemplate();
		//}else{
			PredicttemplateCondition objPTC = new PredicttemplateCondition();
			objPTC.setPotid(strPotid);
			List objList = PredicttemplateDemand.query(objPTC);// 查询修改模板名称
			PredicttemplateColumns templeColumns = (PredicttemplateColumns) objList
					.get(0);
			strName = templeColumns.getPotpotname();
			predictList=PredicttemplateDemand.queryTemplatevalue(strPotid,true);
			String[] arrIndex = new String[100];// 映射列
			String[] arrCmt = new String[100];// 映射方式
			
			List columnsList = PredicttemplateDemand.queryColumnsTemplate(strPotid);// 标准模板映射客户模板项
			
			
			for (int i = 0; i < columnsList.size(); i++) {
				ColumnstemplateColumns objColumns = (ColumnstemplateColumns) columnsList
						.get(i);
				String strIndex = objColumns.getPpotv_id();
				String strCmt = objColumns.getCcmt_name();

				int n = Integer.parseInt(objColumns.getTtc_id());
				if (!StringUtility.isNull(arrIndex[n - 1])) {
					arrIndex[n - 1] = arrIndex[n - 1] + "," + strIndex;
					strCmt = "追加";
				} else {
					arrIndex[n - 1] = strIndex;
					arrCmt[n - 1] = strCmt;
				}
			}
			request.setAttribute("pathName", strName);
			session.setAttribute("POTVList", predictList);
			session.setAttribute("excelList", predictList);
			session.setAttribute("strCocode", strCocode);
			session.setAttribute("templateList", templateList);
			session.setAttribute("arrIndex", arrIndex);
			session.setAttribute("arrCmt", arrCmt);
			}else{
				predictList = PredicttemplateDemand.queryTemplatevalue(strPotid,true);
				session.setAttribute("POTVList", predictList);
				session.setAttribute("excelList", predictList);
				session.setAttribute("strCocode", strCocode);
				session.setAttribute("templateList", templateList);
			}
		//}
		
		return SUCCESS;
	}
	/*
	 * 保存映射国家
	 */
	public String saveCountry() throws Exception {					
		new PredictdicMapping().save(objPredictdicmappingColumns);			
		return SUCCESS;
	}
	/*
	 * 国家列表
	 */
	@SuppressWarnings("unchecked")
	public String listCountry() throws Exception{
		String potid = request.getParameter("potid");
		String originvalue = request.getParameter("originvalue");
		//String standardvalue = request.getParameter("standardvalue");
		
		//分页参数
		int pageCount=0;
		if(StringUtility.isNull(request.getParameter("customInputCount")) ||
				"".equals(request.getParameter("customInputCount"))){
			pageCount=9;
		}else{
			pageCount=Integer.parseInt(request.getParameter("customInputCount"));
		}
		
		List <PredictdicmappingColumns> listCountry = new ArrayList<PredictdicmappingColumns>();
		
		PredictdicmappingCondition objPredictdicmappingCondition = new PredictdicmappingCondition();
		objPredictdicmappingCondition.setPotid(potid);
		objPredictdicmappingCondition.setPodmoriginvalue(originvalue);
		m_objPageConfig.setMaxPageResultCount(pageCount);
		objPredictdicmappingCondition.setPageConfig(m_objPageConfig);
		listCountry = PreictorderdicmappingDemand.queryListCountry(objPredictdicmappingCondition);
		request.setAttribute("listCountry", listCountry);
		return SUCCESS;
	}
	/*
	 * 修改国家
	 */
	public String modifyCountry() throws Exception{
		String podmid = request.getParameterValues("checkbox")[0];
		objPredictdicmappingColumns.setPodmpodmid(Long.parseLong(podmid));
		new PredictdicMapping().save(objPredictdicmappingColumns);	
		return SUCCESS;
	}
	/*
	 * 删除国家
	 */
	public String deleteCountry() throws Exception{
		String []s = request.getParameterValues("checkbox");
		boolean flag = false;
		if (!("".equals(s) || s == null)) {
			for (int i = 0; i < s.length; i++) {
				System.out.println(s[i]);
				flag = PredictdicMapping.deleteCountry(s[i]);
			}
		}
		if (!flag) {
			session.setAttribute("MESSAGEBEAN",new MessageBean(IBasicData.MSG_TYPE_ERROR,
					"删除国家出错","抱歉，删除国家失败！"));
			return ERROR;
		} else {
			return SUCCESS;
		}
		
	}
}
