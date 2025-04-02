package jspproject;

import java.text.SimpleDateFormat;

public class NotifiMgr {
	private DBConnectionMgr pool;
	public static final String  SAVEFOLDER = "C:/Users/dita_810/git/2025_JspProject/myapp/src/main/webapp/jspproject/img";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 5*1024*1024;
	private final SimpleDateFormat SDF_DATE = new SimpleDateFormat("yyyy'년'  M'월' d'일' (E)");
	
	public NotifiMgr() {
	pool = DBConnectionMgr.getInstance();
	}
	
	//알림 리스트
	
	//
}
