package com.daiyun.dax;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;

import kyle.common.util.prompt.PromptUtility;
import kyle.common.util.prompt.SavedResultUtility;
import kyle.leis.eo.operation.housewaybill.dax.PredictOrderCheck;
import kyle.leis.eo.operation.predictwaybill.bl.Predictwaybill;
import kyle.leis.eo.operation.predictwaybill.da.PredictwaybillColumns;
import kyle.leis.eo.operation.predictwaybill.dax.PredictwaybillDemand;

public class OrderUploadThread implements Callable<Map<String, Object>> {
	private List<String> subDataList;
	//private String pwbCode;
	private String OpId;
	public OrderUploadThread(List<String> subDataList,String OpId){
		this.subDataList=subDataList;
		this.OpId=OpId;
	}

	/**
	 * 传List数据 过来
	 */
	public Map<String, Object> call() throws Exception {
		int normalSize=0;
		Map<String,String> resultMap = new HashMap<String, String>();
		Map<String, Object> allResultMap =new HashMap<String, Object>();
		Predictwaybill pwb=new Predictwaybill();
		String[] strs=null;
		SavedResultUtility objSavedResultUtility=new SavedResultUtility();
		for(int i=0;i<subDataList.size();i++){
			strs = subDataList.get(i).split(",");
			PredictwaybillColumns predictway =PredictwaybillDemand.load(strs[0]);
			if (predictway == null){
				continue;
			}
			PredictOrderCheck predictOrder= new PredictOrderCheck();
			PromptUtility promptUtility=predictOrder.checkRepeatCustomerEWB(predictway.getCoco_code(), 
					predictway.getPwbpwb_orderid(), 
					predictway.getPwbpwb_consigneename(),
					"");
			if(promptUtility!=null){
				continue;
			}
			objSavedResultUtility = pwb.upload(strs[0], OpId);
			if(objSavedResultUtility.getPromptUtilityCollection().canGo(false)){
				normalSize++;
				resultMap.put(strs[1],"");
			} else {
				resultMap.put(strs[1], objSavedResultUtility.getPromptUtilityCollection().toString());
			}
		}
		allResultMap.put("normalSize", normalSize);
		allResultMap.put("resultMap", resultMap);
		return allResultMap;
	}

}
