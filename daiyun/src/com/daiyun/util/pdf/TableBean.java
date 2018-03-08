package com.daiyun.util.pdf;


import java.awt.Color;
import java.util.List;
import com.lowagie.text.Table;

/**
 * @author Jack Chang
 * @version ?�建???�?an 21, 2010 10:07:32 AM �????
 */
public class TableBean {

	private int columns; // ??
	private float width = 100; // 宽度1�?00 ,%为�?�?
	private float borderWidth = 1; // 边�?宽度
	private Color borderColor = Color.BLACK; // 边�?�??
	private float cellSpacing = 0; // cell �?���?
	private float cellPadding = 1; // cell ??���?
	private int alignMent = Table.ALIGN_CENTER; // 对�??��?
	private List<String> thList; // 表头
	private List<List> bodyList; // 表�?
	public int getColumns() {
		return columns;
	}
	public void setColumns(int columns) {
		this.columns = columns;
	}
	public float getWidth() {
		return width;
	}
	public void setWidth(float width) {
		this.width = width;
	}
	public float getBorderWidth() {
		return borderWidth;
	}
	public void setBorderWidth(float borderWidth) {
		this.borderWidth = borderWidth;
	}
	public Color getBorderColor() {
		return borderColor;
	}
	public void setBorderColor(Color borderColor) {
		this.borderColor = borderColor;
	}
	public float getCellSpacing() {
		return cellSpacing;
	}
	public void setCellSpacing(float cellSpacing) {
		this.cellSpacing = cellSpacing;
	}
	public float getCellPadding() {
		return cellPadding;
	}
	public void setCellPadding(float cellPadding) {
		this.cellPadding = cellPadding;
	}
	public int getAlignMent() {
		return alignMent;
	}
	public void setAlignMent(int alignMent) {
		this.alignMent = alignMent;
	}
	public List<String> getThList() {
		return thList;
	}
	public void setThList(List<String> thList) {
		this.thList = thList;
	}
	public List<List> getBodyList() {
		return bodyList;
	}
	public void setBodyList(List<List> bodyList) {
		this.bodyList = bodyList;
	}
}
