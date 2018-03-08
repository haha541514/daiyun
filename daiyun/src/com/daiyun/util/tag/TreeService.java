package com.daiyun.util.tag;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.components.Component;

import com.opensymphony.xwork2.util.ValueStack;

public class TreeService extends Component {
	private List<TreeNode> nodes; 
	private HttpServletRequest request;
	private StringBuffer html;
	
	public void setNodes(List<TreeNode> nodes) {
		this.nodes = nodes;
	}

	public TreeService(ValueStack stack, HttpServletRequest request) {
		super(stack);
		this.request = request;
	}
	
	public boolean start(Writer writer){
		html = new StringBuffer();
		if (nodes != null && !nodes.isEmpty()) {
			for (TreeNode node : nodes) {
				//父节点为空，则为根节点，可以有多个根节点
				if (node.getpId() == null) {
					buildTree(node);
				}
			}
		}
		try {
			writer.write(html.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return super.start(writer); 
	}
	
	private List<TreeNode> getChildren(String id){
		List<TreeNode> list = new ArrayList<TreeNode>();
		for (TreeNode node : nodes) {
			if (id.equals(node.getpId())) {
				list.add(node);
			}
		}
		return list;
	}
	
	private void buildTree(TreeNode node){
		List<TreeNode> list = getChildren(node.getId());
		if (list == null || list.isEmpty()) {
			if (node.getLink().indexOf("javascript:") >= 0) {
				html.append("<dd><a href=\"#\" onclick=\"" + node.getLink() + "\">" 
						+ node.getName() + "</a></dd>");
			} else {
				html.append("<dd><a href=\"" + request.getContextPath() + node.getLink() +  "\">" 
						+ node.getName() + "</a></dd>");
			}
		} else {
			html.append("<dl>");
			html.append("<dt class=\"admin_menu_back\" style=\"margin-top:0px; width: 198px;\" onClick=\"toggleDl(this)\">" 
					+ node.getName() + "</dt>");
			for (TreeNode treeNode : list) {
				buildTree(treeNode);
			}
			html.append("</dl>");
		}
	}
}










