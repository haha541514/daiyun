package com.daiyun.util.pdf;

import java.awt.Color;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.BaseFont;

/**
 * @author Jack Chang
 * 
 * @version ?µå»º???ï¼?an 19, 2010 5:14:00 PM é¡????ä¸??å­??å·¥å?ç±?
 */
public class ITextFontUtil {

	/**
	 * ?°å»ºä¸?¸ªå­??,iText???æ³?STSongStd-Light ???ä½????TextAsian.jar ä¸?»¥propertyä¸ºå?ç¼?
	 * UniGB-UCS2-H ????????TextAsian.jar ä¸?»¥cmapä¸ºå?ç¼?H ä»£è¡¨????????æ¨??ï¼??¸å???V ä»£è¡¨ç«??
	 */
	private static String CHINA_FONT_SONGTI = "STSongStd-Light"; // å®??
	private static String ENCODE_GB = "UniGB-UCS2-H"; // ä¸??ç¼??GBï¼?¨ª???

	/**
	 * ????ºæ?å­??
	 * 
	 * @param font
	 * @param encode
	 * @return
	 */
	public static BaseFont getBaseFont(String font, String encode) {
		BaseFont bfChinese = null;
		try {
			bfChinese = BaseFont.createFont(font, encode, false);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bfChinese;
	}

	/**
	 *????·ä?å­??
	 * 
	 * @param baseFont
	 *            ?ºæ?å­??
	 * @param fontSize
	 *            å­??å¤§å? ï¼??12
	 * @param fontStyle
	 *            å­???·å?ï¼?å¦?om.lowagie.text.Font.BOLD(ç²??ï¼?Font.ITALICï¼??ï¼??
	 *            Font.BOLDITALICï¼?????,Font.NORMAL(???)
	 * @param color
	 *            å­??é¢?? ,å¦??java.awt.Color.BLACK ,Color.BLUE
	 * @return
	 */
	public static Font getFont(BaseFont baseFont, float fontSize,
			int fontStyle, Color color) {
		Font font = new Font(baseFont, fontSize, fontStyle, color);
		return font;
	}

	/**
	 * ???ä¸???ºæ?å­??ï¼?¨ª???
	 * 
	 * @return
	 */
	public static BaseFont getCnBaseFont() {
		return getBaseFont(CHINA_FONT_SONGTI, ENCODE_GB);
	}

	/**
	 * ???æ­£å¸¸å­??
	 * 
	 * @param fontSize
	 *            å­??å¤§å? ï¼??12
	 * @param color
	 *            å­??é¢?? ï¼??Color.BLACK
	 * @return
	 */
	public static Font getCnFont(float fontSize, Color color) {
		BaseFont bfCn = getCnBaseFont();
		Font boldFont = getFont(bfCn, fontSize, Font.NORMAL, color);
		return boldFont;
	}

	/**
	 * ??????å­??
	 * 
	 * @param fontSize
	 *            å­??å¤§å? ï¼??12
	 * @param color
	 *            å­??é¢?? ï¼??Color.BLACK
	 * @return
	 */
	public static Font getCnBoldFont(float fontSize, Color color) {
		BaseFont bfCn = getCnBaseFont();
		Font boldFont = getFont(bfCn, fontSize, Font.BOLD, color);
		return boldFont;
	}

	/**
	 * ??????
	 * 
	 * @param fontSize
	 *            å­??å¤§å? ï¼??12
	 * @param color
	 *            å­??é¢?? ï¼??Color.BLACK
	 * @return
	 */
	public static Font getCnItalicFont(float fontSize, Color color) {
		BaseFont bfCn = getCnBaseFont();
		Font boldFont = getFont(bfCn, fontSize, Font.ITALIC, color);
		return boldFont;
	}

	/**
	 * ???ç²??ä½?
	 * 
	 * @param fontSize
	 *            å­??å¤§å? ï¼??12
	 * @param color
	 *            å­??é¢?? ï¼??Color.BLACK
	 * @return
	 */
	public static Font getCnBoldItalicFont(float fontSize, Color color) {
		BaseFont bfCn = getCnBaseFont();
		Font boldFont = getFont(bfCn, fontSize, Font.BOLDITALIC, color);
		return boldFont;
	}

	/**
	 * ???ä¸??çº¿å?ä½?
	 * 
	 * @param fontSize
	 *            å­??å¤§å? ï¼??12
	 * @param color
	 *            å­??é¢?? ï¼??Color.BLACK
	 * @return
	 */
	public static Font getCnUnderlineFont(float fontSize, Color color) {
		BaseFont bfCn = getCnBaseFont();
		Font boldFont = getFont(bfCn, fontSize, Font.UNDERLINE, color);
		return boldFont;
	}

}
