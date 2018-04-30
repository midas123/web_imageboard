<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="madvirus.gallery.Theme" %>
<%@ page import="madvirus.gallery.ThemeManager" %>
<%@ page import="madvirus.gallery.ThemeManagerException" %>
<%@ page import="madvirus.CommentDataBean" %>
<%@ page import="madvirus.CommentDBBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>



<%
  String themeId = request.getParameter("id");

  ThemeManager manager = ThemeManager.getInstance();
  Theme theme = manager.select(Integer.parseInt(themeId));
	
  
  
  //댓글 페이징
  int pageSize=10;
  String cPageNum = request.getParameter("cpageNum");
  if(cPageNum == null)
	{
		cPageNum = "1";
	}
  int cCurrentPage = Integer.parseInt(cPageNum);
	
	int startRow = (cCurrentPage*10)-9;
	int endRow = cCurrentPage*pageSize;
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
  
 	try {
	  CommentDBBean cdb = CommentDBBean.getInstance();
	  ArrayList comments=cdb.getComments(theme.getId(),startRow, endRow);
		int count=cdb.getCommentCount(theme.getId());
 	
		
  
%>


<c:set var="theme" value="<%= theme %>" />
<c:if test="${empty theme }">
존재하지 않는 테마 이미지입니다.
</c:if>
<c:if test="${! empty theme }">
<table width="100%" border="1" cellpadding="1" cellspacing="0">
<tr>
  <td>제목</td>
  <td>${theme.title }></td>
</tr>
<tr>
  <td>작성자</td>
  <td>
  ${theme.name }
  <c:if test="${empty theme.email }">
  <a href="mailto:${theme.email }">[이메일]</a>
  </c:if>
  </td>
</tr>
<c:if test="${! empty theme.image }">
<tr>
  <td colspan="2" align="center">
    <a href="javascript:viewLarge('./image/${theme.image }')">
    <img src="./image/${theme.image }" width="500" border="0">
    <br>[크게보기]
    </a>
  </td>
</tr>
</c:if>
<tr>
  <td>내용</td>
  <td><pre>${theme.content }</pre></td>
</tr>
<tr>
  <td colspan="2">
  <a href="javascript:goReply()">[답변]</a>
  <a href="javascript:goModify()">[수정]</a>
  <a href="javascript:goDelete()">[삭제]</a>
  <a href="javascript:goList()">[목록]</a>
  </td>
</tr>
<%-- <form method=post action=contentPro.jsp name="comment" onsubmit="return writeSave()">
					<tr bgcolor=<%=value_c %> align=center>
						<td>코멘트 작성</td>
						<td colspan=2>
							<textarea name=commentt rows="6" cols="40"></textarea>
							<input type=hidden name=content_num value=<%=article.getNum() %>>
							<input type=hidden name=p_num value=<%=pageNum%>>
							<input type=hidden name=comment_num value=<%=count+1%>>
						</td>
						<td align=center>
							작성자<br>
							<input type=text name=commenter size=10><br>
							비밀번호<br>
							<input type=password name=passwd size=10><p>
							<input type=submit value=코멘트달기>
						</td>
					</tr>
					</form> --%>





</table>
</c:if>
<%
		}catch(Exception e){}
			%> 
<script language="JavaScript">
function goReply() {
	document.move.action = "writeForm.jsp";
	document.move.submit();
}
function goModify() {
	document.move.action = "updateForm.jsp";
	document.move.submit();
}
function goDelete() {
	document.move.action = "deleteForm.jsp";
	document.move.submit();
}
function goList() {
	document.move.action = "list.jsp";
	document.move.submit();
}
function viewLarge(imgUrl) {
	
}

function writeSave(){
	if(document.comment.commentt.value==""){
	  alert("작성자를 입력하십시요.");
	  document.comment.commentt.focus();
	  return false;
	}
}
</script>

<form name="move" method="post">
  <input type="hidden" name="id" value="${theme.id }">
  <input type="hidden" name="parentId" value="${theme.id }">
  <input type="hidden" name="groupId" value="${theme.groupId }">
  
  <input type="hidden" name="page" value="${param.page }">
  <c:forEach var="searchCond" items="${paramValues.search_cond }">
    <c:if test="${searchCond == 'title' }">
    <input type="hidden" name="search_cond" value="title">
    </c:if>
    <c:if test="${searchCond == 'name' }">
    <input type="hidden" name="search_cond" value="name">
    </c:if>
  </c:forEach>
  
  <c:if test="${! empty param.search_key }">
  <input type="hidden" name="search_key" value="${param.search_key }">
  </c:if>
</form>
<!-- 크게보기 스크립트는 직접찾아서 구현해주세요... -->