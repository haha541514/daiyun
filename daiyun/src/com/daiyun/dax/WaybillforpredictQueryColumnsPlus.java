package com.daiyun.dax;

import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictColumns;

public class WaybillforpredictQueryColumnsPlus extends WaybillforpredictColumns {

	private static final long serialVersionUID = 1L;

	public WaybillforpredictQueryColumnsPlus() {
		// m_astrColumns = new String[75];
		this.m_astrColumns = new String[68];
	}

	public WaybillforpredictQueryColumnsPlus(
			String cwCw_code, 
            String cwCw_customerewbcode, String cwCw_serverewbcode, 
            String cwCw_ewbcode, String pkPk_code, 
            String pkPk_sename, String cwDt_code_signin, 
            String dtDt_hubcode, String dtDt_ename, 
            String hwHw_shippercompany, String hwHw_shippername, 
            String hwHw_shipperaddress1, String hwHw_shipperaddress2, 
            String hwHw_shipperaddress3, String hwHw_shippertelephone, 
            String hwHw_shipperpostcode, String hwHw_shipperfax, 
            String hwHw_consigneename, String hwHw_consigneecompany, 
            String dtDt_statecode, String hwHw_consigneecity, 
            String hwHw_consigneeaddress1, String hwHw_consigneeaddress2, 
            String hwHw_consigneeaddress3, String hwHw_consigneetelephone, 
            String hwHw_consigneepostcode, String hwHw_consigneefax, 
            String hwHw_buyerid, String hwHw_transactionid, 
            String hwHw_remark, String cwCw_chargeweight, 
            String cwCw_customerchargeweight,
            String cwCw_pieces, String cwsCws_code, 
            String cwsCws_name, String ihsIhs_code, 
            String ihsIhs_name, String ccoCo_code, 
            String ccoCo_labelcode, String Scocode, 
            String Scolabelcode, String Scosename, 
            String chnChn_code, String chnChn_sename, 
            String chnChn_sname, String chnChn_customerlabel, 
            String Originorderid, String Alonecustomsign, 
            String hwHw_attacheinfosign, 
            String chnChn_customlable,
            String Hw_signindate,  
            String dtDt_name, String pkPk_showserverewbcode, 
            String hwHw_consigneeaddressex, String hwHw_consigneenameex, 
            String bwbBw_labelcode, String Eraccount, 
            String chnChn_selflablecode, String Subconame, 
            String ddtDt_code, String ddtDt_hubcode,
            
            String pwPwb_createdate,String pwPwb_printdate,
            String pwPwb_declaredate,
            //String hwHw_consigneecityex, String hwPat_code, 
            //String hwDt_code, String hwCgk_code, 
            //String hwBk_code, String hwHw_dutypaidsign,
            //String hwHw_dcustomssign,
            //String itIpt_code, String ifyIb_code, 
            //String hwHw_insurancevalue,
			
			

			String cwCw_createdate, String hwHw_customerdeclaredate,
			String hwHw_customerlabelprintdate,
			String hwHw_signoutdate) {
		 //this.m_astrColumns = new String[77];
		this.m_astrColumns = new String[67];
		setCwcw_code(cwCw_code);
	    setCwcw_customerewbcode(cwCw_customerewbcode);
	    setCwcw_serverewbcode(cwCw_serverewbcode);
	    setCwcw_ewbcode(cwCw_ewbcode);
	    setPkpk_code(pkPk_code);
	    setPkpk_sename(pkPk_sename);
	    setCwdt_code_signin(cwDt_code_signin);
	    setDtdt_hubcode(dtDt_hubcode);
	    setDtdt_ename(dtDt_ename);
	    setHwhw_shippercompany(hwHw_shippercompany);
	    setHwhw_shippername(hwHw_shippername);
	    setHwhw_shipperaddress1(hwHw_shipperaddress1);
	    setHwhw_shipperaddress2(hwHw_shipperaddress2);
	    setHwhw_shipperaddress3(hwHw_shipperaddress3);
	    setHwhw_shippertelephone(hwHw_shippertelephone);
	    setHwhw_shipperpostcode(hwHw_shipperpostcode);
	    setHwhw_shipperfax(hwHw_shipperfax);
	    setHwhw_consigneename(hwHw_consigneename);
	    setHwhw_consigneecompany(hwHw_consigneecompany);
	    setDtdt_statecode(dtDt_statecode);
	    setHwhw_consigneecity(hwHw_consigneecity);
	    setHwhw_consigneeaddress1(hwHw_consigneeaddress1);
	    setHwhw_consigneeaddress2(hwHw_consigneeaddress2);
	    setHwhw_consigneeaddress3(hwHw_consigneeaddress3);
	    setHwhw_consigneetelephone(hwHw_consigneetelephone);
	    setHwhw_consigneepostcode(hwHw_consigneepostcode);
	    setHwhw_consigneefax(hwHw_consigneefax);
	    setHwhw_buyerid(hwHw_buyerid);
	    setHwhw_transactionid(hwHw_transactionid);
	    setHwhw_remark(hwHw_remark);
	    setCwcw_chargeweight(cwCw_chargeweight);
	    setCwcw_customerchargeweight(cwCw_customerchargeweight);
	    setPwpwb_createdate(pwPwb_createdate);
	    setCwcw_pieces(cwCw_pieces);
	    setCwscws_code(cwsCws_code);
	    setCwscws_name(cwsCws_name);
	    setIhsihs_code(ihsIhs_code);
	    setIhsihs_name(ihsIhs_name);
	    setCcoco_code(ccoCo_code);
	    setCcoco_labelcode(ccoCo_labelcode);
	    setScocode(Scocode);
	    setScolabelcode(Scolabelcode);
	    setScosename(Scosename);
	    setChnchn_code(chnChn_code);
	    setChnchn_sename(chnChn_sename);
	    setChnchn_sname(chnChn_sname);
	    setChnchn_customerlabel(chnChn_customerlabel);
	    setOriginorderid(Originorderid);
	    setAlonecustomsign(Alonecustomsign);
	    setHwhw_attacheinfosign(hwHw_attacheinfosign);
	    setChnchn_customlable(chnChn_customlable);
	    setPwpwb_printdate(pwPwb_printdate);
	    setHw_signindate(Hw_signindate);
	    setPwpwb_declaredate(pwPwb_declaredate);
	    setDtdt_name(dtDt_name);
	    setPkpk_showserverewbcode(pkPk_showserverewbcode);
	    setHwhw_consigneeaddressex(hwHw_consigneeaddressex);
	    setHwhw_consigneenameex(hwHw_consigneenameex);
	    setBwbbw_labelcode(bwbBw_labelcode);
	    setEraccount(Eraccount);
	    setChnchn_selflablecode(chnChn_selflablecode);
	    setSubconame(Subconame);
	    setDdtdt_code(ddtDt_code);
	    setDdtdt_hubcode(ddtDt_hubcode);
	    
	    
		//setHwhw_consigneecityex(hwHw_consigneecityex);
		//setHwpat_code(hwPat_code);
		//setHwdt_code(hwDt_code);
		//setHwcgk_code(hwCgk_code);
		//setHwbk_code(hwBk_code);
		//setHwhw_dutypaidsign(hwHw_dutypaidsign);
		//setHwhw_dcustomssign(hwHw_dcustomssign);
		//setItipt_code(itIpt_code);
		//setIfyib_code(ifyIb_code);
		//setHwhw_insurancevalue(hwHw_insurancevalue);//生成的sql语句中没有这个。
	    
		// HW_CUSTOMERLABELPRINTDATE
		setCwcw_createdate(cwCw_createdate);
		setHwhw_customerdeclaredate(hwHw_customerdeclaredate);
		setHwhw_customerlabelprintdate(hwHw_customerlabelprintdate);
		setHwhw_signoutdate(hwHw_signoutdate);

	}

	public void setCwcw_createdate(String cwCw_createdate) {
		this.setField(64, cwCw_createdate);
	}

	public String getCwcw_createdate() {
		return this.getField(64);
	}

	public void setHwhw_customerdeclaredate(String hwHw_customerdeclaredate) {
		this.setField(65, hwHw_customerdeclaredate);
	}

	public String getHwhw_customerdeclaredate() {
		return this.getField(65);
	}

	public void setHwhw_customerlabelprintdate(
			String hwHw_customerlabelprintdate) {
		this.setField(66, hwHw_customerlabelprintdate);
	}
//HW_CUSTOMERLABELPRINTDATE,原来是大小写写反了，难怪页面上获取不到的
	public String getHwhw_customerlabelprintdate() {
		return this.getField(66);
	}
	public void setHwhw_signoutdate(
			String hwHw_signoutdate) {
		this.setField(67, hwHw_signoutdate);
	}

	public String getHwhw_signoutdate() {
		return this.getField(67);
	}
	/**
	 * 2016-10-12 方法覆盖，设置订单查询管理界面收件人的 编码格式
	 * **/
	public String getHwhw_consigneename() {
		String strOriginname = super.getHwhw_consigneename();
		if (StringUtility.isNull(super.getHwhw_consigneenameex()))
			return strOriginname;
		else {
			return StringUtility.buildFromByte(super.getHwhw_consigneenameex(),
					"utf-8");
		}
	}
	
	
	
}