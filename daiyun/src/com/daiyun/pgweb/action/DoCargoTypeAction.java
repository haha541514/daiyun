package com.daiyun.pgweb.action;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import kyle.leis.fs.cachecontainer.da.CargotypeColumns;
import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.daiyun.dax.CargoTypeDemand;

public class DoCargoTypeAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 9129661770603972623L;

	/*
	 * 初始化货物类型列表	 */
	public String getAllCargoTypes(){
		try{
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			List<CargotypeColumns> listCTColumns = CargoTypeDemand.queryAllCargotypes();
			JSONArray JsonArray = JSONArray.fromObject(listCTColumns);
			String jsonData = JsonArray.toString();
			out.print(jsonData);
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
}
