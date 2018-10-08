package com.senyuan.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.senyuan.entity.StoreProcess;


public class SpExcelUtil {
	public static void export(OutputStream os,List<StoreProcess> sps){
		Workbook  workbook=new XSSFWorkbook();
		
		//合并单元格
		CellRangeAddress cr=new CellRangeAddress(0, 0, 0, 5);
		
		
		/***first row 样式******************************************************/
		CellStyle _1_style=workbook.createCellStyle();
		_1_style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		_1_style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		
		
		Font _16_font=workbook.createFont();
		_16_font.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
		_16_font.setFontHeightInPoints((short)16);
		_1_style.setFont(_16_font);
		/***first row 样式******************************************************/
		
		
		
	
		
		
		Sheet sheet=workbook.createSheet("storeprocess");
		sheet.addMergedRegion(cr);
		sheet.setColumnWidth(0, 5*256);
		sheet.setColumnWidth(1, 20*256);
		sheet.setColumnWidth(2, 30*256);
		sheet.setColumnWidth(3, 20*256);
		sheet.setColumnWidth(4, 15*256);
		sheet.setColumnWidth(5, 50*256);
		
	
		Row row=sheet.createRow(0);
		Cell  cell=row.createCell(0);
		cell.setCellValue("卓翼科技");
		cell.setCellStyle(_1_style);
		
		/***title row 样式******************************************************/
		CellStyle title_style=workbook.createCellStyle();
		title_style.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		title_style.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
		Font  font_white=workbook.createFont();
  		font_white.setBoldweight(XSSFFont.BOLDWEIGHT_BOLD);
  		font_white.setColor(HSSFColor.WHITE.index);
  		font_white.setFontHeightInPoints((short)10);
  		title_style.setFont(font_white);
		title_style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		title_style.setFillForegroundColor(HSSFColor.BROWN.index);
		/***title row 样式******************************************************/
		
		row=sheet.createRow(1);
		cell=row.createCell(0);
		cell.setCellValue("");
		cell.setCellStyle(title_style);
		cell=row.createCell(1);
		cell.setCellValue("存储过程名字");
		cell.setCellStyle(title_style);
		cell=row.createCell(2);
		cell.setCellValue("存储过程作用");
		cell.setCellStyle(title_style);
		cell=row.createCell(3);
		cell.setCellValue("隶属于数据库");
		cell.setCellStyle(title_style);
		cell=row.createCell(4);
		cell.setCellValue("作者");
		cell.setCellStyle(title_style);
		cell=row.createCell(5);
		cell.setCellValue("其他备注信息");
		cell.setCellStyle(title_style);
		
		
		/***CONTENT row 样式******************************************************/
		CellStyle content_style=workbook.createCellStyle();
		content_style.setBorderBottom(XSSFCellStyle.BORDER_HAIR);
		content_style.setBorderLeft(XSSFCellStyle.BORDER_HAIR);
		content_style.setBorderRight(XSSFCellStyle.BORDER_HAIR);
		content_style.setBorderTop(XSSFCellStyle.BORDER_HAIR);
		/***CONTENT row 样式******************************************************/
		
		if(sps!=null){
			for(int x=0;x<sps.size();x++){
				//写第2行
				row=sheet.createRow(x+2);
				StoreProcess sp=sps.get(x);
				
				cell=row.createCell(0);
				cell.setCellValue(x+1+"");
				cell.setCellStyle(content_style);
				cell=row.createCell(1);
				cell.setCellValue(sp.getSpName());
				cell.setCellStyle(content_style);
				cell=row.createCell(2);
				cell.setCellValue(sp.getSpFunction());
				cell.setCellStyle(content_style);
				cell=row.createCell(3);
				cell.setCellValue(sp.getSpDatabase());
				cell.setCellStyle(content_style);
				cell=row.createCell(4);
				cell.setCellValue(sp.getSpAuthor());
				cell.setCellStyle(content_style);
				cell=row.createCell(5);
				cell.setCellValue(sp.getSpComment());
				cell.setCellStyle(content_style);
			}
		}
		
		
		try {
			workbook.write(os);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
	}
	
	
	public  static  List<StoreProcess>  readExcel(File file) throws Exception{
	    Workbook workbook=null;
	    if(file.getName().endsWith("xls")){
	    	workbook=new  HSSFWorkbook(new FileInputStream(file));
	    }
	    else if(file.getName().endsWith("xlsx")){
	    	workbook=new  XSSFWorkbook(new FileInputStream(file));
	    }
	    else{
	    	throw  new  RuntimeException("非法excel文件");
	    }
	    
	    Sheet sheet=workbook.getSheetAt(0);
	   int len= sheet.getPhysicalNumberOfRows();
	   Row  row=null;
	   StoreProcess  sp=null;
	   List<StoreProcess>  list=new  ArrayList<StoreProcess>();
	   for(int x=2;x<len;x++){
		   //0 1 rows  we  didnot  need
		   row=sheet.getRow(x);
		   sp=new StoreProcess();
		   sp.setSpName(CellValueUtil.getValue(row.getCell(1)));
		   sp.setSpFunction(CellValueUtil.getValue(row.getCell(2)));
		   sp.setSpDatabase(CellValueUtil.getValue(row.getCell(3)));
		   sp.setSpAuthor(CellValueUtil.getValue(row.getCell(4)));
		   sp.setSpComment(CellValueUtil.getValue(row.getCell(5)));
		   
		   list.add(sp);
	   }
		
		return list;
	}
	
}
