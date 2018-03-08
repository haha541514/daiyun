package com.daiyun.dax;

import kyle.common.dbaccess.query.IColumns;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictQuery;

public class WaybillforpredictQueryPlus  extends WaybillforpredictQuery{
	
	public WaybillforpredictQueryPlus(){
			//ɾ��pw
			this.m_strSelectClause = "SELECT cw.cw_code,cw.cw_customerewbcode,cw.cw_serverewbcode,cw.cw_ewbcode,pk.pk_code,pk.pk_sename,cw.dt_code_signin,dt.dt_hubcode,dt.dt_ename,hw.hw_shippercompany,hw.hw_shippername,hw.hw_shipperaddress1,hw.hw_shipperaddress2,hw.hw_shipperaddress3,hw.hw_shippertelephone,hw.hw_shipperpostcode,hw.hw_shipperfax,hw.hw_consigneename,hw.hw_consigneecompany,dt.dt_statecode,hw.hw_consigneecity,hw.hw_consigneeaddress1,hw.hw_consigneeaddress2,hw.hw_consigneeaddress3,hw.hw_consigneetelephone,hw.hw_consigneepostcode,hw.hw_consigneefax,hw.hw_buyerid,hw.hw_transactionid,hw.hw_remark,cw.cw_chargeweight,cw.cw_customerchargeweight,'' as pwb_createdate,cw.cw_pieces,cws.cws_code,cws.cws_name,ihs.ihs_code,ihs.ihs_name,cco.co_code,cco.co_labelcode,sco.co_code as scocode,sco.co_labelcode as scolabelcode,sco.co_sename as scosename,chn.chn_code,chn.chn_sename,chn.chn_sname,chn.chn_customerlabel, FUN_GET_CUSTOMEREWBCODES(cw.cw_code) as originorderid, FUN_GET_SPECIALTYPESIGN(cw.cw_code, 'A0101') as AlonecustomSign,hw.HW_ATTACHEINFOSIGN, chn.CHN_CustomLable,'' as pwb_PrintDate,HW_SignInDate,'' as pwb_DeclareDate,dt.dt_name,pk.pk_showserverewbcode,hw.HW_ConsigneeAddressEX,hw.HW_ConsigneeNameEX,bwb.bw_labelcode,chn.chn_masteraccount ,chn.chn_selflablecode, '' as subconame, ddt.dt_code as cdtcode,ddt.dt_hubcode as cdthubcode " +
			",cw.cw_createdate,hw.HW_CUSTOMERDECLAREDATE,hw.HW_CUSTOMERLABELPRINTDATE ,hw.HW_SIGNOUTDATE FROM T_OP_COREWAYBILL cw,T_OP_HOUSEWAYBILL hw,T_DI_PRODUCTKIND pk,T_DI_DISTRICT dt,T_DI_COREWAYBILLSTATUS cws,t_co_corporation cco, t_co_corporation sco,t_chn_channel chn, t_di_issueholdstatus ihs,t_op_batchwaybill bwb, T_DI_DISTRICT ddt";
			this.m_strWhereClause = "cw.bw_code_arrival = bwb.bw_code and cw.cw_code = hw.cw_code  and cw.pk_code = pk.pk_code and cw.co_code_customer = cco.co_code  and cw.cws_code = cws.cws_code and cw.co_code_supplier = sco.co_code(+) and cw.chn_code_supplier = chn.chn_code(+) and cw.dt_code_signin = dt.dt_code(+) and cw.dt_code_destination = ddt.dt_code(+) and cw.ihs_code = ihs.ihs_code(+)";
			this.m_strOrderByClause = "cw.cw_customerewbcode, cw.cw_createdate desc";

			this.m_strGroupByClause = "";
		    this.m_astrConditionWords =  new String[] { "bwb.bw_labelcode ='~~'", "cw.cws_code != '~~'", "cw.cws_code in (~~)", "lower(hw.hw_consigneename) like lower('%~~%')", "lower(hw.hw_consigneecompany) like lower('%~~%')", "lower(hw.hw_consigneename) = lower('~~')", "lower(hw.hw_consigneecompany) = lower('~~')", "lower(hw.hw_buyerid) = lower('~~')", "lower(hw.hw_transactionid) = lower('~~')", "lower(hw.hw_consigneeaddress1||hw.hw_consigneeaddress2||hw.hw_consigneeaddress3) like lower('%~~%')", "pk.pk_code = '~~'", "(cw.cw_customerewbcode in (~~))", "cw.cw_ewbcode = '~~'", "cw.cw_serverewbcode = '~~'", "cw.co_code_customer = '~~'", "cw.dt_code_signin = '~~'", "cw.cws_code = '~~'", "cw.cw_code = ~~", "cw.cw_code in (~~)", "cw.cw_createdate >= to_date('~~','yyyy-mm-dd hh24:mi:ss')", "to_date('~~','yyyy-mm-dd hh24:mi:ss') >= cw.cw_createdate", "exists (select cwc.cwbc_id from t_op_corewaybillcode cwc where cwc.cw_code = cw.cw_code and cwc.cwbc_customerewbcode in (~~))", "hw.HW_CustomerLabelPrintDate >= to_date('~~','yyyy-mm-dd hh24:mi:ss')", "to_date('~~','yyyy-mm-dd hh24:mi:ss') >= hw.HW_CustomerLabelPrintDate", "HW_SignInDate >= to_date('~~','yyyy-mm-dd hh24:mi:ss')", "to_date('~~','yyyy-mm-dd hh24:mi:ss') >= HW_SignInDate", "hw.HW_CustomerDeclareDate >= to_date('~~','yyyy-mm-dd hh24:mi:ss')", "to_date('~~','yyyy-mm-dd hh24:mi:ss') >= hw.HW_CustomerDeclareDate", "exists(select cw.cw_code from t_op_hwbcargoinfo hci where hci.cw_code = cw.cw_code and lower(hci.ci_ename) like lower('~~'))", "exists(select cw.cw_code from t_op_hwbcargoinfo hci where hci.cw_code = cw.cw_code and lower(hci.ci_attacheinfo) like lower('~~'))", "nvl(hw.HW_ATTACHEINFOSIGN,'C') = '~~'", "cco.co_labelcode = '~~'", "FUN_GET_CUSTOMERSTRUCTURECODE(cw.co_code_customer) like FUN_GET_CUSTOMERSTRUCTURECODE('~~')||'%'" };
		    this.m_aiConditionVariableCount = new int[]{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
		  
	}
	
	public WaybillforpredictQueryPlus(String field,String sort){
		this.m_strSelectClause = "SELECT cw.cw_code,cw.cw_customerewbcode,cw.cw_serverewbcode,cw.cw_ewbcode,pk.pk_code,pk.pk_sename,cw.dt_code_signin,dt.dt_hubcode,dt.dt_ename,hw.hw_shippercompany,hw.hw_shippername,hw.hw_shipperaddress1,hw.hw_shipperaddress2,hw.hw_shipperaddress3,hw.hw_shippertelephone,hw.hw_shipperpostcode,hw.hw_shipperfax,hw.hw_consigneename,hw.hw_consigneecompany,dt.dt_statecode,hw.hw_consigneecity,hw.hw_consigneeaddress1,hw.hw_consigneeaddress2,hw.hw_consigneeaddress3,hw.hw_consigneetelephone,hw.hw_consigneepostcode,hw.hw_consigneefax,hw.hw_buyerid,hw.hw_transactionid,hw.hw_remark,cw.cw_chargeweight,cw.cw_customerchargeweight,'' as pwb_createdate,cw.cw_pieces,cws.cws_code,cws.cws_name,ihs.ihs_code,ihs.ihs_name,cco.co_code,cco.co_labelcode,sco.co_code as scocode,sco.co_labelcode as scolabelcode,sco.co_sename as scosename,chn.chn_code,chn.chn_sename,chn.chn_sname,chn.chn_customerlabel, FUN_GET_CUSTOMEREWBCODES(cw.cw_code) as originorderid, FUN_GET_SPECIALTYPESIGN(cw.cw_code, 'A0101') as AlonecustomSign,hw.HW_ATTACHEINFOSIGN, chn.CHN_CustomLable,'' as pwb_PrintDate,HW_SignInDate,'' as pwb_DeclareDate,dt.dt_name,pk.pk_showserverewbcode,hw.HW_ConsigneeAddressEX,hw.HW_ConsigneeNameEX,bwb.bw_labelcode,chn.chn_masteraccount ,chn.chn_selflablecode, '' as subconame, ddt.dt_code as cdtcode,ddt.dt_hubcode as cdthubcode " +
		",cw.cw_createdate,hw.HW_CUSTOMERDECLAREDATE,hw.HW_CUSTOMERLABELPRINTDATE ,hw.HW_SIGNOUTDATE FROM T_OP_COREWAYBILL cw,T_OP_HOUSEWAYBILL hw,T_DI_PRODUCTKIND pk,T_DI_DISTRICT dt,T_DI_COREWAYBILLSTATUS cws,t_co_corporation cco, t_co_corporation sco,t_chn_channel chn, t_di_issueholdstatus ihs,t_op_batchwaybill bwb, T_DI_DISTRICT ddt";
		this.m_strWhereClause = "cw.bw_code_arrival = bwb.bw_code and cw.cw_code = hw.cw_code  and cw.pk_code = pk.pk_code and cw.co_code_customer = cco.co_code  and cw.cws_code = cws.cws_code and cw.co_code_supplier = sco.co_code(+) and cw.chn_code_supplier = chn.chn_code(+) and cw.dt_code_signin = dt.dt_code(+) and cw.dt_code_destination = ddt.dt_code(+) and cw.ihs_code = ihs.ihs_code(+)";
		this.m_strOrderByClause = ""+field +"  "+ sort;
		this.m_strGroupByClause = "";
		this.m_astrConditionWords = new String[] { "bwb.bw_labelcode ='~~'", "cw.cws_code != '~~'", "cw.cws_code in (~~)", "lower(hw.hw_consigneename) like lower('%~~%')", "lower(hw.hw_consigneecompany) like lower('%~~%')", "lower(hw.hw_consigneename) = lower('~~')", "lower(hw.hw_consigneecompany) = lower('~~')", "lower(hw.hw_buyerid) = lower('~~')", "lower(hw.hw_transactionid) = lower('~~')", "lower(hw.hw_consigneeaddress1||hw.hw_consigneeaddress2||hw.hw_consigneeaddress3) like lower('%~~%')", "pk.pk_code = '~~'", "(cw.cw_customerewbcode in (~~))", "cw.cw_ewbcode = '~~'", "cw.cw_serverewbcode = '~~'", "cw.co_code_customer = '~~'", "cw.dt_code_signin = '~~'", "cw.cws_code = '~~'", "cw.cw_code = ~~", "cw.cw_code in (~~)", "cw.cw_createdate >= to_date('~~','yyyy-mm-dd hh24:mi:ss')", "to_date('~~','yyyy-mm-dd hh24:mi:ss') >= cw.cw_createdate", "exists (select cwc.cwbc_id from t_op_corewaybillcode cwc where cwc.cw_code = cw.cw_code and cwc.cwbc_customerewbcode in (~~))", "hw.HW_CustomerLabelPrintDate >= to_date('~~','yyyy-mm-dd hh24:mi:ss')", "to_date('~~','yyyy-mm-dd hh24:mi:ss') >= hw.HW_CustomerLabelPrintDate", "HW_SignInDate >= to_date('~~','yyyy-mm-dd hh24:mi:ss')", "to_date('~~','yyyy-mm-dd hh24:mi:ss') >= HW_SignInDate", "hw.HW_CustomerDeclareDate >= to_date('~~','yyyy-mm-dd hh24:mi:ss')", "to_date('~~','yyyy-mm-dd hh24:mi:ss') >= hw.HW_CustomerDeclareDate", "exists(select cw.cw_code from t_op_hwbcargoinfo hci where hci.cw_code = cw.cw_code and lower(hci.ci_ename) like lower('~~'))", "exists(select cw.cw_code from t_op_hwbcargoinfo hci where hci.cw_code = cw.cw_code and lower(hci.ci_attacheinfo) like lower('~~'))", "nvl(hw.HW_ATTACHEINFOSIGN,'C') = '~~'", "cco.co_labelcode = '~~'", "FUN_GET_CUSTOMERSTRUCTURECODE(cw.co_code_customer) like FUN_GET_CUSTOMERSTRUCTURECODE('~~')||'%'" };
	    this.m_aiConditionVariableCount = new int[]{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
	  			
	}
	
	public IColumns createColumns() {
		// TODO Auto-generated method stub
		return new WaybillforpredictQueryColumnsPlus();
	}
	
	
	
	
}