package com.daiyun.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kyle.common.util.jlang.NumberUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.operation.housewaybill.dax.PredictOrderRow;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;


/**
 * by wukq �ж��Ƿ���Excel2003����Ecel2007
 * 
 * @author by wukq
 * @date 2016-9-13
 * @version 1.0
 */
public class ExcelUtilEX extends ExcelUtil{
	private InputStream in;

	private List<PredictOrderRow> excel;
	private XSSFWorkbook workbook;
	//private XSSFSheet sheet;
	private Sheet sheet;

	
	public ExcelUtilEX() {
		workbook = new XSSFWorkbook();
		 sheet = workbook.createSheet();//���ص���XSSFSheet,Sheet���Ǹ����
	}
//	public ExcelUtilEX(File uploadFile,File target) throws FileNotFoundException{
//		String path = target.toString();
//		if(ExcelUtilEX.isExcel2003(path)){
//			objExcelUtil = new ExcelUtil(uploadFile);
//		}else if(ExcelUtilEX.isExcel2007(path)){
//			objExcelUtilEX = new ExcelUtilEX(uploadFile);
//		}
//		
//		
//	}

	public ExcelUtilEX(String pathname) throws FileNotFoundException {
		this(new File(pathname));
	}

	public ExcelUtilEX(File file) throws FileNotFoundException {
		this(new FileInputStream(file));
								
	}

	public ExcelUtilEX(InputStream in) {
		this.in = in;
		createWorkbook();
	}

	private void createWorkbook() {
		try {
			workbook = new XSSFWorkbook(in);// ���ﱨ��
			setCurrSheet(0);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * �ж��ļ���ʽ�Ƿ�Ϊxls
	 * 
	 * @param: path
	 * */
	public static boolean isExcel2003(String filePath) {
		return filePath.matches("^.+\\.(?i)(xls)$");
	}

	/**
	 * @date 2016-9-13 by wukq
	 * @param String
	 * @return boolean
	 * @version 1.0
	 */
	public static boolean isExcel2007(String filePath) {
		return filePath.matches("^.+\\.(?i)(xlsx)$");
	}

	/**
	 * ��ȡ������XSSFSheet������
	 * 
	 * **/
	public int getRowCount() {
			if (sheet.getRow(0) == null) {
				return 0;
			}
			return sheet.getLastRowNum() + 1;

	}

	/**
	 * �õ���ǰ���ı�ͷ,XSSFSheet
	 * 
	 * @return
	 */
	public String[] getExcelTitle() {
		
			int columnCount = getColumnCount();
			Row row = sheet.getRow(0);
			String[] excelTitle = new String[columnCount];
			for (int i = 0; i < columnCount; i++) {
				Cell cell = row.getCell(i);
				excelTitle[i] = cell.getStringCellValue();
			}
			return excelTitle;
		
	}

	/**
	 * ��ȡ������sheet��ͬ
	 * 
	 * @return
	 */
	public int getColumnCount() {
			Row row = sheet.getRow(0);
			if (row == null) {
				return 0;
			}
			int num = 0;
			int j = row.getPhysicalNumberOfCells();
			for (int i = 0; i < j; i++) {
				Cell cell = row.getCell(i);
				if (cell != null
						&& !StringUtility.isNull(cell.getRichStringCellValue()
								.getString())) {
					num = num + 1;
				}
			}
			return num;
	
	}

	
	/**
	 * �õ���ǰ�������ݣ������ˣ�map��keyΪ������valueΪ��ֵ�����˹���Ϊand�߼���
	 * @param map
	 * @return
	 */
	public List<PredictOrderRow> getData(){
		excel = new ArrayList<PredictOrderRow>();
		int rowCount = getRowCount();
		int columnCount = getColumnCount();
		String[] excelTitle = getExcelTitle();//xlsx����д
		for (int i = 1; i < rowCount; i++) {
			PredictOrderRow orderRow = new PredictOrderRow();
			Row row =  sheet.getRow(i);//row = null,
			if(row != null){//row ��Ϊ�����ȥ
				for (int j = 0; j < columnCount; j++) {
					Cell cell = row.getCell(j);
					if (cell == null) {
						orderRow.put(excelTitle[j], null);
						continue;
					}
					if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
						String cellValue = String.valueOf(cell.getNumericCellValue());
						if(cellValue.endsWith(".0")){
							cellValue = cellValue.substring(0, cellValue.length() - 2);
						}
						cellValue = NumberUtility.toStandardstring(cellValue);
						orderRow.put(excelTitle[j], cellValue);
					} else {
						orderRow.put(excelTitle[j], cell.getStringCellValue());
					}
					if (ExcelUtil.ROWNUM_TITLENAME.equals(excelTitle[j])) {
						orderRow.setExcelRowIndex(Integer.valueOf(cell.getStringCellValue()));//�����к�
					}
				}
				
				excel.add(orderRow);
				
			}else if(row == null){
				continue;
			}
			
		
		}
		return excel;
			
			
	}


	public void setCurrSheet(int index) {
		sheet = workbook.getSheetAt(index);
	}
	
	public List<PredictOrderRow> getData(Map<String, ExcelFilterRule> map){
		excel = new ArrayList<PredictOrderRow>();
		int rowCount = getRowCount();
		int columnCount = getColumnCount();
		String[] excelTitle = getExcelTitle();
		for (int i = 1; i < rowCount; i++) {
			PredictOrderRow orderRow = new PredictOrderRow();
			Row row = sheet.getRow(i);
			boolean add = true;
			breakLabel : for (int j = 0; j < columnCount; j++) {
				String titleName = excelTitle[j];
				Cell cell = row.getCell(j);
				if (cell == null) {
					orderRow.put(titleName, null);
					continue;
				}
				String cellValue = null;
				if (cell.getCellType() == Cell.CELL_TYPE_NUMERIC) {
					cellValue = String.valueOf(cell.getNumericCellValue());
					if(cellValue.endsWith(".0")){
						cellValue = cellValue.substring(0, cellValue.length() - 2);
					}
					cellValue = NumberUtility.toStandardstring(cellValue);
				} else {
					cellValue = cell.getStringCellValue();
				}
				//�ж��Ƿ����
				if (map.containsKey(titleName) && map.get(titleName) != null) {
					ExcelFilterRule filterRule = map.get(titleName);
					String value = filterRule.getValue();
					Rules rules = filterRule.getRules();
					switch (rules) {
					case Equal:
						if (!value.equals(cellValue.trim())) {
							add = false;
							break breakLabel;
						}
						break;
					case NotEqual:
						if (value.equals(cellValue.trim())) {
							add = false;
							break breakLabel;
						}
						break;
					default:
						break;
					}
				}
				if (ExcelUtil.ROWNUM_TITLENAME.equals(excelTitle[j])) {
					orderRow.setExcelRowIndex(Integer.valueOf(cell.getStringCellValue()));//�����к�
				}
				orderRow.put(titleName, cellValue);
			}
			if (add) {
				excel.add(orderRow);
			}
		}
		return excel;
	}
	
	/**
	 * 20160927,by wukq	
	 * �ж�row�Ƿ��ǿ��У�
	 * row�е�cell����пո���Ϊ��Ϊ��
	 * Ϊ�շ���false������շ���true
	 * @param  
	 * */
	public static boolean isBlankRow(XSSFRow row){
        if(row == null) return true;
        boolean result = true;
        for(int i = row.getFirstCellNum(); i < row.getLastCellNum(); i++){
            XSSFCell cell = row.getCell(i, Row.RETURN_BLANK_AS_NULL);
            String value = "";
            if(cell != null){
                switch (cell.getCellType()) {
                case Cell.CELL_TYPE_STRING:
                    value = cell.getStringCellValue();
                    break;
                case Cell.CELL_TYPE_NUMERIC:
                    value = String.valueOf((int) cell.getNumericCellValue());
                    break;
                case Cell.CELL_TYPE_BOOLEAN:
                    value = String.valueOf(cell.getBooleanCellValue());
                    break;
                case Cell.CELL_TYPE_FORMULA:
                    value = String.valueOf(cell.getCellFormula());
                    break;
                //case Cell.CELL_TYPE_BLANK:
                //    break;,Ϊ��valueΪ"",�ж����е��ж�Ϊ��
                default:
                    break;
                }
                 
                if(!value.trim().equals("")){
                    result = false;
                    //break;
                    continue;
                }
            }
        }
         
        return result;
    }
	
	
	public static boolean isBlankRow2(XSSFRow row,int cellNum){
        if(row == null) return true;
        boolean result = true;
        int index = 0;
        for(int i = 0 ; i < cellNum; i++){
            XSSFCell cell = row.getCell(i, Row.RETURN_BLANK_AS_NULL);
            if(cell == null){
            	index++;		
             }          
        }
        if(cellNum == index){//��������о�Ϊ�գ�resultΪfalse 	
        	result = false;
        }
         return result;
    }
}
