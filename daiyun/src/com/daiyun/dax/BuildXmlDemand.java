package com.daiyun.dax;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import kyle.common.util.jlang.StringUtility;
import kyle.leis.eo.operation.cargoinfo.da.CargoinfoColumns;
import kyle.leis.eo.operation.cargoinfo.dax.CargoInfoDemand;
import kyle.leis.eo.operation.corewaybillpieces.da.CorewaybillpiecesColumns;
import kyle.leis.eo.operation.corewaybillpieces.dax.CorewaybillpiecesDemand;
import kyle.leis.eo.operation.housewaybill.da.WaybillforpredictColumns;
import kyle.leis.es.company.channel.da.ChannelColumns;
import kyle.leis.es.company.channel.dax.ChannelDemand;
import kyle.leis.fs.cachecontainer.da.DistrictColumns;
import kyle.leis.fs.dictionary.district.da.AlldhldistrictColumns;
import kyle.leis.fs.dictionary.district.dax.DistrictDemand;

public class BuildXmlDemand {
	//WaybillforpredictColumns
	//http://127.0.0.1:8089/baiqian/PrintPDFLableServlet.xsv?serverewbcode=6992018401&username=1043262_API&password=27AC8U01
	public static String getXmlString(WaybillforpredictColumns  wayBills) throws Exception{
		ChannelColumns channelColumns=ChannelDemand.load(wayBills.getChnchn_code(),true);
		List<CorewaybillpiecesColumns> Corewaybillpieceslist=CorewaybillpiecesDemand.load(wayBills.getCwcw_code());
		List<CargoinfoColumns> cargolist = CargoInfoDemand.queryAndweightByCwCode(wayBills.getCwcw_code(), wayBills.getCwcw_customerchargeweight());
		String dtcode=DistrictDemand.getDtcodeByHubcode(wayBills.getDtdt_hubcode());
		DistrictColumns district=DistrictDemand.load(dtcode);
		StringBuilder xmlStr = new StringBuilder();
		xmlStr.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
		xmlStr.append("<res:ShipmentValidateResponse xmlns:res='http://www.dhl.com' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xsi:schemaLocation= 'http://www.dhl.com ship-val-res.xsd'>");
		
		xmlStr.append("<Response>");
		xmlStr.append("<ServiceHeader>");
		xmlStr.append("<MessageTime>"+new SimpleDateFormat("yyyy-MM-dd  HH:mm:ss").format(Calendar.getInstance().getTime())+"</MessageTime>");
		xmlStr.append("<MessageReference>"+""+"</MessageReference>");
		xmlStr.append("<SiteID>"+"1468636"+"</SiteID>");
		xmlStr.append("</ServiceHeader>>");
		xmlStr.append("</Response>");
		
		xmlStr.append("<Note>");
		xmlStr.append("<ActionNote>Success</ActionNote>");
		xmlStr.append("</Note>");
		
		xmlStr.append("<AirwayBillNumber>"+wayBills.getCwcw_serverewbcode()+"</AirwayBillNumber>");
		String CourierMessage="";

		if(cargolist.size()!=0 && cargolist!=null){
			for(int i=0;i<cargolist.size();i++){
				if(i==(cargolist.size()-1)){
					CourierMessage=CourierMessage+cargolist.get(i).getCiciename();
					break;
				}
				CourierMessage=CourierMessage+cargolist.get(i).getCiciename()+", ";
			}
		}
		
		xmlStr.append("<BillingCode>"+""+"</BillingCode>");
		String currencycode=cargolist.get(0).getCkckcode();
		xmlStr.append("<CurrencyCode>"+currencycode+"</CurrencyCode>");
		xmlStr.append("<CourierMessage>"+CourierMessage+"</CourierMessage>");
		
		xmlStr.append("<DestinationServiceArea>");
		
		if (!StringUtility.isNull(wayBills.getHwhw_consigneepostcode())) {
			String strDthubcode = DistrictDemand.getDHLHubcode(wayBills.getDtdt_hubcode(), wayBills.getHwhw_consigneepostcode());
			if (StringUtility.isNull(strDthubcode))
				strDthubcode = wayBills.getDdtdt_hubcode();
			xmlStr.append("<ServiceAreaCode>"+strDthubcode+"</ServiceAreaCode>");
			if (StringUtility.isNull(strDthubcode)) {
				return "E_" + "您输入的邮编" + wayBills.getHwhw_consigneepostcode() + 
				"国家" + wayBills.getDtdt_hubcode() + "错误";
			}
			String str = DistrictDemand.getDHLLocationCode(wayBills.getHwhw_consigneecity(),
					strDthubcode,
					wayBills.getDtdt_hubcode(),  
					wayBills.getHwhw_consigneepostcode());
			if (StringUtility.isNull(str)) {
				return "E_" + "您输入的邮编" + wayBills.getHwhw_consigneepostcode() + 
				"国家" + wayBills.getDtdt_hubcode() + "城市" + wayBills.getHwhw_consigneecity() + "错误";
			}			
			xmlStr.append("<FacilityCode>"+str+"</FacilityCode>");
		} else {
			AlldhldistrictColumns objADDColumns = DistrictDemand.getAlldhldistrict(wayBills.getHwhw_consigneecity(),
					"", 
					wayBills.getDtdt_hubcode(), 
					"");			
			if (objADDColumns == null) {
				return "E_" + "您输入的国家" + wayBills.getDtdt_hubcode() + "城市" + wayBills.getHwhw_consigneecity() + "错误";				
			}
			xmlStr.append("<ServiceAreaCode>" + objADDColumns.getDhldd_hubcode() + "</ServiceAreaCode>");
			xmlStr.append("<FacilityCode>" + objADDColumns.getDhldd_locationcode() + "</FacilityCode>");			
		}
		xmlStr.append("<InboundSortCode>"+""+"</InboundSortCode>");
		xmlStr.append("</DestinationServiceArea>");
		xmlStr.append("<OriginServiceArea>");
		xmlStr.append("<ServiceAreaCode>HKG</ServiceAreaCode>");
		xmlStr.append("<OutboundSortCode>"+""+"</OutboundSortCode>");
		xmlStr.append("</OriginServiceArea>");
		
		xmlStr.append("<Rated>N</Rated>");
		xmlStr.append("<WeightUnit>K</WeightUnit>");
		xmlStr.append("<ChargeableWeight>"+wayBills.getCwcw_chargeweight()+"</ChargeableWeight>");
		xmlStr.append("<DimensionalWeight>0.0</DimensionalWeight>");
		xmlStr.append("<CountryCode>HK</CountryCode>");
		
		xmlStr.append("<Barcodes>");	
		xmlStr.append("<AWBBarCode>"+wayBills.getCwcw_serverewbcode()+"</AWBBarCode>");
		xmlStr.append("<OriginDestnBarcode>"+""+"</OriginDestnBarcode>");
		xmlStr.append("<DHLRoutingBarCode>"+""+"</DHLRoutingBarCode>");
		xmlStr.append("</Barcodes>");		
		xmlStr.append("<Piece>"+Corewaybillpieceslist.size()+"</Piece>");
		xmlStr.append("<Contents>"+CourierMessage+"</Contents>");
		
		xmlStr.append("<Reference>");
		xmlStr.append("<ReferenceID>"+wayBills.getCwcw_customerewbcode()+"</ReferenceID>");
		xmlStr.append("<ReferenceType>St</ReferenceType>");
		xmlStr.append("</Reference>");
		
		xmlStr.append(Consignee(wayBills,district));
		xmlStr.append(Shipper(wayBills));
		
		xmlStr.append("<CustomerID>"+""+"</CustomerID>");
		xmlStr.append("<ShipmentDate>"+new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime())+"</ShipmentDate>");
		xmlStr.append("<GlobalProductCode>P</GlobalProductCode>");
		
		xmlStr.append("<Billing>");
		xmlStr.append("<ShipperAccountNumber>"+channelColumns.getEraccount()+"</ShipperAccountNumber>");
		xmlStr.append("<ShippingPaymentType>S</ShippingPaymentType>");
		xmlStr.append("<BillingAccountNumber>"+channelColumns.getChnchnpaymentaccount()+"</BillingAccountNumber>");
		xmlStr.append("<DutyPaymentType>R</DutyPaymentType>");
		xmlStr.append("</Billing>");
		
		xmlStr.append("<Dutiable>");
		double value =0.0;
		for(int i=0;i<cargolist.size();i++){
			if(!StringUtility.isNull(cargolist.get(i).getCicitotalprice()))
				value=value+Double.parseDouble(cargolist.get(i).getCicitotalprice());
		}
		xmlStr.append("<DeclaredValue>"+value+""+"</DeclaredValue>");
		xmlStr.append("<DeclaredCurrency>"+currencycode+"</DeclaredCurrency>");
		xmlStr.append("</Dutiable>");
		
		xmlStr.append("<DHLRoutingCode>"+district.getDtcountrydthubcode()+wayBills.getHwhw_consigneepostcode()+"+48000001"+"</DHLRoutingCode>");
		xmlStr.append("<DHLRoutingDataId>2L</DHLRoutingDataId>");
		xmlStr.append("<ProductContentCode>WPX</ProductContentCode>");
		xmlStr.append("<ProductShortName>EXPRESS WORLDWIDE</ProductShortName>");
		xmlStr.append("<InternalServiceCode>C</InternalServiceCode>");
		xmlStr.append("<DeliveryDateCode/>");
		xmlStr.append("<DeliveryTimeCode/>");
		xmlStr.append(price(Corewaybillpieceslist, wayBills));
		xmlStr.append("</res:ShipmentValidateResponse>");
		
		return xmlStr.toString();
	}
	
	public static String Consignee(WaybillforpredictColumns  wayBills,DistrictColumns district) throws Exception{
		StringBuilder consig=new StringBuilder();
		consig.append("<Consignee>");
		consig.append("<CompanyName>"+wayBills.getHwhw_consigneecompany()+"</CompanyName>");
		consig.append("<AddressLine>"+wayBills.getHwhw_consigneeaddress1()+"</AddressLine>");
		consig.append("<AddressLine>"+wayBills.getHwhw_consigneeaddress2()+"</AddressLine>");
		consig.append("<AddressLine>"+wayBills.getHwhw_consigneeaddress3()+"</AddressLine>");
		consig.append("<City>"+wayBills.getHwhw_consigneecity()+"</City>");
		consig.append("<PostalCode>"+wayBills.getHwhw_consigneepostcode()+"</PostalCode>");
		consig.append("<CountryCode>"+district.getDtcountrydthubcode()+"</CountryCode>");
		consig.append("<CountryName>"+district.getDtcountrydtename()+"</CountryName>");
		consig.append("<Contact>");
		consig.append("<PersonName>"+wayBills.getHwhw_consigneename()+"</PersonName>");
		consig.append("<PhoneNumber>"+wayBills.getHwhw_consigneetelephone()+"</PhoneNumber>");
		consig.append("</Contact>");
		
		consig.append("</Consignee>");
		
		return consig.toString();
	} 
	
	public static String Shipper(WaybillforpredictColumns  wayBills) throws Exception{
		StringBuilder shipper=new StringBuilder();
		shipper.append("<Shipper>");
		shipper.append("<ShipperID>"+""+"</ShipperID>");//
		shipper.append("<CompanyName>"+wayBills.getHwhw_shippercompany()+"</CompanyName>");
		shipper.append("<AddressLine>"+wayBills.getHwhw_shipperaddress1()+"</AddressLine>");
		shipper.append("<AddressLine>"+wayBills.getHwhw_shipperaddress2()+"</AddressLine>");
		shipper.append("<AddressLine>"+wayBills.getHwhw_shipperaddress3()+"</AddressLine>");
		shipper.append("<City>HONG KONG</City>");
		shipper.append("<CountryCode>HK</CountryCode>");
		shipper.append("<CountryName>HONG KONG</CountryName>");
		if (wayBills.getHwhw_shipperpostcode()==null || "".equals(wayBills.getHwhw_shipperpostcode().trim())) {
			shipper.append("<PostalCode>"+""+"</PostalCode>");
		}else{
			shipper.append("<PostalCode>"+wayBills.getHwhw_shipperpostcode()+"</PostalCode>");
		}
		shipper.append("<Contact>");
		shipper.append("<PersonName>"+wayBills.getHwhw_shippername()+"</PersonName>");
		shipper.append("<PhoneNumber>"+wayBills.getHwhw_shippertelephone()+"</PhoneNumber>");
		shipper.append("</Contact>");
		
		shipper.append("</Shipper>");
		return shipper.toString();
	}
	
	public static String price(List<CorewaybillpiecesColumns> Corewaybillpieceslist,
			WaybillforpredictColumns wayBills){
		if(Corewaybillpieceslist.size()==0 || Corewaybillpieceslist==null){
			return "";
		}
		StringBuffer strPirce=new StringBuffer();
		strPirce.append("<Pieces>");
		for(int i=0;i<Corewaybillpieceslist.size();i++){
			CorewaybillpiecesColumns cwp=Corewaybillpieceslist.get(i);
			strPirce.append("<Piece>");
			strPirce.append("<PieceNumber>"+(i+1)+"</PieceNumber>");
			strPirce.append("<Weight>" + wayBills.getCwcw_chargeweight() + "</Weight>");
			strPirce.append("<DimWeight>0.0</DimWeight>");
			strPirce.append("<DataIdentifier>J</DataIdentifier>");
			String liccensePlate ="JD01"+cwp.getCpcplabelcode();
			strPirce.append("<LicensePlate>"+liccensePlate+"</LicensePlate>");
			strPirce.append("<LicensePlateBarCode>"+liccensePlate+"</LicensePlateBarCode>");
			strPirce.append("</Piece>");
		}
		strPirce.append("</Pieces>");
		return strPirce.toString();
	}
}
