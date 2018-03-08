package com.daiyun.sfweb.da;

import net.sf.hibernate.Session;
import kyle.common.dbaccess.transaction.AbstractTransaction;
import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.fs.authoritys.user.da.UrseqColumns;
import kyle.leis.fs.authoritys.user.da.UrseqQuery;
import kyle.leis.fs.authoritys.user.da.UserColumns;
import kyle.leis.fs.authoritys.user.dax.UserDemand;
import kyle.leis.hi.TdiOperator;




public class SaveUserTransactionEX extends AbstractTransaction{
	private String m_newOperId;
	private String m_strOperId;
	private UserColumns m_objUColumns;
	
	public void setParam(String strOperId,UserColumns objUColumns) throws Exception
	{
		m_strOperId = strOperId;
		m_objUColumns = objUColumns;
	}

	public void transaction(Session objSession) throws Exception
	{
		if(m_objUColumns == null ) return;
		TdiOperator objTdiOperator;
		if(StringUtility.isNull(m_objUColumns.getOpopid()))//id?code?
		{
			//新增
			objTdiOperator = new TdiOperator();
			UrseqQuery objUrseqQuery = new UrseqQuery();
			UrseqColumns objUrseqColumns = (UrseqColumns)objUrseqQuery.getResults().get(0);
			String strUrseq = objUrseqColumns.getUrseq();
			objTdiOperator.setOpId(Long.parseLong(strUrseq));
			//操作员为空则使用本编号(序列)如网站新建用户时
			if(StringUtility.isNull(m_strOperId))
				m_strOperId = strUrseq;
			objTdiOperator.setOpIdCreator((Long.parseLong(m_strOperId)));
			objTdiOperator.setOpCreatedate(DateFormatUtility.getSysdate());
		}
		else
			//修改
			objTdiOperator = (TdiOperator)objSession.load(TdiOperator.class, Long.parseLong(m_objUColumns.getOpopid()));
			//objTdiOperator = TdiOperatorDC.loadByKey(m_objOPColumns.getOpopid());??
		UserDemand.setUserColumns(objTdiOperator, m_objUColumns,m_strOperId,objSession);
		objSession.save(objTdiOperator);
		m_newOperId = String.valueOf(objTdiOperator.getOpId());
	}

	public String getM_newOperId() {
		return m_newOperId;
	}

	public void setM_newOperId(String operId) {
		m_newOperId = operId;
	}

	
	
	
}