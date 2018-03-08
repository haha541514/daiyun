package com.daiyun.util.pdf;


import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.lowagie.text.Element;

/**
 * @author Jack Chang
 * @version ?�建???�?an 20, 2010 11:15:48 AM �????Pdf信�?
 */
public class PdfBean implements Serializable {

	/**
	 * implements Serializable�??????��?�??�???��?�???��??��????�?��没�?

	 */
	 
	private static final long serialVersionUID = 7727797166859442722L;; 

	// pdf�??

	private String title;// ???
	private String subject; // 主�?
	private String keywords; // ?��?�?
	private String author; // �??

	private String creator; // ??���?
	private Map headerMap;// 对�?pdf??��???�?oc.addHeader()�??html??��???�??�?��???档�?头信??

	// ???�??

	private List<Element> elementList; // ???List
	private String fileName;// pdf??��??

	// 页头??���?
	private String header;// 页头
	private String footer;// 页尾

	// 以�????�?
	private boolean encryptFlag = false; // ??????;
	private String userPsw; // ?��?�?? null ??"" �??�??
	private String ownerPsw; // �??�?? null ??"" �??�??
	private List permissionList; // ?????�� ,???PdfWriter常�? �??ALLOW_COPY

	public PdfBean() {

	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public Map getHeaderMap() {
		return headerMap;
	}

	public void setHeaderMap(Map headerMap) {
		this.headerMap = headerMap;
	}

	public List<Element> getElementList() {
		return elementList;
	}

	public void setElementList(List<Element> elementList) {
		this.elementList = elementList;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public String getFooter() {
		return footer;
	}

	public void setFooter(String footer) {
		this.footer = footer;
	}

	public boolean isEncryptFlag() {
		return encryptFlag;
	}

	public void setEncryptFlag(boolean encryptFlag) {
		this.encryptFlag = encryptFlag;
	}

	public String getUserPsw() {
		return userPsw;
	}

	public void setUserPsw(String userPsw) {
		this.userPsw = userPsw;
	}

	public String getOwnerPsw() {
		return ownerPsw;
	}

	public void setOwnerPsw(String ownerPsw) {
		this.ownerPsw = ownerPsw;
	}

	public List getPermissionList() {
		return permissionList;
	}

	public void setPermissionList(List permissionList) {
		this.permissionList = permissionList;
	}

	/**
	 * html?��???
	 * 
	 * @param headerMap
	 */
	public PdfBean(Map headerMap) {
		headerMap.put("Expires", 0);
		this.headerMap = headerMap;
	}
}
