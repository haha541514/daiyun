package com.daiyun.util.tag;

import java.io.Serializable;

public class TreeNode implements Serializable{
	private static final long serialVersionUID = 1L;
	private String id;
	private String pId;
	private String name;
	private String link;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getpId() {
		return pId;
	}
	public void setpId(String pId) {
		this.pId = pId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLink() {
		return link == null ? "#" : link;
	}
	public void setLink(String link) {
		this.link = link;
	}
}
