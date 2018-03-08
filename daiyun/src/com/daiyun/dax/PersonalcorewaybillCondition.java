package com.daiyun.dax;

import kyle.common.dbaccess.query.GeneralCondition;

public class PersonalcorewaybillCondition extends GeneralCondition {
	public PersonalcorewaybillCondition() {
		m_astrConditions = new String[4];
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
	public void setCwcocodecustomer(String cwcocodecustomer) {
		this.setField(2, cwcocodecustomer);
	}

	public String getCwcocodecustomer() {
		return this.getField(2);
	}
	
}
