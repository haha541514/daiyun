package com.daiyun.util.pdf;


import java.awt.Color;
import java.util.List;
import com.lowagie.text.Table;

/**
 * @author Jack Chang
 * @version ?µå»º???ï¼?an 21, 2010 10:07:32 AM é¡????
 */
public class TableBean {

	private int columns; // ??
	private float width = 100; // å®½åº¦1ï¼?00 ,%ä¸ºå?ä½?
	private float borderWidth = 1; // è¾¹æ?å®½åº¦
	private Color borderColor = Color.BLACK; // è¾¹æ?é¢??
	private float cellSpacing = 0; // cell å¤?¾¹è·?
	private float cellPadding = 1; // cell ??¾¹è·?
	private int alignMent = Table.ALIGN_CENTER; // å¯¹é??¹å?
	private List<String> thList; // è¡¨å¤´
	private List<List> bodyList; // è¡¨ä?
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
