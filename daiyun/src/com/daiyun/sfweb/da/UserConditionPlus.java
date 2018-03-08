package com.daiyun.sfweb.da;

import kyle.leis.fs.authoritys.user.da.UserCondition;





public class UserConditionPlus extends UserCondition{
	public UserConditionPlus() {
		m_astrConditions = new String[27];
	}	
	
	
	/******set && get*********/

	
	
	public void setOpemail(String opEmail) {
		this.setField(24, opEmail);
	}

	public String getOpemail() {
		return this.getField(24);
	}
	public void setOpmobile(String opMobile) {
		this.setField(25, opMobile);
	}

	public String getOpmobile() {
		return this.getField(25);
	}
	
}