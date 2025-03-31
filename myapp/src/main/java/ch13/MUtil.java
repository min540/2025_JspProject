package ch13;

import java.util.*;
import java.text.*;

public class MUtil {

	public static String getContent(String comment) {
		return br("", "<br/>", comment);
	}

	public static String br(String first, String brTag, String comment) {
		StringBuffer buffer = new StringBuffer();
		StringTokenizer st = new StringTokenizer(comment, "\n");
		int count = st.countTokens();
		buffer.append(first);
		int i = 1;
		while (st.hasMoreTokens()) {
			if (i == count) {
				buffer.append(st.nextToken());
			} else {
				buffer.append(st.nextToken() + brTag);
			}
			i++;
		}
		return buffer.toString();
	}

	public static String monFormat(String b) {
		String won;
		double bb = Double.parseDouble(b);
		won = NumberFormat.getIntegerInstance().format(bb);
		return won;
	}

	public static String monFormat(int b) {
		String won;
		double bb = b;
		won = NumberFormat.getIntegerInstance().format(bb);
		return won;
	}

	public static String intFormat(int i) {
		String s = String.valueOf(i);
		return monFormat(s);
	}

	// 2009. 9. 28
	public static String getDay() {
		Date now = new Date();
		DateFormat df = DateFormat.getDateInstance();
		return df.format(now).toString();
	}

	// where num in (?,?,?);
	public static String ph(int length) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			sb.append("?");
			if(i<length-1)
				sb.append(", ");
		}
		return sb.toString();
	}
	
	public static void main(String[] args) {
		System.out.println(ph(5));
		System.out.println(ph(10));
	}
}