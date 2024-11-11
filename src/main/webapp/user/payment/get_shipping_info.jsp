<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%@ page import="kr.co.sist.user.payment.*" %>
<%@ page import="org.json.simple.JSONObject" %>

<%
    JSONObject jsonResponse = new JSONObject();

    try {
        // 파라미터 받기
        int shippingId = Integer.parseInt(request.getParameter("shippingId"));

        // 배송지 정보 조회
        ShippingDAO dao = new ShippingDAO();
        ShippingVO sVO = dao.selectOneShipping(shippingId);

        if(sVO != null) {
            jsonResponse.put("success", true);
            jsonResponse.put("shippingId", sVO.getShippingId());
            jsonResponse.put("recipient", sVO.getRecipient());
            jsonResponse.put("phone", sVO.getPhone());
            jsonResponse.put("address", sVO.getAddress());
            jsonResponse.put("address2", sVO.getAddress2());
            jsonResponse.put("memo", sVO.getMemo());
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "배송지 정보를 찾을 수 없습니다.");
        }

    } catch(Exception e) {
        jsonResponse.put("success", false);
        jsonResponse.put("message", "배송지 정보 조회 중 오류가 발생했습니다: " + e.getMessage());
    }

    response.setContentType("application/json");
    out.print(jsonResponse.toJSONString());
%>