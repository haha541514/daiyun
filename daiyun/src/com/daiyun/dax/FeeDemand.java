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
		    strError = "��׼ȷ��д����������Ϣ";
			sb.append("\t<error>\n\t\t<errorcode>" + strErrorCode
					+ "</errorcode>\n\t\t<errorinfo>"
					+ strError + "</errorinfo>\n\t</error>\n");
		}else{
			SaleTrialCalculateResult result = (SaleTrialCalculateResult) resultList.get(0);
			sb.append("\t<result>\n");
			sb.append("\t\t<chargeweight>"+result.getChargeweight()+"</chargeweight>\n");//�ջ�����
			sb.append("\t\t<volumeweight>"+result.getVolumeweight()+"</volumeweight>\n");//�������
			sb.append("\t\t<grossweight>"+result.getGrossweight()+"</grossweight>\n");//ʵ��
			sb.append("\t\t<freightvalue>"+result.getFreightvalue()+"</freightvalue>\n");//����ֵ
			sb.append("\t\t<surchargevalue>"+result.getSurchargevalue()+"</surchargevalue>\n");//���ӷ�
			sb.append("\t\t<incidentalvalue>"+result.getIncidentalvalue()+"</incidentalvalue>\n");//�ӷ�
			sb.append("\t\t<remark>"+result.getFreightpriceRemark()+"</remark>\n");//��ע
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
					pattern.matcher(dthubcode).matches()) {//����������������֣�����Ϊ�ǹ��Ҵ��룬����ת��
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
						
			//��Ʒ���б�
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
			stcParameter.setCocode(cocode);//���ù�˾����
			stcParameter.setPkcode(pkcode);//���ò�Ʒ����
			stcParameter.setCtcode(ctctcode);//���û�������
			stcParameter.setPmcode(pmpmcode);//���ø�������
			stcParameter.setOrginDtcode(orginDtcode);//���˵�
			stcParameter.setDestDtcode(Dtdt_code);//Ŀ�Ĺ���
			stcParameter.setGrossweight(grossweight);//����
			stcParameter.setPiecesList(listPieces);//���ò�Ʒ����
		//	stcParameter.setPostcode(Postcode);//�ʱ�
			SaleTrialCalculate sc=new SaleTrialCalculate();
			List<SaleTrialCalculateResult> saleList=sc.calculate(stcParameter);	
			//�����ܶ��������
			Comparator comp = new Mycomparator();
			Collections.sort(saleList,comp);
			return saleList;
		
	}
	
	//���ݲ�Ʒ���Ƶõ���Ʒ���ܵ�����
	  public static String findLinkByPkName(String PkName) throws Exception{
		  ProductkindQuery objPKQ = new ProductkindQuery();
		  objPKQ.setField(3, PkName);
		  List<ProductkindColumns> listPKC = (List<ProductkindColumns>)objPKQ.getResults();
        return listPKC.get(0).getPkIntroductionlink();
	  }
}
