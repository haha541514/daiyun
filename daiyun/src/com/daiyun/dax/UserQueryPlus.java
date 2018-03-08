package com.daiyun.dax;

import kyle.leis.fs.authoritys.user.da.UserQuery;
public class UserQueryPlus extends UserQuery{
	public UserQueryPlus() {
		 m_strSelectClause = "SELECT new kyle.leis.fs.authoritys.user.da.UserColumns(op.opId, op.opCode, op.opName, op.opSex, op.opPassword, op.opEname, op.opSname, op.opIdnumber, op.opEmail, op.opIdCreator, op.opCreatedate, op.opIdModifier, op.opModifydate, op.opAddress, op.opTelephone, op.opMobile, op.opConfirmdate, op.opDimissiondate, op.opMsnname, op.opQqnumber, op.opFaxnumber, ps.psCode, ps.psName, ps.psEname, ee.eeCode, ee.eeName, ee.eeEname, ee.eeSname, ee.eeEsname, fc.fcCode, fc.fcName, fc.fcEname, co.coCode, co.coName, co.coEname, co.coSname, co.coSename, dp.dpCode, dp.dpName, dp.dpEname, os.osCode, os.osName, op.opIssuecontactpersonsign,st.stCode,st.stName,ct.ctCode,ct.ctName) FROM TdiOperator as op inner join op.tdiPosition as ps inner join op.tdiEnterpriseelement as ee inner join op.tdiFunction as fc left join op.tcoCorporation as co inner join op.tdiDepartment as dp left join op.tdiOperatorstatus as os left join op.tdiState as st left join op.tdiCity as ct";
		 m_strWhereClause = "";
		 m_strOrderByClause = "";
		 m_strGroupByClause = "";
		 m_astrConditionWords = new String[] { "op.opId = ~~", "op.opCode = '~~'", "op.opPassword = '~~'", "op.opEname = '~~'", "op.opIdnumber = '~~'", "ee.eeCode = '~~'", "co.coCode = '~~'", "dp.dpCode = '~~'", "fc.fcCode = '~~'", "ps.psCode = '~~'", "op.opCreatedate >= to_date('~~','yyyy-mm-dd hh24:mi:ss')", "to_date('~~','yyyy-mm-dd hh24:mi:ss') >= op.opCreatedate", "op.opDimissiondate >= to_date('~~','yyyy-mm-dd hh24:mi:ss')", "to_date('~~','yyyy-mm-dd hh24:mi:ss') >= op.opDimissiondate", "os.osCode = '~~'", "co.coCode is ~~", "co.coCode is not ~~", "op.opQqnumber = '~~'", "op.opIssuecontactpersonsign = '~~'", "op.opName = '~~'", "fc.fcName = '~~'", "dp.dpName = '~~'","st.stCode = '~~'","ct.ctCode = '~~'","op.opEmail = '~~'" , "op.opMobile = '~~'" };
		 m_aiConditionVariableCount = new int[] { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};		
	}	
	
	
	
}