<%@page import="ch20.MUtil"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="ch20.BusanThemeBean" %>
<jsp:useBean id="mgr" class="ch20.BusanThemeMgr"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>부산테마여행</title>
<link rel="stylesheet" href="css/common.css">
</head>
<body>
    <div id="wrap">
        <!-- header -->
        <header id="header">
            <!-- nav -->
            <nav id="nav">
                <h3 class="logo">
                    <span>부산</span>
                </h3>
            </nav>
        </header>
        <!-- main -->
        <main class="common_wrap" id="theme_detail_page">
            <div id="container">
                <section class="common_box content_box">
                    <div class="common_title theme_title">
                        <h1>테마 여행 상세보기</h1>
                    </div>
                    <div class="theme_field">
                       <%
                       		int ucSeq = MUtil.parseInt(request, "ucSeq");
                       		BusanThemeBean bean = mgr.getBusanThemeDetail(ucSeq);
                       		if(bean != null){
                       %>
                        <div class="theme_detail_content">
                            <div class="theme_detail_img">
                                <img src="<%=bean.getMainImgNormal()%>" 
                                alt = "<%=bean.getMainTitle()%>">
                            </div>
                            <div class="theme_detail_info">
                                <h2 class="theme_detail_title"><%=bean.getMainTitle()%></h2>
                                <p class="theme_detail_subtitle"><%=bean.getSubtitle()!=null? bean.getSubtitle():""%></p>
                                <ul class="theme_detail_fields">
                                    <li><span class="theme_detail_label">지역:<%=bean.getGugunNm() %></span></li>
                                    <li><span class="theme_detail_label">카테고리:<%=bean.getCate2Nm() %></span></li>
                                    <li><span class="theme_detail_label">위치:<%=bean.getPlace() %></span> </li>
                                    <li><span class="theme_detail_label">주소:<%=bean.getAddr1() %></span> </li>
                                    <li><span class="theme_detail_label">홈페이지:</span> 
                                    <a href="<%=bean.getHomepageUrl().length()!=0? bean.getHomepageUrl():"#" %>" target="_blank">
                                    <%=bean.getHomepageUrl().length()!=0?bean.getHomepageUrl(): "홈페이지 없음" %></a></li>
                                    <li><span class="theme_detail_label">
                                    교통 정보:</span >
                                    <span class="theme_detail_textarea">
                                    <%=bean.getTrfcInfo().length()!=0?bean.getTrfcInfo(): "교통 정보 없음"%></span></li>
                                    <li><span class="theme_detail_label">상세 설명:</span> 
                                    <span class="theme_detail_textarea"><%=bean.getItemcntnts()%></span></li>
                                </ul>
                            </div>
                        </div>
                        <div class="action_btn">
                            <button onclick="window.history.back()">목록으로 돌아가기</button>
                        </div>
                        <% } else { %>
                        <p>해당 테마 여행 정보를 찾을 수 없습니다.</p>
                       <% } // -- if else %>
                    </div>
                </section>
            </div>
        </main>
    </div>
</body>
</html>