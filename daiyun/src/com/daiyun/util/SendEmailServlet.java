package com.daiyun.util;

import kyle.common.conf.elementconfig.SMTPConfig;
import kyle.common.connectors.conf.ActionServiceConfig;
import kyle.common.util.email.EMail;

public class SendEmailServlet {
	//public static String s_strFrom = "kyle@xinsofts.com";
	
	public static String s_strFrom = "541514716@qq.com";
	//public static String s_strTo = "zhouerya109@hotmail.com";
	public static String s_strTo = "wu_kaiquan@foxmail.com";

	public static String s_strCC = "";

	public static String s_strBCC = "";

	public static String s_strSubject = "电子邮件发送测试";
	public static void main(String[] args) {
		//SMTPConfig.getInstance("211.154.135.204", "25", "kyle@xinsofts.com","", "true");
		//sendTextMail();

		// sendTextMailAttachFile();

		new ActionServiceConfig("E:\\wkq\\Devolop_tools\\apache-tomcat-6.0.45\\webapps\\daiyun\\WEB-INF\\ServiceConfig.xml");
		//sendHtmlMailAttachFile();
		sendTextMail();
		// sendHtmlMailAttachContent();

		// sendGroupHtmlMail();
		System.exit(0);
	}

	private static void sendTextMail() {
		String strContent = "就是测试一下\r\n" + "带附件的文本邮件发送";

		try {
			EMail.sendMail(s_strFrom, s_strTo, s_strCC, s_strBCC, s_strSubject,
					strContent, null);
		} catch (Exception e) {
			// 不再处理
		}
	}

	private static void sendTextMailAttachFile() {
		String strContent = "就是测试一下\r\n" + "带附件的文本邮件发送";
		String[] astrAttach = { "E:\\temp\\测试文档test.txt" };

		try {
			EMail.sendMail(s_strFrom, s_strTo, s_strCC, s_strBCC, s_strSubject,
					strContent, astrAttach);
		} catch (Exception e) {
			// 不再处理
		}
	}

	/**
	 * 测试发送HTML格式的邮件，且带贴图和附件，贴图和附件都从文件中获取。
	 */
	private static void sendHtmlMailAttachFile() {
		String strContent = "<HTML>\n" + "<HEAD>\n" + "<TITLE>XXX</TITLE>\n"
				+ "</HEAD>\n" + "<BODY>\n" + "你好我好代价哦附加阿卢瑟福界阿疯狂了撒"
				+ "<H1>XXX</H1>测试发送HTML邮件" +
				/*
				 * " <td align=\"center\" valign=\"middle\">\n" + " <div
				 * align=\"center\">\n" + " <a href=\"http://www.test.com/\"
				 * target=\"_blank\" >\n" + " <img src=\"cid:button3.gif\"
				 * width=\"60\" height=\"45\" border=\"0\">\n" + " </a>\n" + "
				 * </div>\n" + " </td>" +
				 */
				"</BODY>\n" + "</HTML>";

		//String[] astrAttach = { "E:\\temp\\gm_config.xml" };
		//String[] astrPack = { "E:\\temp\\button3.gif" };

		try {
			// EMail.sendHtmlMail(s_strFrom, s_strTo, s_strCC, s_strBCC,
			// s_strSubject, strContent, astrPack, astrAttach);

			EMail.sendHtmlMail(s_strFrom, s_strTo, s_strCC, s_strBCC,
					s_strSubject, strContent, null, null);

			// EMail.sendMail(s_strFrom, s_strTo, s_strCC, s_strBCC,
			// s_strSubject, strContent, astrAttach);
		} catch (Exception e) {

		}
	}

	/**
	 * 发送HTML邮件，带附件和贴图，且附件和贴图都从字符串获得
	 */
	private static void sendHtmlMailAttachContent() {
		String strContent = "<HTML>\n"
				+ "<HEAD>\n"
				+ "<TITLE>"
				+ s_strSubject
				+ "</TITLE>\n"
				+ "</HEAD>\n"
				+ "<BODY>\n"
				+ "<H1>"
				+ s_strSubject
				+ "</H1>"
				+ "测试发送HTML邮件\n"
				+ "    <td align=\"center\" valign=\"middle\">\n"
				+ "      <div align=\"center\">\n"
				+ "        <a href=\"http://www.test.com/\" target=\"_blank\" >\n"
				+
				// " <img src=\"cid:button3.gif\" width=\"60\" height=\"45\"
				// border=\"0\">\n" +
				"        </a>\n" + "      </div>\n" + "    </td>" + "</BODY>\n"
				+ "</HTML>";

		String[] astrAttachName = { "中华.xml" };
		String[] astrAttachContent = { "<?xml version=\"1.0\" encoding=\"GBK\"?>\n"
				+ "<datar江山>等级埃阿发福军队司立法局xjieoij</datar江山>" };

		try {
			EMail.sendHtmlMail(s_strFrom, s_strTo, s_strCC, s_strBCC,
					s_strSubject, strContent, null, null, astrAttachName,
					astrAttachContent);
		} catch (Exception e) {

		}
	}

	private static void sendGroupHtmlMail() {
		String[] astrTo = { "kylezhou@xssoft.com", "kylezhou@xssoft.com",
				"kylezhou@xssoft.com", "kylezhou@xssoft.com" };
		String strContent = "<HTML>\n"
				+ "<HEAD>\n"
				+ "<TITLE>"
				+ s_strSubject
				+ "</TITLE>\n"
				+ "</HEAD>\n"
				+ "<BODY>\n"
				+ "<H1>"
				+ s_strSubject
				+ "</H1>"
				+ "测试发送HTML邮件\n"
				+ "    <td align=\"center\" valign=\"middle\">\n"
				+ "      <div align=\"center\">\n"
				+ "        <a href=\"http://www.test.com/\" target=\"_blank\" >\n"
				+ "          <img src=\"cid:button3.gif\" width=\"60\" height=\"45\" border=\"0\">\n"
				+ "        </a>\n" + "      </div>\n" + "    </td>"
				+ "</BODY>\n" + "</HTML>";

		String[] astrPack = { "E:\\temp\\button3.gif" };
		String[] astrAttach = { "E:\\temp\\A.xls" };

		try {
			EMail.sendGroupHtmlMail(s_strFrom, astrTo, s_strSubject,
					strContent, astrPack, astrAttach);
		} catch (Exception e) {

		}
	}
}
