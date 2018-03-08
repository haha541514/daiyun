package com.daiyun.util.pdf;

import java.awt.Color;
import java.awt.Point;
import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.lowagie.text.Anchor;
import com.lowagie.text.Annotation;
import com.lowagie.text.BadElementException;
import com.lowagie.text.Cell;
import com.lowagie.text.Chapter;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.HeaderFooter;
import com.lowagie.text.Image;
import com.lowagie.text.ListItem;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Section;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.PdfWriter;

/**
 * @author Jack Chang
 * @version ?µå»º???ï¼?an 19, 2010 4:49:26 PM é¡????
 */
public class PdfUtil {

	private static final Log log = LogFactory.getLog(PdfUtil.class);// ?¥å?

	/**
	 * å¯¼å?PDF??¡£(??????æ³??°ç??????
	 * 
	 * @param ????¾ç¤º????????
	 *            ,???ä¸??å®???¾ç½®ç¬??javabeané£????±»???è±¡ã?

	 * @param pdfPath
	 *            å¯¼å?pdf??¡£è·??
	 */
	public static void exportPdf(String content, String pdfPath) {
		Document document = null;
		OutputStream out = null;
		try {
			// 1.å»ºç?com.lowagie.text.Documentå¯¹è±¡???ä¾?
			document = new Document();
			// 2.å»ºç?ä¸?¸ªä¹????Writer)ä¸?ocumentå¯¹è±¡?³è?ï¼??è¿?¹¦???(Writer)??»¥å°??æ¡£å??¥å?ç£??ä¸?
			out = new FileOutputStream(pdfPath);
			PdfWriter.getInstance(document, out);
			// 3.?????¡£
			document.open();
			// 4.???æ¡£ä¸­æ·»å????
			document.add(new Paragraph(content)); // ä¼?¸­??¹±??
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		} finally {
			document.close();// 5.?³é???¡£
			try {
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * å¯¼å?ä¸??è¯??pdf?°ç??????
	 * 
	 * @param para
	 * @param pdfPath
	 */
	public static void exportPdf(Paragraph para, String pdfPath,
			boolean vertical) {
		Document doc = null;
		OutputStream out = null;
		try {
			// 1.å»ºç?com.lowagie.text.Documentå¯¹è±¡???ä¾?
			doc = buildDoc(vertical);
			// 2.å»ºç?ä¸?¸ªä¹????Writer)ä¸?ocumentå¯¹è±¡?³è?ï¼??è¿?¹¦???(Writer)??»¥å°??æ¡£å??¥å?ç£??ä¸?
			out = new FileOutputStream(pdfPath);
			PdfWriter.getInstance(doc, out);
			// 3.?????¡£
			doc.open();
			// 4.???æ¡£ä¸­æ·»å????
			doc.add(para);

		} catch (Exception e) {
			e.printStackTrace();
			log.debug("???pdf?ºé?");
		} finally {
			close(doc, out);// 5.?³é?
		}
	}

	/**
	 * å¯¼å?PDF?°ç??????
	 * 
	 * @param doc
	 * @param element
	 * @param pdfPath
	 */
	public static void exportPdf(Document doc, Element element, String pdfPath) {
		OutputStream out = null;
		try {
			// 2.å»ºç?ä¸?¸ªä¹????Writer)ä¸?ocumentå¯¹è±¡?³è?ï¼??è¿?¹¦???(Writer)??»¥å°??æ¡£å??¥å?ç£??ä¸?
			out = new FileOutputStream(pdfPath);
			PdfWriter.getInstance(doc, out);
			// 3.?????¡£
			doc.open();
			// 4.???æ¡£ä¸­æ·»å????
			doc.add(element);
		} catch (Exception e) {
			e.printStackTrace();
			log.debug("???pdf?ºé?");
		} finally {
			close(doc, out);// 5.?³é?
		}
	}

	/**
	 * å¯¼å?pdf?°ç??????
	 * 
	 * @param doc
	 * @param pdfBean
	 */
	public static void exprotPdf(Document doc, PdfBean pdfBean) {
		OutputStream out = null;
		try {
			// 2.å»ºç?ä¸?¸ªä¹????Writer)ä¸?ocumentå¯¹è±¡?³è?ï¼??è¿?¹¦???(Writer)??»¥å°??æ¡£å??¥å?ç£??ä¸?
			out = new FileOutputStream(pdfBean.getFileName());
			PdfWriter writer = gerPdfWriter(doc, out);
			doc = setPdfProperty(doc, pdfBean); // è®¾ç½®å±??


			// ???å¤??
			if (pdfBean.isEncryptFlag()) {
				List permissionList = pdfBean.getPermissionList();
				if (permissionList != null && permissionList.size() > 0) {
					int allPermission = 0;
					for (Iterator it = permissionList.iterator(); it.hasNext();) {
						int permission = (Integer) it.next();
						allPermission = allPermission | permission; // ???è¿???¥ç´¯?????
					}
					writer = encrypt(writer, pdfBean.getUserPsw(), pdfBean
							.getOwnerPsw(), allPermission);
				}
			}
			// 3.?????¡£
			doc.open();

			// 4.???æ¡£ä¸­æ·»å????
			List elementList = pdfBean.getElementList();
			if (elementList != null && !elementList.isEmpty()) {
				for (Iterator it = elementList.iterator(); it.hasNext();) {
					Element element = (Element) it.next();
					doc.add(element);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.debug("???pdf?ºé?");
		} finally {
			close(doc, out);// 5.?³é?
		}
	}

	/**
	 * å¯¼å?pdf??rl*
	 * 
	 * @param doc
	 * @param pdfBean
	 */
	public static void exprotPdfToUrl(Document doc, PdfBean pdfBean,
			HttpServletResponse response) {
		ByteArrayOutputStream bao = null;
		ServletOutputStream out = null;
		try {
			// 2.å»ºç?ä¸?¸ªä¹????Writer)ä¸?ocumentå¯¹è±¡?³è?ï¼??è¿?¹¦???(Writer)??»¥å°??æ¡£å??¥å?ç£??ä¸?
			bao = new ByteArrayOutputStream();
			PdfWriter writer = gerPdfWriter(doc, bao);
			doc = setPdfProperty(doc, pdfBean); // è®¾ç½®å±??

			// ???å¤??
			if (pdfBean.isEncryptFlag()) {
				List permissionList = pdfBean.getPermissionList();
				if (permissionList != null && permissionList.size() > 0) {
					int allPermission = 0;
					for (Iterator it = permissionList.iterator(); it.hasNext();) {
						int permission = (Integer) it.next();
						allPermission = allPermission | permission; // ???è¿???¥ç´¯?????
					}
					writer = encrypt(writer, pdfBean.getUserPsw(), pdfBean
							.getOwnerPsw(), allPermission);
				}
			}
			// 3.?????¡£
			doc.open();
			// 4.???æ¡£ä¸­æ·»å????
			List elementList = pdfBean.getElementList();
			if (elementList != null && !elementList.isEmpty()) {
				for (Iterator it = elementList.iterator(); it.hasNext();) {
					Element element = (Element) it.next();
					doc.add(element);
				}
			}
			doc.close(); // ?³é?document

			// responseè®¾ç½®
			response.setContentType("application/pdf");

			/* =====æ·»å?ä¸??ä¸??ï¼???»æ?ç¤ºâ????ä¸ºâ?ï¼??????¥å?æµ???¨ä¸­??? start ===== */
			// response.setHeader("Content-Disposition",
			// "attachment;filename=\"temp.pdf\"");
			// response.setHeader("Cache-Control",
			// "must-revalidate, post-check=0, pre-check=0");
			// response.setHeader("Pragma", "public");
			// response.setDateHeader("Expires", (System.currentTimeMillis() +
			// 1000));
			/* ====æ·»å?ä¸??ä¸??ï¼???»æ?ç¤ºâ????ä¸ºâ?ï¼??????¥å?æµ???¨ä¸­??? end ====== */
			response.setContentLength(bao.size());
			out = response.getOutputStream();
			bao.writeTo(out);
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
			log.debug("é¡µé?è¾??pdf?ºé?");
		} finally {
			try {
				bao.close();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
	}

	/**
	 * ???PDFä¸????????ä½?
	 * 
	 * @param content
	 * @param font
	 * @return
	 */
	public static Chunk getChunk(String content, Font font) {
		Chunk chunk = new Chunk(content, font);
		return chunk;
	}
	
	/////
	public static Chunk getChunk(String content)
	{
		Font font = new Font();
		font.setSize(8);
		Chunk chunk = new Chunk(content,font);
		return chunk;
	}

	/**
	 * ???
	 * 
	 * @param content
	 * @param font
	 * @return
	 */
	public static Phrase getPhrase(String content, Font font) {
		Phrase phrase = new Phrase(content, font);
		return phrase;
	}

	/**
	 * è®¾ç½®å­??
	 * 
	 * @param content
	 * @param font
	 * @return
	 */
	public static Paragraph getPara(String content, Font font) {
		Paragraph para = new Paragraph(content, font);
		return para;
	}

	/**
	 * è®¾å????ï¼???¾æ?ï¼?
	 * 
	 * @param content
	 * @param font
	 * @param url
	 *            ,å¦?ttp://www.baidu.com ??? #aim
	 * @return
	 */
	public static Anchor getAnchor(String content, Font font, String url) {
		Anchor anchor = new Anchor(content, font);
		anchor.setReference(url);
		return anchor;
	}

	/**
	 * è®¾å???¡¨
	 * 
	 * @param list
	 *            ?°æ?
	 * @param numbered
	 *            true ?°å???¡¨ï¼?false ?¾æ???¡¨
	 * @param symbolIndent
	 *            ç¼©è? true-20 false-10
	 * @return
	 */
	public static com.lowagie.text.List getPdfList(List list, boolean numbered,
			float symbolIndent, Font font) {
		com.lowagie.text.List pdfList = new com.lowagie.text.List(numbered,
				symbolIndent);
		ListItem li = null;
		if (list != null && !list.isEmpty()) {
			for (Iterator it = list.iterator(); it.hasNext();) {
				li = new ListItem(it.next().toString(), font);
				pdfList.add(li);
			}
		}
		return pdfList;
	}

	/**
	 * è®¾å?æ³¨é?(ä»¥å?ä¸????¡¶?¹å????0,0)
	 * 
	 * @param title
	 *            ??§°
	 * @param text
	 *            ???
	 * @param x
	 *            lower left x pdfé¡µé?ï¼??ç«??è·?·¦è¾¹å?å°?xï¼?å¦?00ï¼?ï¼?, y)?¸å?äº??100ï¼?0ï¼?
	 * @param y
	 *            upper right y
	 * @return
	 */
	public static Annotation getAnnotation(String title, String text, float x,
			float y) {
		Annotation anno = new Annotation(title, text, x, 0f, 0f, y);
		return anno;
	}

	/**
	 * urlæ³¨é?(ä¸?¸ª?????rl?¾æ?ï¼?
	 * 
	 * @param url
	 * @param x
	 * @param y
	 * @return
	 */
	public static Annotation getAnnotationUrl(float llx, float lly, float urx,
			float ury, String url) {
		Annotation anno = new Annotation(llx, lly, urx, ury, url);
		return anno;
	}

	/**
	 * ???ç«??é¡µï?ï¼? Chapter is a special Section ï¼?»§?¿ä?Section å¤?ew ??¸ªï¼?°±??¡µ
	 * 
	 * @param content
	 * @param font
	 * @param numberDepth
	 * @return
	 */
	public static Chapter getChapter(String content, Font font, int numberDepth) {
		Paragraph p = getPara(content, font);
		Chapter chapter = new Chapter(p, numberDepth);
		return chapter;
	}

	/**
	 * ?ºå?(????¶ä??ºå?ï¼???½ï???¡¨ï¼?¡¨?¼ï? A Section is a part of a Document containing other
	 * Sections, Paragraphs, List and/or Tables
	 * 
	 * @param content
	 * @param font
	 * @param numberDepth
	 *            ï¼?³¨?¥ä¸º0, å°±ä??¾ç¤ºå±?º§??
	 * @return
	 */
	public static Section getSection(Chapter chapter, String content,
			Font font, int numberDepth) {
		Paragraph p = getPara(content, font);
		Section s = chapter.addSection(p, numberDepth);
		return s;
	}

	/**
	 * ?ºå?(????¶ä??ºå?ï¼???½ï???¡¨ï¼?¡¨?¼ï? A Section is a part of a Document containing other
	 * Sections, Paragraphs, List and/or Tables
	 * 
	 * @param content
	 * @param font
	 * @param numberDepth
	 *            ï¼?³¨?¥ä¸º0, å°±ä??¾ç¤ºå±?º§??
	 * @return
	 */
	public static Section getSection(Section section, String content,
			Font font, int numberDepth) {
		Paragraph p = getPara(content, font);
		Section s = section.addSection(p, numberDepth);
		return s;
	}

	/**
	 * è®¾ç½®?¾ç?å¯¹è±¡
	 * 
	 * @param imgPath
	 *            ?¾ç??©ç??°å?
	 * @param alignMent
	 *            å¯¹é??¹å? Image.RIGHT, MIDDLE, LEFT ,TEXTWRAP(???ï¼? UNDERLYING(???ï¼?
	 *            ??»¥???å¹¶å?ä¸?µ·???å¦?mage.RIGHT | Image.UNDERLYING
	 * @param absoluteX
	 *            æ¨????
	 * @param absoluteY
	 *            çºµå???
	 * @return
	 */
	public static Image getImage(String imgPath, int alignMent,
			float absoluteX, float absoluteY) {
		Image img = null;
		try {
			img = Image.getInstance(imgPath);// ????¾ç?å¯¹è±¡
			// è®¾ç½®ä¸??å­??é½??å¼?
			img.setAlignment(alignMent);// Image.RIGHT, MIDDLE, LEFT
			// ,TEXTWRAP(???ï¼? UNDERLYING(???ï¼?
			if (absoluteX != -1 && absoluteY != -1) {// ??, y???ç­??ï¼?
				img.setAbsolutePosition(absoluteX, absoluteY);// è®¾ç½®ç»??ä½?½®
			}
		} catch (Exception e) {
			log.debug("??»º?¾ç?å¯¹è±¡???");
			e.printStackTrace();
		}
		return img;
	}

	public static Table getTable() {
		Table table = null;
		try {
			table = new Table(4, 3);
			table.setAutoFillEmptyCells(true);// æ²¡æ????cellä¸ºç©º
			table.addCell("a1", new Point(2, 2));
			table.addCell("b1", new Point(4, 3));

		} catch (BadElementException e) {
			e.printStackTrace();
		}
		return table;
	}

	public static Table getTable(TableBean tableBean, Font thFont, Font bodyFont) {
		Table table = null;
		try {
			table = new Table(tableBean.getColumns()); // ???tableå¯¹è±¡
			table.setWidth(tableBean.getWidth()); // å®½åº¦
			table.setBorderWidth(tableBean.getBorderWidth()); // è¾¹æ?å®½åº¦
			table.setBorderColor(tableBean.getBorderColor()); // è¾¹æ?color
			table.setPadding(tableBean.getCellPadding()); // ????¼å?è¾¹è?
			table.setSpacing(tableBean.getCellSpacing()); // ????¼å?è¾¹è?
			table.setAlignment(tableBean.getAlignMent()); // tableå¯¹é??¹å?
			// å¢??è¡¨å¤´
			table = getTableTh(table, tableBean.getThList(), thFont);
			// å¢??è¡¨æ???
			table = getTableBody(table, tableBean.getBodyList(), bodyFont);
			table.setLastHeaderRow(2);// è®¾ç½®è·¨é¡µ?¶ï?è¡¨å¤´è¿??
		} catch (Exception e) {
			log.debug("???table???");
			e.printStackTrace();
		}
		return table;
	}

	/**
	 * å°??è¡¨å¤´th
	 * 
	 * @param table
	 * @param thList
	 * @param cnBoldFont
	 * @return
	 */
	public static Table getTableTh(Table table, List<String> thList,
			Font cnBoldFont) {
		Cell cell = null;
		try {
			if (thList != null && !thList.isEmpty()) {
				int i = 1;////
				for (Iterator it = thList.iterator(); it.hasNext();i++) {
					String thName = (String) it.next();
					Chunk thChunk = getChunk(thName, cnBoldFont);
					cell = new Cell(thChunk);
					if(i==1)
						cell.setColspan(2);
					cell.setHeader(true); // è®¾ä¸ºå¤´é?
					cell.setHorizontalAlignment(Cell.ALIGN_CENTER);// æ¨??è·?¸­
					cell.setVerticalAlignment(Cell.ALIGN_MIDDLE);
					cell.setBackgroundColor(new Color(239, 219, 150)); // ??? #EFDB96 ?????
					table.addCell(cell);
				}
			}
		} catch (Exception e) {
			log.debug("???è¡¨å¤´?ºé?");
			e.printStackTrace();
		}
		return table;
	}

	public static Table getTableBody(Table table, List<List> bodyList,
			Font cnFont) {
		Cell cell = null;
		try {
			if (bodyList != null && !bodyList.isEmpty()) {
				int i = 1;
				for (Iterator it = bodyList.iterator(); it.hasNext(); i++) {
					List rowList = (List) it.next();
					if (rowList != null && !rowList.isEmpty()) {
						int j = 1;
						for (Iterator it2 = rowList.iterator(); it2.hasNext();j++) {
							String cellContent = (String) it2.next();
							Paragraph tdPara = new Paragraph(cellContent,
									cnFont);
							cell = new Cell(tdPara);
							cell.setHorizontalAlignment(Cell.ALIGN_LEFT);// æ¨??å·?
							// cell.setVerticalAlignment(Cell.ALIGN_TOP);
							if(j==1)
								cell.setColspan(2);
							if (i % 2 == 0) {
								cell
										.setBackgroundColor(new Color(240, 240,
												240)); // ??? #F0F0F0
							}
							table.addCell(cell);
						}
					}
				}
			}
		} catch (Exception e) {
			log.debug("???è¡¨å¤´?ºé?");
			e.printStackTrace();
		}
		return table;
	}

	/**
	 * ??»ºdoc ,true ?????dfï¼?false???æ¨??pdf
	 * 
	 * @param vertical
	 * @return
	 */
	public static Document buildDoc(boolean vertical) {
		Document doc = null;
		if (vertical) {// ç«??ï¼??è®?
			doc = new Document();
		} else {// æ¨??
			doc = new Document(PageSize.A4.rotate());
		}
		return doc;
	}

	/**
	 * è®¾ç½®pdfå±??ä¿¡æ?ï¼??é¡»ç???dfwriterä¹??ï¼?
	 * 
	 * @param doc
	 * @param title
	 * @param subject
	 * @param author
	 * @param keywords
	 * @param creator
	 * @return
	 */
	public static Document setPdfProperty(Document doc, PdfBean pdfBean) {
		if (pdfBean.getTitle() != null) {
			doc.addTitle(pdfBean.getTitle()); // ???
		}
		if (pdfBean.getSubject() != null) {
			doc.addSubject(pdfBean.getSubject());// ä¸»é?
		}
		if (pdfBean.getAuthor() != null) {
			doc.addAuthor(pdfBean.getAuthor()); // ä½??

		}
		if (pdfBean.getKeywords() != null) {
			doc.addKeywords(pdfBean.getKeywords()); // ?³é?è¯?
		}
		if (pdfBean.getCreator() != null) {
			doc.addCreator(pdfBean.getCreator()); // ??»ºäº?
		}
		if (pdfBean.getTitle() != null) {
			doc.addTitle(pdfBean.getTitle()); // ???
		}
		Map headerMap = pdfBean.getHeaderMap();
		if (headerMap != null) {
			for (Iterator it = headerMap.entrySet().iterator(); it.hasNext();) {
				Object key = it.next();
				Object val = headerMap.get(key);
				doc.addHeader(key.toString(), val.toString());
			}
		}
		if (pdfBean.getHeader() != null) {// ?¥å¤´
			//Font font = ITextFontUtil.getCnBoldFont(20, Color.BLACK); // è®¾ç½®å­??
			
			Font font = ITextFontUtil.getCnFont(12, Color.red);////
			
			HeaderFooter header = new HeaderFooter(new Phrase(pdfBean
					.getHeader(), font), false); // falseè¡¨ç¤ºï¼?²¡??????å­??é¡µç?ï¼?
			header.setAlignment(Element.ALIGN_CENTER);// å±?¸­
			// header.setBorder(Rectangle.NO_BORDER);//è®¾ç½®è¾¹ç?å®½åº¦,é»????
			header.setBorderWidthTop(0);
			header.setBorderWidthBottom(0);
			doc.setHeader(header);
		}
		if (pdfBean.getFooter() != null) {// ?¥å°¾
			HeaderFooter footer = new HeaderFooter(new Phrase(pdfBean
					.getFooter()), true); // trueè¡¨ç¤ºï¼?????å­??é¡µç?ï¼?
			footer.setAlignment(Element.ALIGN_RIGHT);
			footer.setBorderWidthTop(0);/////
			footer.setBorderWidthBottom(0);/////
			doc.setFooter(footer);
		}
		return doc;
	}

	/**
	 * ???PdfWriter
	 * 
	 * @param doc
	 * @param out
	 * @return
	 */
	public static PdfWriter gerPdfWriter(Document doc, OutputStream out) {
		PdfWriter writer = null;
		try {
			writer = PdfWriter.getInstance(doc, out);
		} catch (DocumentException e) {
			log.debug("??»ºPdfWriterå¤±è´¥");
			e.printStackTrace();
		}
		return writer;
	}

	/**
	 * pdf???å¤??(bcprov-jdk15-139.jar ????¶ç???
	 * 
	 * @param writer
	 * @param userPsw
	 *            null??"ï¼?¡¨ç¤ºä??¨å???è¯»ï?
	 * @param ownerPsw
	 *            null??"ï¼?¡¨ç¤ºä??¨å???????
	 * @param permissions
	 *            ALLOW_SCREENREADERS ??? PdfWriter.ALLOW_COPY ???å¤??
	 *            PdfWriter.ALLOW_PRINTING ??????,?¶ä????PdfWriterå¸¸é?
	 * @return
	 */
	public static PdfWriter encrypt(PdfWriter writer, String userPsw,
			String ownerPsw, int permissions) {
		try {
			writer.setEncryption(PdfWriter.STANDARD_ENCRYPTION_128, userPsw,
					ownerPsw, permissions);
		} catch (DocumentException e) {
			log.debug("pdf??????");
			e.printStackTrace();
		}
		return writer;
	}

	/**
	 * ?³é?doc,è¾??pdf???
	 * 
	 * @param doc
	 * @param out
	 */
	public static void close(Document doc, OutputStream out) {
		try {
			doc.close();// ?³é???¡£
			out.close();
		} catch (IOException e) {
			log.debug("?³é?document????ºæ????");
			e.printStackTrace();
		}
	}

}
