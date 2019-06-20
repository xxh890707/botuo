package com.botuo.common.utils.excel;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

/**
 * poi导入excel数据工具类
 * @author cui
 *
 */
public class ImportExcelUtil {
	
	/**
	 * 忽略第一行和最后一行读取excel数据
	 * 
	 * @param headNames
	 *            中英文表头名称映射关系
	 * @return
	 * @throws IOException
	 * @throws InvalidFormatException
	 * 
	 */
	public static List<Map<String, String>> readExcelIgnoreFistAndLastRow(
			Map<String, String> headNames, InputStream in)
			throws InvalidFormatException, IOException {

		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		Workbook workbook = WorkbookFactory.create(in);
		// Sheet的数量
//		int sheetCount = workbook.getNumberOfSheets();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		// 遍历每个Sheet
//		for (int s = 0; s < sheetCount; s++) {
			Sheet sheet = workbook.getSheetAt(0);
			// 获取总行数
			int rowCount = sheet.getPhysicalNumberOfRows();
			// 取得表头
			Row head = sheet.getRow(0);
			// 根据表头获取总列数
			int cellCount = head.getPhysicalNumberOfCells();
			String[] heads = new String[cellCount];

			// 遍历每一行
			for (int r = 0; r < rowCount; r++) {
				// 获取当前行
				Row row = sheet.getRow(r);
				Map<String, String> map = new LinkedHashMap<String, String>(cellCount);
				if(null != row){
					// 遍历每一列
					for (int c = 0; c < cellCount; c++) {
						int cellType = 100;
						Cell cell = row.getCell(c);
						if(cell != null){
							cellType= cell.getCellType();
						}
						String cellValue = "";
						switch (cellType) {
						case Cell.CELL_TYPE_STRING: //文本
							cellValue = cell.getStringCellValue();
							break;
						case Cell.CELL_TYPE_NUMERIC: //数字、日期
							if (DateUtil.isCellDateFormatted(cell)) {
								cellValue = fmt.format(cell.getDateCellValue()); //日期型
							} else {
								if("age".equals(heads[c])){
									cellValue = String.valueOf(cell.getNumericCellValue()); //数字
								}else{
									BigDecimal b = new BigDecimal(cell.getNumericCellValue());
									cellValue = String.valueOf(b.toString()); //数字
								}
							}
							break;
						case Cell.CELL_TYPE_BOOLEAN: //布尔型
							cellValue = String.valueOf(cell.getBooleanCellValue());
							break;
						case Cell.CELL_TYPE_BLANK: //空白
							cellValue = cell.getStringCellValue();
							break;
						case Cell.CELL_TYPE_ERROR: //错误
							cellValue = "错误";
							break;
						case Cell.CELL_TYPE_FORMULA: //公式
							cellValue = "";
							break;
						default:
							cellValue = "";
						}
						// 表头
						if (r == 0) {
							// 用英文表头替换中文表头
							if (headNames.containsKey(cellValue)) {
								heads[c] = headNames.get(cellValue);
							}
						}
						if (r != 0) {
							// 存当前行数据
							if(heads[c]!=null &&!"".equals(heads[c])){
								map.put(heads[c], cellValue);
							}
							
						}
					}
				}
				// 表头行不存
				if (r != 0) {
					list.add(map);
				}
			}
//		}
		return list;
	}
	
	
	/**
	 * 读取excel
	 * @param headNames  中英文表头名称映射关系
	 * @param in
	 * @return
	 * @throws IOException 
	 * @throws InvalidFormatException 
	 *
	 */
	public static List<Map<String, String>> readExcel(
			Map<String, String> headNames, InputStream in) throws InvalidFormatException, IOException{
		
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
		Workbook workbook = WorkbookFactory.create(in);
		// Sheet的数量
		int sheetCount = workbook.getNumberOfSheets();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		// 遍历每个Sheet
		for (int s = 0; s < sheetCount; s++) {
			Sheet sheet = workbook.getSheetAt(s);
			// 获取总行数
			int rowCount = sheet.getPhysicalNumberOfRows();
			// 取得表头
			Row head = sheet.getRow(0);
			// 根据表头获取总列数
			int cellCount = head.getPhysicalNumberOfCells();
			String[] heads = new String[cellCount];

			// 遍历每一行
			for (int r = 0; r < rowCount; r++) {
				// 获取当前行
				Row row = sheet.getRow(r);
				Map<String, String> map = new LinkedHashMap<String, String>(cellCount);
				// 遍历每一列
				for (int c = 0; c < cellCount; c++) {
					Cell cell = row.getCell(c);
					int cellType = cell.getCellType();
					String cellValue = "";
					switch (cellType) {
					case Cell.CELL_TYPE_STRING: //文本
						cellValue = cell.getStringCellValue();
						break;
					case Cell.CELL_TYPE_NUMERIC: // 数字、日期
						if (DateUtil.isCellDateFormatted(cell)) {
							cellValue = fmt.format(cell.getDateCellValue()); //日期型
						} else {
							cellValue = String.valueOf(cell
									.getNumericCellValue()); //数字
						}
						break;
					case Cell.CELL_TYPE_BOOLEAN: //布尔型
						cellValue = String.valueOf(cell.getBooleanCellValue());
						break;
					case Cell.CELL_TYPE_BLANK: //空白
						cellValue = cell.getStringCellValue();
						break;
					case Cell.CELL_TYPE_ERROR: //错误
						cellValue = "错误";
						break;
					case Cell.CELL_TYPE_FORMULA: //公式
						cellValue = "";
						break;
					default:
						cellValue = "";
					}
					// 表头
					if (r == 0) {
						// 用英文表头替换中文表头
						if (headNames.containsKey(cellValue)) {
							heads[c] = headNames.get(cellValue);
						}else{
							
						}
					}
					if (r != 0) {
						// 存当前行数据
						map.put(heads[c], cellValue);
					}
				}
				// 表头行不存
				if (r != 0) {
					list.add(map);
				}
			}
		}
		return list;
	}
}
