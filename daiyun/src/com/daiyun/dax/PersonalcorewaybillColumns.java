package com.daiyun.dax;
import java.io.Serializable;
import kyle.common.dbaccess.query.GeneralColumns;

public class PersonalcorewaybillColumns extends GeneralColumns implements Serializable {

	private static final long serialVersionUID = -8265284628323765505L;
	
	public PersonalcorewaybillColumns(){
		m_astrColumns = new String[6];
	}

	public PersonalcorewaybillColumns(String haha,String newcreate,String trans,
			String print,String recevie) {
		m_astrColumns = new String[6];
		setHaha(haha);
		setNewcreate(newcreate);
		setTrans(trans);
		setPrint(print);
		setRecevie(recevie);
	}

	
	public void setHaha(String haha) {
		this.setField(0, haha);
	}
	public String getHaha(){
		return this.getField(0);
	}
	public  void setNewcreate(String newcreate) {
		this.setField(1, newcreate);
	}
	public String getNewcreate(){
		return this.getField(1);
	}
	public void setTrans(String trans) {
		this.setField(2,trans);
	}
	public String getTrans(){
		return this.getField(2);
	}
	public void setPrint(String print) {
		this.setField(3, print);	
	}
	public String getPrint(){
		return this.getField(3);
	}
	public void setRecevie(String recevie) {
		this.setField(4, recevie);
	}
	public String getRecevie(){
		return this.getField(4);
	}

}
