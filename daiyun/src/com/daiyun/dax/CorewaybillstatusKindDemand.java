package com.daiyun.dax;


import java.util.ArrayList;
import java.util.List;

import kyle.common.util.jlang.CollectionUtility;

import kyle.leis.eo.customerservice.track.da.WaybilltransferphaseColumns;
import kyle.leis.eo.customerservice.track.da.WaybilltransferphaseQuery;
import kyle.leis.eo.operation.corewaybillpieces.da.CorewaybillpiecesColumns;
import kyle.leis.eo.operation.corewaybillpieces.da.CorewaybillpiecesCondition;
import kyle.leis.eo.operation.corewaybillpieces.da.CorewaybillpiecesQuery;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeColumns;
import kyle.leis.es.company.shipperconsignee.da.ShipperconsigneeCondition;
import kyle.leis.es.company.shipperconsignee.dax.ShipperconsigneeDemand;
import kyle.leis.fs.cachecontainer.da.CorewaybillstatusColumns;
import kyle.leis.fs.cachecontainer.da.CorewaybillstatusQuery;
import org.apache.struts2.ServletActionContext;






/**
 *运单状态，2016-9-21
 *
 */

public class CorewaybillstatusKindDemand{
	
	public CorewaybillstatusKindDemand(){
		
	}
	
	/**
	 * 查询已收货运单状态，去掉EL,CEL,RP
	 * 
	 * */
	public static List<CorewaybillstatusColumns> getAllCWSStatus() throws Exception{
		List<CorewaybillstatusColumns> listResults = new ArrayList<CorewaybillstatusColumns>();
		CorewaybillstatusQuery query = new CorewaybillstatusQuery();
		listResults= query.getResults();
		
		for(int i = 0 ; i< listResults.size() ; i++){
			if(listResults.get(i).getCwscwscode().equals("EL") || listResults.get(i).getCwscwscode().equals("CEL") || listResults.get(i).getCwscwscode().equals("PR")){
				listResults.remove(i);
			}
		}
		
		return listResults;
	}
	/**
	 * 2016-10-08
	 * 获得货物的尺寸
	 * @throws Exception 
	 * **/
	 public static String getGoodsSize(String cwcode) throws Exception{
		 String goodssize = "";
		 CorewaybillpiecesQuery query = new CorewaybillpiecesQuery();
		 CorewaybillpiecesCondition condition  = new CorewaybillpiecesCondition();
		 condition.setCwcode(cwcode);
		 query.setCondition(condition);
		 List list = query.getResults();
		if(!CollectionUtility.isNull(list) && list.size() > 0){
			
			CorewaybillpiecesColumns columns  =  (CorewaybillpiecesColumns) list.get(0);
			String length = columns.getCpcplength();
			String width = columns.getCpcpwidth();
			String height = columns.getCpcpheight();
			goodssize = length +" X " + width +" X " + height;
			return goodssize;
		} 
		
		 return goodssize;
	 }

	
	/**
	* @date 2016-10-11 by wukq
	* @param CorewaybillstatusKindDemand
	* @return List<WaybillforpredictColumns>
	* @version 1.0
	 * @param sort 
	 * @param field 
	 * @param objWaybillforpredictCondition 
	 * @throws Exception 
	*/
	/*public static List<WaybillforpredictQueryColumnsPlus> queryForpredict(WaybillforexportConditionPlus objWFPCondition, String field, String sort) throws Exception {
		//排序查询，默认是收货时间和降序
		WaybillforpredictQueryPlus objWFPQuery  = null;
		if(field == null){
			objWFPQuery = new WaybillforpredictQueryPlus();
		}else{
			objWFPQuery = new WaybillforpredictQueryPlus(field, sort);
		}
		
		String strCustomerEwbcode = objWFPCondition.getCwcustomerewbcode();
		if (!StringUtility.isNull(strCustomerEwbcode))
			objWFPCondition.setExistsorderid("");
		
		objWFPQuery.setCondition(objWFPCondition);
		List objList = objWFPQuery.getResults();
		
		if (!StringUtility.isNull(strCustomerEwbcode)) {
			objWFPQuery = new WaybillforpredictQueryPlus(field, sort);
			objWFPCondition.setCwcustomerewbcode("");
			objWFPCondition.setExistsorderid(strCustomerEwbcode);
			objWFPQuery.setCondition(objWFPCondition);
			List listResults = objWFPQuery.getResults();
			objList = addPredictNoExists(objList, listResults);
		}
		
		return objList;
	}
	private static List addPredictNoExists(List listSource,
			List listDestination) {
		if (listSource == null || listSource.size() < 1)
			return listDestination;
		if (listDestination == null || listDestination.size() < 1)
			return listSource;
		List<WaybillforpredictQueryColumnsPlus> listResults = new ArrayList<WaybillforpredictQueryColumnsPlus>();
		for (int i = 0; i < listSource.size(); i++) {
			listResults.add((WaybillforpredictQueryColumnsPlus)listSource.get(i));
		}
		for (int i = 0; i < listDestination.size(); i++) {
			WaybillforpredictQueryColumnsPlus objHWC = (WaybillforpredictQueryColumnsPlus)listDestination.get(i);
			boolean isRepeat = false;
			for (int j = 0; j < listSource.size(); j++) {
				WaybillforpredictQueryColumnsPlus objHWCSource = (WaybillforpredictQueryColumnsPlus)listSource.get(j);
				if (objHWC.getCwcw_code().equals(objHWCSource.getCwcw_code())) {
					isRepeat = true;
					break;
				}
			}
			if (!isRepeat)
				listResults.add(objHWC);
		}
		return listResults;
	}*/
	/**
	 *提货地址 
	 * @throws Exception 
	 * */
	
	public static List<ShipperconsigneeColumns> getTihuoAddress() throws Exception{
		ShipperconsigneeCondition objSCCondition = new ShipperconsigneeCondition();
		objSCCondition.setCmcocode((String)ServletActionContext.getRequest().getSession().getAttribute("Cocode"));
		objSCCondition.setScshipperconsigneetype("T");
		List<ShipperconsigneeColumns> TinfoList = ShipperconsigneeDemand.query(objSCCondition);
		return TinfoList;
		
	}
	/**
	 * 获得货件状态
	 * @throws Exception 
	 * */
	public static List getGoogsState() throws Exception{
		WaybilltransferphaseQuery query = new WaybilltransferphaseQuery();
		List<WaybilltransferphaseColumns> results = (List<WaybilltransferphaseColumns> )query.getResults();
		if(!CollectionUtility.isNull(results)){
			return results;
		}else{
			return null;
		}
	}
	
}