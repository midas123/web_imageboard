<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="madvirus.CommentDBBean" %>
<%@ page import="java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("euc-kr");
%>    
<jsp:useBean id="cmt" scope="page" class="madvirus.CommentDataBean">
<jsp:setProperty name="cmt" property="*"/>
</jsp:useBean>

<%
	CommentDBBean comt = CommentDBBean.getInstance();
	cmt.setReg_date(new Timestamp(System.currentTimeMillis()));
	cmt.setIp(request.getRemoteAddr());
	comt.insertComment(cmt);
	
	String content_num = request.getParameter("content_num");
	String p_num = request.getParameter("page");
	String url="read_view.jsp?id="+content_num+"&page="+p_num;
	response.sendRedirect(url);
%>
    
