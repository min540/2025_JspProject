package ch19;

import java.io.File;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

public class MUtil {
	
	public static void delete(String s) {
		File file = new File(s);
		if (file.isFile()) {
			file.delete();
		}
	}
	
	public static int parseInt(HttpServletRequest request, 
			String name) {
		return Integer.parseInt(request.getParameter(name));
	}
}