<%@page import="org.json.simple.JSONObject"%>
<%@ page import="kr.co.sist.user.temp.UserInquiryDAO" %>
<%@ page import="kr.co.sist.user.temp.InquiryVO" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/session_chk.jsp" %>
<%
// 응답 타입을 여기서 설정
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

request.setCharacterEncoding("UTF-8");

String userId = sessionId;
int inquiryId = Integer.parseInt(request.getParameter("inquiryId"));

// 디버깅용 출력
System.out.println("userId: " + userId);
System.out.println("inquiryId: " + inquiryId);

UserInquiryDAO uiDAO = UserInquiryDAO.getInstance();
InquiryVO iVO = uiDAO.selectUserOneInquiry(userId, inquiryId);

// 디버깅용 출력
System.out.println("iVO is null? " + (iVO == null));
if(iVO != null) {
    System.out.println("Content: " + iVO.getContent());
}

JSONObject jsonObj = new JSONObject();

if(iVO != null && iVO.getContent() != null) {
    String content = iVO.getContent();
    // CLOB과 줄바꿈 문자 제거, 앞뒤 공백 제거
    content = content.replace("CLOB", "").replace("\n", "").trim();
    System.out.println("Processed content: " + content); // 디버깅용
    
    jsonObj.put("content", content);
    jsonObj.put("answer", iVO.getAnswer() != null ? iVO.getAnswer() : "답변이 없습니다.");
} else {
    jsonObj.put("content", "내용을 찾을 수 없습니다.");
    jsonObj.put("answer", "답변이 없습니다.");
}

System.out.println("Final JSON: " + jsonObj.toJSONString()); // 디버깅용

out.clear();
out.print(jsonObj.toJSONString());
out.flush();
%>