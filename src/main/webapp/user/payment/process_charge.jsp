<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%@ page import="kr.co.sist.user.payment.*" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ include file="/common/session_chk.jsp" %>

<%
    JSONObject jsonResponse = new JSONObject();

    try {
//        String userId = request.getParameter("userId");
        String userId = "user1";
        int amount = Integer.parseInt(request.getParameter("amount"));

        UserCashDAO cashDAO = new UserCashDAO();

        // 현재 캐시 조회
        int currentCash = cashDAO.selectUserCash(userId);

        // 새로운 캐시 금액
        int newCash = currentCash + amount;

        // 캐시 업데이트 또는 insert
        int result = cashDAO.updateCash(userId, newCash);

        if(result > 0) {
            jsonResponse.put("success", true);
            jsonResponse.put("message", "충전이 완료되었습니다.");
            jsonResponse.put("newBalance", newCash);
        } else {
            // 사용자 캐시 정보가 없는 경우 새로 입력
            result = cashDAO.insertCash(userId, amount);
            if(result > 0) {
                jsonResponse.put("success", true);
                jsonResponse.put("message", "충전이 완료되었습니다.");
                jsonResponse.put("newBalance", amount);
            } else {
                throw new Exception("충전 처리에 실패했습니다.");
            }
        }

    } catch(Exception e) {
        e.printStackTrace();
        jsonResponse.put("success", false);
        jsonResponse.put("message", "충전 중 오류가 발생했습니다: " + e.getMessage());
    }

    response.setContentType("application/json");
    out.print(jsonResponse.toJSONString());
%>