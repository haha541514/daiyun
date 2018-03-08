package com.daiyun.dax;


import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import kyle.common.util.jlang.CollectionUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.es.price.expressprice.bl.ExpressPrice;

import kyle.leis.fs.cachecontainer.da.ProductkindColumns;
import kyle.leis.fs.cachecontainer.da.ProductkindQuery;
import kyle.leis.fs.dictionary.productkind.da.PkcargokindjdbcColumns;
import kyle.leis.fs.dictionary.productkind.da.PkcargokindjdbcCondition;
import kyle.leis.fs.dictionary.productkind.da.PkcargokindjdbcQuery;




public class ProductkindDemand {
	
	public static List<ProductkindColumns> queryProductkind2()throws Exception
	{
		ProductkindQuery objPKQ = new ProductkindQuery();
		objPKQ.setUseCachesign(true);
		List<ProductkindColumns> listPKC = (List<ProductkindColumns>)objPKQ.getResults();
		return listPKC;
	}
	
	//当前用户拥有的产品列表
	public static List<ProductkindColumns> getAllProduct() throws Exception{
		// HttpServletRequest request = ServletActionContext.getRequest();
		// HttpServletResponse response = ServletActionContext.getResponse();
		// response.setCharacterEncoding("UTF-8");
		List listResults = ProductkindDemand.queryProductkind2();
		List<ProductkindColumns> objProductkindColumns = new ArrayList<ProductkindColumns>();
		for (int i = 0; i < listResults.size(); i++)
			objProductkindColumns.add((ProductkindColumns)listResults.get(i));		
		
		//String strCocode = (String)request.getAttribute("strCocode");
		HttpSession session = ServletActionContext.getRequest().getSession();
		String strCocode = (String)session.getAttribute("Cocode");
		
		if(StringUtility.isNull(strCocode))
			strCocode = "2";
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
		return objProductkindColumns;
	}
	
	/**
	 * 当前用户拥有的产品列表
	 * @param cocode
	 * @return
	 * @throws Exception
	 */
	public static List<ProductkindColumns> getAllProduct(String cocode) throws Exception{
		// HttpServletRequest request = ServletActionContext.getRequest();
		// HttpServletResponse response = ServletActionContext.getResponse();
		// response.setCharacterEncoding("UTF-8");
		List listResults = ProductkindDemand.queryProductkind2();
		List<ProductkindColumns> objProductkindColumns = new ArrayList<ProductkindColumns>();
		for (int i = 0; i < listResults.size(); i++)
			objProductkindColumns.add((ProductkindColumns)listResults.get(i));		
		
		//String strCocode = (String)request.getAttribute("strCocode");
//		HttpSession session = ServletActionContext.getRequest().getSession();
//		String strCocode = (String)session.getAttribute("Cocode");
		
		if(StringUtility.isNull(cocode))
			cocode = "338";
		String strDtcode = "719";
		String strEecode = "1";
		ExpressPrice e = new ExpressPrice();
		HashSet<String> hashset = e.searchProductKind(cocode, strDtcode, strEecode);
		List<ProductkindColumns> list = new ArrayList<ProductkindColumns>();
		Iterator<ProductkindColumns> iterator = objProductkindColumns.iterator();
		while(iterator.hasNext()){
			ProductkindColumns objPkc = (ProductkindColumns)iterator.next(); 
			//System.out.println((objPkc).getPkcode()+"====");
			Iterator<String> hashIter =hashset.iterator();
			while(hashIter.hasNext()){
				String s = hashIter.next();
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
		return objProductkindColumns;
	}
	
	/**
	 * 可接特殊货物
	 * @throws Exception 
	 * */
	@SuppressWarnings("unchecked")
	public static String getCargoKind(String pkCode) throws Exception{
		HttpSession session = ServletActionContext.getRequest().getSession();
		String strEecode = (String)session.getAttribute("Eecode");
		PkcargokindjdbcQuery query = new PkcargokindjdbcQuery();
		PkcargokindjdbcCondition objCondition = new PkcargokindjdbcCondition();
		objCondition.setEe_code(strEecode);
		objCondition.setPk_code(pkCode);
		query.setCondition(objCondition);
		List<PkcargokindjdbcColumns> resultLists = query.getResults();
		String strCargoinfo = "";
		if(!CollectionUtility.isNull(resultLists)){
			for(PkcargokindjdbcColumns columns :resultLists){
				strCargoinfo += columns.getCkcgk_name()+" ";
			
			}
		}
		
		return strCargoinfo;
	}
	
	
	
}
