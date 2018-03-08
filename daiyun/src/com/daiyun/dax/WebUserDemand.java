package com.daiyun.dax;

import java.util.List;

import kyle.leis.fs.authoritys.user.da.UserCondition;
import kyle.leis.fs.authoritys.user.da.UserQuery;

public class WebUserDemand {
    public List queryAllUsers(UserCondition con) throws Exception{
    	UserQuery query = new UserQuery();
    	query.setCondition(con);
    	return query.getResults();
    }
}
