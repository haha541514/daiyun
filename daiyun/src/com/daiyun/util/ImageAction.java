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
	 * 验证码对应的Session名
	 */

	private static final String SessionName = "CheckCodeImageAction";
	
	private static final String MobileValadateCode = "mobileValidateCode";

	/**
	 * 
	 * 用于随机生成验证码的数据源
	 */

	private static final char[] source = new char[] {

	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',

	'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',

	'U', 'V', 'W', 'X', 'Y', 'Z',

	'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'

	};
	
	/**
	 * 
	 * 用于随机生成短信验证码的数据源
	 */
	
	private static final char[] numsource = new char[] {

		'1', '2', '3', '4', '5', '6', '7', '8', '9', '0'

		};

	/**
	 * 
	 * 用于随机打印验证码的字符颜色
	 */

	private static final Color[] colors = new Color[] {
		Color.RED, Color.BLUE, Color.BLACK
	};
	/**
	 * 
	 * 用于打印验证码的字体
	 */

	private static final Font font = new Font("宋体", Font.PLAIN, 13);

	/**
	 * 
	 * 用于生成随机数的随机数生成器
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
	 * 生成长度为4的随机字符串
	 */

	private void generateText() {

		char[] source = new char[4];

		for (int i = 0; i < source.length; i++) {
			source[i] = ImageAction.source[rdm
					.nextInt(ImageAction.source.length)];
		}
		this.text = new String(source);
		// 设置Session
		ServletActionContext.getRequest().getSession().setAttribute(
				SessionName, this.text);
	}
	
	
	/**
	 * 
	 * 生成长度为6的随机字符串(短信验证)
	 * @throws IOException 
	 */

	public void sendMobileValidateCode() throws IOException {

		char[] source = new char[6];
       
		for (int i = 0; i < source.length; i++) {
			source[i] = ImageAction.numsource[rdm
					.nextInt(ImageAction.numsource.length)];
		}
		this.text = new String(source);
		// 设置验证码到Session中
		 HttpSession session  =ServletActionContext.getRequest().getSession();
		 session.setMaxInactiveInterval(3000);//五分钟
		 session.setAttribute(MobileValadateCode, this.text);
		String attrmobile = ServletActionContext.getRequest().getParameter("tel");
		//调用短信接口发送短信
		ISMSService sms = SMSServiceFactory.getSMSService();
		//TXT106HttpSMSService  objDHSS =  (TXT106HttpSMSService) SMSServiceFactory.getSMSService();
		System.out.println("电话号码为"+attrmobile);
		System.out.println("验证码为:"+this.text);
		SMSResult objSMSResult = sms.sendOneSms(attrmobile,"【代运网】您的验证码是："+this.text+"30分钟内有效" );
		HttpServletResponse resonse = ServletActionContext.getResponse();
		resonse.setCharacterEncoding("utf-8");
		resonse.getWriter().print(objSMSResult.getResultText());
		//resonse.getWriter().print("发送成功");
	}
	
	
	/**
	 * 
	 * 在内存中生成打印了随机字符串的图片
	 * 
	 * @return 在内存中创建的打印了字符串的图片
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
	 * 根据图片创建字节数组
	 * 
	 * @param image
	 *            用于创建字节数组的图片
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
	
	//生成六位数验证码
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
	 * 被struts2过滤器调用的方法
	 * 
	 * @return 永远返回字符串"image"
	 */
	public String doDefault() {

		this.generateText();

		BufferedImage image = this.createImage();

		this.generatorImageBytes(image);

		return "image";
	}

}
