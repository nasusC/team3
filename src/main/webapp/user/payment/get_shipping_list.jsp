<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%@ page import="kr.co.sist.user.payment.*" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="java.util.List" %>

<%
    JSONObject jsonResponse = new JSONObject();

    try {
        String userId = request.getParameter("userId");

        ShippingDAO dao = new ShippingDAO();
        List<ShippingVO> shippingList = dao.selectAllShipping(userId);

        JSONArray jsonArray = new JSONArray();
        for(ShippingVO sVO : shippingList) {
            JSONObject shipping = new JSONObject();
            shipping.put("shippingId", sVO.getShippingId());
            shipping.put("recipient", sVO.getRecipient());
            shipping.put("phone", sVO.getPhone());
            shipping.put("address", sVO.getAddress());
            shipping.put("address2", sVO.getAddress2());
            jsonArray.add(shipping);
        }

        jsonResponse.put("success", true);
        jsonResponse.put("shippingList", jsonArray);

    } catch(Exception e) {
        jsonResponse.put("success", false);
        jsonResponse.put("message", "배송지 목록 조회 중 오류가 발생했습니다: " + e.getMessage());
    }

    response.setContentType("application/json");
    out.print(jsonResponse.toJSONString());
%>