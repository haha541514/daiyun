package com.daiyun.sfweb.action;


import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.email.EMail;

/**
 * 20161230,
 * �����ʼ�
 * */
public class EmailAction extends ActionSupportEX {

	private static final long serialVersionUID = 1L;
	public static String s_strFrom = "541514716@qq.com";

	//public static String s_strTo = "zhouerya109@hotmail.com";
	public static String s_strTo = "";

	public static String s_strCC = "";

	public static String s_strBCC = "";

	public static String s_strSubject = "�γ�������޹�˾����У��";
	/**
	 * �����ʼ�У���룬ajax
	 * */
	public void sendEmailValidate() {
		String email = request.getParameter("email");
		String path = (String) session.getAttribute("path");
		
		//new ActionServiceConfig("E:\\xs\\java\\daiyun\\WebRoot\\WEB-INF\\ServiceConfig.xml");
		
		s_strTo = email;
		//String[] astrAttach = { "E:\\temp\\�����ĵ�test.txt" };
		String strContent = "<HTML>\n" + "<HEAD>\n" + "<TITLE>XXX</TITLE>\n"
		+ "</HEAD>\n" + "<BODY>\n" + "���"
		+ "<H1>XXX</H1>���Է���HTML�ʼ�" +"<A>www.baidu.com </A>"+
				"</BODY>\n" + "</HTML>";
		try {
		EMail.sendMail(s_strFrom, s_strTo, s_strCC, s_strBCC, s_strSubject,
				strContent, null);
		
		response.getWriter().print("true");
		
		}catch(Exception e){
		
		}
		
	}
	
	
	
	
	
}