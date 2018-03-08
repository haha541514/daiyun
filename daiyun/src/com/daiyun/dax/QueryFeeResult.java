package com.daiyun.dax;

public class QueryFeeResult {

	private String cw_code;
	private String freight;
	private String oilFee;
	
	private String cw_customerewbcode;
	private String otherFee;
	private String totalFee;
	
	
	
	public String getCw_code() {
		return cw_code;
	}
	public void setCw_code(String cw_code) {
		this.cw_code = cw_code;
	}
	public String getFreight() {
		return freight;
	}
	public void setFreight(String freight) {
		this.freight = freight;
	}
	public String getOilFee() {
		return oilFee;
	}
	public void setOilFee(String oilFee) {
		this.oilFee = oilFee;
	}

	
	public String getCw_customerewbcode() {
		return cw_customerewbcode;
	}
	public void setCw_customerewbcode(String cw_customerewbcode) {
		this.cw_customerewbcode = cw_customerewbcode;
	}
	public String getOtherFee() {
		return otherFee;
	}
	public void setOtherFee(String otherFee) {
		this.otherFee = otherFee;
	}
	public String getTotalFee() {
		return totalFee;
	}
	public void setTotalFee(String totalFee) {
		this.totalFee = totalFee;
	}
}
