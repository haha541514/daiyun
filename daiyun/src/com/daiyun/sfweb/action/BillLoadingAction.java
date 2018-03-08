package com.daiyun.sfweb.action;


import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.CollectionUtility;
import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.operation.batchwaybill.bl.ABatchWayBill;
import kyle.leis.eo.operation.batchwaybill.bl.BillOfLadingBatchWayBill;
import kyle.leis.eo.operation.batchwaybill.da.BatchwaybillColumns;
import kyle.leis.eo.operation.batchwaybill.da.BatchwaybillCondition;
import kyle.leis.eo.operation.batchwaybill.dax.BatchWayBillDemand;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeColumns;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeCondition;
import kyle.leis.es.company.shipperconsignee.dax.ShipperconsigneeDemand;
import kyle.leis.fs.dictionary.enterpriseelement.da.EnterpriseelementColumns;
import kyle.leis.fs.dictionary.enterpriseelement.da.EnterpriseelementCondition;
import kyle.leis.fs.dictionary.enterpriseelement.dax.EnterpriseelementDemand;

/**
 * @author Create by wukq
 * @date:2016-11-28
 */
public class BillLoadingAction extends ActionSupportEX {

	private static final long serialVersionUID = 1L;

	/**
	 * 提货单查询
	 * @throws Exception 
	 * */
	@SuppressWarnings("unchecked")
	public String BillLoading() throws Exception{
		String strStartdate = request.getParameter("startdate");
		String strEnddate = request.getParameter("enddate");
		String bwlablecode = request.getParameter("bwlablecode");//提单号	
	
		String strEecode = (String)session.getAttribute("Eecode");
		String bwsStatus = request.getParameter("bwsStatus");	
		if(strStartdate == null && strEnddate ==null){
			strEnddate = DateFormatUtility.getStandardSysdate();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar calendar = Calendar.getInstance();
			//calendar.add(Calendar.MONTH,-3);
			calendar.add(Calendar.DATE, -3);
			Date time = calendar.getTime();
			strStartdate = sf.format(time);
		}
		BatchwaybillCondition objBWCondition = new BatchwaybillCondition();
		if(bwlablecode != null && bwlablecode.trim() != ""){
			objBWCondition.setBwlabelcode(bwlablecode.trim());
			request.setAttribute("bwlablecode", bwlablecode);
		}
		if(bwsStatus!= null){
			if("NW".equals(bwsStatus)||  "AD".equals(bwsStatus) ||"EL".equals(bwsStatus)){
				objBWCondition.setBwscode(bwsStatus);
			}else{
				objBWCondition.setTwbscode(bwsStatus);
			}
			
			request.setAttribute("bwsStatus", bwsStatus);
		}
		objBWCondition.setAdtcode("T");//adtcode为T的是提货单
		objBWCondition.setStartcreatedate(strStartdate);
		objBWCondition.setEndcreatedate(strEnddate);
		objBWCondition.setEecode(strEecode);
		//m_objPageConfig.setMaxPageResultCount(9);
		//objBWCondition.setPageConfig(m_objPageConfig);
		List<BatchwaybillColumns> resultList = BatchWayBillDemand.query(objBWCondition );
		
		request.setAttribute("startdate", strStartdate);
		request.setAttribute("enddate", strEnddate);
		request.setAttribute("LinkValue", 1);
		request.setAttribute("BatchwaybillColumns", resultList);
		
		
		
		return SUCCESS;
	}
	/**
	 * 提货单管理
	 * @throws Exception 
	 * */
	public String BillLoadingManager() throws Exception{
		String bwBwcode = request.getParameter("bw_code");
		//String bwlabelcode = request.getParameter("bwlabelcode");
		String strEecode = (String)session.getAttribute("Eecode");
		
		BatchwaybillCondition objBWCondition = new BatchwaybillCondition();
		objBWCondition.setEecode(strEecode);
		if(bwBwcode !=null && bwBwcode != ""){
			objBWCondition.setBwcode(bwBwcode);
			BatchwaybillColumns columns = (BatchwaybillColumns) BatchWayBillDemand.query(objBWCondition ).get(0);
			request.setAttribute("twblabelcode", columns.getBwbwlabelcode());	
			request.setAttribute("BatchwaybillColumns2", columns);
			request.setAttribute("disablevalue", "disable");
			//是否能作废
			String ttstwbscode = columns.getTtstwbscode();
			if("DA".equals(ttstwbscode) || "AA".equals(ttstwbscode) || "CT".equals(ttstwbscode)){
				request.setAttribute("IsInvalid", 1);
			}
			
			
			
		}
		EnterpriseelementCondition objEnterpriseelementCondition = new EnterpriseelementCondition();
		objEnterpriseelementCondition.setEecode(strEecode);
		EnterpriseelementColumns objEnterpriseelementColumns = (EnterpriseelementColumns)EnterpriseelementDemand.query(objEnterpriseelementCondition).get(0);
		
		//CorporationdCondition objCorporationdCondition = new CorporationdCondition();
		//objCorporationdCondition.setCocode(strCocode);
		//CorporationdQuery objCorporationdQuery = new CorporationdQuery();
		//objCorporationdQuery.setCondition(objCorporationdCondition);
		//CorporationdColumns objCorporationdColumns = (CorporationdColumns)objCorporationdQuery.getResults().get(0);
		
		request.setAttribute("LinkValue", 2);
		request.setAttribute("eename", objEnterpriseelementColumns.getEeeename());
		//request.setAttribute("coconame", objCorporationdColumns.getCoconame());
		return SUCCESS;
	}
	
	
	/**
	 * 新建提货单
	 * @throws Exception 
	 * @throws Exception 
	 * */
	public String CreateBill() throws Exception {
		boolean isIgnoreNotice = true;
		String eecodeId = request.getParameter("eecodeId");
		String bw_totalgrossweight = request.getParameter("bw_totalgrossweight");//毛重
		String bw_totalpieces = request.getParameter("bw_totalpieces");
		String bw_remark = request.getParameter("bw_remark");
		String bw_contactperson = request.getParameter("bw_contactperson");
		String bw_contacttel = request.getParameter("bw_contacttel");

		String bw_contactaddress = request.getParameter("bw_contactaddress");
		String bweename = request.getParameter("bw_company");
		String strOperId = (String)session.getAttribute("OpId");

		String Cocode = (String)session.getAttribute("Cocode");
		ABatchWayBill trans = new BillOfLadingBatchWayBill();
		BatchwaybillColumns objBWColumns = new BatchwaybillColumns();
		setBWColumns(objBWColumns,eecodeId,Cocode,bw_totalgrossweight,bw_totalpieces,bw_remark,bw_contactperson,bw_contacttel
				,bw_contactaddress,bweename);
		
		trans.save(objBWColumns, strOperId, isIgnoreNotice);
		return SUCCESS;	
	
		
	}
	/**
	 * 保存提货单
	 * @throws Exception 
	 * */
	public void SaveBill() throws Exception{
		boolean isIgnoreNotice = true;
		String eecodeId = request.getParameter("eecodeId");
		String bw_totalgrossweight = request.getParameter("bw_totalgrossweight");//毛重
		String bw_totalpieces = request.getParameter("bw_totalpieces");
		String bw_remark = request.getParameter("bw_remark");
		String bw_contactperson = request.getParameter("bw_contactperson");
		String bw_contacttel = request.getParameter("bw_contacttel");
		//String twb_labelcode = request.getParameter("twb_labelcode");//运输主单生成
		String bw_contactaddress = request.getParameter("bw_contactaddress");
		String bweename = request.getParameter("bw_company");
		String strOperId = (String)session.getAttribute("OpId");

		String Cocode = (String)session.getAttribute("Cocode");
		String bwcodehidden = request.getParameter("bwcodehidden");
		ABatchWayBill trans = new BillOfLadingBatchWayBill();
		BatchwaybillColumns objBWColumns = new BatchwaybillColumns();
		if(!StringUtility.isNull(bwcodehidden)){
			objBWColumns.setBwbwcode(Long.parseLong(bwcodehidden));
		}
		
		setBWColumns(objBWColumns,eecodeId,Cocode,bw_totalgrossweight,bw_totalpieces,bw_remark,bw_contactperson,bw_contacttel
				,bw_contactaddress,bweename);	
		trans.save(objBWColumns, strOperId, isIgnoreNotice);
		response.getWriter().print("1");
		return ;	
	}
	/**
	 * 作废提货单
	 * @throws Exception 
	 * */
	public void InvalidBill() throws Exception{
		boolean isIgnoreNotice = true;
		String bwcodehidden = request.getParameter("bwcode");
		
		String strOperId = (String)session.getAttribute("OpId");
		ABatchWayBill trans = new BillOfLadingBatchWayBill();
		BatchwaybillColumns objBWColumns = new BatchwaybillColumns();
		objBWColumns.setBwbwcode(Long.parseLong(bwcodehidden));	
		trans.eliminate(bwcodehidden, strOperId, isIgnoreNotice);//作废
		response.getWriter().print("1");
	}
	
	public void setBWColumns(BatchwaybillColumns objBWColumns,String eecode,String Cocode ,String bw_totalgrossweight,
			String bw_totalpieces,String bw_remark,String bw_contactperson,String bw_contacttel,
			String bw_contactaddress,String bweename){

		objBWColumns.setEeeecode(eecode);
		objBWColumns.setCococode(Cocode);
		BigDecimal objtotal = new BigDecimal(bw_totalgrossweight).divide(new BigDecimal(1),3,4);
		objBWColumns.setBwbwtotalgrossweight(objtotal);
		objBWColumns.setBwbwtotalpieces(Integer.parseInt(bw_totalpieces));
		objBWColumns.setBwbwremark(bw_remark);		
		objBWColumns.setAdtadtcode("T");
		objBWColumns.setBwbwcontactaddress(bw_contactaddress);
		objBWColumns.setBwbwcontactperson(bw_contactperson);
		objBWColumns.setBwbwcontacttel(bw_contacttel);
		objBWColumns.setBwbwautogetgrossweightsign("Y");
		objBWColumns.setBwadddate(DateFormatUtility.getSysdate());
		objBWColumns.setBwsbwsname("Y");
		objBWColumns.setBwbwcontactcompany(bweename);
		
		//运输状态，运输code,公司名称，结算重量
		//objBWColumns.setBwsbwscode("NW");
		objBWColumns.setBwbwcreatedate(DateFormatUtility.getSysdate());
	
	}
	/**
	 * 获得提货单地址
	 * */
	public String tihuochange() throws Exception{
		String scscode = request.getParameter("scscode");
		ShipperconsigneeCondition objSCCondition = new ShipperconsigneeCondition();
		objSCCondition.setCmcocode((String)ServletActionContext.getRequest().getSession().getAttribute("Cocode"));
		objSCCondition.setScshipperconsigneetype("T");
		objSCCondition.setSccode(scscode);
		List<ShipperconsigneeColumns> TinfoList = ShipperconsigneeDemand.query(objSCCondition);
		
		if(!CollectionUtility.isNull(TinfoList)){
			ShipperconsigneeColumns columns = (ShipperconsigneeColumns)TinfoList.get(0);
			
			String connectInfo = toJson(columns.getScscname(),columns.getScscaddress1(),columns.getScsctelephone());
			response.getWriter().print(connectInfo);
		}
		return null;
	}
	
	public String toJson(String connectPerson,String connectAddress,String telephone){
		 JSONObject json=new JSONObject();  
		 json.accumulate("connectPerson", connectPerson);//联系人
		 json.accumulate("connectAddress", connectAddress);//联系地址
		 json.accumulate("telephone", telephone);
		// System.out.println(json.toString());
		 return json.toString();
	}
	
}
