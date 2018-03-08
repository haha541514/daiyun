package com.daiyun.dax;
import java.util.Comparator;

import kyle.leis.eo.billing.calculate.feecalculate.dax.SaleTrialCalculateResult;


public class Mycomparator implements Comparator {

	public int compare(Object o1,Object o2) {
		SaleTrialCalculateResult sr1=(SaleTrialCalculateResult)o1;
		SaleTrialCalculateResult sr2=(SaleTrialCalculateResult)o2; 
		if((Double.parseDouble(sr1.getFreightvalue())+Double.parseDouble(sr1.getIncidentalvalue())+Double.parseDouble(sr1.getSurchargevalue()))>(Double.parseDouble(sr2.getFreightvalue())+Double.parseDouble(sr2.getIncidentalvalue())+Double.parseDouble(sr2.getSurchargevalue())))
		return 1;
		else
		return 0;
	}	
}
