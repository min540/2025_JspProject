<%@ page contentType="application/json; charset=UTF-8" %>
<%@ page import="jspproject.ObjMgr, jspproject.ObjBean" %>
<%@ page import="jspproject.JourMgr, jspproject.JourBean" %>
<%@ page import="java.util.*, java.text.*" %>

<%
    request.setCharacterEncoding("UTF-8");
    String user_id = (String) session.getAttribute("user_id");

    // 세션 없을 때 처리
    if (user_id == null) {
        out.print("{\"error\":\"로그인이 필요합니다.\"}");
        return;
    }

    int[] weeklyComplete = new int[7];
    int[] weeklyJournalCount = new int[7];
    int[] monthlyComplete = new int[6];
    int[] monthlyJournalCount = new int[6];
    String[] monthLabels = new String[6];

    int totalWeeklyComplete = 0;
    int totalWeeklyJournal = 0;
    int totalMonthlyComplete = 0;
    int totalMonthlyJournal = 0;
    int thisMonthComplete = monthlyComplete[5]; // 이번 달
    int thisMonthJournal = monthlyJournalCount[5];

    Calendar today = Calendar.getInstance();
    int currentWeek = today.get(Calendar.WEEK_OF_YEAR);
    int currentYear = today.get(Calendar.YEAR);
    int currentMonth = today.get(Calendar.MONTH) + 1;

    // 최근 6개월 라벨 생성
    for (int i = 5; i >= 0; i--) {
        Calendar temp = (Calendar) today.clone();
        temp.add(Calendar.MONTH, -i);
        int month = temp.get(Calendar.MONTH) + 1;
        monthLabels[5 - i] = "\"" + month + "월\"";
    }

    ObjMgr objMgr = new ObjMgr();
    JourMgr jourMgr = new JourMgr();

    Vector<ObjBean> objList = objMgr.getTotalObjList(user_id);
    Vector<JourBean> jourList = jourMgr.listJour(user_id);

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    for (ObjBean bean : objList) {
        try {
            String original = bean.getObj_regdate().trim(); // 괄호 제거 필요 없음
            Date regDate = sdf.parse(original);
            Calendar cal = Calendar.getInstance();
            cal.setTime(regDate);

            int beanWeek = cal.get(Calendar.WEEK_OF_YEAR);
            int beanYear = cal.get(Calendar.YEAR);
            int beanMonth = cal.get(Calendar.MONTH) + 1;

            if (beanWeek == currentWeek && beanYear == currentYear) {
                int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK) - 1;
                weeklyComplete[dayOfWeek]++;
            }

            int monthDiff = (currentYear - beanYear) * 12 + (currentMonth - beanMonth);
            if (monthDiff >= 0 && monthDiff < 6) {
                monthlyComplete[5 - monthDiff]++;
            }

            if (beanMonth == currentMonth && beanYear == currentYear) {
                thisMonthComplete++;
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    // 총 주간 완료 수 계산
    for (int count : weeklyComplete) {
        totalWeeklyComplete += count;
    }

    // 일지 분석
	for (JourBean bean : jourList) {
	    try {
	    	SimpleDateFormat korFormat = new SimpleDateFormat("yyyy년 M월 d일", Locale.KOREAN);
	    	
	    	String original = bean.getJour_regdate().split("\\(")[0].trim();
	    	Date regDate = korFormat.parse(original);
	        Calendar cal = Calendar.getInstance();
	        cal.setTime(regDate);
	
	        int beanWeek = cal.get(Calendar.WEEK_OF_YEAR);
	        int beanYear = cal.get(Calendar.YEAR);
	        int beanMonth = cal.get(Calendar.MONTH) + 1;
	
	        if (beanWeek == currentWeek && beanYear == currentYear) {
	            int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK) - 1;
	            weeklyJournalCount[dayOfWeek]++;
	        }
	
	        int monthDiff = (currentYear - beanYear) * 12 + (currentMonth - beanMonth);
	        if (monthDiff >= 0 && monthDiff < 6) {
	            monthlyJournalCount[5 - monthDiff]++;
	        }
	
	        // ✅ 이번 달이면 카운트
	        if (beanMonth == currentMonth && beanYear == currentYear) {
	            thisMonthJournal++;
	        }
	
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	}

	 // 총 주간 일지 수 계산
	 for (int count : weeklyJournalCount) {
		 totalWeeklyJournal += count;
	}
	 
	 for (int count : monthlyComplete) {
		 totalMonthlyComplete += count;
	}
	 
	 for (int count : monthlyJournalCount) {
		 totalMonthlyJournal += count;
	}

    // JSON 응답 생성
    StringBuilder json = new StringBuilder("{");
    json.append("\"weeklyComplete\":").append(Arrays.toString(weeklyComplete)).append(",");
    json.append("\"weeklyJournalCount\":").append(Arrays.toString(weeklyJournalCount)).append(",");
    json.append("\"monthlyComplete\":").append(Arrays.toString(monthlyComplete)).append(",");
    json.append("\"monthlyJournalCount\":").append(Arrays.toString(monthlyJournalCount)).append(",");
    json.append("\"monthLabels\":[").append(String.join(",", monthLabels)).append("],");
    json.append("\"totalWeeklyComplete\":").append(totalWeeklyComplete);
    json.append(",\"totalWeeklyJournal\":").append(totalWeeklyJournal);
    json.append(",\"totalMonthlyComplete\":").append(totalMonthlyComplete);
    json.append(",\"totalMonthlyJournal\":").append(totalMonthlyJournal);
    json.append(",\"thisMonthComplete\":").append(thisMonthComplete);
    json.append(",\"thisMonthJournal\":").append(thisMonthJournal);
    json.append("}");

    out.print(json.toString());
%>
