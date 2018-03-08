package com.daiyun.util;
public class StrUtil {
	/**
	 * 截取中英文等长字符串
	 */
	public static String splitString(String str, int bytes) {
		int count = 0; // 统计字节数
		String reStr = ""; // 返回字符串
		if (str == null) {
			return "";
		}
		char[] tempChar = str.toCharArray();
		for (int i = 0; i < tempChar.length; i++) {
			String s1 = str.valueOf(tempChar[i]);
			byte[] b = s1.getBytes();
			count += b.length;
			if (count <= bytes) {
				reStr += tempChar[i];
			}
		}
		return reStr;
	}

	public static String stripHtml(String content) {
		String ct = content.replaceAll("<.*?>", "");
		ct = ct.replaceAll("&nbsp;", "");
		ct = ct.replaceAll(" ", "");
		ct = ct.replaceAll("\\s", "");
		ct = ct.replaceAll("\n", "");
		ct = ct.replaceAll("\t", "");
		ct = ct.replaceAll("\r", "");
		ct = StrUtil.splitString(ct, 300);
		return ct;
	}

	public static String sbString(String str, int x) {
		str = str.substring(x);
		return str;
	}

	public static String splitString(String s) {
		String src = "";
		String src2 = "";
		for (int i = 0; i < s.length() / 4; i++) {
			src = s.substring(i * 4, (i * 4) + 4);
			src2 += src + " ";
		}
		src2 = src2 + s.substring(s.length() - s.length() % 4);
		return src2;
	}

	public static String splitString2(String s) {
		String str = "";
		String str2 = "";
		if (s.length() > 4) {
			str = s.substring(0, 2);
			str2 = str + " ";
			str = s.substring(2, 4);
			str2 += str + " ";
			for (int i = 0; i < (s.length() - 4) / 3; i++) {
				str = s.substring(4 + i * 3, i * 3 + 3 + 4);
				str2 += str + " ";
			}
			return str2;
		}
		return s;
	}

	public static String repString(String s) {
		s = s.replace("A2", "A 2");
		return s;
	}
	public static String splitserverewbcode(String str){
		String s = "";
		String str1 = " ";
		s = str.substring(0, 2) + str1;
		s = s + str.substring(s.length() - str1.length(),s.length() + 3) + str1;
		s = s + str.substring(s.length()- 2*str1.length(),s.length() + 1) + str1;
		s = s + str.substring(s.length() - 3*str1.length(), s.length()) + str1;
		s = s + str.substring(s.length() - 4*str1.length(), s.length() - 1) + str1;
		s = s + str.substring(str.length() - 1);
		return s;
	}
}
