package com.daiyun.sfweb.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.struts2.ServletActionContext;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.customerservice.track.bl.Track;
import kyle.leis.eo.operation.housewaybill.bl.PredictOrderEX;
import kyle.leis.eo.operation.housewaybill.da.ForinputallColumns;
import kyle.leis.eo.operation.housewaybill.da.LabeldataColumns;
import kyle.leis.eo.operation.housewaybill.da.LabeldataCondition;
import kyle.leis.eo.operation.housewaybill.da.LabeldataQuery;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictColumns;
import kyle.leis.eo.operation.housewaybill.dax.HousewaybillDemand;
import kyle.leis.es.company.channel.da.ChanneladdressColumns;
import kyle.leis.es.company.channel.dax.ChannelDemand;
import kyle.leis.fs.dictionary.district.dax.DistrictDemand;
import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;
import com.daiyun.dax.WaybillforpredictColumnsadd;

@SuppressWarnings("serial")
public class PrinterAction extends ActionSupportEX {
	private Date date;

	public Date getDate() {
		return date;
	}

	@SuppressWarnings("unchecked")
	public String queryPrinter() throws Exception {
		MessageBean objMessage = null;
		String[] strCwCode = (request.getParameter("cwcode")).split(",");
		session.setAttribute("checkboxCode", strCwCode);
		request.setAttribute("bl", HousewaybillDemand.loadForPredict(
				strCwCode[0]).getChnchn_customerlabel());
		//济宁E邮宝,深圳E邮宝selflablecode为空,customerlabel为空
		String chnchn_code = HousewaybillDemand.loadForPredict(strCwCode[0]).getChnchn_code();
	
		WaybillforpredictColumns wayBills = null;
		WaybillforpredictColumnsadd wayBillsadd = null;
		// 定义新的list接收打印的多个选项
		List listWayBillsBQ = new ArrayList();// C_BQB
		List listWayBillsOTS = new ArrayList();
		List listWayBillsPY = new ArrayList();// C_HKPY
		List listWayBillsGH = new ArrayList();// C_HKGH
		List listWayBillsSGGH = new ArrayList();// C_CGGH
		List listWayBillsSGPY = new ArrayList();// C_CGPY
		List listWayBillsSWGH = new ArrayList();// C_SWGH
		List listWayBillsOTSR = new ArrayList();// C_OTSR
		List listWayBillsDHLGM = new ArrayList();
		List listUSDHLGM = new ArrayList();
		List listWayBillsGMHK = new ArrayList();// C_GMHK
		List listWayBillsGMDE = new ArrayList();// C_GMDE
		List listWayBillsGMEXDE = new ArrayList();// C_GMEXDE
		List listWayBillsGMSE = new ArrayList();// C_GMSE
		List listWayBillsSWISS = new ArrayList();// C_SWISS
		List listWayBillsORSWISS = new ArrayList();// C_ORSWISS
		List listWayBillsSDHLGM = new ArrayList();// C_SDHLGM
		List listWayBillsFL = new ArrayList();// C_FL
		List listWayBillsPG = new ArrayList();// C_PG
		List listWayBillsPL = new ArrayList();// C_PL
		List listWayBillsPO = new ArrayList();// C_PO
		List listWayBillsGA = new ArrayList();// C_GA
		List listWayBillsGO = new ArrayList();// C_GO
		List listWayBillsGMHKD = new ArrayList();// C_GMHKD
		List listWayBillsUDFDE = new ArrayList();// C_UDFDE
		List listWayBillsUDFOR = new ArrayList();// C_UDFOR
		List listWayBillsUDFDEP = new ArrayList();// C_UDFDEP
		List listWayBillsUDFORP = new ArrayList();// C_UDFORP
		List listWayBillsSGDE = new ArrayList();// C_SGDE
		List listWayBillsDGMP = new ArrayList();// C_DGMP
		List listWayBillsDGMG = new ArrayList();// C_DGMG
		List listWayBillsHUNP = new ArrayList();// C_HUNP
		List listWayBillsHUNG = new ArrayList();// C_HUNG
		List listWayBillsDGMUDF = new ArrayList();// C_DGMUDF
		List listWayBillsA2BDGM = new ArrayList();// C_A2BDGM
		List listWayBillsDGMA2BP = new ArrayList();// C_DGMA2BP
		List listWayBillSZPG = new ArrayList();//C_SZPG
		List listWayBillSZPE = new ArrayList();//C_SZPE
		//List listWayBillsHUPE = new ArrayList();   //C_HUPE
		
		LabeldataCondition l = null;
		LabeldataQuery la = null;
		LabeldataColumns lable = null;
		ChanneladdressColumns objChanneladdressColumns = null;
		List<LabeldataColumns> ls = null;
		String strCocode = (String) session.getAttribute("Cocode");//strCocode =1 
		//String opId = (String) session.getAttribute("OpId");
		int num = 0;
		String dgmCode = "";
		for (int i = strCwCode.length - 1; i >= 0; i--) {
			if (!StringUtility.isNull(strCwCode[i])) {
				wayBills = HousewaybillDemand.loadForPredict(strCwCode[i]);
				//String op = request.getParameter("op");
				String selflablecode = wayBills.getChnchn_customerlabel();
				if (StringUtility.isNull(strCocode)
						&& !StringUtility.isNull(wayBills
								.getChnchn_selflablecode())) {
					selflablecode = wayBills.getChnchn_selflablecode();
				}
				/*
				 * if("101380".equals(opId)){ listWayBillsDGMG.add(wayBills);
				 * listWayBillsDGMP.add(wayBills); continue; },cwcode = [6131299];
				 */
				//获得州代码,getHwhw_consigneecity= null,Hubcode = "",dt_Hubcode= null,Hwhw_consigneepostcode() = 12417
				String dtdtHubcode = wayBills.getDtdt_hubcode();				
				
				if(dtdtHubcode == null){
					String cwcwCustomerewbcode = wayBills.getCwcw_customerewbcode();//获取单号
					 objMessage = new MessageBean(IBasicData.MSG_TYPE_ERROR, "打印标签失败", cwcwCustomerewbcode+",请检查邮编、城市资料和目的地国家是否正确！");
					ServletActionContext.getRequest().getSession().setAttribute("MESSAGEBEAN", objMessage);

				}else{
					
					String dd_StateCode=DistrictDemand.getDHLStateCode(wayBills.getHwhw_consigneecity(),
							"", 
							wayBills.getDtdt_hubcode(), 
							wayBills.getHwhw_consigneepostcode());
					wayBills.setDtdt_statecode(dd_StateCode);
				}
			
				if (!StringUtility.isNull(selflablecode)
						&& "C_BQB".equals(selflablecode)) {
					listWayBillsBQ.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_HKPY".equals(selflablecode)) {
					listWayBillsPY.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_HKGH".equals(selflablecode)) {
					listWayBillsGH.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_SGGH".equals(selflablecode)) {
					listWayBillsSGGH.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_SGPY".equals(selflablecode)) {
					listWayBillsSGPY.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_SWGH".equals(selflablecode)) {
					listWayBillsSWGH.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_OTSR".equals(selflablecode)) {
					listWayBillsOTSR.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_DHLGB".equals(selflablecode)) {
					listWayBillsDHLGM.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_USDHLGB".equals(selflablecode)) {
					listUSDHLGM.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_GMHK".equals(selflablecode)) {
					listWayBillsGMHK.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_GMDE".equals(selflablecode)) {
					listWayBillsGMDE.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_GMEXDE".equals(selflablecode)) {
					listWayBillsGMEXDE.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_GMSE".equals(selflablecode)) {
					listWayBillsGMSE.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_SWISS".equals(selflablecode)) {
					listWayBillsSWISS.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_ORSWISS".equals(selflablecode)) {
					listWayBillsORSWISS.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_SDHLGM".equals(selflablecode)) {
					wayBillsadd = new WaybillforpredictColumnsadd();
					l = new LabeldataCondition();
					if (Double.parseDouble(wayBills
							.getCwcw_customerchargeweight()) <= 0.17007165) {
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
					la = new LabeldataQuery();
					la.setCondition(l);
					ls = la.getResults();
					lable = new LabeldataColumns();
					lable.setPle1(ls.get(0).getPle1());
					lable.setPle2(ls.get(0).getPle2());
					lable.setPle3(ls.get(0).getPle3());
					lable.setPle4(ls.get(0).getPle4());
					lable.setPle5(ls.get(0).getPle5());
					lable.setPle6(ls.get(0).getPle6());
					objChanneladdressColumns = ChannelDemand
							.loadChanneladdress(wayBills
									.getChnchn_customerlabel());
					wayBillsadd.setLabel(lable);
					wayBillsadd.setWay(wayBills);
					wayBillsadd
							.setObjChanneladdressColumns(objChanneladdressColumns);
					listWayBillsSDHLGM.add(wayBillsadd);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_FL".equals(selflablecode)) {
					listWayBillsFL.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_PG".equals(selflablecode)) {
					listWayBillsPG.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_PL".equals(selflablecode)) {
					listWayBillsPL.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_PO".equals(selflablecode)) {
					listWayBillsPO.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_GA".equals(selflablecode)) {
					listWayBillsGA.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_GO".equals(selflablecode)) {
					listWayBillsGO.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_GMHKD".equals(selflablecode)) {
					listWayBillsGMHKD.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_UDFDE".equals(selflablecode)) {
					listWayBillsUDFDE.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_UDFOR".equals(selflablecode)) {
					listWayBillsUDFOR.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_UDFDEP".equals(selflablecode)) {
					listWayBillsUDFDEP.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_UDFORP".equals(selflablecode)) {
					listWayBillsUDFORP.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_SGDE".equals(selflablecode)) {
					listWayBillsSGDE.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_DGMP".equals(selflablecode)) {
//					listWayBillsDGMP.add(wayBills);
					num += 1;
					dgmCode = dgmCode+strCwCode[i]+",";
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_DGMG".equals(selflablecode)) {
					//listWayBillsDGMG.add(wayBills);
					num += 1;
					dgmCode = dgmCode +strCwCode[i]+",";
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_HUNP".equals(selflablecode)) {
					listWayBillsHUNP.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_HUNG".equals(selflablecode)) {
					listWayBillsHUNG.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_DGMUDF".equals(selflablecode)) {
					listWayBillsDGMUDF.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_DGMA2B".equals(selflablecode)) {
					listWayBillsA2BDGM.add(wayBills);
				} else if (!StringUtility.isNull(selflablecode)
						&& "C_DGMA2BP".equals(selflablecode)) {
					listWayBillsDGMA2BP.add(wayBills);
				} else if(!StringUtility.isNull(selflablecode)
						&& "C_HUPE".equals(selflablecode)){
					num += 1;
					dgmCode = dgmCode+strCwCode[i]+",";
				} else if(!StringUtility.isNull(selflablecode)
						&& "C_HUPG".equals(selflablecode)){
					num += 1;
					dgmCode = dgmCode+strCwCode[i]+",";
				} else if(!StringUtility.isNull(selflablecode)
						&& "C_GZEUB".equals(selflablecode)){
					num += 1;
					dgmCode = dgmCode+strCwCode[i]+",";
				} else if(!StringUtility.isNull(selflablecode)
						&& "C_ZZEUB".equals(selflablecode)){
					num += 1;
					dgmCode = dgmCode+strCwCode[i]+",";
				}else if(!StringUtility.isNull(selflablecode)
						&& "C_SZPG".equals(selflablecode)){
					num += 1;
					dgmCode = dgmCode+strCwCode[i]+",";
					
				}else if (!StringUtility.isNull(selflablecode)
						&& "C_SZPE".equals(selflablecode)){
					num += 1;
					dgmCode = dgmCode+strCwCode[i]+",";
				}else if("20220".equals(chnchn_code)){//如果是济宁E邮宝chnchn_code
					num += 1;
					dgmCode = dgmCode+strCwCode[i]+",";
				}else if("20462".equals(chnchn_code)){//如果是深圳E邮宝
					num += 1;
					dgmCode = dgmCode+strCwCode[i]+",";
				}
				else {
					listWayBillsOTS.add(wayBills);
				}

			}
		}
		
		
		
		// 打印标签格式
		String raval = request.getParameter("raval");
		request.setAttribute("raval", raval);
		request.setAttribute("dgmCode",dgmCode);
		if(num==strCwCode.length){
			return "dgm";
		}
		request.setAttribute("listWayBillsBQ", listWayBillsBQ);
		request.setAttribute("listWayBillsOTS", listWayBillsOTS);
		request.setAttribute("listWayBillsPY", listWayBillsPY);
		request.setAttribute("listWayBillsGH", listWayBillsGH);
		request.setAttribute("listWayBillsSGGH", listWayBillsSGGH);
		request.setAttribute("listWayBillsSGPY", listWayBillsSGPY);
		request.setAttribute("listWayBillsSWGH", listWayBillsSWGH);
		request.setAttribute("listWayBillsOTSR", listWayBillsOTSR);
		request.setAttribute("listWayBillsDHLGM", listWayBillsDHLGM);
		request.setAttribute("listUSDHLGM", listUSDHLGM);
		request.setAttribute("listWayBillsGMHK", listWayBillsGMHK);
		request.setAttribute("listWayBillsGMDE", listWayBillsGMDE);
		request.setAttribute("listWayBillsGMEXDE", listWayBillsGMEXDE);
		request.setAttribute("listWayBillsGMSE", listWayBillsGMSE);
		// request.setAttribute("listWayBillsGMNP", listWayBillsGMNP);
		request.setAttribute("listWayBillsSWISS", listWayBillsSWISS);
		request.setAttribute("listWayBillsORSWISS", listWayBillsORSWISS);
		request.setAttribute("listWayBillsSDHLGM", listWayBillsSDHLGM);
		request.setAttribute("listWayBillsFL", listWayBillsFL);
		request.setAttribute("listWayBillsPG", listWayBillsPG);
		request.setAttribute("listWayBillsPL", listWayBillsPL);
		request.setAttribute("listWayBillsPO", listWayBillsPO);
		request.setAttribute("listWayBillsGA", listWayBillsGA);
		request.setAttribute("listWayBillsGO", listWayBillsGO);
		request.setAttribute("listWayBillsGMHKD", listWayBillsGMHKD);
		request.setAttribute("listWayBillsUDFDE", listWayBillsUDFDE);
		request.setAttribute("listWayBillsUDFOR", listWayBillsUDFOR);
		request.setAttribute("listWayBillsUDFDEP", listWayBillsUDFDEP);
		request.setAttribute("listWayBillsUDFORP", listWayBillsUDFORP);
		request.setAttribute("listWayBillsSGDE", listWayBillsSGDE);
		request.setAttribute("listWayBillsDGMP", listWayBillsDGMP);
		request.setAttribute("listWayBillsDGMG", listWayBillsDGMG);
		request.setAttribute("listWayBillsHUNP", listWayBillsHUNP);
		request.setAttribute("listWayBillsHUNG", listWayBillsHUNG);
		request.setAttribute("listWayBillsDGMUDF", listWayBillsDGMUDF);
		request.setAttribute("listWayBillsA2BDGM", listWayBillsA2BDGM);
		request.setAttribute("listWayBillsDGMA2BP", listWayBillsDGMA2BP);
		request.setAttribute("listWayBillSZPG", listWayBillSZPG);
		request.setAttribute("listWayBillSZPE", listWayBillSZPE);
		date = new Date();
		
		return SUCCESS;
	}

	/*
	 * 修改标签的状态
	 */
	public String printAll() throws Exception {
		String opId = (String) session.getAttribute("OpId");
		String[] checkboxCode = (request.getParameter("checkboxCode"))
				.split(",");
		System.out.println(checkboxCode.length);
		for (int i = 0; i < checkboxCode.length; i++) {
			System.out.println("|" + checkboxCode[i] + "|");
			if (!StringUtility.isNull(opId)) {
				checkboxCode[i] = checkboxCode[i].trim();
				new PredictOrderEX().modifyCorewaybillStatus(checkboxCode[i],
						"CHP", opId);
				// 增加轨迹
				Track objTrack = new Track();
				objTrack.addSingleTrack(checkboxCode[i], "719", "TS", opId,
						DateFormatUtility.getStandardSysdate());
			}
		}

		return SUCCESS;
	}


	// 打印报表
	@SuppressWarnings("unchecked")
	public String reportPrint() throws Exception {
		String[] strCwCode = (request.getParameter("cwcode")).split(",");
		ForinputallColumns forinputallColumns = new ForinputallColumns();
		List listForFedex = new ArrayList();
		List listForDHLCN = new ArrayList();
		List listForSTD = new ArrayList();
		WaybillforpredictColumns wayBills = null;
		//WaybillforpredictColumnsEX objWBPCEX = new WaybillforpredictColumnsEX();
		for (int i = 0; i < strCwCode.length; i++) {
			if (!StringUtility.isNull(strCwCode[i])) {
				wayBills = HousewaybillDemand.loadForPredict(strCwCode[i]);
				System.out.println("=============="
						+ wayBills.getChnchn_customlable());
				// 定义inputallColumns
				forinputallColumns = HousewaybillDemand.load(strCwCode[i]);
				forinputallColumns
						.setHwconsigneename(StringUtility
								.isNull(forinputallColumns
										.getHwconsigneenameex()) ? forinputallColumns
								.getHwconsigneename()
								: StringUtility.buildFromByte(
										forinputallColumns
												.getHwconsigneenameex(),
										"utf-8"));
				forinputallColumns
						.setHwconsigneeaddress1(StringUtility
								.isNull(forinputallColumns
										.getHwconsigneeaddressex()) ? forinputallColumns
								.getHwconsigneeaddress1()
								: StringUtility.buildFromByte(
										forinputallColumns
												.getHwconsigneeaddressex(),
										"utf-8"));
				forinputallColumns
						.setHwconsigneeaddress2(StringUtility
								.isNull(forinputallColumns
										.getHwconsigneeaddressex()) ? forinputallColumns
								.getHwconsigneeaddress2()
								: ".");
				forinputallColumns
						.setHwconsigneeaddress3(StringUtility
								.isNull(forinputallColumns
										.getHwconsigneeaddressex()) ? forinputallColumns
								.getHwconsigneeaddress3()
								+ "   "
								+ StringUtility.nullToEmpty(forinputallColumns
										.getHwconsigneepostcode())
								: "."
										+ StringUtility
												.nullToEmpty(forinputallColumns
														.getHwconsigneepostcode()));
				if ("FEDEX".equals(wayBills.getChnchn_customlable())) {
					listForFedex.add(forinputallColumns);
				} else if ("STD".equals(wayBills.getChnchn_customlable())) {
					listForSTD.add(forinputallColumns);
				} else {
					listForDHLCN.add(forinputallColumns);
				}
			}

		}

		request.setAttribute("listForFedex", listForFedex);
		request.setAttribute("listForSTD", listForSTD);
		request.setAttribute("listForDHLCN", listForDHLCN);

		return SUCCESS;
	}
	/**
	 * 
	 * 提货单打印
	 * @throws Exception 
	 * */
	public String BillLodingPrint() throws Exception{
		String bwcode = request.getParameter("bwcodehidden");
		String bwblabelcode = request.getParameter("bwblabelcode");//提货编号
	
		request.setAttribute("bwcode", bwcode);
		request.setAttribute("bwblabelcode", bwblabelcode);
		//co_labelcode

		
		
		
		return SUCCESS;
	}
	
	
	
	
	
	
	
	
	

}
