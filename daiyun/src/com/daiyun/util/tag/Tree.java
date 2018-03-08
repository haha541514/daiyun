package com.daiyun.util.tag;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.components.Component;
import org.apache.struts2.views.jsp.ComponentTagSupport;

import com.opensymphony.xwork2.util.ValueStack;
/**
 * 可以有多个根节点
 * @author Administrator
 *
 */
public class Tree extends ComponentTagSupport {
	private static final long serialVersionUID = 1L;
	private List<TreeNode> items;

	public List<TreeNode> getItems() {
		return items;
	}

	public void setItems(List<TreeNode> items) {
		this.items = items;
	}

	@Override
	public Component getBean(ValueStack stack, HttpServletRequest request,
			HttpServletResponse response) {
		return new TreeService(stack, request);
	}
	
	@Override  
    protected void populateParams() {  
        super.populateParams();  
        TreeService treeService = (TreeService) getComponent();  
        treeService.setNodes(getItems());
    }

}
