package com.daiyun.util;

import com.opensymphony.xwork2.ActionSupport;

import java.util.Random;

import java.awt.*;

import java.awt.image.*;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kyle.common.util.sms.ISMSService;
import kyle.common.util.sms.SMSResult;
import kyle.common.util.sms.SMSServiceFactory;

import org.apache.struts2.ServletActionContext;

public class ImageAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2579734583835239801L;

	/**
	 * 
	 * ��֤���Ӧ��Session��
	 */

	private static final String SessionName = "CheckCodeImageAction";
	
	private static final String MobileValadateCode = "mobileValidateCode";

	/**
	 * 
	 * �������������֤�������Դ
	 */

	private static final char[] source = new char[] {

	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',

	'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',

	'U', 'V', 'W', 'X', 'Y', 'Z',

	'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'

	};
	
	/**
	 * 
	 * ����������ɶ�����֤�������Դ
	 */
	
	private static final char[] numsource = new char[] {

		'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'

		};

	/**
	 * 
	 * ���������ӡ��֤����ַ���ɫ
	 */

	private static final Color[] colors = new Color[] {
		Color.RED, Color.BLUE, Color.BLACK
	};
	/**
	 * 
	 * ���ڴ�ӡ��֤�������
	 */

	private static final Font font = new Font("����", Font.PLAIN, 13);

	/**
	 * 
	 * ��������������������������
	 */

	private static final Random rdm = new Random();

	private String text = "";

	private byte[] bytes = null;

	private String contentType = "image/png";

	public byte[] getImageBytes() {

		return this.bytes;

	}

	public String getContentType() {

		return this.contentType;

	}

	public void setContentType(String value) {

		this.contentType = value;

	}

	public int getContentLength() {

		return bytes.length;

	}

	/**
	 * 
	 * ���ɳ���Ϊ4������ַ���
	 */

	private void generateText() {

		char[] source = new char[4];

		for (int i = 0; i < source.length; i++) {
			source[i] = ImageAction.source[rdm
					.nextInt(ImageAction.source.length)];
		}
		this.text = new String(source);
		// ����Session
		ServletActionContext.getRequest().getSession().setAttribute(
				SessionName, this.text);
	}
	
	
	/**
	 * 
	 * ���ɳ���Ϊ6������ַ���(������֤)
	 * @throws IOException 
	 */

	public void sendMobileValidateCode() throws IOException {

		char[] source = new char[6];
       
		for (int i = 0; i < source.length; i++) {
			source[i] = ImageAction.numsource[rdm
					.nextInt(ImageAction.numsource.length)];
		}
		this.text = new String(source);
		// ������֤�뵽Session��
		 HttpSession session  =ServletActionContext.getRequest().getSession();
		 session.setMaxInactiveInterval(3000);//�����
		 session.setAttribute(MobileValadateCode, this.text);
		String attrmobile = ServletActionContext.getRequest().getParameter("tel");
		//���ö��Žӿڷ��Ͷ���
		ISMSService sms = SMSServiceFactory.getSMSService();
		//TXT106HttpSMSService  objDHSS =  (TXT106HttpSMSService) SMSServiceFactory.getSMSService();
		System.out.println("�绰����Ϊ"+attrmobile);
		System.out.println("��֤��Ϊ:"+this.text);
		SMSResult objSMSResult = sms.sendOneSms(attrmobile,"����������������֤���ǣ�"+this.text+"30��������Ч" );
		HttpServletResponse resonse = ServletActionContext.getResponse();
		resonse.setCharacterEncoding("utf-8");
		resonse.getWriter().print(objSMSResult.getResultText());
		//resonse.getWriter().print("���ͳɹ�");
	}
	
	
	/**
	 * 
	 * ���ڴ������ɴ�ӡ������ַ�����ͼƬ
	 * 
	 * @return ���ڴ��д����Ĵ�ӡ���ַ�����ͼƬ
	 */
	private BufferedImage createImage() {

		int width = 35;

		int height = 14;

		BufferedImage image =

		new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

		Graphics g = image.getGraphics();

		g.setColor(Color.LIGHT_GRAY);

		g.fillRect(0, 0, width, height);

		g.setFont(font);

		for (int i = 0; i < this.text.length(); i++) {

			g.setColor(colors[rdm.nextInt(colors.length)]);

			g.drawString(this.text.substring(i, i + 1), 2 + i * 8, 12);

		}
		g.dispose();

		return image;
	}

	/**
	 * 
	 * ����ͼƬ�����ֽ�����
	 * 
	 * @param image
	 *            ���ڴ����ֽ������ͼƬ
	 */

	private void generatorImageBytes(BufferedImage image) {

		ByteArrayOutputStream bos = new ByteArrayOutputStream();

		try {

			javax.imageio.ImageIO.write(image, "jpg", bos);

			this.bytes = bos.toByteArray();

		} catch (Exception ex) {

		} finally {

			try {
				bos.close();

			} catch (Exception ex1) {

			}

		}

	}
	
	//������λ����֤��
	public static String proSixCode(){
		char[] source = new char[6];
	    String r_str=""; 
		for (int i = 0; i < source.length; i++) {
			source[i] = ImageAction.numsource[rdm
					.nextInt(ImageAction.numsource.length)];
			r_str+=ImageAction.numsource[rdm.nextInt(ImageAction.numsource.length)];
		}
		return r_str;
		
	}

	/**
	 * 
	 * ��struts2���������õķ���
	 * 
	 * @return ��Զ�����ַ���"image"
	 */
	public String doDefault() {

		this.generateText();

		BufferedImage image = this.createImage();

		this.generatorImageBytes(image);

		return "image";
	}

}
