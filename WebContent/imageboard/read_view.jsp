<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="madvirus.gallery.Theme" %>
<%@ page import="madvirus.gallery.ThemeManager" %>
<%@ page import="madvirus.gallery.ThemeManagerException" %>
<%
  String themeId = request.getParameter("id");

  ThemeManager manager = ThemeManager.getInstance();
  Theme theme = manager.select(Integer.parseInt(themeId));
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
    <a href="javascript:viewLarge('./image/${theme.image }')" >
    <img src="./image/${theme.image }" width="150" border="0" onclick="doImgPop('./image/${theme.image }')" >
    <br>[크게보기]
    </a>
  </td>
</tr>
</c:if>
<script language="JavaScript" type="text/javascript">
function doImgPop(img){ 
	 img1= new Image(); 
	 img1.src=(img); 
	 imgControll(img); 
	} 
	  
	function imgControll(img){ 
	 if((img1.width!=0)&&(img1.height!=0)){ 
	    viewImage(img); 
	  } 
	  else{ 
	     controller="imgControll('"+img+"')"; 
	     intervalID=setTimeout(controller,20); 
	  } 
	}

	function viewImage(img){ 
	 W=img1.width; 
	 H=img1.height; 
	 O="width="+W+",height="+H+",scrollbars=yes"; 
	 imgWin=window.open("","",O); 
	 imgWin.document.write("<html><head><title>:*:*:*: 이미지상세보기 :*:*:*:*:*:*:</title></head>");
	 imgWin.document.write("<body topmargin=0 leftmargin=0>");
	 imgWin.document.write("<img src="+img+" onclick='self.close()' style='cursor:pointer;' title ='클릭하시면 창이 닫힙니다.'>");
	 imgWin.document.close();
	}
</script>
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
</table>
</c:if>

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