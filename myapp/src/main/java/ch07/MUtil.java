package ch07;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;

public class MUtil {
	
	public static String randomColor(){
		Random r = new Random();
		String rgb = Integer.toHexString(r.nextInt(256));
		rgb += Integer.toHexString(r.nextInt(256));
		rgb += Integer.toHexString(r.nextInt(256));
		return "#"+rgb;
	}
	
	public static int parseInt(HttpServletRequest request,
			String name) {
		return Integer.parseInt(request.getParameter(name));
	}
}
