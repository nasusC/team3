<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%@ page import="kr.co.sist.user.payment.*" %>
<%@ page import="org.json.simple.JSONObject" %>

<%
    JSONObject jsonResponse = new JSONObject();

    try {
        request.setCharacterEncoding("UTF-8");

        // 파라미터 받기
        String recipient = request.getParameter("recipient");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String address2 = request.getParameter("address2");

        // 임시 ORDER_ID 설정 (실제로는 주문 처리 시 생성된 ORDER_ID를 사용해야 함)
        int orderId = 1; // 또는 실제 주문 ID

        // ShippingVO 객체 생성 및 데이터 설정
        ShippingVO sVO = new ShippingVO();
        sVO.setOrderId(orderId); // ORDER_ID 설정
        sVO.setRecipient(recipient);
        sVO.setPhone(phone);
        sVO.setAddress(address);
        sVO.setAddress2(address2);

        // 배송지 정보 저장
        ShippingDAO dao = new ShippingDAO();
        int result = dao.insertNewShipping(sVO);

        if(result > 0) {
            jsonResponse.put("success", true);
            jsonResponse.put("message", "배송지가 추가되었습니다.");
            jsonResponse.put("shippingId", sVO.getShippingId());
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "배송지 추가에 실패했습니다.");
        }

    } catch(Exception e) {
        e.printStackTrace();
        jsonResponse.put("success", false);
        jsonResponse.put("message", "배송지 추가 중 오류가 발생했습니다: " + e.getMessage());
    }

    response.setContentType("application/json");
    out.print(jsonResponse.toJSONString());
%>