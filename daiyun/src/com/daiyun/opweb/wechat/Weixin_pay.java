package com.daiyun.opweb.wechat;


import java.net.InetAddress;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.daiyun.opweb.action.WeChatAction;
import kyle.leis.eo.finance.cashrecord.wechat.HttpUtil;
import kyle.leis.eo.finance.cashrecord.wechat.PayCommonUtil;
import kyle.leis.eo.finance.cashrecord.wechat.PayConfigUtil;
import kyle.leis.eo.finance.cashrecord.wechat.XMLUtil;



public class Weixin_pay {

	
	@SuppressWarnings("unchecked")
	public void weixin_pay(String rechargeAmount,HttpSession session,HttpServletRequest request,
			HttpServletResponse response,String out_trade_no)throws Exception {
		// 账号信息
        String appid = PayConfigUtil.APPID;  // appid
        //String appsecret = PayConfigUtil.APP_SECRET; // appsecret
        String mch_id = PayConfigUtil.MCH_ID; // 商业号
        String key = PayConfigUtil.API_KEY; // key
        String currTime = PayCommonUtil.getCurrTime();
        String strTime = currTime.substring(8, currTime.length());
        String strRandom = PayCommonUtil.buildRandom(4) + "";
        String nonce_str = strTime + strRandom;
        String order_price =  rechargeAmount; // 价格   注意：价格的单位是分
        String body = "代运网会员充值";   // 商品名称
       
        

        // 获取发起电脑 ip
        InetAddress addr = InetAddress.getLocalHost(); 
		String ip=addr.getHostAddress();//获得本机IP
     
        // 回调接口 
        String notify_url = PayConfigUtil.NOTIFY_URL;
        String trade_type = "NATIVE";
        
        SortedMap<Object,Object> packageParams = new TreeMap<Object,Object>();
        packageParams.put("appid", appid);
        packageParams.put("mch_id", mch_id);
        packageParams.put("nonce_str", nonce_str);
        packageParams.put("body", body);
        packageParams.put("out_trade_no", out_trade_no);
        packageParams.put("total_fee", order_price);
        packageParams.put("spbill_create_ip", ip);
        packageParams.put("notify_url", notify_url);
        packageParams.put("trade_type", trade_type);

        String sign = PayCommonUtil.createSign("UTF-8", packageParams,key);
        packageParams.put("sign", sign);
        String requestXML = PayCommonUtil.getRequestXml(packageParams);
        String resXml = HttpUtil.postData(PayConfigUtil.UNIFIED_ORDER_URL, requestXML);

        Map map = XMLUtil.doXMLParse(resXml);
        //String return_code = (String) map.get("return_code");
        //String prepay_id = (String) map.get("prepay_id");
        String urlCode = (String) map.get("code_url");
        response.getOutputStream().print(urlCode);
        WeChatAction wc=new WeChatAction();
        Thread thread = new Thread(wc);  
        thread.start();
		}
	 
}
