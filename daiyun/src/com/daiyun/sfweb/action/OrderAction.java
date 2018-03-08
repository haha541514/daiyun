package com.daiyun.sfweb.action;

import java.io.File;
import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.DateUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.common.util.prompt.PromptUtility;
import kyle.leis.eo.operation.batchwaybill.dax.BatchWayBillDemand;
import kyle.leis.eo.operation.cargoinfo.bl.Cargoinfo;
import kyle.leis.eo.operation.cargoinfo.da.CargoinfoColumns;
import kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand;
import kyle.leis.eo.operation.corewaybillpieces.da.CorewaybillpiecesColumns;
import kyle.leis.eo.operation.housewaybill.bl.PredictOrderEX;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictColumns;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictCondition;
import kyle.leis.eo.operation.housewaybill.dax.HousewaybillDemand;
import kyle.leis.eo.operation.housewaybill.dax.PredictOrderCheck;
import kyle.leis.eo.operation.predictwaybill.bl.Predictwaybill;
import kyle.leis.eo.operation.predictwaybill.da.PredictwaybillColumns;
import kyle.leis.eo.operation.predictwaybill.da.PredictwaybillCondition;
import kyle.leis.eo.operation.predictwaybill.dax.PredictwaybillDemand;
import kyle.leis.eo.operation.specialtype.bl.Specialtype;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import com.daiyun.predictwaybill.PredictOrderDemand;




/**
 * @author udpdate by wukq
 * @date:2016-11-28
 * 
 */
public class OrderAction extends ActionSupportEX {

	private static final long serialVersionUID = 1L;
	

	/**
	 * �鿴��������
	 */
	public String queryOrdersDetail() throws Exception {
		String link = request.getParameter("link");
		request.setAttribute("link", link);
		String cw_code = request.getParameter("cw_code");
		if(cw_code.equals("0")){
			cw_code=(String)request.getAttribute("cw_code");
		}
		if (StringUtility.isNull(cw_code)) {
			if (!("".equals(request.getParameterValues("checkbox")) || request
					.getParameterValues("checkbox") == null)) {
				String[] strCwCode = request.getParameterValues("checkbox");
				for (int i = 0; i < strCwCode.length; i++) {
					cw_code = strCwCode[i];
				}
			}
		}
		WaybillforpredictCondition objWaybillforpredictCondition = new WaybillforpredictCondition();
		objWaybillforpredictCondition.setCwcode(cw_code);
		WaybillforpredictColumns objWaybillforpredictColumns = (WaybillforpredictColumns) HousewaybillDemand
		.queryForPredict(objWaybillforpredictCondition).get(0);
		request.setAttribute("objWaybillforpredictColumns",objWaybillforpredictColumns);
		return SUCCESS;
	}

	/**
	 * ��ʾ������Ϣ
	 */
	public String queryProducDetail() throws Exception {
		String strCwCodes=request.getParameter("cwcode");
		String[] strCwCode=new String[]{};
		if(strCwCodes.equals("")){
			strCwCode=session.getAttribute("strCwCode").toString().split(",");

		}else{
			strCwCode = strCwCodes.split(",");
		}
		List<WaybillforpredictColumns> waybillforpredictColumns=new ArrayList<WaybillforpredictColumns>();
		for(int i=0;i<strCwCode.length;i++){
			if(!StringUtility.isNull(strCwCode[i])){
				if(!strCwCode[i].equals("")){
					WaybillforpredictCondition objWaybillforpredictCondition = new WaybillforpredictCondition();
					objWaybillforpredictCondition.setCwcode(strCwCode[i]);
					WaybillforpredictColumns objWaybillforpredictColumns = (WaybillforpredictColumns) HousewaybillDemand
					.queryForPredict(objWaybillforpredictCondition).get(0);
					waybillforpredictColumns.add(objWaybillforpredictColumns);
				}
			}
		}
		request.setAttribute("strCwCode", strCwCode);	
		request.setAttribute("waybillforpredictColumns", waybillforpredictColumns);
		Map<CargoinfoColumns,List<WaybillforpredictColumns>> map1=new HashMap<CargoinfoColumns,List<WaybillforpredictColumns>>();
		List<CargoinfoColumns> cargoinfoList=new ArrayList<CargoinfoColumns>();

		for(int i=0;i<waybillforpredictColumns.size();i++){
			WaybillforpredictColumns wfc=waybillforpredictColumns.get(i);
			String cwcw_code=wfc.getCwcw_code();
			CargoInfoDemand cid=new CargoInfoDemand();
			List l=cid.queryByCwCode(cwcw_code);
			for(int j=0;j<l.size();j++){
				CargoinfoColumns c=(CargoinfoColumns)l.get(j);
				cargoinfoList.add(c);
			}
		}
		for(int k=0;k<cargoinfoList.size();k++){		
			List<WaybillforpredictColumns> ls=new ArrayList<WaybillforpredictColumns>();
			for(int z=0;z<cargoinfoList.size();z++){
				if(cargoinfoList.get(k).getCiciattacheinfo()==null || cargoinfoList.get(z).getCiciattacheinfo()==null ||cargoinfoList.get(k).getCiciename()==null || cargoinfoList.get(z).getCiciename()==null){
					if(cargoinfoList.get(k).getCiciattacheinfo()==null && cargoinfoList.get(z).getCiciattacheinfo()==null){
						if(cargoinfoList.get(k).getCiciename()==null && cargoinfoList.get(z).getCiciename()==null){
							WaybillforpredictCondition owf = new WaybillforpredictCondition();
							owf.setCwcode(cargoinfoList.get(z).getCicomp_idcwcode());
							WaybillforpredictColumns wwff = (WaybillforpredictColumns) HousewaybillDemand
							.queryForPredict(owf).get(0);											
							ls.add(wwff); 
						}
						else if(cargoinfoList.get(k).getCiciename().equals(cargoinfoList.get(z).getCiciename())){
							WaybillforpredictCondition owf = new WaybillforpredictCondition();
							owf.setCwcode(cargoinfoList.get(z).getCicomp_idcwcode());
							WaybillforpredictColumns wwff = (WaybillforpredictColumns) HousewaybillDemand
							.queryForPredict(owf).get(0);										
							ls.add(wwff); 
						}
					}
					else if(cargoinfoList.get(k).getCiciename()==null && cargoinfoList.get(z).getCiciename()==null){
						if(cargoinfoList.get(k).getCiciattacheinfo()==null && cargoinfoList.get(z).getCiciattacheinfo()==null){
							WaybillforpredictCondition owf = new WaybillforpredictCondition();
							owf.setCwcode(cargoinfoList.get(z).getCicomp_idcwcode());
							WaybillforpredictColumns wwff = (WaybillforpredictColumns) HousewaybillDemand
							.queryForPredict(owf).get(0);											
							ls.add(wwff); 						
						}else if(cargoinfoList.get(k).getCiciattacheinfo().equals(cargoinfoList.get(z).getCiciattacheinfo())){
							WaybillforpredictCondition owf = new WaybillforpredictCondition();
							owf.setCwcode(cargoinfoList.get(z).getCicomp_idcwcode());
							WaybillforpredictColumns wwff = (WaybillforpredictColumns) HousewaybillDemand
							.queryForPredict(owf).get(0);										
							ls.add(wwff); 

						}
					}
				}
				else if(cargoinfoList.get(k).getCiciattacheinfo().equals(cargoinfoList.get(z).getCiciattacheinfo()) && cargoinfoList.get(k).getCiciename().equals(cargoinfoList.get(z).getCiciename())){
					WaybillforpredictCondition owf = new WaybillforpredictCondition();
					owf.setCwcode(cargoinfoList.get(z).getCicomp_idcwcode());
					WaybillforpredictColumns wwff = (WaybillforpredictColumns) HousewaybillDemand
					.queryForPredict(owf).get(0);
					if(ls.contains(wwff)){
						continue;
					}else{					
						ls.add(wwff); 
					}
				}
			}
			List <WaybillforpredictColumns> wfcs=new ArrayList<WaybillforpredictColumns>();
			for(int e=0;e<ls.size();e++){
				if(!wfcs.contains(ls.get(e))){
					wfcs.add(ls.get(e));
				}
			}				
			Set<CargoinfoColumns> set=map1.keySet();
			Iterator<CargoinfoColumns> iter=set.iterator();
			while(iter.hasNext()){					
				CargoinfoColumns cc=iter.next();
				if(cargoinfoList.get(k).getCiciattacheinfo()==null || cc.getCiciattacheinfo()==null ||cargoinfoList.get(k).getCiciename()==null || cc.getCiciename()==null){
					if(cargoinfoList.get(k).getCiciattacheinfo()==null && cc.getCiciattacheinfo()==null){
						if(cargoinfoList.get(k).getCiciename()==null && cc.getCiciename()==null){
							map1.remove(cc);
							break;
						}else if(cargoinfoList.get(k).getCiciename().equals(cc.getCiciename())){
							map1.remove(cc);
							break;
						}
					}
					else if(cargoinfoList.get(k).getCiciename()==null && cc.getCiciename()==null){
						if(cargoinfoList.get(k).getCiciattacheinfo()==null && cc.getCiciattacheinfo()==null){
							map1.remove(cc);
							break;
						}else if(cargoinfoList.get(k).getCiciattacheinfo().equals(cc.getCiciattacheinfo())){
							map1.remove(cc);
							break;
						}
					}
				}else if(cargoinfoList.get(k).getCiciattacheinfo().equals(cc.getCiciattacheinfo()) && cargoinfoList.get(k).getCiciename().equals(cc.getCiciename())){
					map1.remove(cc);
					break;
				}
			}
			map1.put(cargoinfoList.get(k), wfcs);

		}
		request.setAttribute("waybillforpredictColumnsMap1", map1);
		return SUCCESS;
	}
	//�޸Ļ�����Ϣ
	public String updateProductDetail() throws Exception{
		String strCwcodes=request.getParameter("strCwCodes");
		String allcode=request.getParameter("allcode");
		String [] codes=allcode.split(",");
		String ciid=request.getParameter("ciid");
		String ciCiattacheinfo=request.getParameter("newInfo");
		String ciCiename=request.getParameter("newName");
		//����
		ciCiattacheinfo=URLDecoder.decode(ciCiattacheinfo,"utf-8");
		ciCiattacheinfo=ciCiattacheinfo.toUpperCase();
		ciCiename=URLDecoder.decode(ciCiename,"utf-8");
		ciCiename=ciCiename.toUpperCase();
		CargoInfoDemand cd=new CargoInfoDemand();
		List oldlist=cd.queryByCwCode(codes[0]);
		String oldciCiattacheinfo="";
		String oldciCiename="";
		boolean result=false;
		for(int a=0;a<oldlist.size();a++){
			CargoinfoColumns objCIC = (CargoinfoColumns) oldlist.get(a);
			if(objCIC.getCicomp_idciid().equals(ciid)){
				oldciCiattacheinfo=objCIC.getCiciattacheinfo();
				oldciCiename=objCIC.getCiciename();
				break;
			}
		}		
		for(int i=0;i<codes.length;i++){
			List listCagoinfo=cd.queryByCwCode(codes[i]);
			for(int j=0;j<listCagoinfo.size();j++){
				CargoinfoColumns objCIC = (CargoinfoColumns) listCagoinfo.get(j);
				if(objCIC.getCiciattacheinfo()==null || oldciCiattacheinfo==null ||objCIC.getCiciename()==null || oldciCiename==null){
					if(objCIC.getCiciattacheinfo()==null && oldciCiattacheinfo==null){
						if(objCIC.getCiciename()==null &&oldciCiename==null){
							listCagoinfo.remove(j);
							objCIC.setCiciattacheinfo(ciCiattacheinfo);
							objCIC.setCiciename(ciCiename);
							listCagoinfo.add(objCIC);
						}else if(objCIC.getCiciename().equals(oldciCiename)){
							listCagoinfo.remove(j);
							objCIC.setCiciattacheinfo(ciCiattacheinfo);
							objCIC.setCiciename(ciCiename);
							listCagoinfo.add(objCIC);
						}
					}
					else if(objCIC.getCiciename()==null && oldciCiename==null){
						if(objCIC.getCiciattacheinfo()==null && oldciCiattacheinfo==null){
							listCagoinfo.remove(j);
							objCIC.setCiciattacheinfo(ciCiattacheinfo);
							objCIC.setCiciename(ciCiename);
							listCagoinfo.add(objCIC);
						}else if(objCIC.getCiciattacheinfo().equals(oldciCiattacheinfo)){
							listCagoinfo.remove(j);
							objCIC.setCiciattacheinfo(ciCiattacheinfo);
							objCIC.setCiciename(ciCiename);
							listCagoinfo.add(objCIC);
						}
					}
				}else if(objCIC.getCiciattacheinfo().equals(oldciCiattacheinfo) && objCIC.getCiciename().equals(oldciCiename)){
					listCagoinfo.remove(j);
					objCIC.setCiciattacheinfo(ciCiattacheinfo);
					objCIC.setCiciename(ciCiename);
					listCagoinfo.add(objCIC);
				}
			}			
			result=Cargoinfo.deleteCargoinfo(listCagoinfo, codes[i]);

		}
		session.setAttribute("result", result);
		session.setAttribute("strCwCode", strCwcodes);
		return SUCCESS;
	}
	/**
	 * ��õ�������(Ĭ��15����)
	 */
	private void getLabelCode(String cocode){
		List labelCodes=new ArrayList();
		WaybillforpredictCondition objWaybillforpredictCondition=new WaybillforpredictCondition();

		//�õ���ǰʱ�䵽ǰ15���ʱ��
		String strAbwcode=request.getParameter("strAbwcode");
		String strEnddate=DateFormatUtility.getStandardSysdate();
		String strStartdate=DateUtility.getMoveDate(strEnddate, -15);

		try {
			labelCodes= (List) BatchWayBillDemand.getLatestBatchwaybill("",cocode,"1",strStartdate,strEnddate,"A");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.print("���ȣ�----"+labelCodes.size());
	}
	/**
	 * 2016-11-17��Edit by wukq
	 * ���ж������ݴ棬���걨���Ѵ�ӡ�����
	 * 
	 */
	@SuppressWarnings("unchecked")
	public String queryOrdersByParams() throws Exception {
		//�Ƿ����ⲿ����
		String netout=request.getParameter("netout");
		if(StringUtility.isNull(netout)){
			netout="";
		}
		List<WaybillforpredictColumns> listWaybillforpredictColumnsReturn = new ArrayList<WaybillforpredictColumns>();
		WaybillforpredictCondition objWaybillforpredictCondition = new WaybillforpredictCondition();
		
		String strCocode = (String) session.getAttribute("Cocode");//������
		//��ҳ����
		int pageCount=0;
		if(StringUtility.isNull(request.getParameter("customInputCount")) ||
				"".equals(request.getParameter("customInputCount"))){
			pageCount=9;
		}else{
			pageCount=Integer.parseInt(request.getParameter("customInputCount"));
		}
		if (StringUtility.isNull(strCocode)) {
			strCocode = "338";
		}
		if(netout.equals("wai") || netout.equals("def")){
			strCocode="";
		}
		request.setAttribute("pageCount", Integer.valueOf(pageCount));
		//����ҳ���ֵ
		//request.setAttribute("pageCount", pageCount);
		// �ͻ�������
		String strCustomerewbcode = request.getParameter("customerewbcode");
		// ��ʼʱ��
		String strStartdate = request.getParameter("startdate");
		// ��ֹ����
		String strEnddate = request.getParameter("enddate");
		// ��������
		String strPkcode = request.getParameter("pkcode");
		//ҳ��״̬
		String linkValue = request.getParameter("linkValue");
		//����״̬
		String strCwscwscode = request.getParameter("Cwscwscode");	
		//�����̵���
		String strCwserverewbcode = request.getParameter("strCwserverewbcode");		
		//����״̬
		String strWbtpwbtp_code =request.getParameter("wbtp_code"); 
		
		/*�����̵�������*/
		if(!StringUtility.isNull(strCwserverewbcode)){
			objWaybillforpredictCondition.setCwserverewbcode(strCwserverewbcode.trim());
			request.setAttribute("strCwserverewbcode", strCwserverewbcode);
		}
		if (!StringUtility.isNull(strCwscwscode)) {
			objWaybillforpredictCondition.setCwcwscode(strCwscwscode);
			request.setAttribute("Cwscode", strCwscwscode);
		} else {
			request.setAttribute("Cwscode", null);
		}
		if (!StringUtility.isNull(strPkcode)) {
			objWaybillforpredictCondition.setPkpkcode(strPkcode);
			request.setAttribute("pkcode", strPkcode);
		} else {
			request.setAttribute("pkcode", null);
		}
		String link = request.getParameter("link");						
		if(StringUtility.isNull(strStartdate)){
			strStartdate=DateUtility.getMoveDate(DateFormatUtility.getStandardSysdate(), -3);
		}
		if(StringUtility.isNull(strEnddate)){
			strEnddate=DateFormatUtility.getStandardSysdate();
		}
		
		
		
		if ("transient".equals(link)) {// �ݴ涩��״̬
			objWaybillforpredictCondition.setCwcwscode("CTS");			
			objWaybillforpredictCondition.setStartcreatedate(strStartdate);
			request.setAttribute("startdate", strStartdate);
			objWaybillforpredictCondition.setEndcreatedate(strEnddate);
			request.setAttribute("enddate", strEnddate);
			linkValue = "1";
			// ���걨����״̬
		}else if ("declared".equals(link)) {
			objWaybillforpredictCondition.setCwcwscode("CHD");
			objWaybillforpredictCondition.setStartcreatedate(strStartdate);
			request.setAttribute("startdate", strStartdate);
			objWaybillforpredictCondition.setEndcreatedate(strEnddate);
			request.setAttribute("enddate", strEnddate);
		
			if(netout.equals("wai") || netout.equals("def")){
				request.setAttribute("netout", netout);
			}
			linkValue = "2";
			// �Ѵ�ӡ����״̬
		} 	else if ("printed".equals(link)) {
			objWaybillforpredictCondition.setCwcwscode("CHP");
			objWaybillforpredictCondition.setStartcreatedate(strStartdate);
			request.setAttribute("startdate", strStartdate);
			objWaybillforpredictCondition.setEndcreatedate(strEnddate);
			request.setAttribute("enddate", strEnddate);
			linkValue = "3";
			// ���ջ�����״̬
			request.setAttribute("linkValue",3);
		} else if ("received".equals(link)) {
			objWaybillforpredictCondition.setIncwscode("SI,IP,SO");
			objWaybillforpredictCondition.setStartsignindate(strStartdate);			
			request.setAttribute("startdate", strStartdate);			
			objWaybillforpredictCondition.setEndsignindate(strEnddate);			
			request.setAttribute("enddate", strEnddate);
			if(!StringUtility.isNull(strWbtpwbtp_code)){
				objWaybillforpredictCondition.setWbtpwbtp_code(strWbtpwbtp_code);
				request.setAttribute("wbtp_code", strWbtpwbtp_code);
			}
			linkValue = "5";
			request.setAttribute("linkValue",5);
			this.getLabelCode(strCocode);
			//���������
		} else if ("allocate".equals(link)) {
			objWaybillforpredictCondition.setHwattacheinfosign("I");
			objWaybillforpredictCondition.setStartcreatedate(strStartdate);
			request.setAttribute("startdate", strStartdate);
			objWaybillforpredictCondition.setEndcreatedate(strEnddate);		
			request.setAttribute("enddate", strEnddate);
			linkValue = "4";
			// ���϶���״̬
		} else if ("recycle".equals(link)) {
			objWaybillforpredictCondition.setCwcwscode("CEL");
			objWaybillforpredictCondition.setStartcreatedate(strStartdate);			
			request.setAttribute("startdate", strStartdate);
			objWaybillforpredictCondition.setEndcreatedate(strEnddate);
			request.setAttribute("enddate", strEnddate);
			
		}

		if(netout.equals("wai")){
			strEnddate=DateFormatUtility.getStandardSysdate();
			strStartdate=DateUtility.getMoveDate(strEnddate, -3);
			objWaybillforpredictCondition.setStartcreatedate(strStartdate);	
			objWaybillforpredictCondition.setEndcreatedate(strEnddate);
			request.setAttribute("strStartdate", strStartdate);
			request.setAttribute("strEnddate", strEnddate);
			objWaybillforpredictCondition.setCwcwscode("");
		}
		if(netout.equals("def")){
			objWaybillforpredictCondition.setCwcwscode("");
		}
		m_objPageConfig.setMaxPageResultCount(pageCount);
		objWaybillforpredictCondition.setPageConfig(m_objPageConfig);//��ҳ����
		//�в�ѯ
		//String field=request.getParameter("colSort");
		String field = null;
		if(StringUtility.isNull(field)){
			if(link == null){
			}else{
			if(link.equals("transient")){field="cw.cw_createdate";}
			else if(link.equals("declared")){field="cw.cw_createdate";}//Ĭ�����걨ʱ������
			else if(link.equals("printed")){field="cw.cw_createdate";}//Ĭ���Ѵ�ӡʱ������
			else if(link.equals("received")){field="hw_signindate";}//Ĭ�����ջ�ʱ������
			else if(link.equals("queryRecycleOrders")){field= "cw.cw_createdate";}
			}
		}
		//����ʽ
		String sort=request.getParameter("sortWay");
		if(StringUtility.isNull(sort)){
			sort="DESC";
		}

		//�Ƿ�ֻ��ʾ���մ�ӡ��
		String show=request.getParameter("isShow");
		if(!StringUtility.isNull(show)){
			objWaybillforpredictCondition.setStartlbprintdate(new Date(System.currentTimeMillis()).toString());
			request.setAttribute("show", show);
		}
	
		//���ݿͻ����Ų�ѯ��ҳ������
		if (!StringUtility.isNull(strCustomerewbcode)) {
			objWaybillforpredictCondition = new WaybillforpredictCondition();
			objWaybillforpredictCondition.setCwcustomerewbcode(strCustomerewbcode);
			request.setAttribute("customerewbcode", strCustomerewbcode);
		}	
		//����ҳ�����
		request.setAttribute("linkValue", linkValue);
		// ���ÿͻ�
		objWaybillforpredictCondition.setCocodecustomer(strCocode);		
		listWaybillforpredictColumnsReturn = HousewaybillDemand.queryForPredict(objWaybillforpredictCondition, field, sort);
		
		if (listWaybillforpredictColumnsReturn != null
				&& listWaybillforpredictColumnsReturn.size() > 0) {
			request.setAttribute("listWaybillforpredictColumns",listWaybillforpredictColumnsReturn);
		}
		//request.setAttribute("filed", field);
		request.setAttribute("sortWays", sort);
		return SUCCESS;
	}
	/**
	 *����Ecel,2016-11-26
	 *Edit by wukq
	 * */
	public void export() throws Exception {
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
		String strCocode = (String) session.getAttribute("Cocode");
		if (StringUtility.isNull(strCocode)) {
			strCocode = "338";
		}
		WaybillforpredictCondition objWaybillforpredictCondition = new WaybillforpredictCondition();
		objWaybillforpredictCondition.setIncwscode("SI,IP,SO");
		WaybillforpredictColumns objWaybillforpredictColumns = null;
		List<WaybillforpredictColumns> listWaybillforpredict = new ArrayList<WaybillforpredictColumns>();
		String items = request.getParameter("items");
		String[] strCwCode = null;
		if (!StringUtility.isNull(items)) {
			strCwCode = items.split(",");
		}
		System.out.println(items);
		for (int i = 0; i < strCwCode.length; i++) {
			objWaybillforpredictCondition.setCwcode(strCwCode[i]);
			objWaybillforpredictColumns = (WaybillforpredictColumns) HousewaybillDemand
			.queryForPredict(objWaybillforpredictCondition).get(0);
			listWaybillforpredict.add(objWaybillforpredictColumns);
		}
		String xlsName = strCocode + "_"+ DateFormatUtility.getFileNameSysdate() + "_arrival.xls";
		String outputFile = request.getRealPath("/export_excel/" + xlsName);
		// ����һ��excel������
		HSSFWorkbook workbook = new HSSFWorkbook();
		// excel�������½�һ�¹�����
		HSSFSheet sheet = workbook.createSheet("Sheet1");
		// �����п��
		sheet.setColumnWidth(0, 4500);
		sheet.setColumnWidth(1, 3000);
		sheet.setColumnWidth(2, 8000);
		sheet.setColumnWidth(3, 8000);
		sheet.setColumnWidth(4, 8000);
		sheet.setColumnWidth(5, 3000);
		sheet.setColumnWidth(6, 3000);
		sheet.setColumnWidth(7, 4500);
		sheet.setColumnWidth(8, 6000);
		// ��������
		HSSFFont font = workbook.createFont();
		font.setFontName("Verdana");
		font.setBoldweight((short) 100);
		font.setFontHeight((short) 300);
		font.setColor(HSSFColor.BLUE.index);
		// ���õ�Ԫ���ʽ
		HSSFCellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
		// ���ñ߿�
		cellStyle.setBottomBorderColor(HSSFColor.RED.index);
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		// ��������
		cellStyle.setFont(font);
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);
		cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		// ������0λ�ô�����(��һ��)
		HSSFRow row = sheet.createRow((short) 0);
		HSSFCell cell1 = row.createCell((short) 0);
		HSSFCell cell2 = row.createCell((short) 1);
		HSSFCell cell3 = row.createCell((short) 2);
		HSSFCell cell4 = row.createCell((short) 3);
		HSSFCell cell5 = row.createCell((short) 4);
		HSSFCell cell6 = row.createCell((short) 5);
		HSSFCell cell7 = row.createCell((short) 6);
		HSSFCell cell8 = row.createCell((short) 7);
		HSSFCell cell9 = row.createCell((short) 8);

		cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell3.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell4.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell5.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell6.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell7.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell8.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell9.setCellType(HSSFCell.CELL_TYPE_STRING);

		cell1.setCellType(HSSFCell.ENCODING_UTF_16);
		cell2.setCellType(HSSFCell.ENCODING_UTF_16);
		cell3.setCellType(HSSFCell.ENCODING_UTF_16);
		cell4.setCellType(HSSFCell.ENCODING_UTF_16);
		cell5.setCellType(HSSFCell.ENCODING_UTF_16);
		cell6.setCellType(HSSFCell.ENCODING_UTF_16);
		cell7.setCellType(HSSFCell.ENCODING_UTF_16);
		cell8.setCellType(HSSFCell.ENCODING_UTF_16);
		cell9.setCellType(HSSFCell.ENCODING_UTF_16);

		cell1.setCellValue("�ͻ�������");
		cell2.setCellValue("��������");
		cell3.setCellValue("�ռ���");
		cell4.setCellValue("�ռ��˹�˾");
		cell5.setCellValue("Ŀ�Ĺ���");
		cell6.setCellValue("�ͻ�����");
		cell7.setCellValue("�Ʒ���");
		cell8.setCellValue("��˾������");
		cell9.setCellValue("�µ�ʱ��");

		Iterator iter = listWaybillforpredict.iterator();
		int temp = 0;
		while (iter.hasNext()) {
			++temp;
			row = sheet.createRow((short) temp);
			HSSFCell cell11 = row.createCell((short) 0);
			HSSFCell cell12 = row.createCell((short) 1);
			HSSFCell cell13 = row.createCell((short) 2);
			HSSFCell cell14 = row.createCell((short) 3);
			HSSFCell cell15 = row.createCell((short) 4);
			HSSFCell cell16 = row.createCell((short) 5);
			HSSFCell cell17 = row.createCell((short) 6);
			HSSFCell cell18 = row.createCell((short) 7);
			HSSFCell cell19 = row.createCell((short) 8);

			WaybillforpredictColumns WaybillforpredictColumns = (WaybillforpredictColumns) iter.next();
			cell11.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell11.setCellType(HSSFCell.ENCODING_UTF_16);
			cell11.setCellValue(WaybillforpredictColumns.getCwcw_customerewbcode());
			cell12.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell12.setCellType(HSSFCell.ENCODING_UTF_16);
			cell12.setCellValue(WaybillforpredictColumns.getPkpk_sename());
			cell13.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell13.setCellType(HSSFCell.ENCODING_UTF_16);
			cell13.setCellValue(WaybillforpredictColumns.getHwhw_consigneename());
			cell14.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell14.setCellType(HSSFCell.ENCODING_UTF_16);
			cell14.setCellValue(WaybillforpredictColumns.getHwhw_consigneecompany());
			cell15.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell15.setCellType(HSSFCell.ENCODING_UTF_16);
			cell15.setCellValue(WaybillforpredictColumns.getDtdt_ename());
			cell16.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
			cell16.setCellType(HSSFCell.ENCODING_UTF_16);
			cell16.setCellValue(Double.parseDouble(WaybillforpredictColumns.getCwcw_customerchargeweight()));
			cell17.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
			cell17.setCellType(HSSFCell.ENCODING_UTF_16);
			cell17.setCellValue(Double.parseDouble(WaybillforpredictColumns.getCwcw_chargeweight()));
			cell18.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell18.setCellType(HSSFCell.ENCODING_UTF_16);
			cell18.setCellValue(WaybillforpredictColumns.getCwcw_serverewbcode());
			cell19.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell19.setCellType(HSSFCell.ENCODING_UTF_16);
			//cell19.setCellValue(WaybillforpredictColumns.getCwcw_createdate());
			cell19.setCellValue(DateFormatUtility.getStandardSysdate());
		}
		File path = new File(outputFile);
		path.delete();
		FileOutputStream fout = new FileOutputStream(outputFile);
		workbook.write(fout);
		fout.flush();
		fout.close();
		response.getWriter().print(xlsName);
	}
	/**
	 * ����,�����Ѵ�ӡ����excel�ļ�
	 */
	public void exportprint() throws Exception {
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
		String strCocode = (String) session.getAttribute("Cocode");
		if (StringUtility.isNull(strCocode)) {
			strCocode = "338";
		}
		WaybillforpredictCondition objWaybillforpredictCondition = new WaybillforpredictCondition();
		objWaybillforpredictCondition.setIncwscode("CHP");
		WaybillforpredictColumns objWaybillforpredictColumns = null;
		List<WaybillforpredictColumns> listWaybillforpredict = new ArrayList<WaybillforpredictColumns>();
		String items = request.getParameter("items");
		String[] strCwCode = null;
		if (!StringUtility.isNull(items)) {
			strCwCode = items.split(",");
		}
		System.out.println(items);
		for (int i = 0; i < strCwCode.length; i++) {
			objWaybillforpredictCondition.setCwcode(strCwCode[i]);
			objWaybillforpredictColumns = (WaybillforpredictColumns) HousewaybillDemand
			.queryForPredict(objWaybillforpredictCondition).get(0);
			listWaybillforpredict.add(objWaybillforpredictColumns);
		}
		String xlsName = strCocode + "_"+ DateFormatUtility.getFileNameSysdate() + "_arrival.xls";
		String outputFile = request.getRealPath("/export_excel/" + xlsName);
		// ����һ��excel������
		HSSFWorkbook workbook = new HSSFWorkbook();
		// excel�������½�һ�¹�����
		HSSFSheet sheet = workbook.createSheet("Sheet1");
		// �����п��
		sheet.setColumnWidth(0, 4500);
		sheet.setColumnWidth(1, 4500);
		sheet.setColumnWidth(2, 3000);
		sheet.setColumnWidth(3, 4500);
		sheet.setColumnWidth(4, 8000);
		sheet.setColumnWidth(5, 6000);
		sheet.setColumnWidth(6, 6000);
		sheet.setColumnWidth(7, 6000);
		sheet.setColumnWidth(8, 6000);
		sheet.setColumnWidth(9, 3000);
		sheet.setColumnWidth(10, 3000);
		sheet.setColumnWidth(11, 3000);
		sheet.setColumnWidth(12, 3000);
		// ��������
		HSSFFont font = workbook.createFont();
		font.setFontName("Verdana");
		font.setBoldweight((short) 100);
		font.setFontHeight((short) 300);
		font.setColor(HSSFColor.BLUE.index);
		// ���õ�Ԫ���ʽ
		HSSFCellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("@"));
		// ���ñ߿�
		cellStyle.setBottomBorderColor(HSSFColor.RED.index);
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		// ��������
		cellStyle.setFont(font);
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		cellStyle.setFillForegroundColor(HSSFColor.LIGHT_TURQUOISE.index);
		cellStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		// ������0λ�ô�����(��һ��)
		HSSFRow row = sheet.createRow((short) 0);
		HSSFCell cell1 = row.createCell((short) 0);
		HSSFCell cell2 = row.createCell((short) 1);
		HSSFCell cell3 = row.createCell((short) 2);
		HSSFCell cell4 = row.createCell((short) 3);
		HSSFCell cell5 = row.createCell((short) 4);
		HSSFCell cell6 = row.createCell((short) 5);
		HSSFCell cell7 = row.createCell((short) 6);
		HSSFCell cell8 = row.createCell((short) 7);
		HSSFCell cell9 = row.createCell((short) 8);
		HSSFCell cell10 = row.createCell((short) 9);
		HSSFCell cell11 = row.createCell((short) 10);
		HSSFCell cell12 = row.createCell((short) 11);
		HSSFCell cell13 = row.createCell((short) 12);

		cell1.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell2.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell3.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell4.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell5.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell6.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell7.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell8.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell9.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell10.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell11.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell12.setCellType(HSSFCell.CELL_TYPE_STRING);
		cell13.setCellType(HSSFCell.CELL_TYPE_STRING);

		cell1.setCellType(HSSFCell.ENCODING_UTF_16);
		cell2.setCellType(HSSFCell.ENCODING_UTF_16);
		cell3.setCellType(HSSFCell.ENCODING_UTF_16);
		cell4.setCellType(HSSFCell.ENCODING_UTF_16);
		cell5.setCellType(HSSFCell.ENCODING_UTF_16);
		cell6.setCellType(HSSFCell.ENCODING_UTF_16);
		cell7.setCellType(HSSFCell.ENCODING_UTF_16);
		cell8.setCellType(HSSFCell.ENCODING_UTF_16);
		cell9.setCellType(HSSFCell.ENCODING_UTF_16);
		cell10.setCellType(HSSFCell.ENCODING_UTF_16);
		cell11.setCellType(HSSFCell.ENCODING_UTF_16);
		cell12.setCellType(HSSFCell.ENCODING_UTF_16);
		cell13.setCellType(HSSFCell.ENCODING_UTF_16);

		cell1.setCellValue("�ͻ�����");
		cell2.setCellValue("��ǧ����");
		cell3.setCellValue("���䷽ʽ");
		cell4.setCellValue("Ŀ�Ĺ���");
		cell5.setCellValue("�ռ���");
		cell6.setCellValue("��ӡʱ��");
		cell7.setCellValue("�ϴ�ʱ��");
		cell8.setCellValue("����ʱ��");
		cell9.setCellValue("�ռ��˹�˾");
		cell10.setCellValue("�ͻ�����");
		cell11.setCellValue("�¼Ʒ���");
		cell12.setCellValue("�ۼ�״̬");
		cell13.setCellValue("������");

		Iterator iter = listWaybillforpredict.iterator();
		int temp = 0;
		while (iter.hasNext()) {
			++temp;
			row = sheet.createRow((short) temp);
			HSSFCell cell15 = row.createCell((short) 0);
			HSSFCell cell16 = row.createCell((short) 1);
			HSSFCell cell17 = row.createCell((short) 2);
			HSSFCell cell18 = row.createCell((short) 3);
			HSSFCell cell19 = row.createCell((short) 4);
			HSSFCell cell20 = row.createCell((short) 5);
			HSSFCell cell21 = row.createCell((short) 6);
			HSSFCell cell22 = row.createCell((short) 7);
			HSSFCell cell23 = row.createCell((short) 8);
			HSSFCell cell24 = row.createCell((short) 9);
			HSSFCell cell25 = row.createCell((short) 10);
			HSSFCell cell26 = row.createCell((short) 11);
			HSSFCell cell27 = row.createCell((short) 12);

			WaybillforpredictColumns WaybillforpredictColumns = (WaybillforpredictColumns) iter.next();
			cell15.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell15.setCellType(HSSFCell.ENCODING_UTF_16);
			cell15.setCellValue(WaybillforpredictColumns.getCwcw_customerewbcode());
			cell16.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell16.setCellType(HSSFCell.ENCODING_UTF_16);
			cell16.setCellValue(WaybillforpredictColumns.getCwcw_ewbcode());
			cell17.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell17.setCellType(HSSFCell.ENCODING_UTF_16);
			cell17.setCellValue(WaybillforpredictColumns.getPkpk_sename());
			cell18.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell18.setCellType(HSSFCell.ENCODING_UTF_16);
			cell18.setCellValue(WaybillforpredictColumns.getDtdt_name());
			cell19.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell19.setCellType(HSSFCell.ENCODING_UTF_16);
			cell19.setCellValue(WaybillforpredictColumns.getHwhw_consigneename());
			cell20.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
			cell20.setCellType(HSSFCell.ENCODING_UTF_16);
			// cell20.setCellValue(WaybillforpredictColumns.getHwhw_customerlabelprintdate());
			cell20.setCellValue(DateFormatUtility.getStandardSysdate());

			cell21.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
			cell21.setCellType(HSSFCell.ENCODING_UTF_16);
			//cell21.setCellValue(WaybillforpredictColumns.getCwcw_createdate());
			cell21.setCellValue(DateFormatUtility.getStandardSysdate());


			cell22.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell22.setCellType(HSSFCell.ENCODING_UTF_16);
			//cell22.setCellValue(WaybillforpredictColumns.getHwhw_customerdeclaredate());
			cell22.setCellValue(DateFormatUtility.getStandardSysdate());


			cell23.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell23.setCellType(HSSFCell.ENCODING_UTF_16);
			cell23.setCellValue(WaybillforpredictColumns.getHwhw_consigneecompany());
			cell24.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell24.setCellType(HSSFCell.ENCODING_UTF_16);
			cell24.setCellValue(WaybillforpredictColumns.getCwcw_customerchargeweight());
			cell25.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell25.setCellType(HSSFCell.ENCODING_UTF_16);
			cell25.setCellValue(WaybillforpredictColumns.getCwcw_chargeweight());
			cell26.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell26.setCellType(HSSFCell.ENCODING_UTF_16);
			cell26.setCellValue(WaybillforpredictColumns.getIhsihs_name());
			cell27.setCellType(HSSFCell.CELL_TYPE_STRING);
			cell27.setCellType(HSSFCell.ENCODING_UTF_16);
			if(WaybillforpredictColumns.getHwhw_attacheinfosign()==null){
				cell27.setCellValue("");
			}else{
				if(WaybillforpredictColumns.getHwhw_attacheinfosign().equals("I")){
					cell27.setCellValue("���");
				}else{
					cell27.setCellValue("");
				}
			}						
		}
		File path = new File(outputFile);
		path.delete();
		FileOutputStream fout = new FileOutputStream(outputFile);
		workbook.write(fout);
		fout.flush();
		fout.close();
		response.getWriter().print(xlsName);
	}
	/***
	 * ����,�Ѵ�ӡ�����ۼ�
	 */
	public String detainOrders() throws Exception {
		String strCocode = (String) session.getAttribute("Cocode");
		if (StringUtility.isNull(strCocode)) {
			strCocode = "338";
		}
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
		if (!("".equals(request.getParameterValues("checkbox")) || request
				.getParameterValues("checkbox") == null)) {
			String[] strCwcode = request.getParameterValues("checkbox");
			for (int i = 0; i < strCwcode.length; i++) {
				new PredictOrderEX().hold(strCocode, strCwcode[i], OpId);
			}
		}
		return SUCCESS;
	}

	/**
	 * ���ˣ�ɾ���ݴ涩��
	 */
	public String deleteTransientOrders() throws Exception {
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
		// ��ѡ������ɾ��
		if (!("".equals(request.getParameterValues("checkbox")) || request
				.getParameterValues("checkbox") == null)) {
			String[] strCwCode = request.getParameterValues("checkbox");
			for (int i = 0; i < strCwCode.length; i++) {
				new PredictOrderEX().modifyCorewaybillStatus(strCwCode[i],"CEL", OpId);
			}
		}
		return SUCCESS;
	}



	/**
	 * ���ˣ��걨�����
	 * 
	 * */
	public String complete() throws Exception{
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
		if (!("".equals(request.getParameterValues("checkbox")) || request
				.getParameterValues("checkbox") == null)) {
			String[] strCwCode = request.getParameterValues("checkbox");
			for (int i = 0; i < strCwCode.length; i++) {
				Predictwaybill predictwaybill = new Predictwaybill();
				predictwaybill.upload(strCwCode[i], OpId);
				predictwaybill.print(strCwCode[i],OpId);
			}
		}
		return SUCCESS;
	}	


	/**
	 * ����,�����Ѵ�ӡ״̬��Ϊ�ݴ�״̬
	 */
	public String newRecoverOrders() throws Exception {
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
		if (!("".equals(request.getParameterValues("checkbox")) || request
				.getParameterValues("checkbox") == null)) {
			String[] strCwCode = request.getParameterValues("checkbox");
			for (int i = 0; i < strCwCode.length; i++) {
				String strPwbcode = PredictOrderDemand.getPwbcodeByCwcode(strCwCode[i]);
				if(!StringUtility.isNull(strPwbcode))
					new Predictwaybill().withdraw(strPwbcode,OpId, false);
				else 
					new PredictOrderEX().modifyCorewaybillStatus(strCwCode[i],"CTS", OpId);
			}
		}
		return SUCCESS;
	}

	/**
	 * ��������
	 * 
	 * @return
	 * @throws Exception
	 */
	public String addAlonecustoms() throws Exception {
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
		if (!("".equals(request.getParameterValues("checkbox")) || request
				.getParameterValues("checkbox") == null)) {
			String[] strCwCode = request.getParameterValues("checkbox");
			for (int i = 0; i < strCwCode.length; i++) {
				Specialtype objSpecialtype = new Specialtype();
				if(request.getParameter("isbg").equals("y")){
					objSpecialtype.addSpecialtype(strCwCode[i], "A0101", OpId,"�ͻ���վ���뵥������", false);
				}else{
					objSpecialtype.delete(strCwCode[i], "A0101");
				}
			}
		}
		return SUCCESS;
	}

	

	

	/**
	 * ��������ɾ���ݴ涩��
	 */
	public String deleteBatch() throws Exception {
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
		String customerewbcode = request.getParameter("customerewbcode").trim();
		String strHwconsigneename = request.getParameter("strHwconsigneename").trim();
		String pkCode = request.getParameter("pkCode");
		String strHwConsigneeCompany = request.getParameter("strHwConsigneeCompany").trim();
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String buyerid = request.getParameter("buyerid");
		String transactionid = request.getParameter("transactionid");
		WaybillforpredictCondition objWaybillforpredictCondition = new WaybillforpredictCondition();
		// �ݴ�״̬����
		objWaybillforpredictCondition.setCwcwscode("CTS");
		objWaybillforpredictCondition.setCwcustomerewbcode(customerewbcode);
		objWaybillforpredictCondition.setHwconsigneename(strHwconsigneename);
		objWaybillforpredictCondition.setPkpkcode(pkCode);
		objWaybillforpredictCondition.setHwconsigneecompany(strHwConsigneeCompany);
		if (!StringUtility.isNull(startdate)) {
			objWaybillforpredictCondition.setStartcreatedate(startdate);
		}
		if (!StringUtility.isNull(enddate)) {
			objWaybillforpredictCondition.setEndcreatedate(enddate);
		}
		objWaybillforpredictCondition.setHwbuyerid(buyerid);
		objWaybillforpredictCondition.setHwtransactionid(transactionid);

		List<WaybillforpredictColumns> list = HousewaybillDemand
		.queryForPredict(objWaybillforpredictCondition);
		if (list != null && list.size() > 0) {
			Iterator iter = list.iterator();
			while (iter.hasNext()) {
				WaybillforpredictColumns objWaybillforpredictColumns = (WaybillforpredictColumns) iter.next();
				// System.out.println("==========="+objWaybillforpredictColumns.getCwcw_code());
				new PredictOrderEX().modifyCorewaybillStatus(objWaybillforpredictColumns
						.getCwcw_code(), "CEL", OpId);
			}
		}
		return SUCCESS;
	}

	/**
	 * (��)��������ɾ���ݴ涩��
	 */
	public String newDeleteBatch() throws Exception {
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
		String customerewbcode = request.getParameter("customerewbcode").trim();
		String strHwconsigneename = request.getParameter("strHwconsigneename").trim();
		String pkCode = request.getParameter("pkCode");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		//String buyerid = request.getParameter("buyerid");
		//String transactionid = request.getParameter("transactionid");
		PredictwaybillCondition objpPredictwaybillCondition = new PredictwaybillCondition();
		// �ݴ�״̬����
		objpPredictwaybillCondition.setPwbs_code("CTS");
		objpPredictwaybillCondition.setPwb_orderid(customerewbcode);
		objpPredictwaybillCondition.setPwb_consigneename(strHwconsigneename);
		objpPredictwaybillCondition.setPk_code(pkCode);
		if (!StringUtility.isNull(startdate)) {
			objpPredictwaybillCondition.setStartcreatedate(startdate);
		}
		if (!StringUtility.isNull(enddate)) {
			objpPredictwaybillCondition.setEndcreatedate(enddate);
		}
		//		objpPredictwaybillCondition.setHwbuyerid(buyerid);
		//		objpPredictwaybillCondition.setHwtransactionid(transactionid);
		List<WaybillforpredictColumns> list = PredictwaybillDemand.query(objpPredictwaybillCondition);
		if (list != null && list.size() > 0) {
			Iterator iter = list.iterator();
			while (iter.hasNext()) {
				PredictwaybillColumns objPredictwaybillColumns = (PredictwaybillColumns) iter.next();
				String strPwbcode = objPredictwaybillColumns.getPwbpwb_code();
				new Predictwaybill().withdraw(strPwbcode, OpId, false);
			}
		}
		return SUCCESS;
	}

	

	/**
	 * ���ˣ��걨����
	 */
	public String declare() throws Exception{
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
		if (!("".equals(request.getParameterValues("checkbox")) || request
				.getParameterValues("checkbox") == null)) {
			String[] strCwCode = request.getParameterValues("checkbox");
			for (int i = 0; i < strCwCode.length; i++) {
				new PredictOrderEX().modifyCorewaybillStatus(strCwCode[i],"CHD", OpId);
			}
		}
		return SUCCESS;
	}
	/**
	 * ���ˣ��޸Ļ�����Ϣ
	 * */
	@SuppressWarnings("unchecked")
	public String queryModifyOrders() throws Exception {
		String cw_code = request.getParameter("cw_code");
		WaybillforpredictColumns objWaybillforpredictColumns = HousewaybillDemand
				.loadForPredict(cw_code);
		List listCargoinfoColumns = CargoInfoDemand.queryByCwCode(cw_code);
		request.setAttribute("cw_code", cw_code);
		request.setAttribute("objWaybillforpredictColumns",
				objWaybillforpredictColumns);
		request.setAttribute("listCargoinfoColumns", listCargoinfoColumns);
		return "success";
	}





	/**
	 * �ύ�걨ʱ���鶩��
	 */
	public String declareCheckOut()throws Exception{
		int num=0;//�ж��Ƿ�����Ҫ���ǻ�ϲ��ļ�¼
		List<com.daiyun.predictwaybill.PredictOrderColumnsEX> pocList=new ArrayList<com.daiyun.predictwaybill.PredictOrderColumnsEX>();;

		if (!("".equals(request.getParameter("cwcode")) || request
				.getParameter("cwcode") == null)) {
			String[] strPwbCode = request.getParameter("cwcode").split(",");

			PredictwaybillColumns predictway =new PredictwaybillColumns();
			PredictOrderCheck predictOrder= new PredictOrderCheck();
			PromptUtility promptUtility=null;
			com.daiyun.predictwaybill.PredictOrderColumnsEX pocex =null;

			for (int i = 0; i < strPwbCode.length; i++) {
				predictway =PredictwaybillDemand.load(strPwbCode[i]);
				if (predictway!=null){
					promptUtility=predictOrder.checkRepeatCustomerEWB(predictway.getCoco_code(), 
							predictway.getPwbpwb_orderid(), 
							predictway.getPwbpwb_consigneename(),
							"");
					pocex =new com.daiyun.predictwaybill.PredictOrderColumnsEX();

					if(promptUtility==null){
						pocex.setOpermode("");
						pocex.setPredictwaybillColumns(predictway);
					}else{
						num++;
						pocex.setOpermode(promptUtility.getPromptCode());
						pocex.setPromptinfo(promptUtility.getDescribtion());
						pocex.setPredictwaybillColumns(predictway);
					}
					pocList.add(i,pocex);
				}
			}
			//������Ҫ�ϲ��򸲸ǵ�����
			if(num>0){
				session.setAttribute("pocList", pocList);
			}
		}

		//���û����Ҫ���ǻ�ϲ��ļ�¼����ֱֵ���걨
		if(num==0){
			List<String> strCode=new ArrayList<String>();
			StringBuilder sb=null;
			for(int j=0;j<pocList.size();j++){
				sb = new StringBuilder();
				strCode.add(sb.append(pocList.get(j).getPredictwaybillColumns().getPwbpwb_code())
						.append(",")
						.append(pocList.get(j).getPredictwaybillColumns().getPwbpwb_orderid()).toString());
			}
			request.setAttribute("strCode", strCode);
			return "declare";
		}
		request.setAttribute("pocList", pocList);
		return SUCCESS;
	}		

	


	/**
	 * �������걨״̬��Ϊ�ݴ�״̬
	 */
	public String recoverDeclaredOrders() throws Exception {
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
		if (!("".equals(request.getParameterValues("checkbox")) || request
				.getParameterValues("checkbox") == null)) {
			String[] strCwCode = request.getParameterValues("checkbox");
			for (int i = 0; i < strCwCode.length; i++) {
				new PredictOrderEX().modifyCorewaybillStatus(strCwCode[i],"CTS", OpId);
			}
		}
		return SUCCESS;
	}


	/**
	 * ���ˣ��������걨״̬��Ϊ�ݴ�״̬
	 */
	public String newRecoverDeclaredOrders() throws Exception {
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
		if (!("".equals(request.getParameterValues("checkbox")) || request
				.getParameterValues("checkbox") == null)) {
			String[] strCwcode = request.getParameterValues("checkbox");
			for (int i = 0; i < strCwcode.length; i++) {
				String strPwbcode =PredictOrderDemand.getPwbcodeByCwcode(strCwcode[i]);
				if(!StringUtility.isNull(strPwbcode))
					new Predictwaybill().withdraw(strPwbcode, OpId, false);
				else 
					new PredictOrderEX().modifyCorewaybillStatus(strCwcode[i],"CTS", OpId);
			}
		}
		return SUCCESS;
	}



	/**
	 *���ˣ� ���
	 */
	public String allocate() throws Exception{
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
		if (!("".equals(request.getParameterValues("checkbox")) || request
				.getParameterValues("checkbox") == null)) {
			String[] strCwCode = request.getParameterValues("checkbox");
			for (int i = 0; i < strCwCode.length; i++) {
				new PredictOrderEX().modifyAttacheinfosign(strCwCode[i], "I", OpId);
			}
		}
		return SUCCESS;
	}

	/**
	 * ���ˣ�������
	 */
	public String completeAllocate()throws Exception{
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId)) {
			OpId = "1";
		}
		if (!("".equals(request.getParameterValues("checkbox")) || request
				.getParameterValues("checkbox") == null)) {
			String[] strCwCode = request.getParameterValues("checkbox");
			for (int i = 0; i < strCwCode.length; i++) {
				new PredictOrderEX().modifyAttacheinfosign(strCwCode[i], "C", OpId);
			}
		}
		return SUCCESS;
	}

	/**
	 * ����վ����ɾ��
	 * */
	public String deleteRecycleOrders() throws Exception {
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId))
			OpId = "1";
		if (!"".equals(request.getParameterValues("checkbox"))
				&& request.getParameterValues("checkbox") != null) {
			String strCwCode[] = request.getParameterValues("checkbox");
			for (int i = 0; i < strCwCode.length; i++)
				(new PredictOrderEX()).modifyCorewaybillStatus(strCwCode[i],
						"EL", OpId);

		}
		return "success";
	}
	/**
	 * ����վ��ԭ
	 * */
	public String recoverRecycleOrders() throws Exception {
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId))
			OpId = "1";
		if (!"".equals(request.getParameterValues("checkbox"))
				&& request.getParameterValues("checkbox") != null) {
			String strCwCode[] = request.getParameterValues("checkbox");
			for (int i = 0; i < strCwCode.length; i++)
				(new PredictOrderEX()).modifyCorewaybillStatus(strCwCode[i],
						"CTS", OpId);

		}
		return "success";
	}
	/**
	 * ��������ɾ��
	 * */
	public String deleteBatchRecycle() throws Exception {
		String OpId = (String) session.getAttribute("OpId");
		if (StringUtility.isNull(OpId))
			OpId = "1";
		String customerewbcode = request.getParameter("customerewbcode").trim();
		String strHwconsigneename = request.getParameter("strHwconsigneename")
				.trim();
		String pkCode = request.getParameter("pkCode");
		String strHwConsigneeCompany = request.getParameter(
				"strHwConsigneeCompany").trim();
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		String buyerid = request.getParameter("buyerid");
		String transactionid = request.getParameter("transactionid");
		WaybillforpredictCondition objWaybillforpredictCondition = new WaybillforpredictCondition();
		objWaybillforpredictCondition.setCwcwscode("CEL");
		objWaybillforpredictCondition.setCwcustomerewbcode(customerewbcode);
		objWaybillforpredictCondition.setHwconsigneename(strHwconsigneename);
		objWaybillforpredictCondition.setPkpkcode(pkCode);
		objWaybillforpredictCondition
				.setHwconsigneecompany(strHwConsigneeCompany);
		if (!StringUtility.isNull(startdate))
			objWaybillforpredictCondition.setStartcreatedate(startdate);
		if (!StringUtility.isNull(enddate))
			objWaybillforpredictCondition.setEndcreatedate(enddate);
		objWaybillforpredictCondition.setHwbuyerid(buyerid);
		objWaybillforpredictCondition.setHwtransactionid(transactionid);
		List list = HousewaybillDemand
				.queryForPredict(objWaybillforpredictCondition);
		if (list != null && list.size() > 0) {
			WaybillforpredictColumns objWaybillforpredictColumns;
			for (Iterator iter = list.iterator(); iter.hasNext(); (new PredictOrderEX())
					.modifyCorewaybillStatus(objWaybillforpredictColumns
							.getCwcw_code(), "EL", OpId))
				objWaybillforpredictColumns = (WaybillforpredictColumns) iter
						.next();

		}
		return "success";
	}
	/**
	 * qucklyOrder
	 * */
	public String qucklyOrder(){
		
		String Ctctcodes = request.getParameter("Ctctcode");//��������
		String[] destination_2 = request.getParameterValues("destination_2");//Ŀ�Ĺ���
		String Dtdt_hubcode = request.getParameter("Dtdt_hubcode");//Ŀ�Ĺ��Ҷ�����
		String OrginDtcode = request.getParameter("OrginDtcode");//���˳���
		String Pmpmcode = request.getParameter("Pmpmcode");//���ѷ�ʽ
		String Grossweight = request.getParameter("Grossweight");//��������
		
		List<CorewaybillpiecesColumns> listPieces = (List<CorewaybillpiecesColumns>) session.getAttribute("listPieces");
		String salebean_Pkcode = request.getParameter("salebean_Pkcode");//��������
		String salebean_Freightvalue = request.getParameter("salebean_Freightvalue");
		String salebean_Chargeweight = request.getParameter("salebean_Chargeweight");
		//String salebean_Incidentalvalue = request.getParameter("salebean_Incidentalvalue");
		//String salebean_Surchargevalue = request.getParameter("salebean_Surchargevalue");	
		//String salebean_Grossweight = request.getParameter("salebean_Grossweight");
		//String salebean_Volumeweight = request.getParameter("salebean_Volumeweight");
		//String salebean_Volumerate = request.getParameter("salebean_Volumerate");
		request.setAttribute("destination_2", destination_2);
		request.setAttribute("listPieces", listPieces);
		request.setAttribute("salebean_Pkcode", salebean_Pkcode);
		request.setAttribute("Ctctcodes", Ctctcodes);
		request.setAttribute("Dtdt_hubcode", Dtdt_hubcode);
		request.setAttribute("OrginDtcode", OrginDtcode);
		request.setAttribute("Pmpmcode", Pmpmcode);
		request.setAttribute("Grossweight", Grossweight);
		request.setAttribute("salebean_Freightvalue", salebean_Freightvalue);
		request.setAttribute("salebean_Chargeweight", salebean_Chargeweight);
		//request.setAttribute("salebean_Incidentalvalue", salebean_Incidentalvalue);
		//request.setAttribute("salebean_Surchargevalue", salebean_Surchargevalue);
		//request.setAttribute("salebean_Grossweight", salebean_Grossweight);
		//request.setAttribute("salebean_Volumeweight", salebean_Volumeweight);
		//request.setAttribute("salebean_Volumerate", salebean_Volumerate);

		return SUCCESS;
	}
	
	
	
}
