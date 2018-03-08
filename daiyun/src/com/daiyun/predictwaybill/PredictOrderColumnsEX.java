package com.daiyun.predictwaybill;

import java.util.List;
import kyle.leis.eo.operation.cargoinfo.da.CargoinfoColumns;
import kyle.leis.eo.operation.predictwaybill.da.PredictcargoinfoColumns;
import kyle.leis.eo.operation.predictwaybill.da.PredictwaybillColumns;

public class PredictOrderColumnsEX {
	private String opermode;
	private String promptinfo;
	private int index;
	private int ExcelRowIndex;
	private PredictwaybillColumns predictwaybillColumns;
	private List<CargoinfoColumns> listCargoInfo;
	private List<PredictcargoinfoColumns> listPredictcargoinfo;
	
	public List<PredictcargoinfoColumns> getListPredictcargoinfo() {
		return listPredictcargoinfo;
	}
	public void setListPredictcargoinfo(
			List<PredictcargoinfoColumns> listPredictcargoinfo) {
		this.listPredictcargoinfo = listPredictcargoinfo;
	}
	public List<CargoinfoColumns> getListCargoInfo() {
		return listCargoInfo;
	}
	public void setListCargoInfo(List<CargoinfoColumns> listCargoInfo) {
		this.listCargoInfo = listCargoInfo;
	}

	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public String getOpermode() {
		return opermode;
	}
	public void setOpermode(String opermode) {
		this.opermode = opermode;
	}
	public String getPromptinfo() {
		return promptinfo;
	}
	public void setPromptinfo(String promptinfo) {
		this.promptinfo = promptinfo;
	}
	public int getExcelRowIndex() {
		return ExcelRowIndex;
	}
	public void setExcelRowIndex(int ExcelRowIndex) {
		this.ExcelRowIndex = ExcelRowIndex;
	}
	public PredictwaybillColumns getPredictwaybillColumns() {
		return predictwaybillColumns;
	}
	public void setPredictwaybillColumns(PredictwaybillColumns predictwaybillColumns) {
		this.predictwaybillColumns = predictwaybillColumns;
	}
	
}

