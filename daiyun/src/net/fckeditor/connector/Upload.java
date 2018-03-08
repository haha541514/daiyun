package net.fckeditor.connector;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import jxl.Sheet;
import jxl.Workbook;

public class Upload {
	public List<String[]> getExcel(String filePath) throws Exception {
		List<String[]> list = new ArrayList<String[]>();
		File inFile = new File(filePath);
		Workbook workbook = null;
		workbook = Workbook.getWorkbook(inFile);
		Sheet sheet = workbook.getSheet(0);
		try {
			for (int i = 1; i < sheet.getRows(); i++) {
				for(int j = 0;j<sheet.getColumns();j++){
					System.out.println("单元格内容："+sheet.getCell(j,i));
				}

			}

		} catch (Exception e) {

		} finally {
			workbook.close();
		}
		return list;
	}

}
