package com.daiyun.dax;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;

import kyle.common.util.jlang.StringUtility;
import kyle.common.util.prompt.PromptUtilityCollection;
import kyle.common.util.prompt.SavedResultUtility;
import kyle.leis.eo.operation.cwbimportlog.da.CwbimportlogColumns;
import kyle.leis.eo.operation.housewaybill.dax.PredictOrderRow;
import kyle.leis.eo.operation.predictwaybill.bl.Predictwaybill;
import kyle.leis.eo.operation.predictwaybill.da.PredictwaybillColumns;

import com.daiyun.predictwaybill.PredictOrderColumnsEX;
import com.daiyun.predictwaybill.PredictwaybillBaseCheck;

public class UploadThread implements Callable<Map<String, Object>>{

	private List<PredictOrderRow> rowList;
	private String cocode;
	private String opId;
	private String strTemplate;
	private CwbimportlogColumns cwbimport;
	private int index;
	private int threadSize;
	public UploadThread(int threadSize, int index,List<PredictOrderRow> rowList,
			String cocode,String opId,String temple,
			CwbimportlogColumns cwbimport){
		super();
		this.threadSize=threadSize;
		this.index=index;
		this.rowList=rowList;
		this.cocode=cocode;
		this.opId=opId;
		this.strTemplate=temple;
		this.cwbimport=cwbimport;
	}
	
	public Map<String, Object> call() throws Exception {
		
		Map<String, Object> allresult=new HashMap<String, Object>();
		int normalSize=0;
		Map<String, PredictwaybillColumns> predMap = new HashMap<String, PredictwaybillColumns>();
		for(int i=1;i<=rowList.size();i++){
			PredictOrderRow row=rowList.get(i-1);
			row.setExcelRowIndex((index-1)*threadSize+i);
			PredictwaybillBaseCheck pwbCheck=new PredictwaybillBaseCheck();
			SavedResultUtility sru = null;
			//转换成标准
			PredictOrderColumnsEX predictColumnsEX = pwbCheck.RowToColumns(row,cocode,opId,strTemplate);
			//基本检查 
			predictColumnsEX=pwbCheck.checkAll(predictColumnsEX, cocode);
			String strPrompt = predictColumnsEX.getPromptinfo();
			 PredictwaybillColumns columns = predictColumnsEX.getPredictwaybillColumns();
			 if(StringUtility.isNull(strPrompt)){
		     //保存
				 Predictwaybill pwb = new Predictwaybill();			 
				 sru = pwb.save(columns, predictColumnsEX.getListPredictcargoinfo(), opId);
				 //t_op_predictwaybill
				 PredictwaybillColumns pwbColumns = (PredictwaybillColumns) sru.getColumns();
				 PromptUtilityCollection puCollection = sru.getPromptUtilityCollection();
				 if(StringUtility.isNull(puCollection.toString())){
					 normalSize ++;
					 predMap.put("", pwbColumns);
				 }else{
					 predMap.put(puCollection.toString(),pwbColumns);
					 pwbCheck.saveCwbimportrowColumns(row.getExcelRowIndex(), puCollection.toString(), cwbimport.getToccwlid());
				 }
			 } else {
				 predMap.put(strPrompt,columns);
				 pwbCheck.saveCwbimportrowColumns(row.getExcelRowIndex(), strPrompt, cwbimport.getToccwlid());
			 }
		}
		allresult.put("normalSize", normalSize);		
		allresult.put("predMap", predMap);
		return allresult;
	}

}
