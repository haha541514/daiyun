package com.daiyun.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kyle.common.util.jlang.NumberUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.operation.housewaybill.dax.PredictOrderRow;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

public class ExcelUtil {
	private InputStream in;
	private OutputStream out;
	private List<PredictOrderRow> excel;
	private Workbook workbook;
	private Sheet sheet;
	/**
	 * �����������й���
	 */
	public static final String ROWNUM_TITLENAME = "XSϵͳ�к�";
	
	public enum CellType{String_Type, Number_Type, Boolean_Type, Blank_Type;}
	public enum Rules{Equal, NotEqual;}
	
	public ExcelUtil(){
		workbook = new HSSFWorkbook();
		sheet = workbook.createSheet();
	}
	
	public ExcelUtil(String pathname) throws FileNotFoundException{
		this(new File(pathname));
	}
	
	public ExcelUtil(File file) throws FileNotFoundException{
		this(new FileInputStream(file));
	}
	
	public ExcelUtil(InputStream in){
		this.in = in;
		createWorkbook();
	}
	private void createWorkbook(){
		try {
			workbook = new HSSFWorkbook(in);
			setCurrSheet(0);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * ���õ�ǰ���
	 * @param index
	 */
	public void setCurrSheet(int index) {
		sheet = workbook.getSheetAt(index);
	}

	/**
	 * �õ���ǰ���ı�ͷ
	 * @return
	 */
	public String[] getExcelTitle(){
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
	 * ��ȡ����
	 * @return
	 */
	public int getRowCount() {
		if (sheet.getRow(0) == null) {
			return 0;
		}
		return sheet.getLastRowNum() + 1;
	}
	/**
	 * ��ȡ����
	 * @return
	 */
	public int getColumnCount() {
//		Row row = sheet.getRow(0);
//		if (row == null) {
//			return 0;
//		}
//		return row.getPhysicalNumberOfCells();
		Row row = sheet.getRow(0);
		if (row == null) {
			return 0;
		}
		int num = 0;
		int j = row.getPhysicalNumberOfCells();
		for(int i = 0;i<j;i++){
			Cell cell= row.getCell(i);
			if(cell != null && !StringUtility.isNull(cell.getRichStringCellValue().getString())){
				num=num+1;
			}
		}
		return num;
	}
	
	/**
	 * �õ���ǰ��������
	 * @return
	 */
	public List<PredictOrderRow> getData(){
		excel = new ArrayList<PredictOrderRow>();
		int rowCount = getRowCount();
		int columnCount = getColumnCount();
		String[] excelTitle = getExcelTitle();
		for (int i = 1; i < rowCount; i++) {
			PredictOrderRow orderRow = new PredictOrderRow();
			Row row = sheet.getRow(i);
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
				if (ROWNUM_TITLENAME.equals(excelTitle[j])) {
					orderRow.setExcelRowIndex(Integer.valueOf(cell.getStringCellValue()));//�����к�
				}
			}
			excel.add(orderRow);
		}
		return excel;
	}
	/**
	 * �õ���ǰ�������ݣ������ˣ�map��keyΪ������valueΪ��ֵ�����˹���Ϊand�߼���
	 * @param map
	 * @return
	 */
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
				if (ROWNUM_TITLENAME.equals(excelTitle[j])) {
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
	 * ������
	 * @param startIndex
	 * @param endIndex
	 */
	public void addRows(int startIndex, int endIndex){
		int length = endIndex - startIndex + 1;
		for (int i = 0; i < length; i++) {
			sheet.createRow(startIndex + i);
		}
	}
	/**
	 * ��ӵ�Ԫ��
	 * @param rowIndex
	 * @param columnIndex
	 * @param value
	 * @param cellType
	 */
	public void addColumns(int rowIndex, int columnIndex, String value, CellType cellType){
		Row row = sheet.getRow(rowIndex);
		Cell cell = row.createCell(columnIndex);
		switch (cellType) {
		case Number_Type:
			cell.setCellValue(Double.valueOf(value));
			break;
		case String_Type:
			cell.setCellValue(value);
			break;
		case Boolean_Type:
			cell.setCellValue(Boolean.valueOf(value));
			break;
		default:
			cell.setCellValue(value);
			break;
		}
	}
	/**
	 * �޸ĵ�Ԫ��
	 * @param rowIndex
	 * @param columnIndex
	 * @param value
	 * @param cellType
	 */
	public void setColumns(int rowIndex, int columnIndex, String value){
		Row row = sheet.getRow(rowIndex);
		Cell cell = row.getCell(columnIndex);
		int type = cell.getCellType();
		switch (type) {
		case Cell.CELL_TYPE_NUMERIC:
			cell.setCellValue(Double.valueOf(value));
			break;
		case Cell.CELL_TYPE_STRING:
			cell.setCellValue(value);
			break;
		case Cell.CELL_TYPE_BOOLEAN:
			cell.setCellValue(Boolean.valueOf(value));
			break;
		default:
			cell.setCellValue(value);
			break;
		}
	}
	/**
	 * ɾ����
	 * @param index
	 */
	public void deleteRow(int index){
		//���һ��ֱ��ɾ��
		if (index == (getRowCount() - 1)) {
			Row row = sheet.getRow(index);
			sheet.removeRow(row);
			return;
		}
		//�������һ�У��Ȱ�ɾ�����������е�������һ�У���ɾ�������Ŀ���
		sheet.shiftRows(index + 1, getRowCount() - 1, -1);
		Row row = sheet.getRow(getRowCount());//ע�⣺����getRowCount() - 1
		sheet.removeRow(row);
	}
	/**
	 * ���ݹ��˹���ɾ����
	 * @param map
	 */
	public void deleteRow(Map<String, ExcelFilterRule> map){
		int columnCount = getColumnCount();
		String[] excelTitle = getExcelTitle();
		for (int i = 1; i < getRowCount(); i++) {
			Row row = sheet.getRow(i);
			breakLabel : for (int j = 0; j < columnCount; j++) {
				Cell cell = row.getCell(j);
				if (cell == null) {
					continue;
				}
				String titleName = excelTitle[j];
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
							deleteRow(i);
							i--;
							break breakLabel;
						}
						break;
					case NotEqual:
						if (value.equals(cellValue.trim())) {
							deleteRow(i);
							i--;
							break breakLabel;
						}
						break;
					default:
						break;
					}
				}
			}
		}
	}
	/**
	 * ɾ����
	 * @param startIndex
	 * @param endIndex
	 * @param n
	 */
	public void deleteColumn(int index){
		shiftColumns(index + 1, getColumnCount() - 1);
	}
	/**
	 * ͨ������ɾ����
	 * @param titles
	 */
	public void deleteColumn(String[] titles){
		for (int i = 0; i < titles.length; i++) {
			String[] excelTitle = getExcelTitle();
			for (int j = 0; j < excelTitle.length; j++) {
				if (titles[i].equals(excelTitle[j])) {
					deleteColumn(j);
					break;
				}
			}
		}
	}
	/**
	 * �ƶ��У�����һ�У�
	 * @param startIndex
	 * @param endIndex
	 */
	private void shiftColumns(int startIndex, int endIndex){
		int rowCount = getRowCount();
		for (int j = startIndex; j <= endIndex; j++) {
			for (int i = 0; i < rowCount; i++) {
				Row row = sheet.getRow(i);
				Cell toCell = row.createCell(j - 1);
				Cell fromCell = row.getCell(j);
				copyCell(fromCell, toCell);
			}
		}
		//ɾ�����һ��
		for (int i = 0; i < getRowCount(); i++) {
			Row row = sheet.getRow(i);
			row.removeCell(row.getCell(endIndex));
		}
	}
	/**
	 * ���Ƶ�Ԫ��
	 * @param from
	 * @param to
	 */
	private void copyCell(Cell from, Cell to){
		to.setCellComment(from.getCellComment());
		to.setCellStyle(from.getCellStyle());
		to.setCellType(from.getCellType());
		switch (to.getCellType()) {
		case Cell.CELL_TYPE_BOOLEAN:
			to.setCellValue(from.getBooleanCellValue());
			break;
		case Cell.CELL_TYPE_ERROR:
			to.setCellValue(from.getErrorCellValue());
			break;
		case Cell.CELL_TYPE_FORMULA:
			to.setCellValue(from.getCellFormula());
			break;
		case Cell.CELL_TYPE_NUMERIC:
			to.setCellValue(from.getNumericCellValue());
			break;
		case Cell.CELL_TYPE_STRING:
			to.setCellValue(from.getStringCellValue());
			break;
		default:
			break;
		}
	}
	/**
	 * д��excel
	 * @param filePath
	 */
	public void write(String filePath){
		write(new File(filePath));
	}
	/**
	 * д��excel
	 * @param file
	 */
	public void write(File file){
		try {
			write(new FileOutputStream(file));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
	/**
	 * д��excel
	 * @param out
	 */
	public void write(FileOutputStream out){
		try {
			this.out = out;
			workbook.write(out);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * �ر�excel
	 */
	public void close(){
		try {
			if (out != null) {
				out.close();
			}
			if (in != null) {
				in.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static class ExcelFilterRule {
		private Rules rules;
		private String value;
		public ExcelFilterRule(){}
		
		public ExcelFilterRule(String value, Rules rules) {
			this.rules = rules;
			this.value = value;
		}

		public Rules getRules() {
			return rules;
		}
		public void setRules(Rules rules) {
			this.rules = rules;
		}
		public String getValue() {
			return value;
		}
		public void setValue(String value) {
			this.value = value;
		}
	}
	public static boolean isBlankRow2(HSSFRow row,int cellNum){
        if(row == null) return true;
        boolean result = true;
        //int sumcell  = row.getLastCellNum();//��������
        int index = 0;
        for(int i = 0; i < cellNum; i++){//getFirstCellNum=2 ?
            HSSFCell cell = row.getCell(i, Row.RETURN_BLANK_AS_NULL);
            if(cell == null){
            	index++;		
             }          
        }
        if(cellNum == index || cellNum-1 == index){//��������о�Ϊ�գ�resultΪfalse 	
        	result = false;
        }
         return result;
    }
}






