package com.daiyun.opweb.action;

import java.io.IOException;

import javax.servlet.http.HttpSession;
import kyle.baiqian.fs.web.action.ActionSupportEX;
import kyle.common.util.jlang.StringUtility;

public class ProgressBar extends ActionSupportEX {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public void responseNum() throws IOException{
		HttpSession session = request.getSession(); session=request.getSession();
		String number1=(String) session.getAttribute("number1");
		System.out.println(number1);
		if(!StringUtility.isNull(number1)){
			String number2=(String) session.getAttribute("number2");
			System.out.println(number2);
			if(!StringUtility.isNull(number2)){
				String number3=(String) session.getAttribute("number3");
				System.out.println(number3);
				if(!StringUtility.isNull(number3)){
					String number4=(String) session.getAttribute("number4");
					System.out.println(number4);
					if(!StringUtility.isNull(number4)){
						response.getOutputStream().print(number4);
					}else{
						response.getOutputStream().print(number3);
					}
				}else{
					response.getOutputStream().print(number2);
				}
			}else{
				response.getOutputStream().print(number1);
			}
		}else{
			return;
		}
		}

}
