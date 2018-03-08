package com.daiyun.sfweb.da;
import kyle.common.dbaccess.query.IColumns;
import kyle.common.dbaccess.query.JGeneralQuery;

public class PersonalcorewaybillQuery extends JGeneralQuery {
	
	public PersonalcorewaybillQuery(){//and cw.co_code_customer = '1'
	    m_strSelectClause = "SELECT case ssg.ssg_name        when '小包' then '小包'       when '专线' then '专线'       else '快递' end haha       ,sum(case  when cw.cws_code='CTS' then 1 else 0 end )  newcreate,       sum(case when cw.cws_code = 'CHD' then 1 else 0 end)  trans,       sum(case when cw.cws_code in ('SI','IP') then 1 else 0 end )  print,       sum(case when cw.cws_code = 'SO' then 1 else 0 end )  recevie FROM T_OP_COREWAYBILL   cw,T_DI_PRODUCTKIND   pk,T_DI_SERVERSTRUCTUREGROUP  ssg";
	    m_strWhereClause = "cw.pk_code = pk.pk_code and pk.ssg_code = ssg.ssg_code  and cw.cws_code in('CTS','CHD','SI','IP','SO')";
	    m_strOrderByClause = "";
	    m_strGroupByClause = " case ssg.ssg_name        when '小包' then '小包'       when '专线' then '专线'       else '快递' end";
	    m_astrConditionWords = new String[] { " cw.cw_createdate>= to_date('~~','yyyy-mm-dd hh24:mi:ss')	", " to_date('~~','yyyy-mm-dd hh24:mi:ss') >= cw.cw_createdate	" ," cw.co_code_customer= '~~'	"};
	    m_aiConditionVariableCount = new int[] { 1, 1,1 };		
	}
	
	@Override
	public IColumns createColumns() {
		// TODO Auto-generated method stub
		return new PersonalcorewaybillColumns();
	}
	
	public void setStartcreatedate(String StartCreateDate) {
		this.setField(0, StartCreateDate);
	}

	public String getStartcreatedate() {
		return this.getField(0);
	}

	public void setEndcreatedate(String EndCreateDate) {
		this.setField(1, EndCreateDate);
	}

	public String getEndcreatedate() {
		return this.getField(1);
	}

}
