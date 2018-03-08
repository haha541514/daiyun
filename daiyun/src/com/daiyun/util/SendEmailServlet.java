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

	public static String s_strSubject = "�����ʼ����Ͳ���";
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
		String strContent = "���ǲ���һ��\r\n" + "���������ı��ʼ�����";

		try {
			EMail.sendMail(s_strFrom, s_strTo, s_strCC, s_strBCC, s_strSubject,
					strContent, null);
		} catch (Exception e) {
			// ���ٴ���
		}
	}

	private static void sendTextMailAttachFile() {
		String strContent = "���ǲ���һ��\r\n" + "���������ı��ʼ�����";
		String[] astrAttach = { "E:\\temp\\�����ĵ�test.txt" };

		try {
			EMail.sendMail(s_strFrom, s_strTo, s_strCC, s_strBCC, s_strSubject,
					strContent, astrAttach);
		} catch (Exception e) {
			// ���ٴ���
		}
	}

	/**
	 * ���Է���HTML��ʽ���ʼ����Ҵ���ͼ�͸�������ͼ�͸��������ļ��л�ȡ��
	 */
	private static void sendHtmlMailAttachFile() {
		String strContent = "<HTML>\n" + "<HEAD>\n" + "<TITLE>XXX</TITLE>\n"
				+ "</HEAD>\n" + "<BODY>\n" + "����Һô���Ŷ���Ӱ�¬ɪ���簢�������"
				+ "<H1>XXX</H1>���Է���HTML�ʼ�" +
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
	 * ����HTML�ʼ�������������ͼ���Ҹ�������ͼ�����ַ������
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
				+ "���Է���HTML�ʼ�\n"
				+ "    <td align=\"center\" valign=\"middle\">\n"
				+ "      <div align=\"center\">\n"
				+ "        <a href=\"http://www.test.com/\" target=\"_blank\" >\n"
				+
				// " <img src=\"cid:button3.gif\" width=\"60\" height=\"45\"
				// border=\"0\">\n" +
				"        </a>\n" + "      </div>\n" + "    </td>" + "</BODY>\n"
				+ "</HTML>";

		String[] astrAttachName = { "�л�.xml" };
		String[] astrAttachContent = { "<?xml version=\"1.0\" encoding=\"GBK\"?>\n"
				+ "<datar��ɽ>�ȼ�������������˾������xjieoij</datar��ɽ>" };

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
				+ "���Է���HTML�ʼ�\n"
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
