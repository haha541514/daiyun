package com.daiyun.pgweb.action;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import kyle.leis.fs.cachecontainer.da.PaymentmodeColumns;
import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.daiyun.dax.PaymentmodeDemand;

public class DoPaymentmodeAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = -205609522483368536L;

	/*
	 * 初始化付款模式列表	 */
	public String getAllPaymentmodes(){
		try{
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			List<PaymentmodeColumns> listPMColumns = PaymentmodeDemand.queryAllPaymentmodes();
			JSONArray JsonArray = JSONArray.fromObject(listPMColumns);
			String jsonData = JsonArray.toString();
			out.print(jsonData);
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
}
