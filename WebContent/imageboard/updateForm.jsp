<%@ page contentType="text/html; charset=EUC-KR" %>
<%
  request.setCharacterEncoding("euc-kr");
%>
<jsp:forward page="../template/template.jsp">
  <jsp:param name="CONTENTPAGE" value="./updateForm_view.jsp" />
</jsp:forward>