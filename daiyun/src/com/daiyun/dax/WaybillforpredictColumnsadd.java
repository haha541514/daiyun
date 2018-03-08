package com.daiyun.dax;

import kyle.leis.eo.operation.housewaybill.da.LabeldataColumns;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictColumns;
import kyle.leis.es.company.channel.da.ChanneladdressColumns;

public class WaybillforpredictColumnsadd {
	private WaybillforpredictColumns way;
	private LabeldataColumns label;
	private ChanneladdressColumns objChanneladdressColumns;
	private String Ciciename1;
	private String Ciciename2;
	private int Cicipieces1;
	private int Cicipieces2;
	private double Ciciprice1;
	private double Ciciprice2;
	private double Ciciweight1;
	private double Ciciweight2;
	private double totalWeight;
	private double totalPrice;

	public WaybillforpredictColumns getWay() {
		return way;
	}

	public void setWay(WaybillforpredictColumns way) {
		this.way = way;
	}

	public LabeldataColumns getLabel() {
		return label;
	}

	public void setLabel(LabeldataColumns label) {
		this.label = label;
	}

	public ChanneladdressColumns getObjChanneladdressColumns() {
		return objChanneladdressColumns;
	}

	public void setObjChanneladdressColumns(
			ChanneladdressColumns objChanneladdressColumns) {
		this.objChanneladdressColumns = objChanneladdressColumns;
	}

	public String getCiciename1() {
		return Ciciename1;
	}

	public void setCiciename1(String ciciename1) {
		Ciciename1 = ciciename1;
	}

	public String getCiciename2() {
		return Ciciename2;
	}

	public void setCiciename2(String ciciename2) {
		Ciciename2 = ciciename2;
	}

	public int getCicipieces1() {
		return Cicipieces1;
	}

	public void setCicipieces1(int cicipieces1) {
		Cicipieces1 = cicipieces1;
	}

	public int getCicipieces2() {
		return Cicipieces2;
	}

	public void setCicipieces2(int cicipieces2) {
		Cicipieces2 = cicipieces2;
	}

	public double getCiciprice1() {
		return Ciciprice1;
	}

	public void setCiciprice1(double ciciprice1) {
		Ciciprice1 = ciciprice1;
	}

	public double getCiciprice2() {
		return Ciciprice2;
	}

	public void setCiciprice2(double ciciprice2) {
		Ciciprice2 = ciciprice2;
	}

	public double getCiciweight1() {
		return Ciciweight1;
	}

	public void setCiciweight1(double ciciweight1) {
		Ciciweight1 = ciciweight1;
	}

	public double getCiciweight2() {
		return Ciciweight2;
	}

	public void setCiciweight2(double ciciweight2) {
		Ciciweight2 = ciciweight2;
	}

	public double getTotalWeight() {
		return totalWeight;
	}

	public void setTotalWeight(double totalWeight) {
		this.totalWeight = totalWeight;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

}
