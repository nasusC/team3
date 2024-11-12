<%@ page import="kr.co.sist.user.temp.UserVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${ empty userData }">
<c:redirect url="/user/login/login_page_o.jsp"/>
</c:if>
<%
String sessionId=
((UserVO)session.getAttribute("userData")).getUserId();
//로그인 한 계정의 id
%>