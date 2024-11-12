<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%@ page import="kr.co.sist.user.payment.*" %>
<%@ page import="kr.co.sist.user.order.*" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.sql.Date" %>
<%@ include file="/common/session_chk.jsp" %>

<%
   JSONObject jsonResponse = new JSONObject();

   try {
       // 1. 파라미터 로깅
       System.out.println("Received parameters:");
       System.out.println("productId: " + request.getParameter("productId"));
       System.out.println("amount: " + request.getParameter("amount"));
       System.out.println("shippingId: " + request.getParameter("shippingId"));
       System.out.println("paymentMethod: " + request.getParameter("paymentMethod"));

       // 2. 파라미터 유효성 검사
       String productIdStr = request.getParameter("productId");
       String amountStr = request.getParameter("amount");
       String shippingIdStr = request.getParameter("shippingId");
       String paymentMethod = request.getParameter("paymentMethod");

       if(productIdStr == null || amountStr == null || shippingIdStr == null || paymentMethod == null) {
           throw new Exception("필수 파라미터가 누락되었습니다.");
       }

       // 3. 파라미터 변환
       int productId = 0;
       int amount = 0;
       int shippingId = 0;

       try {
           productId = Integer.parseInt(productIdStr);
           amount = Integer.parseInt(amountStr);
           shippingId = Integer.parseInt(shippingIdStr);
       } catch(NumberFormatException e) {
           throw new Exception("잘못된 파라미터 형식입니다: " + e.getMessage());
       }

       String userId = sessionId;

       // 4. 배송지 정보 조회
       ShippingDAO shippingDAO = new ShippingDAO();
       ShippingVO shippingVO = shippingDAO.selectOneShipping(shippingId);

       // 5. 주문 정보 생성
       OrderVO orderVO = new OrderVO();
       orderVO.setUserId(userId);
       orderVO.setOrderName("상품 주문");
       orderVO.setOrderDate(new Date(System.currentTimeMillis()));
       orderVO.setOrderStatus("결제완료");
       orderVO.setTotalAmount(amount);
       orderVO.setOrderFlag("배송준비");

       // 6. 주문 상품 정보 생성
       OrderProductVO orderProductVO = new OrderProductVO();
       orderProductVO.setProductId(productId);
       orderProductVO.setQuantity(1);
       orderProductVO.setPrice(amount);

       // 7. 주문 정보 DB 처리 (배송지 정보도 함께 처리)
       OrderDAO orderDAO = new OrderDAO();
       System.out.println("Attempting to insert order...");

       int orderResult = orderDAO.insertOrder(orderVO, orderProductVO, shippingId);
       System.out.println("Order insert result: " + orderResult);

       if(orderResult > 0) {
           // 8. 결제 정보 저장
           PaymentVO paymentVO = new PaymentVO();
           paymentVO.setOrderId(orderResult);
           paymentVO.setAmount(amount);
           paymentVO.setMethod(paymentMethod);
           paymentVO.setPaymentDate(new Date(System.currentTimeMillis()));
           paymentVO.setUserCash(0);

           PaymentDAO paymentDAO = new PaymentDAO();
           System.out.println("Attempting to insert payment...");

           int paymentResult = paymentDAO.insertPayment(paymentVO);
           System.out.println("Payment insert result: " + paymentResult);

           if(paymentResult > 0) {
               jsonResponse.put("success", true);
               jsonResponse.put("orderId", orderResult);
           } else {
               throw new Exception("결제 정보 저장 실패");
           }
       } else {
           throw new Exception("주문 정보 저장 실패");
       }

   } catch(Exception e) {
       System.out.println("Error occurred: " + e.getMessage());
       e.printStackTrace();
       jsonResponse.put("success", false);
       jsonResponse.put("message", "결제 처리 중 오류가 발생했습니다: " + e.getMessage());
   }

   response.setContentType("application/json");
   response.setCharacterEncoding("UTF-8");
   out.print(jsonResponse.toJSONString());
   out.flush();
%>