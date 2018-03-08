package com.daiyun.pgweb.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.DateFormatUtility;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.es.bulletin.bl.Bulletin;
import kyle.leis.es.bulletin.bl.WechatItem;
import kyle.leis.es.bulletin.da.BulletinColumns;
import kyle.leis.es.bulletin.da.BulletinCondition;
import kyle.leis.es.bulletin.da.WechatitemColumns;
import kyle.leis.es.bulletin.da.WechatitemCondition;
import kyle.leis.es.bulletin.dax.BulletinDemand;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemColumns;
import kyle.leis.fs.authoritys.gmenus.da.GmenusitemCondition;
import kyle.leis.fs.authoritys.gmenus.dax.GmenusItemDemand;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.daiyun.dax.BulletinOpr;
import com.daiyun.dax.IBasicData;
import com.daiyun.dax.MessageBean;
import com.daiyun.dax.WechatitemDemand;
public class ToIndexBlAction extends ActionSupportEX{
	
	private static final long serialVersionUID = 3193353022281437259L;
	private String blId;
	private File image; //上传的文件
    private String imageFileName; //文件名称
    private String imageContentType; //文件类型
	
	public File getImage() {
		return image;
	}
	public void setImage(File image) {
		this.image = image;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public String getImageContentType() {
		return imageContentType;
	}
	public void setImageContentType(String imageContentType) {
		this.imageContentType = imageContentType;
	}
	public String getBlId() {
		return blId;
	}
	public void setBlId(String blId) {
		this.blId = blId;
	}
	
	public String queryByBlId() throws Exception{		
		GmenusitemCondition objGmenusitemCondition = new GmenusitemCondition();
		objGmenusitemCondition.setGmlevel("2");
		objGmenusitemCondition.setGmstructurecode("A08");
		List submenulist=GmenusItemDemand.query(objGmenusitemCondition);
		request.setAttribute("submenulist", submenulist);
		
		//得到主菜单名称
		GmenusitemCondition objGmenusitemCondition1 = new GmenusitemCondition();
		objGmenusitemCondition1.setGmlevel("1");
		objGmenusitemCondition1.setGmstructurecode("A08");
		GmenusitemColumns gc=(GmenusitemColumns)GmenusItemDemand.query(objGmenusitemCondition1).get(0);
		request.setAttribute("gmname", gc.getGmgm_name());
		request.setAttribute("sc", "A08");
		
		String pf=request.getParameter("pf");
		String strBlId=request.getParameter("blId");
		String code=request.getParameter("gmcode");		
		BulletinColumns bc=BulletinOpr.queryByBlId(strBlId);
		request.setAttribute("objBulletin", bc);
		request.setAttribute("pf", pf);
		request.setAttribute("gmcode",code);		
		return SUCCESS;
	}
	public String queryByBkcode() throws Exception{
		String structCode=request.getParameter("sc");
		GmenusitemCondition objGmenusitemCondition = new GmenusitemCondition();
		objGmenusitemCondition.setGmlevel("2");
		objGmenusitemCondition.setGmstructurecode(structCode);
		List submenulist=GmenusItemDemand.query(objGmenusitemCondition);
		request.setAttribute("submenulist", submenulist);
		request.setAttribute("sc", structCode);
		
		//得到主菜单名称
		GmenusitemCondition objGmenusitemCondition1 = new GmenusitemCondition();
		objGmenusitemCondition1.setGmlevel("1");
		objGmenusitemCondition1.setGmstructurecode(structCode);
		GmenusitemColumns gc=(GmenusitemColumns)GmenusItemDemand.query(objGmenusitemCondition1).get(0);
		request.setAttribute("gmname", gc.getGmgm_name());
		
		//根据gmcode得到菜单名称
		String gmCode=request.getParameter("gmcode");
		GmenusitemCondition objGmenusitemCondition2 = new GmenusitemCondition();
		objGmenusitemCondition2.setGmcode(gmCode);
		GmenusitemColumns gc1=(GmenusitemColumns)GmenusItemDemand.query(objGmenusitemCondition2).get(0);
		request.setAttribute("objGmenusitemColumns", gc1);
		
		String bulltin=request.getParameter("pf");
		String strBkcode=request.getParameter("bkcode");
		BulletinCondition objBulletinCondition = new BulletinCondition();
		objBulletinCondition.setBkcode(strBkcode);
		m_objPageConfig.setMaxPageResultCount(11);
		objBulletinCondition.setPageConfig(m_objPageConfig);
		List listBulletin=BulletinDemand.query(objBulletinCondition);
		request.setAttribute("bullentinList", listBulletin);
		request.setAttribute("pf", bulltin);
		return SUCCESS;
	}
	
	//后台根据条件查询公告
	public String queryBulletin() throws Exception{
		String bulletinHeading=request.getParameter("bulletinHeading");
		String bulletinType=request.getParameter("bulletinType");
		String bulletinLevle=request.getParameter("bulletinLevle");
		String bulletinCreater=request.getParameter("bulletinCreater");
		BulletinCondition objBulletinCondition=new BulletinCondition();
		objBulletinCondition.setBlheading(bulletinHeading);
		objBulletinCondition.setBkcode(bulletinType);
		objBulletinCondition.setBlcode(bulletinLevle);
		if(bulletinCreater!=null && !"".equals(bulletinCreater)){
			if(bulletinCreater.equals("admin")){
				objBulletinCondition.setOpid("0");
			}else{
				objBulletinCondition.setOpid("");
			}
		}
		m_objPageConfig.setMaxPageResultCount(8);
		objBulletinCondition.setPageConfig(m_objPageConfig);
		List bulletinList=BulletinDemand.queryByWeChatSign(objBulletinCondition, null);
		request.setAttribute("bulletinList", bulletinList);
		request.setAttribute("bulletinType", bulletinType);
		request.setAttribute("bulletinLevle", bulletinLevle);
		request.setAttribute("searchArticleTitle", bulletinHeading);
		request.setAttribute("searchArticleCreater", bulletinCreater);
		return SUCCESS;
	}
	/*
	 * 根据 ID获取公告信息
	 * 
	 */
	public String getBulletinById(){
		String strBlId = request.getParameter("strBlId");
		session.setAttribute("strBlblid",strBlId);
		try {
			BulletinColumns bulletinColumns=BulletinOpr.queryByBlId(strBlId);
			request.setAttribute("bulletinColumns", bulletinColumns);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	
	public String saveBulletin() throws Exception{
	
		// 修改者ID
		String strOperId = request.getParameter("strOperId");
		// 得到需要修改的公告ID
		String strBlId = request.getParameter("strBlId");
		String bulletinHeading=request.getParameter("bulletinHeading");
		String bulletinType=request.getParameter("bulletinType");
		String bulletinLevel=request.getParameter("bulletinLevel");
		String blBlcontent=request.getParameter("bulletincontent");
		String blvaliddate = request.getParameter("blvaliddate");
		//得到操作类型
		String addflag=request.getParameter("addflag");
		
		BulletinColumns objBulletinReturn = new BulletinColumns();
		if(!StringUtility.isNull(strBlId)){
			objBulletinReturn=BulletinOpr.queryByBlId(strBlId);
		}
		objBulletinReturn.setBlblheading(bulletinHeading);
		objBulletinReturn.setBlblcontent(blBlcontent);
		objBulletinReturn.setBllblcode(bulletinLevel);
		objBulletinReturn.setBkbkcode(bulletinType);
		Date date = new Date();
		if (!StringUtility.isNull(blvaliddate)) {
			date = DateFormatUtility.getStandardDate(blvaliddate);
		}
		objBulletinReturn.setBlblvaliddate(date);
		objBulletinReturn.setBlblmodifydate(new Date());
		if(!("".equals(addflag) || addflag == null)){
			objBulletinReturn.setBlblcreatedate(new Date());
			objBulletinReturn.setBlblcontentindex(bulletinHeading);
			objBulletinReturn.setBlblsignname(bulletinHeading);
			objBulletinReturn.setBlblcontentindex(bulletinHeading);
		}
		Bulletin bulletin=new Bulletin();
		bulletin.save(objBulletinReturn, strOperId);
		return SUCCESS;
	}
	public String deleteBulletin(){		
	
		// 复选框批量删除
		if (!("".equals(request.getParameterValues("delid")) || request
				.getParameterValues("delid") == null)) {
			Bulletin bulletin=new Bulletin();
			String[] strblId = request.getParameterValues("delid");
			for (int i = 0; i < strblId.length; i++) {
				try {
					bulletin.delete(strblId[i]);
				} catch (Exception e) {
					e.printStackTrace();
					MessageBean messageBean = new MessageBean(IBasicData.MSG_TYPE_ERROR, "删除失败", 
							"公告" + strblId[i] + "有子公告，请先删除子公告。异常信息：" + e.getMessage());
					session.setAttribute("MESSAGEBEAN", messageBean);
					return ERROR;
				}
			}
		}		
		return SUCCESS;
	}
	public void headingAjax() throws Exception{
		PrintWriter out=response.getWriter();
		String blHeading=request.getParameter("blHeading");
		String strBlId=request.getParameter("strBlId");
		BulletinCondition objBulletinCondition = new BulletinCondition();
		objBulletinCondition.setBlheading(blHeading);
		List bllist=BulletinDemand.queryByHeading(objBulletinCondition);
		if(bllist !=null && bllist.size()>0){
			if(!StringUtility.isNull(strBlId)){
				BulletinCondition objBulletinCondition1 = new BulletinCondition();
				objBulletinCondition1.setBlid(strBlId);
				BulletinColumns bc=(BulletinColumns)BulletinDemand.query(objBulletinCondition1).get(0);
				if(blHeading.equals(bc.getBlblheading())){
					out.print("no");
				}else{
					out.print("yes");
				}
			}else{
				out.print("yes");
			}
		}else{
			out.print("no");
		}
	}
	/**
	 * 微信公告管理
	 * @return
	 */
	public String weChatBulletin(){
		String bulletinHeading=request.getParameter("bulletinHeading");
		String bulletinType=request.getParameter("bulletinType");
		String bulletinLevle=request.getParameter("bulletinLevle");
		String bulletinCreater=request.getParameter("bulletinCreater");
		BulletinCondition objBulletinCondition=new BulletinCondition();
		objBulletinCondition.setBlheading(bulletinHeading);
		objBulletinCondition.setBkcode(bulletinType);
		objBulletinCondition.setBlcode(bulletinLevle);
		if(bulletinCreater!=null && !"".equals(bulletinCreater)){
			if(bulletinCreater.equals("admin")){
				objBulletinCondition.setOpid("0");
			}else{
				objBulletinCondition.setOpid("");
			}
		}
		m_objPageConfig.setMaxPageResultCount(8);
		objBulletinCondition.setPageConfig(m_objPageConfig);
		List<?> bulletinList = BulletinDemand.queryByWeChatSign(objBulletinCondition, "Y");
		request.setAttribute("bulletinList", bulletinList);
		
		request.setAttribute("bulletinList", bulletinList);
		request.setAttribute("bulletinType", bulletinType);
		request.setAttribute("bulletinLevle", bulletinLevle);
		request.setAttribute("searchArticleTitle", bulletinHeading);
		request.setAttribute("searchArticleCreater", bulletinCreater);
		return SUCCESS;
	}
	/**
	 * 跳转至添加微信公告
	 * @return
	 */
	public String toAddWechat(){
		return SUCCESS;
	}
	/**
	 * 保存微信公告
	 * @return
	 */
	public String saveWechat(){
		// 修改者ID
		String strOperId = request.getParameter("strOperId");
		// 得到需要修改的公告ID
		String strBlId = request.getParameter("strBlId");
		String bulletinHeading=request.getParameter("bulletinHeading");
		String bulletinType=request.getParameter("bulletinType");
		String bulletinLevel=request.getParameter("bulletinLevel");
		String blvaliddate = request.getParameter("blvaliddate");
		//得到操作类型
		String addflag=request.getParameter("addflag");
		
		BulletinColumns objBulletinReturn = new BulletinColumns();
		if(!StringUtility.isNull(strBlId)){
			try {
				objBulletinReturn=BulletinOpr.queryByBlId(strBlId);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		objBulletinReturn.setBlblheading(bulletinHeading);
		objBulletinReturn.setBlblcontent("weChat");
		objBulletinReturn.setBllblcode(bulletinLevel);
		objBulletinReturn.setBkbkcode(bulletinType);
		Date validDate = new Date();
		if (!StringUtility.isNull(blvaliddate)) {
			validDate = DateFormatUtility.getStandardDate(blvaliddate);
		}
		objBulletinReturn.setBlblvaliddate(validDate);
		objBulletinReturn.setBlblmodifydate(new Date());
		objBulletinReturn.setBlblwechatsign("Y");//保存为微信公告
		if(!("".equals(addflag) || addflag == null)){
			objBulletinReturn.setBlblcreatedate(new Date());
			objBulletinReturn.setBlblcontentindex(bulletinHeading);
			objBulletinReturn.setBlblsignname(bulletinHeading);
			objBulletinReturn.setBlblcontentindex(bulletinHeading);
		}
		Bulletin bulletin = new Bulletin();
		try {
			blId = bulletin.save(objBulletinReturn, strOperId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	/**
	 * 编辑微信
	 * @return
	 */
	public String editWechat(){
		String blId = request.getParameter("blId");
		WechatitemCondition condition = new WechatitemCondition();
		condition.setBlid(blId);
		request.setAttribute("wechatitemColumnsList", WechatitemDemand.query(condition));
		request.setAttribute("blId", blId);
		try {
			BulletinColumns bulletinColumns = BulletinOpr.queryByBlId(blId);
			request.setAttribute("bulletinColumns", bulletinColumns);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}
	/**
	 * 保存微信项目
	 * @return
	 */
	public String saveWechatItem(){
		String wcId = request.getParameter("wcId");
		String blId = request.getParameter("blId");
		String title = request.getParameter("title");
		String description = request.getParameter("description");
		String picUrl = request.getParameter("picUrl");
		String url = request.getParameter("url");
		WechatItem wechatItem = new WechatItem();
		WechatitemColumns columns = new WechatitemColumns();
		if (!StringUtility.isNull(wcId)) {
			columns.setWccomp_idwciid(Integer.valueOf(wcId));
		}
		columns.setBlblid(Long.valueOf(blId));
		columns.setWcwcititle(title);
		columns.setWcwcidescription(description);
		columns.setWcwcipicurl(picUrl);
		columns.setWcwciurl(url);
		try {
			wechatItem.save(columns);
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("blId", blId);
		return SUCCESS;
	}
	/**
	 * 删除微信
	 * @return
	 */
	public String deleteWechatItem(){
		WechatItem item = new WechatItem();
		String cwid = request.getParameter("cwid");
		String blid = request.getParameter("blid");
		try {
			item.delete(cwid, blid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		setBlId(blid);
		return SUCCESS;
	}
	/**
	 * 上传图片
	 * @return
	 */
	public String uploadImage(){
		String realpath = ServletActionContext.getServletContext().getRealPath("/pictures");
		String iamgeName = System.currentTimeMillis() + imageFileName;
        if (image != null) {
            File savefile = new File(new File(realpath), iamgeName);
            if (!savefile.getParentFile().exists())
                savefile.getParentFile().mkdirs();
            try {
				FileUtils.copyFile(image, savefile);
				response.setContentType("text/html; charset=utf-8");
				response.getWriter().write("pictures/" + iamgeName);
			} catch (IOException e) {
				e.printStackTrace();
			}
        }
		return null;
	}
}














