package com.senyuan.util;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.util.NumberToTextConverter;

public class CellValueUtil {
   
	
	public  static String getValue(Cell  cell){
		String value="";
		if(cell==null){
			return  value;
		}
		if(cell.getCellType()==cell.CELL_TYPE_STRING){
			return  cell.getStringCellValue();
		}
		else  if(cell.getCellType()==cell.CELL_TYPE_NUMERIC){
			return NumberToTextConverter.toText(cell.getNumericCellValue());
		}
		else{
			return  null;
		}
	}
}
