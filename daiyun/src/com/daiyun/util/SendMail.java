package com.daiyun.util;

import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
 

public class SendMail {
	public static void main(String[] args) throws Exception {
        
		// ����Properties �����ڼ�¼�����һЩ����
        final Properties props = new Properties();
        // ��ʾSMTP�����ʼ���������������֤
        props.put("mail.smtp.auth", "true");
        //�˴���дSMTP������
        props.put("mail.smtp.host", "smtp.qq.com");
        //�˿ںţ�QQ��������������˿ڣ�������һ����һֱʹ�ò��ˣ����Ծ͸�����һ��587,465����ղ���
        props.put("mail.smtp.port", "587");
        // �˴���д����˺�
        props.put("mail.user", "541514716@qq.com");
        // �˴����������ǰ��˵��16λSTMP����
        props.put("mail.password", "ptdtvdqkzmsbbfgc");

        // ������Ȩ��Ϣ�����ڽ���SMTP���������֤
        Authenticator authenticator = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                // �û���������
                String userName = props.getProperty("mail.user");
                String password = props.getProperty("mail.password");
                return new PasswordAuthentication(userName, password);
            }
        };
        // ʹ�û������Ժ���Ȩ��Ϣ�������ʼ��Ự
        Session mailSession = Session.getInstance(props, authenticator);
        // �����ʼ���Ϣ
        MimeMessage message = new MimeMessage(mailSession);
        // ���÷�����
        InternetAddress form = new InternetAddress(
                props.getProperty("mail.user"));
        message.setFrom(form);

        // �����ռ��˵�����
        InternetAddress to = new InternetAddress("2584442539@qq.com");
        message.setRecipient(RecipientType.TO, to);

        // �����ʼ�����
        message.setSubject("�����ʼ�");

        // �����ʼ���������
        message.setContent("����һ������ʼ�", "text/html;charset=UTF-8");

        // ���Ȼ���Ƿ����ʼ���
        Transport.send(message);
        System.out.println("Send Email Success");
        System.exit(0);
	}
	public  void run(){
		
	}
}
