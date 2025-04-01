<%@page import="ch20.MUtil"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Vector" %>
<%@ page import="ch20.BusanThemeMgr" %>
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
    <!-- wrap -->
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
        <main class="common_wrap" id="theme_list_page">
            <div id="container">
                <section class="common_box content_box">
                    <div class="common_title theme_title">
                        <h1>테마 여행</h1>
                    </div>
                    <!-- 테마 여행 목록 -->
                    <div class="theme_list_area">
                    <%	
                    		int perPage= 6;
                    		int currentPage = 1;
                    		if(request.getParameter("page")!=null){
                    			currentPage = MUtil.parseInt(request, "page");
                    		}
                    		Vector<BusanThemeBean> vlist = mgr.listBusanTheme(currentPage, perPage);
                    		for(int i = 0; i < vlist.size(); i++){
                    			BusanThemeBean bean = vlist.get(i);
                    %>
                     <ul class="theme_item">
                            <ul class="theme_num">
                                <li><%=bean.getCate2Nm() %></li>
                                <li><%=bean.getGugunNm() %></li>
                            </ul>
                            <div class="theme_img">
                            	<a1 href="detail.jsp?ucSeq=<%=bean.getUcSeq()%>">
                                	<img src="<%=bean.getMainImgThumb() %>" alt="<%=bean.getMainTitle()%>">
                               	</a>
                            </div>
                            <div class="theme_article">
                                <div>
                                    <%=bean.getMainTitle()%>(<%=bean.getPlace()%>)
                                </div>
                            </div>
                       </ul>
                    <% } // --for %>
                    </div>
                    <!-- 동적 페이징 처리 시작 -->
                    <ul class="theme_pagination">
                       <%
                        int pageBlock = 5;
						int totalRecord = mgr.getTotalCount();
                        int totalPage = (int)Math.ceil((double)totalRecord / perPage);
                        int nowBlock = (int)Math.ceil((double)currentPage / pageBlock);
                        int pageStart = (nowBlock - 1) * pageBlock + 1;
                        int pageEnd = pageStart + pageBlock - 1;
                        if(pageEnd > totalPage) {
                            pageEnd = totalPage;
                        }
                    %>
                    <ul class="theme_pagination">
                        <% if(currentPage > 1) { %>
                        <li class="prev">
                            <a href="list.jsp?page=<%= currentPage - 1 %>"><</a>
                        </li>
                        <% } else { %>
                        <li class="prev"><</li>
                        <% } %>
                        <% for(int j = pageStart; j <= pageEnd; j++) {
                               if(j == currentPage) { %>
                        <li class="page_num active">
                            <span><%= j %></span>
                        </li>
                        <% } else { %>
                        <li class="page_num">
                            <a href="list.jsp?page=<%= j %>"><%= j %></a>
                        </li>
                        <%     }
                           } %>
                        <% if(currentPage < totalPage) { %>
                        <li class="next">
                            <a href="list.jsp?page=<%= currentPage + 1 %>">></a>
                        </li>
                        <% } else { %>
                        <li class="next">></li>
                        <% } %>
                    </ul>
                    </ul>
                    <!-- 동적 페이징 처리 끝 -->
                </section>
            </div>
        </main>
    </div>
</body>
</html>