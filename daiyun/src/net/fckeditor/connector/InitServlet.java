package net.fckeditor.connector;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class InitServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public InitServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); 
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
	}	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
	}

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		// ��config���õ�ServletContext�У���Ҫ��ʱ��ȥget����  
		config.getServletContext().setAttribute("servletConfig", config); 
		System.out.println("��ʼ��Config����......" );  

	}

}
