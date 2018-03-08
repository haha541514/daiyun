package com.daiyun.pgweb.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kyle.common.util.jlang.StringUtility;
import kyle.leis.es.price.expressprice.bl.ExpressPrice;
import kyle.leis.fs.cachecontainer.da.ProductkindColumns;
import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.daiyun.dax.ProductkindDemand;
import com.opensymphony.xwork2.ActionSupport;

public class DoProductKindAction extends ActionSupport {

	private static final long serialVersionUID = 3436850065268931479L;

	/**
	 * 初始化产品下拉列表	
	 * @return
	 */
	public String getAllProductkind(){
		try{
			HttpServletResponse response = ServletActionContext.getResponse();
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			List listResults = ProductkindDemand.getAllProduct("1");
			List<ProductkindColumns> objProductkindColumns = new ArrayList<ProductkindColumns>();
			for (int i = 0; i < listResults.size(); i++)
				objProductkindColumns.add((ProductkindColumns)listResults.get(i));
			//当前用户拥有的产品列表，
			HttpSession session = ServletActionContext.getRequest().getSession();
			String strCocode = (String)session.getAttribute("Cocode");
			if(StringUtility.isNull(strCocode))
				strCocode="1";
			String strDtcode = "719";
			String strEecode = "1";
			ExpressPrice e = new ExpressPrice();
			HashSet<String> hashset = e.searchProductKind(strCocode, strDtcode, strEecode);
			List<ProductkindColumns> list = new ArrayList<ProductkindColumns>();
			Iterator<ProductkindColumns> iterator = objProductkindColumns.iterator();
			while(iterator.hasNext()){
				ProductkindColumns objPkc = (ProductkindColumns)iterator.next(); 
				//System.out.println((objPkc).getPkcode()+"====");
				Iterator<String> hashIter =hashset.iterator();
				while(hashIter.hasNext()){
					String s = hashIter.next();
					//System.out.println(s.toString()+"-----");
					if(s.toString().equals((objPkc).getPkcode().toString())){
						list.add(objPkc);	
					}	
				}		
		    }
			objProductkindColumns.removeAll(objProductkindColumns);
			Iterator<ProductkindColumns>iterList = list.iterator();
			while(iterList.hasNext()){
				ProductkindColumns pdk = iterList.next();
				objProductkindColumns.add(pdk);
			}
			JSONArray jsonArray = JSONArray.fromObject(objProductkindColumns);
			String jsonData = jsonArray.toString();
			out.print(jsonData);
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
}
