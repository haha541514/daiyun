package com.daiyun.opweb.alipay.config;

/* *
 *������AlipayConfig
 *���ܣ�����������
 *��ϸ�������ʻ��й���Ϣ������·��
 *�汾��3.4
 *�޸����ڣ�2016-03-08
 *˵����
 *���´���ֻ��Ϊ�˷����̻����Զ��ṩ���������룬�̻����Ը����Լ���վ����Ҫ�����ռ����ĵ���д,����һ��Ҫʹ�øô��롣
 *�ô������ѧϰ���о�֧�����ӿ�ʹ�ã�ֻ���ṩһ���ο���
 */

public class AlipayConfig {
	
//�����������������������������������Ļ�����Ϣ������������������������������

	// ���������ID��ǩԼ�˺ţ���2088��ͷ��16λ��������ɵ��ַ������鿴��ַ��https://b.alipay.com/order/pidAndKey.htm
	public static String partner = "2088521202854160";
	
	// �տ�֧�����˺ţ���2088��ͷ��16λ��������ɵ��ַ�����һ��������տ��˺ž���ǩԼ�˺�
	public static String seller_id = "2088521202854160";

	// MD5��Կ����ȫ�����룬�����ֺ���ĸ��ɵ�32λ�ַ������鿴��ַ��https://b.alipay.com/order/pidAndKey.htm
    public static String key = "5tirzvv344r2ic28023qo5xrf4r6r0vh";

//	// �������첽֪ͨҳ��·��  ��http://��ʽ������·�������ܼ�?id=123�����Զ����������������������������
//	public static String notify_url = "http://www.1001000.com/alipay/notify_url.jsp";
//
//	// ҳ����תͬ��֪ͨҳ��·�� ��http://��ʽ������·�������ܼ�?id=123�����Զ����������������������������
//	public static String return_url = "http://www.1001000.com/alipay/return_url.jsp";
	// �������첽֪ͨҳ��·��  ��http://��ʽ������·�������ܼ�?id=123�����Զ����������������������������
	public static String notify_url = "http://121.37.17.161/daiyun/alipay/notify_url.jsp";

	// ҳ����תͬ��֪ͨҳ��·�� ��http://��ʽ������·�������ܼ�?id=123�����Զ����������������������������
	public static String return_url = "http://121.37.17.161/daiyun/alipay/return_url.jsp";
	// ǩ����ʽ
	public static String sign_type = "MD5";
	
	// �����ã�����TXT��־�ļ���·������AlipayCore.java���е�logResult(String sWord)��ӡ������
	public static String log_path = "D:\\";
		
	// �ַ������ʽ Ŀǰ֧�� gbk �� utf-8
	public static String input_charset = "utf-8";
		
	// ֧������ �������޸�
	public static String payment_type = "1";
		
	// ���õĽӿ����������޸�
	public static String service = "create_direct_pay_by_user";


//�����������������������������������Ļ�����Ϣ������������������������������
	
//�������������������� �����������÷�������Ϣ�����û��ͨ�����㹦�ܣ�Ϊ�ռ��� ������������������������������
	
	// ������ʱ���  ��Ҫʹ����������ļ�submit�е�query_timestamp����
	public static String anti_phishing_key = "";
	
	// �ͻ��˵�IP��ַ �Ǿ�����������IP��ַ���磺221.0.0.1
	public static String exter_invoke_ip = "";
		
//�������������������������������÷�������Ϣ�����û��ͨ�����㹦�ܣ�Ϊ�ռ��� ������������������������������
	
}

