package com.daiyun.dax;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.regex.Pattern;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.billing.calculate.feecalculate.bl.SaleTrialCalculate;
import kyle.leis.eo.billing.calculate.feecalculate.dax.SaleTrialCalculateParameter;
import kyle.leis.eo.billing.calculate.feecalculate.dax.SaleTrialCalculateResult;
import kyle.leis.eo.operation.corewaybillpieces.da.CorewaybillpiecesColumns;
import kyle.leis.fs.dictionary.district.da.CountryColumns;
import kyle.leis.fs.dictionary.productkind.da.ProductkindColumns;
import kyle.leis.fs.dictionary.productkind.da.ProductkindQuery;

public class FeeDemand {
	public static String fee(String pkcode,String dthubcode,String grossweight,String ctctcode,String orginDtcode,String pmpmcode,String cocode,
			String lwh) throws Exception{
		StringBuffer sb = new StringBuffer();
		String strErrorCode = null;
		String strError = null;
		sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<SaleTrialCalculate>\n");	
		List resultList=costBudget(pkcode,dthubcode,grossweight,ctctcode,orginDtcode,pmpmcode,cocode,lwh);
		if (resultList.size() < 1) {
			strErrorCode = "EC";
		    strError = "请准确填写试算条件信息";
			sb.append("\t<error>\n\t\t<errorcode>" + strErrorCode
					+ "</errorcode>\n\t\t<errorinfo>"
					+ strError + "</errorinfo>\n\t</error>\n");
		}else{
			SaleTrialCalculateResult result = (SaleTrialCalculateResult) resultList.get(0);
			sb.append("\t<result>\n");
			sb.append("\t\t<chargeweight>"+result.getChargeweight()+"</chargeweight>\n");//收货重量
			sb.append("\t\t<volumeweight>"+result.getVolumeweight()+"</volumeweight>\n");//体积重量
			sb.append("\t\t<grossweight>"+result.getGrossweight()+"</grossweight>\n");//实重
			sb.append("\t\t<freightvalue>"+result.getFreightvalue()+"</freightvalue>\n");//费用值
			sb.append("\t\t<surchargevalue>"+result.getSurchargevalue()+"</surchargevalue>\n");//附加费
			sb.append("\t\t<incidentalvalue>"+result.getIncidentalvalue()+"</incidentalvalue>\n");//杂费
			sb.append("\t\t<remark>"+result.getFreightpriceRemark()+"</remark>\n");//备注
			sb.append("\t</result>\n");
		}
		sb.append("</SaleTrialCalculate>");
		return sb.toString();
	}

	public static List costBudget(String pkcode,String dthubcode,String grossweight,String ctctcode,String orginDtcode,String pmpmcode,String cocode,
			String lwhs) throws Exception{
			String Dtdt_code="";
			Pattern pattern = Pattern.compile("[0-9]*");
			if (!StringUtility.isNull(dthubcode) && 
					pattern.matcher(dthubcode).matches()) {//如果传过来的是数字，就认为是国家代码，不必转换
				Dtdt_code = dthubcode;
			} else {
				CountryDemand cd=new CountryDemand();
				List<CountryColumns> listCountryColumns=cd.queryDtcodeByHubcode(dthubcode);
				if(listCountryColumns==null || listCountryColumns.size()==0){
					Dtdt_code="174";
				}else{
					Dtdt_code=listCountryColumns.get(0).getDtdt_code();
				}
			}
						
			//产品的列表
			List listPieces=new ArrayList();		
			String[] lwh=lwhs.split(",");
			for(int i=0;i<lwh.length;i++){
				String[] one= lwh[i].split("-");
				BigDecimal length= new BigDecimal(one[0]);
				BigDecimal width=new BigDecimal(one[1]);
				BigDecimal height=new BigDecimal(one[2]);
				try{					
					CorewaybillpiecesColumns cc=new CorewaybillpiecesColumns();
//					cc.setCpcpgrossweight(weight);
					cc.setCpcplength(length);
					cc.setCpcpwidth(width);
					cc.setCpcpheight(height);
					listPieces.add(cc);
				}catch(NumberFormatException nfe){
					CorewaybillpiecesColumns cc=new CorewaybillpiecesColumns();
//					cc.setCpcpgrossweight(new BigDecimal("0"));
					cc.setCpcplength(new BigDecimal("0"));
					cc.setCpcpwidth(new BigDecimal("0"));
					cc.setCpcpheight(new BigDecimal("0"));
					listPieces.add(cc);
				}
				
			}

			SaleTrialCalculateParameter stcParameter=new SaleTrialCalculateParameter();
			stcParameter.setCocode(cocode);//设置公司代码
			stcParameter.setPkcode(pkcode);//设置产品名称
			stcParameter.setCtcode(ctctcode);//设置货物类型
			stcParameter.setPmcode(pmpmcode);//设置付费类型
			stcParameter.setOrginDtcode(orginDtcode);//起运地
			stcParameter.setDestDtcode(Dtdt_code);//目的国家
			stcParameter.setGrossweight(grossweight);//重量
			stcParameter.setPiecesList(listPieces);//设置产品件数
		//	stcParameter.setPostcode(Postcode);//邮编
			SaleTrialCalculate sc=new SaleTrialCalculate();
			List<SaleTrialCalculateResult> saleList=sc.calculate(stcParameter);	
			//根据总额进行排序
			Comparator comp = new Mycomparator();
			Collections.sort(saleList,comp);
			return saleList;
		
	}
	
	//根据产品名称得到产品介绍的链接
	  public static String findLinkByPkName(String PkName) throws Exception{
		  ProductkindQuery objPKQ = new ProductkindQuery();
		  objPKQ.setField(3, PkName);
		  List<ProductkindColumns> listPKC = (List<ProductkindColumns>)objPKQ.getResults();
        return listPKC.get(0).getPkIntroductionlink();
	  }
}
