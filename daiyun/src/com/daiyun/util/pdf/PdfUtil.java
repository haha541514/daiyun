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
 * @version ?�建???�?an 19, 2010 4:49:26 PM �????
 */
public class PdfUtil {

	private static final Log log = LogFactory.getLog(PdfUtil.class);// ?��?

	/**
	 * 导�?PDF??��(??????�??��??????
	 * 
	 * @param ????�示????????
	 *            ,???�??�???�置�??javabean�????��???象�?

	 * @param pdfPath
	 *            导�?pdf??���??
	 */
	public static void exportPdf(String content, String pdfPath) {
		Document document = null;
		OutputStream out = null;
		try {
			// 1.建�?com.lowagie.text.Document对象???�?
			document = new Document();
			// 2.建�?�?���????Writer)�?ocument对象?��?�??�?��???(Writer)??���??档�??��?�??�?
			out = new FileOutputStream(pdfPath);
			PdfWriter.getInstance(document, out);
			// 3.?????��
			document.open();
			// 4.???档中添�????
			document.add(new Paragraph(content)); // �?��??��??
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		} finally {
			document.close();// 5.?��???��
			try {
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 导�?�??�??pdf?��??????
	 * 
	 * @param para
	 * @param pdfPath
	 */
	public static void exportPdf(Paragraph para, String pdfPath,
			boolean vertical) {
		Document doc = null;
		OutputStream out = null;
		try {
			// 1.建�?com.lowagie.text.Document对象???�?
			doc = buildDoc(vertical);
			// 2.建�?�?���????Writer)�?ocument对象?��?�??�?��???(Writer)??���??档�??��?�??�?
			out = new FileOutputStream(pdfPath);
			PdfWriter.getInstance(doc, out);
			// 3.?????��
			doc.open();
			// 4.???档中添�????
			doc.add(para);

		} catch (Exception e) {
			e.printStackTrace();
			log.debug("???pdf?��?");
		} finally {
			close(doc, out);// 5.?��?
		}
	}

	/**
	 * 导�?PDF?��??????
	 * 
	 * @param doc
	 * @param element
	 * @param pdfPath
	 */
	public static void exportPdf(Document doc, Element element, String pdfPath) {
		OutputStream out = null;
		try {
			// 2.建�?�?���????Writer)�?ocument对象?��?�??�?��???(Writer)??���??档�??��?�??�?
			out = new FileOutputStream(pdfPath);
			PdfWriter.getInstance(doc, out);
			// 3.?????��
			doc.open();
			// 4.???档中添�????
			doc.add(element);
		} catch (Exception e) {
			e.printStackTrace();
			log.debug("???pdf?��?");
		} finally {
			close(doc, out);// 5.?��?
		}
	}

	/**
	 * 导�?pdf?��??????
	 * 
	 * @param doc
	 * @param pdfBean
	 */
	public static void exprotPdf(Document doc, PdfBean pdfBean) {
		OutputStream out = null;
		try {
			// 2.建�?�?���????Writer)�?ocument对象?��?�??�?��???(Writer)??���??档�??��?�??�?
			out = new FileOutputStream(pdfBean.getFileName());
			PdfWriter writer = gerPdfWriter(doc, out);
			doc = setPdfProperty(doc, pdfBean); // 设置�??


			// ???�??
			if (pdfBean.isEncryptFlag()) {
				List permissionList = pdfBean.getPermissionList();
				if (permissionList != null && permissionList.size() > 0) {
					int allPermission = 0;
					for (Iterator it = permissionList.iterator(); it.hasNext();) {
						int permission = (Integer) it.next();
						allPermission = allPermission | permission; // ???�???�累?????
					}
					writer = encrypt(writer, pdfBean.getUserPsw(), pdfBean
							.getOwnerPsw(), allPermission);
				}
			}
			// 3.?????��
			doc.open();

			// 4.???档中添�????
			List elementList = pdfBean.getElementList();
			if (elementList != null && !elementList.isEmpty()) {
				for (Iterator it = elementList.iterator(); it.hasNext();) {
					Element element = (Element) it.next();
					doc.add(element);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.debug("???pdf?��?");
		} finally {
			close(doc, out);// 5.?��?
		}
	}

	/**
	 * 导�?pdf??rl*
	 * 
	 * @param doc
	 * @param pdfBean
	 */
	public static void exprotPdfToUrl(Document doc, PdfBean pdfBean,
			HttpServletResponse response) {
		ByteArrayOutputStream bao = null;
		ServletOutputStream out = null;
		try {
			// 2.建�?�?���????Writer)�?ocument对象?��?�??�?��???(Writer)??���??档�??��?�??�?
			bao = new ByteArrayOutputStream();
			PdfWriter writer = gerPdfWriter(doc, bao);
			doc = setPdfProperty(doc, pdfBean); // 设置�??

			// ???�??
			if (pdfBean.isEncryptFlag()) {
				List permissionList = pdfBean.getPermissionList();
				if (permissionList != null && permissionList.size() > 0) {
					int allPermission = 0;
					for (Iterator it = permissionList.iterator(); it.hasNext();) {
						int permission = (Integer) it.next();
						allPermission = allPermission | permission; // ???�???�累?????
					}
					writer = encrypt(writer, pdfBean.getUserPsw(), pdfBean
							.getOwnerPsw(), allPermission);
				}
			}
			// 3.?????��
			doc.open();
			// 4.???档中添�????
			List elementList = pdfBean.getElementList();
			if (elementList != null && !elementList.isEmpty()) {
				for (Iterator it = elementList.iterator(); it.hasNext();) {
					Element element = (Element) it.next();
					doc.add(element);
				}
			}
			doc.close(); // ?��?document

			// response设置
			response.setContentType("application/pdf");

			/* =====添�?�??�??�???��?示�????为�?�??????��?�???�中??? start ===== */
			// response.setHeader("Content-Disposition",
			// "attachment;filename=\"temp.pdf\"");
			// response.setHeader("Cache-Control",
			// "must-revalidate, post-check=0, pre-check=0");
			// response.setHeader("Pragma", "public");
			// response.setDateHeader("Expires", (System.currentTimeMillis() +
			// 1000));
			/* ====添�?�??�??�???��?示�????为�?�??????��?�???�中??? end ====== */
			response.setContentLength(bao.size());
			out = response.getOutputStream();
			bao.writeTo(out);
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
			log.debug("页�?�??pdf?��?");
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
	 * ???PDF�????????�?
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
	 * 设置�??
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
	 * 设�????�???��?�?
	 * 
	 * @param content
	 * @param font
	 * @param url
	 *            ,�?ttp://www.baidu.com ??? #aim
	 * @return
	 */
	public static Anchor getAnchor(String content, Font font, String url) {
		Anchor anchor = new Anchor(content, font);
		anchor.setReference(url);
		return anchor;
	}

	/**
	 * 设�???��
	 * 
	 * @param list
	 *            ?��?
	 * @param numbered
	 *            true ?��???���?false ?��???��
	 * @param symbolIndent
	 *            缩�? true-20 false-10
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
	 * 设�?注�?(以�?�????��?��????0,0)
	 * 
	 * @param title
	 *            ??��
	 * @param text
	 *            ???
	 * @param x
	 *            lower left x pdf页�?�??�??�?��边�?�?x�?�?00�?�?, y)?��?�??100�?0�?
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
	 * url注�?(�?��?????rl?��?�?
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
	 * ???�??页�?�? Chapter is a special Section �?��?��?Section �?ew ??���?��??��
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
	 * ?��?(????��??��?�???��???���?��?��? A Section is a part of a Document containing other
	 * Sections, Paragraphs, List and/or Tables
	 * 
	 * @param content
	 * @param font
	 * @param numberDepth
	 *            �?��?�为0, 就�??�示�?��??
	 * @return
	 */
	public static Section getSection(Chapter chapter, String content,
			Font font, int numberDepth) {
		Paragraph p = getPara(content, font);
		Section s = chapter.addSection(p, numberDepth);
		return s;
	}

	/**
	 * ?��?(????��??��?�???��???���?��?��? A Section is a part of a Document containing other
	 * Sections, Paragraphs, List and/or Tables
	 * 
	 * @param content
	 * @param font
	 * @param numberDepth
	 *            �?��?�为0, 就�??�示�?��??
	 * @return
	 */
	public static Section getSection(Section section, String content,
			Font font, int numberDepth) {
		Paragraph p = getPara(content, font);
		Section s = section.addSection(p, numberDepth);
		return s;
	}

	/**
	 * 设置?��?对象
	 * 
	 * @param imgPath
	 *            ?��??��??��?
	 * @param alignMent
	 *            对�??��? Image.RIGHT, MIDDLE, LEFT ,TEXTWRAP(???�? UNDERLYING(???�?
	 *            ??��???并�?�?��???�?mage.RIGHT | Image.UNDERLYING
	 * @param absoluteX
	 *            �????
	 * @param absoluteY
	 *            纵�???
	 * @return
	 */
	public static Image getImage(String imgPath, int alignMent,
			float absoluteX, float absoluteY) {
		Image img = null;
		try {
			img = Image.getInstance(imgPath);// ????��?对象
			// 设置�??�??�??�?
			img.setAlignment(alignMent);// Image.RIGHT, MIDDLE, LEFT
			// ,TEXTWRAP(???�? UNDERLYING(???�?
			if (absoluteX != -1 && absoluteY != -1) {// ??, y???�??�?
				img.setAbsolutePosition(absoluteX, absoluteY);// 设置�??�?��
			}
		} catch (Exception e) {
			log.debug("??��?��?对象???");
			e.printStackTrace();
		}
		return img;
	}

	public static Table getTable() {
		Table table = null;
		try {
			table = new Table(4, 3);
			table.setAutoFillEmptyCells(true);// 没�????cell为空
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
			table = new Table(tableBean.getColumns()); // ???table对象
			table.setWidth(tableBean.getWidth()); // 宽度
			table.setBorderWidth(tableBean.getBorderWidth()); // 边�?宽度
			table.setBorderColor(tableBean.getBorderColor()); // 边�?color
			table.setPadding(tableBean.getCellPadding()); // ????��?边�?
			table.setSpacing(tableBean.getCellSpacing()); // ????��?边�?
			table.setAlignment(tableBean.getAlignMent()); // table对�??��?
			// �??表头
			table = getTableTh(table, tableBean.getThList(), thFont);
			// �??表�???
			table = getTableBody(table, tableBean.getBodyList(), bodyFont);
			table.setLastHeaderRow(2);// 设置跨页?��?表头�??
		} catch (Exception e) {
			log.debug("???table???");
			e.printStackTrace();
		}
		return table;
	}

	/**
	 * �??表头th
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
					cell.setHeader(true); // 设为头�?
					cell.setHorizontalAlignment(Cell.ALIGN_CENTER);// �??�?��
					cell.setVerticalAlignment(Cell.ALIGN_MIDDLE);
					cell.setBackgroundColor(new Color(239, 219, 150)); // ??? #EFDB96 ?????
					table.addCell(cell);
				}
			}
		} catch (Exception e) {
			log.debug("???表头?��?");
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
							cell.setHorizontalAlignment(Cell.ALIGN_LEFT);// �??�?
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
			log.debug("???表头?��?");
			e.printStackTrace();
		}
		return table;
	}

	/**
	 * ??��doc ,true ?????df�?false???�??pdf
	 * 
	 * @param vertical
	 * @return
	 */
	public static Document buildDoc(boolean vertical) {
		Document doc = null;
		if (vertical) {// �??�??�?
			doc = new Document();
		} else {// �??
			doc = new Document(PageSize.A4.rotate());
		}
		return doc;
	}

	/**
	 * 设置pdf�??信�?�??须�???dfwriter�??�?
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
			doc.addSubject(pdfBean.getSubject());// 主�?
		}
		if (pdfBean.getAuthor() != null) {
			doc.addAuthor(pdfBean.getAuthor()); // �??

		}
		if (pdfBean.getKeywords() != null) {
			doc.addKeywords(pdfBean.getKeywords()); // ?��?�?
		}
		if (pdfBean.getCreator() != null) {
			doc.addCreator(pdfBean.getCreator()); // ??���?
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
		if (pdfBean.getHeader() != null) {// ?�头
			//Font font = ITextFontUtil.getCnBoldFont(20, Color.BLACK); // 设置�??
			
			Font font = ITextFontUtil.getCnFont(12, Color.red);////
			
			HeaderFooter header = new HeaderFooter(new Phrase(pdfBean
					.getHeader(), font), false); // false表示�?��??????�??页�?�?
			header.setAlignment(Element.ALIGN_CENTER);// �?��
			// header.setBorder(Rectangle.NO_BORDER);//设置边�?宽度,�????
			header.setBorderWidthTop(0);
			header.setBorderWidthBottom(0);
			doc.setHeader(header);
		}
		if (pdfBean.getFooter() != null) {// ?�尾
			HeaderFooter footer = new HeaderFooter(new Phrase(pdfBean
					.getFooter()), true); // true表示�?????�??页�?�?
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
			log.debug("??��PdfWriter失败");
			e.printStackTrace();
		}
		return writer;
	}

	/**
	 * pdf???�??(bcprov-jdk15-139.jar ????��???
	 * 
	 * @param writer
	 * @param userPsw
	 *            null??"�?��示�??��???读�?
	 * @param ownerPsw
	 *            null??"�?��示�??��???????
	 * @param permissions
	 *            ALLOW_SCREENREADERS ??? PdfWriter.ALLOW_COPY ???�??
	 *            PdfWriter.ALLOW_PRINTING ??????,?��????PdfWriter常�?
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
	 * ?��?doc,�??pdf???
	 * 
	 * @param doc
	 * @param out
	 */
	public static void close(Document doc, OutputStream out) {
		try {
			doc.close();// ?��???��
			out.close();
		} catch (IOException e) {
			log.debug("?��?document????��????");
			e.printStackTrace();
		}
	}

}
