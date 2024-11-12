<%@ page import="kr.co.sist.user.temp.OrderDAO" %>
<%@ page import="kr.co.sist.user.temp.OrderListVO" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.co.sist.user.payment.ShippingDAO" %>
<%@ page import="kr.co.sist.user.payment.ShippingVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         info=""
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/session_chk.jsp" %>
<%
  OrderDAO oDAO = OrderDAO.getInstance();

  ShippingDAO sDAO = new ShippingDAO();
  List<ShippingVO> shippingList = sDAO.selectAllShipping(sessionId);

  List<OrderListVO> orderList = oDAO.SelectOrderList(sessionId);

  pageContext.setAttribute("orderList", orderList);
  pageContext.setAttribute("shippingList", shippingList);

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <link rel="shotcut icon" href="http://192.168.10.218/jsp_prj/common/images/favicon.ico"/>
  <link rel="stylesheet" href="/user/css/main.css">
  <link rel="stylesheet" href="/user/css/order_list.css">
  <!-- jQuery CDN 시작 -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

  <style>

  </style>
  <script type="text/javascript">
      $(function () {

      });//ready
  </script>
</head>
<body>
<header>
  <jsp:include page="/common/header.jsp"/>
</header>
<c:choose>
  <c:when test="${empty orderList}">
    <div class="no-orders">
      주문정보가 없습니다.
    </div>
  </c:when>
  <c:otherwise>
    <c:forEach var="order" items="${orderList}">
      <c:forEach var="shipping" items="${shippingList}">
        <div class="order-container">
          <div class="order-info">
            <img src="images/${order.imgName}" alt="${order.productName}"/>
            <div class="product-name">
              <h2>${order.productName}</h2>
            </div>
          </div>

          <!-- 진행 상태 표시 -->
          <div class="progress-container">
            <div class="progress-bar">
              <div class="progress-steps">
                <!-- 진행 단계들 -->
                <div class="step ${shipping.status eq '배송준비' || shipping.status eq '배송중' || shipping.status eq '배송완료' ? 'active' : ''}">
                  <div class="circle"></div>
                  <span>배송 준비중</span>
                </div>

                <div class="step ${shipping.status eq '배송중' || shipping.status eq '배송완료' ? 'active' : ''}">
                  <div class="circle"></div>
                  <span>배송중</span>
                </div>

                <div class="step ${shipping.status eq '배송완료' ? 'active' : ''}">
                  <div class="circle"></div>
                  <span>배송 완료</span>
                </div>
              </div>
              <!-- 연결 라인 -->
              <div class="progress-line" data-status="${shipping.status}"></div>
            </div>
          </div>

          <div class="button-container">
            <button class="confirm-btn">구매 확정</button>
            <button class="cancel">취소 요청</button>
          </div>
        </div>
        <br>
      </c:forEach>
    </c:forEach>
  </c:otherwise>
</c:choose>

<!-- 리뷰 작성 모달 -->
<div id="reviewModal" class="modal">
  <div class="modal-content">
    <span class="close modal-close">&times;</span>
    <h3>주문 하신 상품이 마음에 드셨나요?</h3><br>
    <div>
      소중한 경험을 리뷰로 남겨주세요.<br>
      더 나은 서비스 제공과 다른 이용자들의 선택에 <br>
      큰 도움이 됩니다
    </div>
    <br>
    <div class="review-container">
      <button type="button" class="review"
              onclick="goToReviewPage()">리뷰 쓰러가기
      </button>
    </div>
  </div>
</div>

<!-- 취소 요청 모달 -->
<div id="cancelModal" class="modal">
  <div class="modal-content">
    <span class="close modal-close">&times;</span>

    <form id="cancelForm" action="cancel_process.jsp" method="post">
      <div class="order-info">
        <img src="images/" alt="" id="cancelModalImg"/>
        <div>
          <h2 class="product-name" id="cancelModalName"></h2>
        </div>
      </div>
      <div class="reason-label">
        <span>상세 이유 입력</span>
        <span id="cancelCharCount">0/100자</span>
      </div>

      <textarea id="cancelReason" name="cancelReason" placeholder="취소 이유를 입력해주세요."
                oninput="updateCharCount('cancelReason', 'cancelCharCount')"></textarea>

      <input type="hidden" id="cancelProductName" name="productName">
      <input type="hidden" id="cancelImgName" name="imgName">
      <input type="hidden" id="cancelOrderId" name="orderId">
      <button type="button" class="submit-btn" onclick="submitCancelRequest()">확인</button>
      <button type="button" class="cancel-btn" onclick="closeModal('cancelModal')">닫기</button>
    </form>
  </div>
</div>

<script>
    $(function () {
        // 구매확정 버튼 클릭 이벤트
        $(document).on('click', '.confirm-btn', function (e) {
            e.preventDefault();
            if (confirm('구매를 확정하시겠습니까?')) {
                $(this).closest('form').submit();
            }//end if
        });

        // 모달 닫기 버튼 클릭 이벤트
        $(document).on('click', '.modal-close', function () {
            $(this).closest('.modal').hide();
        });
    });

    let selectedProductName = '';
    let selectedImgName = '';

    function showReviewModal(productName, imgName) {
        selectedProductName = productName;
        selectedImgName = imgName;
        $("#reviewModal").show();
    }

    function showCancelModal(productName, imgName, orderId) {
        document.getElementById('cancelModalImg').src = 'images/' + imgName;
        document.getElementById('cancelModalImg').alt = productName;
        document.getElementById('cancelModalName').textContent = productName;

        document.getElementById('cancelProductName').value = productName;
        document.getElementById('cancelImgName').value = imgName;
        document.getElementById('cancelOrderId').value = orderId;

        $("#cancelModal").show();
    }

    function showExchangeModal() {
        $("#exchangeModal").show();
    }

    function closeModal(modalId) {
        // 모달 창 닫기
        document.getElementById(modalId).style.display = 'none';

        // 모달 닫을 때 입력 필드 초기화
        if (modalId === 'cancelModal') {
            document.getElementById('cancelReason').value = '';
            document.getElementById('cancelCharCount').textContent = '0/100자';
        }
    }

    function updateCharCount(textareaId, countId) {
        const textarea = document.getElementById(textareaId);
        const charCount = document.getElementById(countId);
        const length = textarea.value.length;
        charCount.textContent = length + '/100자';
    }

    function submitCancelRequest() {
        const reason = $('#cancelReason').val();

        if (!reason) {
            alert('취소 사유를 입력해주세요.');
            return;
        }//end if

        if (reason.length < 10) {
            alert('취소 사유를 10자 이상 입력해주세요.');
            return;
        }//end if

        if (confirm('정말 취소 요청하시겠습니까?')) {
            document.getElementById('cancelForm').submit();
        }//end if
    }

    function goToReviewPage() {
        $.ajax({
            type: "POST",
            url: "set_review_session.jsp",
            data: {
                productName: selectedProductName,
                imgName: selectedImgName
            },
            error: function (xhr) {
                alert(xhr.status);
            },
            success: function () {
                setTimeout(function () {
                    window.location.href = "review_write.jsp";
                    $("#reviewModal").hide();
                }, 100);
            }
        });
    }

    // 페이지 로드 시 세션 체크하여 모달 표시
    $(window).on('load', function () {
        <% if(session.getAttribute("showReviewModal") != null && session.getAttribute("showReviewModal").equals("true")) { %>
        // 세션에 저장된 상품 정보 가져오기
        selectedProductName = "${reviewProductName}";
        selectedImgName = "${reviewImgName}";
        $("#reviewModal").show();

        <%
        session.removeAttribute("showReviewModal");
        session.removeAttribute("reviewProductName");
        session.removeAttribute("reviewImgName");
        %>
        <% } %>
    });
</script>
</body>
</html>