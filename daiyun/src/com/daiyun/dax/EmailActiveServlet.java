package com.daiyun.dax;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EmailActiveServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {
		doPost(req, resp);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {
		String strUsername = req.getParameter("username");//�û���opcode
		String strPassword = req.getParameter("ACTIVECDK");//������
		process(req, resp, getServletConfig());
	}
	
	//����
	public String process(HttpServletRequest req, HttpServletResponse resp,
			ServletConfig sconfig) throws IOException {
				
		
		
		return null;
	}
	
}