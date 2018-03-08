package com.daiyun.pgweb.action;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.StringUtility;
import kyle.leis.fs.authoritys.user.da.UserColumns;
import kyle.leis.fs.authoritys.user.da.UserCondition;
import kyle.leis.fs.authoritys.user.da.UserQuery;

import org.apache.struts2.ServletActionContext;

public class LoginManageAction extends ActionSupportEX {
	public String LoginManageAction() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpSession session = request.getSession();
		String opname = request.getParameter("username").toUpperCase();
		String password = request.getParameter("password");
		UserColumns objReturn = null;
		UserCondition objCondition = new UserCondition();
		UserQuery objQuery = new UserQuery();
		objCondition.setOpcode(opname);
		// objCondition.setOppassword(password);
		objQuery.setCondition(objCondition);
		List list = objQuery.getResults();
		if (StringUtility.isNull(opname) || StringUtility.isNull(password)) {
			addFieldError("username", "用户名或密码不能为空");
			return ERROR;
		}
		if (!StringUtility.isNull(opname) && !StringUtility.isNull(password)) {
			if (list.size() == 0) {
				addFieldError("password", "用户名不存在，请重新输入");
				return ERROR;
			}
			objReturn = (UserColumns) list.get(0);
			if (password.equals(objReturn.getWord())
					&& opname.equals(objReturn.getOpopcode())
					&& StringUtility.isNull(objReturn.getCococode())) {
				// 登录
				kyle.baiqian.fs.authoritys.user.da.UserColumns userReturn=new kyle.baiqian.fs.authoritys.user.da.UserColumns();
				userReturn.setOpopid(Long.valueOf(objReturn.getOpopid()));
				session.setAttribute("loginuser", userReturn);
				//session.setAttribute("OpId", objReturn.getOpopid());
				return SUCCESS;
			} else {
				addFieldError("password", "密码不正确或用户非法");
				return ERROR;
			}
		}

		return null;
	}
}