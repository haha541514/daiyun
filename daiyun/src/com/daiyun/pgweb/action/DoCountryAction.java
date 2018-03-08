package com.daiyun.pgweb.action;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.daiyun.dax.CountryDemand;
import com.opensymphony.xwork2.ActionSupport;

public class DoCountryAction extends ActionSupport {
	private static final long serialVersionUID = 4513923943249449838L;

	/**
	 * 初始化国家下拉列表
	 * @return
	 */
	public String getAllCountry(){
		try{
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			List list = CountryDemand.queryAllCountry();
			System.out.println(list.size());
			JSONArray JsonArray = JSONArray.fromObject(CountryDemand.queryAllCountry());
			String jsonDate = JsonArray.toString();
			out.print(jsonDate);
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
}
