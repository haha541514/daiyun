package com.daiyun.dax;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.DateUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.operation.cargoinfo.da.CargoinfoColumns;
import kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand;
import kyle.leis.eo.operation.corewaybill.blx.CoreWaybillPrintThread;
import kyle.leis.eo.operation.housewaybill.da.HousewaybillColumns;
import kyle.leis.eo.operation.housewaybill.da.LabeldataColumns;
import kyle.leis.eo.operation.housewaybill.da.LabeldataCondition;
import kyle.leis.eo.operation.housewaybill.da.LabeldataQuery;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictColumns;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictCondition;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictQuery;
import kyle.leis.eo.operation.housewaybill.dax.HousewaybillDemand;
import kyle.leis.eo.operation.housewaybill.dax.WaybillforpredictQueryEX;
import kyle.leis.es.company.channel.da.ChannelColumns;
import kyle.leis.es.company.channel.da.ChanneladdressColumns;
import kyle.leis.es.company.channel.da.ChanneladdressQuery;
import kyle.leis.es.company.channel.dax.ChannelDemand;
import kyle.leis.es.price.zone.dax.ZoneDemand;
import kyle.leis.es.systemproperty.dax.SystempropertyDemand;
import kyle.leis.fs.authoritys.user.bl.User;
import kyle.leis.fs.authoritys.user.da.UserColumns;
import kyle.leis.fs.dictionary.dictionarys.da.TchnChannelDC;
import kyle.leis.hi.TchnChannel;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.util.JRLoader;

import com.daiyun.util.StrUtil;
import com.daiyun.util.pdf.BarcodeUtil;
import com.dhl.sop.label.LabelReportHandler;
import com.lowagie.text.Document;
import com.lowagie.text.pdf.PdfCopy;
import com.lowagie.text.pdf.PdfImportedPage;
import com.lowagie.text.pdf.PdfReader;

public class PrintPDFLableServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String strUsername = req.getParameter("username");
		String strPassword = req.getParameter("password");
		if (!StringUtility.isNull(strUsername)
				&& !StringUtility.isNull(strPassword)) {
			User objUser = new User();
			UserColumns objULReturn = objUser.login(strUsername, strPassword);
			if (objULReturn != null) {
				req.getSession().setAttribute("OpId", objULReturn.getOpopid());
				process(req, resp, getServletConfig());
				return;
			} else {
				resp.setContentType("text/html;charset=utf8");
				PrintWriter pw = resp.getWriter();
				pw.write("<script>alert('你的权限不够！请联系客服取得权限！');</script>");
				pw.close();
				return;
			}
		}

		if (StringUtility.isNull(strUsername)) {
			String strUserName = (String) req.getSession().getAttribute("OpId");
			if (!StringUtility.isNull(strUserName)) {
				process(req, resp, getServletConfig());
					return;
				
			}
			String cwcodes = req.getParameter("cwcode");
			if (!StringUtility.isNull(cwcodes)) {
				 process(req, resp, getServletConfig());
				 return;
			
			}
			String serverewbcodes = req.getParameter("serverewbcode");
			if (!StringUtility.isNull(serverewbcodes)
					&& serverewbcodes.indexOf(">") > 0) {
				req.getSession().setAttribute("OpId", "0");
				serverewbcodes = serverewbcodes.substring(serverewbcodes
						.indexOf(">")+1);
				serverewbcodes = serverewbcodes.substring(0,serverewbcodes
						.indexOf("<"));
				//req.getSession().setAttribute("iserverewbcode", serverewbcodes);
				//Servlet方法间的通信都要靠Session
				
				System.out.println("xxxx---" + serverewbcodes);
				
				process(req, resp, getServletConfig(), serverewbcodes);
				return;
			}
			System.out.println("yyyy---" + serverewbcodes);
		}
		resp.setContentType("text/html;charset=utf8");
		PrintWriter pw = resp.getWriter();
		pw.write("<script>alert('你未登陆！请登陆后再试!');</script>");
		pw.close();
	}

	public void printInfo(HttpServletResponse resp, String strInfo,
			String serverewbCode) {
		ServletOutputStream sos = null;
		OutputStreamWriter ow = null;
		try {
			sos = resp.getOutputStream();
			ow = new OutputStreamWriter(sos, "utf-8");
			resp.setContentType("text/html;charset=utf-8");
			ow.write(strInfo + serverewbCode);
			ow.flush();
			ow.close();
			sos.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public String process(HttpServletRequest req, HttpServletResponse resp,
			ServletConfig sconfig) throws IOException {
		return process(req, resp, sconfig, "");
	}
	/**
	 * 生成PDF
	 * 
	 * @throws IOException
	 */
	@SuppressWarnings("deprecation")
	public String process(HttpServletRequest req, HttpServletResponse resp,
			ServletConfig sconfig,
			String serverewbcodes) throws IOException {
		try {
			String cwcodes = req.getParameter("cwcode");
		
			if (req.getSession().getAttribute("iserverewbcode") != null)
				serverewbcodes = (String) req.getSession().getAttribute(
						"iserverewbcode");
			if (StringUtility.isNull(serverewbcodes))
				serverewbcodes = req.getParameter("serverewbcode");

			String isNewV = req.getParameter("isnewv");
			String opId = (String) req.getSession().getAttribute("OpId");
			String strcode[] = null;
			if (!StringUtility.isNull(cwcodes)) {
				strcode = cwcodes.replaceAll("%20", "").split(",");
			} else if (!StringUtility.isNull(serverewbcodes)) {
				strcode = serverewbcodes.replaceAll("%20", "").split(",");
			}
			JasperReport jasperReport = null;
			JasperPrint jasperPrint = new JasperPrint();
			String[] astrCwcode = null;
			WaybillforpredictColumns[] awayBills = null;
			String pdfFilePath = sconfig.getServletContext().getRealPath(
					"/PDFFile");//D:\tomcat\Apache Software Foundation\Tomcat 6.0\webapps\baiqian\PDFFile
			String[] pdfNames = null;
			StringBuffer errorServerewbCode = new StringBuffer();
			if (!StringUtility.isNull(cwcodes)) {
				astrCwcode = new String[strcode.length];
				awayBills = new WaybillforpredictColumns[strcode.length];
				pdfNames = new String[strcode.length];
				for (int i = 0; i < strcode.length; i++) {
					WaybillforpredictColumns wayBills = HousewaybillDemand.loadForPredict(strcode[i]);
					astrCwcode[i] = wayBills.getCwcw_code();
					awayBills[i] = wayBills;
				}
			} else if (!StringUtility.isNull(serverewbcodes)) {//serverewbcodes,传的是服务商单号才会去判断日期是否超出了打印日期
				astrCwcode = new String[strcode.length];
				awayBills = new WaybillforpredictColumns[strcode.length];
				pdfNames = new String[strcode.length];
				for (int i = 0; i < strcode.length; i++) {
					WaybillforpredictCondition objWFPCondition = new WaybillforpredictCondition();
					objWFPCondition.setCwserverewbcode(strcode[i]);
					// 只查询前10天的运单防止服务商运单重号
					objWFPCondition.setStartcreatedate(DateUtility
							.getMoveDate(-10));
					WaybillforpredictQuery objWFPQuery = new WaybillforpredictQueryEX();
					objWFPQuery.setCondition(objWFPCondition);
					List list = objWFPQuery.getResults();
					if (list == null || list.size() < 1) {
						printInfo(resp,
								"<script>alert('打印失败，不存在此运单或者超出了打印的日期范围!",
								errorServerewbCode.append("单号:").append(
										strcode[i]).append("');</script>")
										.toString());
						return "";
					}
					WaybillforpredictColumns wayBills = (WaybillforpredictColumns) list
							.get(0);
					astrCwcode[i] = wayBills.getCwcw_code();
					awayBills[i] = wayBills;
				}
			}
			if (awayBills == null || awayBills.length < 1) {
				printInfo(resp, "<script>alert('打印失败，没有需要打印的数据!');</script>",
						"");
				return "";
			}
			boolean isPrintTrack = false;
			for (int i = 0; i < awayBills.length; i++) {
				WaybillforpredictColumns wayBills = awayBills[i];
				String strLabelURL = "";

				if (!StringUtility.isNull(wayBills.getHwhw_remark())
						&& wayBills.getHwhw_remark().indexOf("Label:") >= 0) {
					strLabelURL = wayBills.getHwhw_remark().substring(
							wayBills.getHwhw_remark().lastIndexOf("Label:")
									+ "Label:".length());
				}
				// 直接通过网站打印
				if (!StringUtility.isNull(strLabelURL)) {
					addTrack(astrCwcode, opId, awayBills);
					//printInfo(resp, strLabelURL, "");//这里有out.flush();导致跳转不了,页面上显示的是地址
					resp.sendRedirect(strLabelURL);
					return strLabelURL;
				}
				boolean isNeedPrintStandard = false;
				// DHL的
				ChannelColumns channelColumns = ChannelDemand.load(wayBills
						.getChnchn_code(), true);
				if ((!StringUtility.isNull(channelColumns.getSsgssgcode()))
						&& channelColumns.getSsgssgcode().startsWith("DHL")
						&& !"DHL-USGlobeMail".equals(channelColumns
								.getSsgssgcode())) {
					// DHL的必须要换单
					HousewaybillColumns objHWColumns = HousewaybillDemand.loadByCwcode(wayBills.getCwcw_code());
					
					
					
					String strCtcode = objHWColumns.getCctctcode();
					// 直客和代理客户不再允许打印DHL的标签而是打印标准格式的标签
					if (!"DC".equals(strCtcode) && !"AG".equals(strCtcode)) {
						if ("Y".equals(objHWColumns.getHwhwserverewbchangedsign())) {
							String resultRUL = printDHL(wayBills, resp);
							if (StringUtility.isNull(resultRUL)) {
								printInfo(resp, "<script>alert('打印失败!",
										errorServerewbCode.append("单号:").append(
												wayBills.getCwcw_customerewbcode())
												.append("');</script>").toString());
								return "";
							} else if (resultRUL.startsWith("E_")) {
								printInfo(resp, "<script>alert('打印失败!'"
										+ resultRUL.substring(2),
										errorServerewbCode.append("单号:").append(
												wayBills.getCwcw_customerewbcode())
												.append("');</script>").toString());
								return "";
							} else {
								addTrack(astrCwcode, opId, awayBills);
								return resultRUL;
							}
						} else {
							printInfo(resp, "<script>alert('打印失败，DHL标签打印需要先换单!",
									errorServerewbCode.append("单号:").append(
											wayBills.getCwcw_customerewbcode())
											.append("');</script>").toString());
							return "";
						}
					}
					isNeedPrintStandard = true;
				}
				// 其他我们自己定义的标签格式
				String customerlabel = wayBills.getChnchn_customerlabel();
				//customerlabel="C_SZEUB";//测试
				// 打印标准格式
				if (isNeedPrintStandard)
					customerlabel = "C_OTS";
				String[] dgmPdfNames = new String[2];
				List<DataSourceTopdf> listDSTPDF = list2bean(wayBills, req);
				// DGM格式默认需要打印4*4的标签
				if (StringUtility.isNull(isNewV)//
						&& ("C_DGMP".equals(customerlabel) || "C_DGMG"
								.equals(customerlabel) || "C_DGMPY"	//C_DGMPY 泽西邮政平邮
								.equals(customerlabel))) {
					for (int j = 1; j < 3; j++) {
						String name = "";
						if ("C_DGMP".equals(customerlabel) || "C_DGMPY"
								.endsWith(customerlabel)){
							if (j == 1) {
								name = "/jasp/DGMP_V1.jasper";
							} else if (j == 2) {
								if ("RU".endsWith(wayBills.getDtdt_hubcode())
										|| "BY".endsWith(wayBills
												.getDtdt_hubcode())) {
									name = "/jasp/DGMP_V2_RU.jasper";
								} else if ("GR".endsWith(wayBills
										.getDtdt_hubcode())) {
									name = "/jasp/DGMP_V2_GR.jasper";
								}  else if ("IT".endsWith(wayBills
										.getDtdt_hubcode())) {
									name = "/jasp/DGMP_V2_IT.jasper";
								}  else if ("IL".endsWith(wayBills
										.getDtdt_hubcode())) {
									name = "/jasp/DGMP_V2_IL.jasper";
								}else if("TH".endsWith(wayBills
										.getDtdt_hubcode())){
									name = "/jasp/DGMP_V2_TH.jasper";
								} else {
									name = "/jasp/DGMP_V2.jasper";
								}
							}
						} else {
							if (j == 1) {
								name = "/jasp/DGMG_V1.jasper";
							} else if (j == 2) {
								if ("RU".endsWith(wayBills.getDtdt_hubcode())
										|| "BY".endsWith(wayBills
												.getDtdt_hubcode())) {
									name = "/jasp/DGMG_V2_RU.jasper";
								} else if ("GR".endsWith(wayBills
										.getDtdt_hubcode())) {
									name = "/jasp/DGMG_V2_GR.jasper";
								} else if ("US".endsWith(wayBills
										.getDtdt_hubcode())) {
									name = "/jasp/DGMG_V2_US.jasper";
								} else if ("IL".endsWith(wayBills
										.getDtdt_hubcode())) {
									name = "/jasp/DGMG_V2_IL.jasper";
								}else if("TH".endsWith(wayBills
										.getDtdt_hubcode())){
									name = "/jasp/DGMG_V2_TH.jasper";
								} else {
									name = "/jasp/DGMG_V2.jasper";
								}
							}
						}
						File objFile = new File(sconfig.getServletContext()
								.getRealPath(name));//获取路径
						if (objFile == null)
							continue;
						//load编译好的模板
						jasperReport = (JasperReport) JRLoader
								.loadObject(objFile.getPath());//读取报表模板文件
						//进行数据填充
						jasperPrint = JasperFillManager.fillReport( 	
								jasperReport, null,
								new JRBeanCollectionDataSource(listDSTPDF));
						
						String pdfFileName = pdfFilePath + File.separator
								+ wayBills.getCwcw_serverewbcode() + j + ".pdf";
						File tmpFile = new File(pdfFileName);
						if (tmpFile.exists()) {
							tmpFile.delete();
						}
						//导出
						JasperExportManager.exportReportToPdfFile(jasperPrint,
								pdfFileName);
						dgmPdfNames[j - 1] = wayBills.getCwcw_serverewbcode()
								+ j + ".pdf";
					}
					//合并PDF
					String dgmPdf = pdfMerger(dgmPdfNames, pdfFilePath);
					pdfNames[i] = dgmPdf;
					isPrintTrack = true;
				} else if("C_SZEUB".equals(customerlabel)||"C_JNEUB".equals(customerlabel)){//e邮宝，支持一票打印两个页面
						String hubcode=wayBills.getDtdt_hubcode();
						//hubcode="AT";
						for (int j = 1; j < 3; j++) {
							String name = "";
							if (j == 1) {
								if ("US".equals(hubcode)) {
									name = "/jasp/SZEYB_USV1.jasper";
								} else if ("GB".equals(hubcode)) {
									name = "/jasp/SZEYB_GBV1.jasper";
								} else if ("FR".equals(hubcode) || "DE".equals(hubcode)) {
									name = "/jasp/SZEYB_FRDEV1.jasper";
								} else {
									name ="/jasp/SZEYB_AUCARUV1.jasper";
								}

							} else if (j == 2) {
								if ("US".equals(hubcode) || "CA".equals(hubcode)
										|| "RU".equals(hubcode) || "AU".equals(hubcode)) {
									name = "/jasp/SZEYB2_V2.jasper";
								} else {
									name = "/jasp/SZEYB_V2.jasper";
								}
							}
							File objFile = new File(sconfig.getServletContext()
									.getRealPath(name));//获取路径
							if (objFile == null)
								continue;
							//load编译好的模板
							jasperReport = (JasperReport) JRLoader
									.loadObject(objFile.getPath());//读取报表模板文件
							//进行数据填充
							jasperPrint = JasperFillManager.fillReport( 	
									jasperReport, null,
									new JRBeanCollectionDataSource(listDSTPDF));
							
							String pdfFileName = pdfFilePath + File.separator
									+ wayBills.getCwcw_serverewbcode() + j + ".pdf";
							File tmpFile = new File(pdfFileName);
							if (tmpFile.exists()) {
								tmpFile.delete();
							}
							//导出
							JasperExportManager.exportReportToPdfFile(jasperPrint,
									pdfFileName);
							dgmPdfNames[j - 1] = wayBills.getCwcw_serverewbcode()
									+ j + ".pdf";
						}
						//合并PDF
						String dgmPdf = pdfMerger(dgmPdfNames, pdfFilePath);
						pdfNames[i] = dgmPdf;
						isPrintTrack = true;
					
				}else {//读取PDF文件
					File objFile = readPDFfile(sconfig.getServletContext(),
							customerlabel, wayBills.getDtdt_hubcode());
					if (objFile == null)
						continue;
					jasperReport = (JasperReport) JRLoader.loadObject(objFile
						.getPath());	
					jasperPrint = JasperFillManager.fillReport(jasperReport,
							null, new JRBeanCollectionDataSource(listDSTPDF));
					String pdfFileName = pdfFilePath + File.separator
							+ wayBills.getCwcw_serverewbcode() + ".pdf";
					File tmpFile = new File(pdfFileName);
					if (tmpFile.exists()) {
						tmpFile.delete();
					}
					JasperExportManager.exportReportToPdfFile(jasperPrint,
							pdfFileName);//D:\tomcat\Apache Software Foundation\Tomcat 6.0\webapps\baiqian\PDFFile\20161018D3A1.pdf
					pdfNames[i] = wayBills.getCwcw_serverewbcode() + ".pdf";
					isPrintTrack = true;
				}
			}
			if (isPrintTrack) {//增加轨迹
				addTrack(astrCwcode, opId, awayBills);
				String pdfAllName = pdfMerger(pdfNames, pdfFilePath);
				String returnUrl = req.getScheme() + "://"
						+ req.getServerName() + ":" + req.getServerPort()
						+ req.getContextPath() + "/PDFFile/" + pdfAllName;
				resp.sendRedirect(returnUrl);
				return returnUrl;
			}
			
			
			printInfo(resp, "<script>alert('打印失败!');</script>", "");
			return "";
		} catch (Exception e) {
			e.printStackTrace();
			printInfo(resp, "<script>alert('打印失败!');</script>", "");
			return "";
		} finally {
			if (resp.getOutputStream() != null) {
				resp.getOutputStream().close();
			}
			resp.flushBuffer();
		}
	}

	@SuppressWarnings("unchecked")
	public static List<ChanneladdressColumns> queryChannelList(String cwcode)
			throws Exception {
		ChanneladdressQuery query = new ChanneladdressQuery();
		query.setChncode(HousewaybillDemand.loadForPredict(cwcode)
				.getChnchn_code());
		List<ChanneladdressColumns> list = query.getResults();
		return list;
	}

	@SuppressWarnings("unchecked")
	public static LabeldataColumns getLabeldataColumns(
			WaybillforpredictColumns wayBills) throws Exception {
		if (!StringUtility.isNull(wayBills.getChnchn_customerlabel())
				&& "C_SDHLGM".equals(wayBills.getChnchn_customerlabel())) {
			LabeldataCondition l = new LabeldataCondition();
			if (Double.parseDouble(wayBills.getCwcw_customerchargeweight()) <= 0.17007165) {
				l.setProducts("82");
				l.setMtype("2");
			} else if (Double.parseDouble(wayBills
					.getCwcw_customerchargeweight()) > 0.1701
					&& Double.parseDouble(wayBills
							.getCwcw_customerchargeweight()) <= 0.45357165) {
				l.setProducts("82");
				l.setMtype("3");
			} else if (Double.parseDouble(wayBills
					.getCwcw_customerchargeweight()) > 0.4536) {
				l.setProducts("83");
				l.setMtype("7");
			}
			l.setCode(wayBills.getHwhw_consigneepostcode());
			LabeldataQuery la = new LabeldataQuery();
			la.setCondition(l);
			List<LabeldataColumns> ls = la.getResults();
			if (ls != null && ls.size() != 0)
				return ls.get(0);
		}
		return null;
	}

	// 赋值
	@SuppressWarnings("unchecked")
	public static List<DataSourceTopdf> list2bean(
			WaybillforpredictColumns wayBills, HttpServletRequest req)
			throws Exception {
		List<CargoinfoColumns> cargoList = CargoInfoDemand
				.queryAndweightByCwCode(wayBills.getCwcw_code(), wayBills
						.getCwcw_customerchargeweight());
		ChanneladdressColumns objChanneladdressColumns = ChannelDemand
				.loadChanneladdress(wayBills.getChnchn_customerlabel());
		String str1 = CargoInfoDemand.getDescription(wayBills.getCwcw_code());
		String str2 = "";
		
		String customerlabel = wayBills.getChnchn_customerlabel();
		//C_SZPE,C_SZPG
		if ("C_SZPG".equals(customerlabel) || "C_SZPE".equals(customerlabel)) {;
			String strZncode = "";
			if("C_SZPG".equals(customerlabel)){
				strZncode = "14861";
			}else {
				strZncode = "14841";
			}
			String strDtcode = wayBills.getDdtdt_code();
			str2 = ZoneDemand.getZnvnameByDistrict(strZncode,strDtcode);
			
		}
		
		String servletName = req.getServletPath().substring(1,
				req.getServletPath().length());
		LabeldataColumns labeldataColumns = getLabeldataColumns(wayBills);
		DataSourceTopdf bean = new DataSourceTopdf();

		bean.setAlonecustomsign(wayBills.getAlonecustomsign());
		bean.setBwbBw_labelcode(wayBills.getBwbbw_labelcode());
		bean.setCcoCo_code(wayBills.getCcoco_code());
		bean.setCcoCo_labelcode(wayBills.getCcoco_labelcode());
		if (objChanneladdressColumns != null) {
			bean.setChnaChnaaddress1(objChanneladdressColumns
					.getChnachnaaddress1());
			bean.setChnaChnaaddress2(objChanneladdressColumns
					.getChnachnaaddress2());
			bean.setChnaChnaaddress3(objChanneladdressColumns
					.getChnachnaaddress3());
			bean.setChnaChnamid(objChanneladdressColumns.getChnachnamid());
			bean.setChnaChnaprocessingaddress1(objChanneladdressColumns
					.getChnachnaprocessingaddress1());
			bean.setChnaChnaprocessingaddress2(objChanneladdressColumns
					.getChnachnaprocessingaddress2());
			bean.setChnaChnaprocessingaddress3(objChanneladdressColumns
					.getChnachnaprocessingaddress3());
			bean.setChnaChncode(objChanneladdressColumns.getChnachncode());
		}
		bean.setChnChn_code(wayBills.getChnchn_code());
		bean.setChnChn_customerlabel(wayBills.getChnchn_customerlabel());
		bean.setChnChn_customlable(wayBills.getChnchn_customlable());
		// bean.setChnChn_mastreaccount(wayBills.getChnchn_masteraccount());//没有该方法
		bean.setChnChn_selflablecode(wayBills.getChnchn_selflablecode());
		bean.setChnChn_sename(wayBills.getChnchn_sename());
		bean.setChnChn_sname(wayBills.getChnchn_sname());
		bean
				.setCiciename1(((CargoinfoColumns) cargoList.get(0))
						.getCiciename());
		if (!StringUtility.isNull(cargoList.get(0).getCicipieces())) {
			bean.setCicipieces1(Integer.valueOf(((CargoinfoColumns) cargoList
					.get(0)).getCicipieces()));
		}
		if (!StringUtility.isNull(cargoList.get(0).getCiciunitprice())) {
			bean.setCiciprice1(Double.parseDouble(((CargoinfoColumns) cargoList
					.get(0)).getCiciunitprice()));
		}
		if (!StringUtility.isNull(cargoList.get(0).getCiciweight())) {
			bean.setCiciweight1(Double.parseDouble(cargoList.get(0)
					.getCiciweight()));
		}
		if (!StringUtility.isNull(cargoList.get(0).getCicitotalprice())) {
			bean.setCicitotalprice1(Double.parseDouble(cargoList.get(0)
					.getCicitotalprice()));
		}
		if (!StringUtility.isNull(cargoList.get(0).getCkckcode())) {
			bean.setCkCk_code(cargoList.get(0).getCkckcode());
		}
		bean.setCiciremark1(cargoList.get(0).getCiciremark());
		bean.setCiciattacheinfo1(cargoList.get(0).getCiciattacheinfo());
		if (cargoList.size() > 1) {
			bean.setCiciename2(((CargoinfoColumns) cargoList.get(1))
					.getCiciename());
			if (!StringUtility.isNull(cargoList.get(1).getCicipieces())) {
				bean.setCicipieces2(Integer
						.valueOf(((CargoinfoColumns) cargoList.get(1))
								.getCicipieces()));
			}
			if (!StringUtility.isNull(cargoList.get(1).getCiciunitprice())) {
				bean.setCiciprice2(Double
						.parseDouble(((CargoinfoColumns) cargoList.get(1))
								.getCiciunitprice()));
			}
			if (!StringUtility.isNull(cargoList.get(1).getCiciweight())) {
				bean.setCiciweight2(Double.parseDouble(cargoList.get(1)
						.getCiciweight()));
			}
			if (!StringUtility.isNull(cargoList.get(1).getCicitotalprice())) {
				bean.setCicitotalprice2(Double.parseDouble(cargoList.get(1)
						.getCicitotalprice()));
			}
			bean.setCiciremark2(cargoList.get(1).getCiciremark());
			bean.setCiciattacheinfo2(cargoList.get(1).getCiciattacheinfo());
		}
		if (cargoList.size() > 2) {
			bean.setCiciename3(((CargoinfoColumns) cargoList.get(2))
					.getCiciename());
			if (!StringUtility.isNull(cargoList.get(2).getCicipieces())) {
				bean.setCicipieces3(Integer
						.valueOf(((CargoinfoColumns) cargoList.get(2))
								.getCicipieces()));
			}
			if (!StringUtility.isNull(cargoList.get(2).getCiciunitprice())) {
				bean.setCiciprice3(Double
						.parseDouble(((CargoinfoColumns) cargoList.get(2))
								.getCiciunitprice()));
			}
			if (!StringUtility.isNull(cargoList.get(2).getCiciweight())) {
				bean.setCiciweight3(Double.parseDouble(cargoList.get(2)
						.getCiciweight()));
			}
			if (!StringUtility.isNull(cargoList.get(2).getCicitotalprice())) {
				bean.setCicitotalprice3(Double.parseDouble(cargoList.get(2)
						.getCicitotalprice()));
			}
			bean.setCiciremark3(cargoList.get(2).getCiciremark());
			bean.setCiciattacheinfo3(cargoList.get(2).getCiciattacheinfo());
		}
		if (cargoList.size() > 3) {
			bean.setCiciename4(((CargoinfoColumns) cargoList.get(3))
					.getCiciename());
			if (!StringUtility.isNull(cargoList.get(3).getCicipieces())) {
				bean.setCicipieces4(Integer
						.valueOf(((CargoinfoColumns) cargoList.get(3))
								.getCicipieces()));
			}
			if (!StringUtility.isNull(cargoList.get(3).getCiciunitprice())) {
				bean.setCiciprice4(Double
						.parseDouble(((CargoinfoColumns) cargoList.get(3))
								.getCiciunitprice()));
			}
			if (!StringUtility.isNull(cargoList.get(3).getCiciweight())) {
				bean.setCiciweight4(Double.parseDouble(cargoList.get(3)
						.getCiciweight()));
			}
			if (!StringUtility.isNull(cargoList.get(3).getCicitotalprice())) {
				bean.setCicitotalprice4(Double.parseDouble(cargoList.get(3)
						.getCicitotalprice()));
			}
			bean.setCiciremark4(cargoList.get(3).getCiciremark());
			bean.setCiciattacheinfo4(cargoList.get(3).getCiciattacheinfo());
		}
		bean.setCwCw_chargeweight(wayBills.getCwcw_chargeweight());
		// bean.setCwCw_createdate(wayBills.getCwcw_createdate());//没有该方法

		bean.setCwCw_customerewbcode(wayBills.getCwcw_customerewbcode());
		bean.setCwCw_ewbcode(wayBills.getCwcw_ewbcode());
		bean.setCwCw_pieces(wayBills.getCwcw_pieces());
		if("C_HUPG".equals(wayBills.getChnchn_customerlabel())&&"HU".equals(wayBills.getDtdt_hubcode())){
			bean.setCwCw_serverewbcode(StrUtil.splitserverewbcode(wayBills.getCwcw_serverewbcode()));
		}else{
			bean.setCwCw_serverewbcode(wayBills.getCwcw_serverewbcode());
		}
		bean.setCwCw_DGMGserverewbcode(StrUtil.splitString2(wayBills
				.getCwcw_serverewbcode()));
		bean.setCwDt_code_signin(wayBills.getCwdt_code_signin());
		bean.setCwsCws_code(wayBills.getCwscws_code());
		bean.setCwsCws_name(wayBills.getCwscws_name());
		bean.setDtDt_ename(wayBills.getDtdt_ename());

		bean.setDtDt_name(wayBills.getDtdt_name());
		bean.setDtDt_statecode(wayBills.getDtdt_statecode());
		bean.setHw_signindate(wayBills.getHw_signindate());
		bean.setHwHw_attacheinfosign(wayBills.getHwhw_attacheinfosign());
		bean.setHwHw_buyerid(wayBills.getHwhw_buyerid());
		bean.setHwHw_consigneeaddress1(wayBills.getHwhw_consigneeaddress1());

		if (!".".equals(wayBills.getHwhw_consigneeaddress2())) {
			bean
					.setHwHw_consigneeaddress2(wayBills
							.getHwhw_consigneeaddress2());
		}
		if (!".".equals(wayBills.getHwhw_consigneeaddress3())) {
			bean
					.setHwHw_consigneeaddress3(wayBills
							.getHwhw_consigneeaddress3());
		}
		bean.setHwHw_consigneeaddressex(wayBills.getHwhw_consigneeaddressex());
		bean.setHwHw_consigneecity(wayBills.getHwhw_consigneecity());
		bean.setHwHw_consigneecompany(wayBills.getHwhw_consigneecompany());
		bean.setHwHw_consigneefax(wayBills.getHwhw_consigneefax());
		bean.setHwHw_consigneename(wayBills.getHwhw_consigneename());
		bean.setHwHw_consigneenameex(wayBills.getHwhw_consigneenameex());
		bean.setHwHw_consigneepostcode(wayBills.getHwhw_consigneepostcode());
		bean.setHwHw_consigneetelephone(wayBills.getHwhw_consigneetelephone());

		// bean.setHwHw_customerdeclaredate(wayBills.getHwhw_customerdeclaredate());//没有该方法
		// bean.setHwHw_customerlabelprintdate(wayBills.getHwhw_customerlabelprintdate());//没有该方法

		String customer = wayBills.getChnchn_customerlabel();
		if (!StringUtility.isNull(customer)
				&& ("C_DGMP".equals(customer) || "C_DGMG".equals(customer))) {
			String http = "http";
			String remark = wayBills.getHwhw_remark();
			if (!StringUtility.isNull(remark)) {
				if (remark.indexOf(http) == -1
						&& remark.indexOf(http.toUpperCase()) == -1) {
					bean.setHwHw_remark(remark);
				}
			}
			bean.setCwCw_customerchargeweight(Double.parseDouble(wayBills
					.getCwcw_customerchargeweight())
					+ "KG");
		} else {
			bean.setCwCw_customerchargeweight(Double.parseDouble(wayBills
					.getCwcw_customerchargeweight())
					+ "");
			bean.setHwHw_remark(wayBills.getHwhw_remark());
		}
		bean.setHwHw_shipperaddress1(wayBills.getHwhw_shipperaddress1());
		bean.setHwHw_shipperaddress2(wayBills.getHwhw_shipperaddress2());
		bean.setHwHw_shipperaddress3(wayBills.getHwhw_shipperaddress3());
		bean.setHwHw_shippercompany(wayBills.getHwhw_shippercompany());
		bean.setHwHw_shipperfax(wayBills.getHwhw_shipperfax());
		bean.setHwHw_shippername(wayBills.getHwhw_shippername());
		bean.setHwHw_shipperpostcode(wayBills.getHwhw_shipperpostcode());
		bean.setHwHw_shippertelephone(wayBills.getHwhw_shippertelephone());
		bean.setHwHw_transactionid(wayBills.getHwhw_transactionid());
		bean.setIhsIhs_code(wayBills.getIhsihs_code());
		bean.setIhsIhs_name(wayBills.getIhsihs_name());
		bean.setOriginorderid(wayBills.getOriginorderid());
		bean.setPkPk_code(wayBills.getPkpk_code());
		bean.setPkPk_sename(wayBills.getPkpk_sename());
		bean.setPkPk_showserverewbcode(wayBills.getPkpk_showserverewbcode());
		if (labeldataColumns != null) {
			bean.setPlE1(labeldataColumns.getPle1());
			bean.setPlE2(labeldataColumns.getPle2());
			bean.setPlE3(labeldataColumns.getPle3());
			bean.setPlE4(labeldataColumns.getPle4());
			bean.setPlE5(labeldataColumns.getPle5());
			bean.setPlE6(labeldataColumns.getPle6());
			bean.setPlLcn(labeldataColumns.getPllcn());
			bean.setPlMailtype(labeldataColumns.getPlmailtype());
			bean.setPlProduct(labeldataColumns.getPlproduct());
			bean.setPlZipcode(labeldataColumns.getPlzipcode());
		}
		bean.setScocode(wayBills.getScocode());
		if (str2 != null && !"".equals(str2)) {
			bean.setZnvznvname(str2);
		}
		bean.setDescription(str1);
		bean.setScolabelcode(wayBills.getScolabelcode());
		bean.setScosename(wayBills.getScosename());
		bean.setTotalPrice(bean.getCiciprice1() + bean.getCiciprice2());
		bean.setTotalWeight(bean.getCiciweight1() + bean.getCiciweight2());
		bean.setTotalpieces(bean.getCicipieces1() + bean.getCicipieces2());
		bean.setImage(BarcodeUtil.createBarcode(req, wayBills, servletName)
				.get(0));
		
		bean.setImage2(BarcodeUtil.createBarcode(req, wayBills, servletName)
		 .get(1));
		
		String rootPath = getRootPath();
		String chnCode = wayBills.getChnchn_code();
		TchnChannel chnChannel = TchnChannelDC.loadByKey(chnCode);
		if (chnChannel != null) {
			bean.setMasteraccount(chnChannel.getChnMasteraccount());
		}
		// bean.setStrUri(strUri);

		// 旧的DGM标签

		// String customerlabel = wayBills.getChnchn_customerlabel();
		// if (!StringUtility.isNull(customerlabel)&&
		// ("C_DGMP".equals(customerlabel)||"C_DGMG".equals(customerlabel))) {
		// String hubcode = wayBills.getDtdt_hubcode();
		// if(!StringUtility.isNull(hubcode)&&"DE".equals(hubcode)){
		// bean.setPicturePash(rootPath+"/images/DGM_de.png");
		// }else if(!StringUtility.isNull(hubcode)&&"IT".equals(hubcode)){
		// bean.setPicturePash(rootPath+"/images/DGM_it.png");
		// }else{
		// bean.setPicturePash(rootPath+"/images/DGM_other.png");
		// }
		// }
		//		
		// if
		// (!StringUtility.isNull(customerlabel)&&"C_DGMP".equals(customerlabel))
		// {
		// String hubcode = wayBills.getDtdt_hubcode();
		// bean.setDgm_DtHubcode(wayBills.getDtdt_hubcode());
		// if(!StringUtility.isNull(hubcode)&&"DE".equals(hubcode)){
		// bean.setDtDt_hubcode("X40");
		// }else{
		// bean.setDtDt_hubcode("BQC(MH)");
		// }
		// }else{
		// bean.setDtDt_hubcode(wayBills.getDtdt_hubcode());
		// }
		bean.setDtDt_hubcode(wayBills.getDtdt_hubcode());
		bean.setStrUri(rootPath);
		bean.setDate(new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH)
				.format(Calendar.getInstance().getTime()));	
		List<DataSourceTopdf> allList = new ArrayList<DataSourceTopdf>();
//		System.out.println(bean.getCiciweight1());

		allList.add(bean);
		return allList;
	}

	public static File readPDFfile(ServletContext servletContext,
			String customerlabel, String hubcode) throws Exception {
		// customerlabel = "C_HUPG";
		File jasperFile = null;
		// 判断标签类型取对应的Jasper文件
		// C_DGMA2B C_DGMA2BP
		if (!StringUtility.isNull(customerlabel)
				&& "C_SWGH".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/swghA4.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_SWISS".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_ORSWISS".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/orswiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_GA".equals(customerlabel)) {
			jasperFile = new File(servletContext.getRealPath("/jasp/GA.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_GO".equals(customerlabel)) {
			jasperFile = new File(servletContext.getRealPath("/jasp/GO.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_PL".equals(customerlabel)) {
			jasperFile = new File(servletContext.getRealPath("/jasp/PL.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_PG".equals(customerlabel)) {
			jasperFile = new File(servletContext.getRealPath("/jasp/PG.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_PO".equals(customerlabel)) {
			jasperFile = new File(servletContext.getRealPath("/jasp/PO.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_UDFDE".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/udfDe.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_UDFOR".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/udfOr.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_UDFDEP".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/udfDep.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_UDFORP".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/udfOrp.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_HKGH".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/ph_1.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_SGDE".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/SGDE.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_HUNP".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/hunP.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& ("C_DGMP".equals(customerlabel) || "C_DGMPY".equals(customerlabel))) {
			if("IL".equals(hubcode)||"TR".equals(hubcode)){	//Update ,TR,
				jasperFile = new File(servletContext
						.getRealPath("/jasp/DGMP_Arial.jasper"));
			}else if("TH".equals(hubcode)) {
				jasperFile = new File(servletContext
						.getRealPath("/jasp/DGMP_TH.jasper"));
			}else{
				jasperFile = new File(servletContext
						.getRealPath("/jasp/DGMP.jasper"));
			
			}
			
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_DGMG".equals(customerlabel)) {
			if ("US".equals(hubcode)) {
				jasperFile = new File(servletContext
						.getRealPath("/jasp/DGMG_US.jasper"));
			}else if ("TR".equals(hubcode)) {
				jasperFile = new File(servletContext
						.getRealPath("/jasp/DGMG_Arial.jasper"));
			}else if("TH".equals(hubcode)){
				jasperFile = new File(servletContext
						.getRealPath("/jasp/DGMG_TH.jasper"));
			}else {
				jasperFile = new File(servletContext
						.getRealPath("/jasp/DGMG.jasper"));
			}
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_DGMA2B".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/A2B_DGM.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_DGMUDF".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/DGMUDF.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_HUNG".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/hunG.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_HUNP".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/hunP.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_DGMA2BP".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/DGM_A2BP.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_DGMPGB".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/GPD.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_ZZEUB".equals(customerlabel)) {
			if ("KW".equals(hubcode)) {
				jasperFile = new File(servletContext
						.getRealPath("/jasp/ZZ_EUB_KW.jasper"));
			} else {
				jasperFile = new File(servletContext
						.getRealPath("/jasp/ZZ_EUB.jasper"));
			}
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_BQB".equals(customerlabel)) {
			// jasperFile =new
			// File(servletContext.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_HKPY".equals(customerlabel)) {
			// jasperFile =new
			// File(servletContext.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_SGGH".equals(customerlabel)) {
			// jasperFile =new
			// File(servletContext.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_SGPY".equals(customerlabel)) {
			// jasperFile =new
			// File(servletContext.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_OTSR".equals(customerlabel)) {
			// jasperFile =new
			// File(servletContext.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_DHLGB".equals(customerlabel)) {
			// jasperFile =new
			// File(servletContext.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_USDHLGB".equals(customerlabel)) {
			// jasperFile =new
			// File(servletContext.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_GMHK".equals(customerlabel)) {
			// jasperFile =new
			// File(servletContext.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_GMDE".equals(customerlabel)) {
			// jasperFile =new
			// File(servletContext.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_GMEXDE".equals(customerlabel)) {
			// jasperFile =new
			// File(servletContext.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_GMSE".equals(customerlabel)) {
			// jasperFile =new
			// File(servletContext.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_SDHLGM".equals(customerlabel)) {
			// jasperFile =new
			// File(servletContext.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_FL".equals(customerlabel)) {
			// jasperFile =new
			// File(servletContext.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_GMHKD".equals(customerlabel)) {
			// jasperFile =new
			// File(servletContext.getRealPath("/jasp/swiss.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_OTS".equals(customerlabel)) {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/ots.jasper"));
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_GZEUB".equals(customerlabel)) {
			if("JP".equals(hubcode)){
				jasperFile = new File(servletContext
						.getRealPath("/jasp/GZ_EUB_JP.jasper"));
			}else if("KR".equals(hubcode)){
				jasperFile = new File(servletContext
						.getRealPath("/jasp/GZ_EUB_KR.jasper"));
			}else if("SA".equals(hubcode)){
				jasperFile = new File(servletContext
						.getRealPath("/jasp/GZ_EUB_SA.jasper"));
			}else if("TH".equals(hubcode)){
				jasperFile = new File(servletContext
						.getRealPath("/jasp/GZ_EUB_TH.jasper"));
			}else{
				jasperFile = new File(servletContext
						.getRealPath("/jasp/GZ_EUB.jasper"));
			}
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_HUPE".equals(customerlabel)) {
			String[] hub = { "AT", "BE", "BG", "CY", "CZ", "DK", "EE", "FI",
					"FR", "DE", "GR", "HU", "IT", "LV", "LT", "LU", "MT", "NL",
					"PL", "PT", "RO", "SK", "SI", "ES", "SE", "GB", "HR", "IE" };
			for (int i = 0; i < hub.length; i++) {
				if (hub[i].equals(hubcode)) {
					jasperFile = new File(servletContext
							.getRealPath("/jasp/HUPY-EU.jasper"));
					break;
				} else {
					jasperFile = new File(servletContext
							.getRealPath("/jasp/HUPY.jasper"));
				}
			}
			return jasperFile;
		} else if (!StringUtility.isNull(customerlabel)
				&& "C_HUPG".equals(customerlabel)) {
			String[] hub = { "AT", "BE", "BG", "CY", "CZ", "DK", "EE", "FI",
					"FR", "DE", "GR", "HU", "IT", "LV", "LT", "LU", "MT", "NL",
					"PL", "PT", "RO", "SK", "SI", "ES", "SE", "GB", "HR", "IE" };
			for (int i = 0; i < hub.length; i++) {
				if (hub[i].equals(hubcode)) {
					if("HU".equals(hub[i])){
						jasperFile = new File(servletContext
								.getRealPath("/jasp/HUBT.jasper"));
						break;
					}else{
						if("JP".equals(hubcode)){
							jasperFile = new File(servletContext
									.getRealPath("/jasp/HUMP-EU-JP.jasper"));
						}else{
							jasperFile = new File(servletContext
									.getRealPath("/jasp/HUMP-EU.jasper"));
						}
						break;
					}
				} else {
					if("JP".equals(hubcode)){
						jasperFile = new File(servletContext
								.getRealPath("/jasp/HUMP-JP.jasper"));
					}else{
						jasperFile = new File(servletContext
								.getRealPath("/jasp/HUMP.jasper"));
					}
				}
			}
			return jasperFile;
		
		}else if(!StringUtility.isNull(customerlabel)
				&& "C_SZPG".equals(customerlabel)){
			//SZ_EUBG.jasper,SZ_EUBP.jasper
			jasperFile = new File(servletContext
					.getRealPath("/jasp/SZ_EUBG.jasper"));
			return jasperFile;
		} else if(!StringUtility.isNull(customerlabel)
				&& "C_SZPE".equals(customerlabel)){
			jasperFile = new File(servletContext
					.getRealPath("/jasp/SZ_EUBP.jasper"));
			return jasperFile;
		
		} else {
			jasperFile = new File(servletContext
					.getRealPath("/jasp/ots.jasper"));
			return jasperFile;
		}

	}

	/**
	 * 合成pdf
	 * 
	 * @param pdfNames
	 * @param path
	 * @return
	 * @throws IOException
	 */
	public static String pdfMerger(String[] pdfNames, String path)
			throws IOException {
		if (pdfNames == null || pdfNames.length == 0) {
			return null;
		}
		if (pdfNames.length == 1) {
			return pdfNames[0];
		}
		String allName = pdfNames.length + "-" + pdfNames[0];

		Document document = null;
		FileOutputStream fos = null;
		try {
			document = new Document(new PdfReader(path + File.separator
					+ pdfNames[0]).getPageSizeWithRotation(1));
			fos = new FileOutputStream(path + File.separator + allName);
			PdfCopy cp = new PdfCopy(document, fos);
			document.open();
			for (int i = 0; i < pdfNames.length; i++) {
				// 读取每一个PDF文件
				PdfReader reader = new PdfReader(path + File.separator
						+ pdfNames[i]);
				int pageNumber = reader.getNumberOfPages();// 得到PDF文件的页码
				PdfImportedPage page = null;
				for (int j = 1; j <= pageNumber; j++) {
					// 把每一页都添加到目标PDF上
					page = cp.getImportedPage(reader, j);
					cp.addPage(page);
				}
				File tmpFile = new File(path + File.separator + pdfNames[i]);
				if (tmpFile.exists()) {
					tmpFile.delete();
				}
			}

			document.close();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			if (fos != null)
				fos.close();
			if (document != null) {
				document.close();
			}
		}
		return allName;
	}

	/**
	 * 获得绝对路径
	 * 
	 * @return
	 */
	public static String getRootPath() {
		String classPath = PrintPDFLableServlet.class.getClassLoader()
				.getResource("/").getPath();
		String rootPath = "";
		if ("\\".equals(File.separator)) {
			// window 系统
			rootPath = classPath.substring(1, classPath
					.indexOf("/WEB-INF/classes"));
			rootPath = rootPath.replace("/", "\\");
		}
		if ("/".equals(File.separator)) {
			// linux 系统
			rootPath = classPath.substring(0, classPath
					.indexOf("/WEB-INF/classes"));
			rootPath = rootPath.replace("\\", "/");
		}
		return rootPath;
	}

	/**
	 * 修改状态
	 * 
	 * @param astrCwcode
	 * @param opId
	 * @return
	 */
	public static void addTrack(String[] astrCwcode, String opId,
			WaybillforpredictColumns[] awayBills) {
		CoreWaybillPrintThread objCWPT = new CoreWaybillPrintThread(astrCwcode,
				opId, awayBills);
		objCWPT.start();
	}

	/**
	 * 打印dhl标签
	 * 
	 * @param wayBills
	 * @param resp
	 * @return
	 */
	public static String printDHL(WaybillforpredictColumns wayBills,
			HttpServletResponse resp) {
		try {
			String fileName = wayBills.getCwcw_serverewbcode() + ".pdf";
			String pdfPath = // IDHLLabelBasicData.DHLWAYBILL_DIRECTORY + "/"
			"/usr/local/tomcatxleis/webapps/Express/dhlsvwaybill/"
					+ DateFormatUtility.getCompactOnlyDateSysdate();
			String strXML = BuildXmlDemand.getXmlString(wayBills);
			// 报错
			if (strXML.startsWith("E_"))
				return strXML;

			LabelReportHandler lableReport = new LabelReportHandler(strXML,
					wayBills.getCwcw_serverewbcode(),
					SystempropertyDemand.getWaybillFilePath() + "/dhlsvwaybill/");
			lableReport.run();
			File jasperFile = new File(pdfPath, fileName);
			ServletOutputStream out = resp.getOutputStream();
			resp
					.setHeader("Content-Disposition", "inline;filename="
							+ fileName);
			// resp.setHeader("Content-Disposition",
			// "attachment;filename="+fileName);
			resp.setContentType("application/pdf");
			InputStream is = new FileInputStream(jasperFile);
			byte[] buffer = new byte[1024];
			int length = -1;
			while ((length = is.read(buffer)) != -1) {
				out.write(buffer, 0, length);
			}
			is.close();
			out.close();
			return pdfPath + File.separator + fileName;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}
}