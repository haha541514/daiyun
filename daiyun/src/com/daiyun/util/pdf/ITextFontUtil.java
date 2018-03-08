package com.daiyun.util.pdf;

import java.awt.Color;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.BaseFont;

/**
 * @author Jack Chang
 * 
 * @version ?�建???�?an 19, 2010 5:14:00 PM �????�??�??工�?�?
 */
public class ITextFontUtil {

	/**
	 * ?�建�?���??,iText???�?STSongStd-Light ???�????TextAsian.jar �?��property为�?�?
	 * UniGB-UCS2-H ????????TextAsian.jar �?��cmap为�?�?H 代表????????�??�??��???V 代表�??
	 */
	private static String CHINA_FONT_SONGTI = "STSongStd-Light"; // �??
	private static String ENCODE_GB = "UniGB-UCS2-H"; // �??�??GB�?��???

	/**
	 * ????��?�??
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
	 *????��?�??
	 * 
	 * @param baseFont
	 *            ?��?�??
	 * @param fontSize
	 *            �??大�? �??12
	 * @param fontStyle
	 *            �???��?�?�?om.lowagie.text.Font.BOLD(�??�?Font.ITALIC�??�??
	 *            Font.BOLDITALIC�?????,Font.NORMAL(???)
	 * @param color
	 *            �??�?? ,�??java.awt.Color.BLACK ,Color.BLUE
	 * @return
	 */
	public static Font getFont(BaseFont baseFont, float fontSize,
			int fontStyle, Color color) {
		Font font = new Font(baseFont, fontSize, fontStyle, color);
		return font;
	}

	/**
	 * ???�???��?�??�?��???
	 * 
	 * @return
	 */
	public static BaseFont getCnBaseFont() {
		return getBaseFont(CHINA_FONT_SONGTI, ENCODE_GB);
	}

	/**
	 * ???正常�??
	 * 
	 * @param fontSize
	 *            �??大�? �??12
	 * @param color
	 *            �??�?? �??Color.BLACK
	 * @return
	 */
	public static Font getCnFont(float fontSize, Color color) {
		BaseFont bfCn = getCnBaseFont();
		Font boldFont = getFont(bfCn, fontSize, Font.NORMAL, color);
		return boldFont;
	}

	/**
	 * ??????�??
	 * 
	 * @param fontSize
	 *            �??大�? �??12
	 * @param color
	 *            �??�?? �??Color.BLACK
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
	 *            �??大�? �??12
	 * @param color
	 *            �??�?? �??Color.BLACK
	 * @return
	 */
	public static Font getCnItalicFont(float fontSize, Color color) {
		BaseFont bfCn = getCnBaseFont();
		Font boldFont = getFont(bfCn, fontSize, Font.ITALIC, color);
		return boldFont;
	}

	/**
	 * ???�??�?
	 * 
	 * @param fontSize
	 *            �??大�? �??12
	 * @param color
	 *            �??�?? �??Color.BLACK
	 * @return
	 */
	public static Font getCnBoldItalicFont(float fontSize, Color color) {
		BaseFont bfCn = getCnBaseFont();
		Font boldFont = getFont(bfCn, fontSize, Font.BOLDITALIC, color);
		return boldFont;
	}

	/**
	 * ???�??线�?�?
	 * 
	 * @param fontSize
	 *            �??大�? �??12
	 * @param color
	 *            �??�?? �??Color.BLACK
	 * @return
	 */
	public static Font getCnUnderlineFont(float fontSize, Color color) {
		BaseFont bfCn = getCnBaseFont();
		Font boldFont = getFont(bfCn, fontSize, Font.UNDERLINE, color);
		return boldFont;
	}

}
