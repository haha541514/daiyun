package com.daiyun.dax;

public class MessageBean {
	private String strType;
	private String strTitle;
	private String strMessage;
	
	public MessageBean(String type,String title,String message){
		this.setStrType(type);
		this.setStrTitle(title);
		this.setStrMessage(message);
	}
	
	public String getStrType() {
		return strType;
	}
	public void setStrType(String strType) {
		this.strType = strType;
	}
	public String getStrTitle() {
		return strTitle;
	}
	public void setStrTitle(String strTitle) {
		this.strTitle = strTitle;
	}
	public String getStrMessage() {
		return strMessage;
	}
	public void setStrMessage(String strMessage) {
		this.strMessage = strMessage;
	}
}
