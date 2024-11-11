<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="kr.co.sist.user.payment.*" %>
<%@ page import="kr.co.sist.user.product.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--로그인세션 필요--%>
<%
  // URL 파라미터 받기
  String productId = request.getParameter("productId");
  String color = request.getParameter("color");
  String size = request.getParameter("size");

  // 상품 정보 조회
  UserProductDAO productDAO = new UserProductDAO();
  ProductVO product = productDAO.selectByProductId(Integer.parseInt(productId));

  // 임시 userId 설정 (실제로는 로그인 세션에서 가져와야 함)
  String userId = "user1"; // 테스트용 임시 userId

  // 배송 정보 조회 (에러 처리 추가)
  ShippingVO defaultShipping = null;
  try {
    ShippingDAO shippingDAO = new ShippingDAO();
    defaultShipping = shippingDAO.selectDefaultShipping(userId);
  } catch (Exception e) {
    System.out.println("배송 정보 조회 실패: " + e.getMessage());
    defaultShipping = new ShippingVO();
    defaultShipping.setRecipient("");
    defaultShipping.setPhone("");
    defaultShipping.setAddress("");
    defaultShipping.setAddress2("");
  }

  // 사용자 캐시 정보 조회 (에러 처리 추가)
  int userCash = 0;
  try {
    UserCashDAO cashDAO = new UserCashDAO();
    userCash = cashDAO.selectUserCash(userId);
  } catch (Exception e) {
    System.out.println("캐시 정보 조회 실패: " + e.getMessage());
  }

  // VO 객체 생성 및 데이터 설정
  PaymentVO paymentVO = new PaymentVO();
  paymentVO.setAmount(product.getPrice());
  paymentVO.setMethod("네이버페이");
  paymentVO.setPaymentDate(new Date(System.currentTimeMillis()));

  // request에 데이터 설정
  request.setAttribute("product", product);
  request.setAttribute("payment", paymentVO);
  request.setAttribute("shipping", defaultShipping);
  request.setAttribute("userCash", userCash);

  // 배송지 목록 조회를 위한 DAO 생성 및 데이터 조회
  ShippingDAO shippingDAO = new ShippingDAO();
  List<ShippingVO> shippingList = shippingDAO.selectAllShipping(userId);

  // request에 배송지 목록 추가
  request.setAttribute("shippingList", shippingList);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>주문/결제</title>
  <link rel="stylesheet" href="../../user/css/payment.css">
    <link rel="stylesheet" href="../../user/css/modal.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
      // 주소 검색 함수
      function findAddr() {
          new daum.Postcode({
              oncomplete: function (data) {
                  var addr = '';
                  if (data.userSelectedType === 'R') {
                      addr = data.roadAddress;
                  } else {
                      addr = data.jibunAddress;
                  }
                  document.getElementById("address").value = addr;
                  document.getElementById("address2").focus();
              }
          }).open();
      }
  </script>
  <style></style>

</head>
<body>
<header>
  <h1>주문/결제</h1>
</header>

<div class="container">
  <div class="main-content">
    <!-- 배송지 정보 섹션 -->
    <section class="delivery-info">
      <div class="info-row">
        <h2 class="section-title">배송지</h2>
        <button class="change-btn hover-effect" onclick="toggleModal('address-modal')">변경</button>
      </div>
      <c:choose>
        <c:when test="${not empty shipping.address}">
          <div class="info-row">
            <span class="name">수령인 : ${shipping.recipient}</span>
          </div>
          <div class="info-row">
            <span class="phone">전화번호 : ${shipping.phone}</span>
          </div>
          <div class="info-row">
            <span class="address">배송 주소 : ${shipping.address}</span>&nbsp;
            <span class="address2">${shipping.address2}</span>
          </div>
        </c:when>
        <c:otherwise>
          <p class="no-address">등록된 배송지가 없습니다.</p>
        </c:otherwise>
      </c:choose>

      <div class="delivery-memo">
        <select id="delivery-request" onchange="toggleInputField()">
          <option value="">배송 요청사항 선택</option>
          <option value="door">문 앞에 놓아주세요</option>
          <option value="security">경비실에 맡겨주세요</option>
          <option value="call">배송 전 연락주세요</option>
          <option value="custom">직접 입력</option>
        </select>
        <input type="text" id="custom-memo" placeholder="배송 요청사항을 입력해주세요" style="display:none;">
      </div>
    </section>

    <!-- 주문 상품 정보 -->
    <section class="order-summary">
      <h2>주문상품</h2>
      <div class="product">
        <img src="${product.mainImg}" alt="${product.name}">
        <div class="product-info">
          <h3>${product.name}</h3>
          <div class="price">
                        <span class="current-price">
                            <fmt:formatNumber value="${product.price}" type="number"/>원
                        </span>
          </div>
          <span class="discount-label">옵션: ${param.color} / ${param.size}</span>
        </div>
      </div>
      <div class="order-total">
        <span>총 상품금액</span>
        <span><fmt:formatNumber value="${product.price}" type="number"/>원</span>
      </div>
    </section>

    <!-- 결제 수단 섹션 수정 -->
    <section class="payment-method">
      <h2>결제수단</h2>
      <div class="user-cash">
        <span>보유 네이버페이 포인트</span>
        <span class="user-cash-amount"><fmt:formatNumber value="${userCash}" type="number"/>원</span>
        <button
            onclick="location.href='charge_cash.jsp?productId=${product.productId}&color=${param.color}&size=${param.size}'"
            class="charge-button">충전하기
        </button>
      </div>
      <div class="payment-option">
        <label class="use-cash-label">
          <input type="checkbox" id="use-cash" onchange="toggleCashUse(${userCash}, ${product.price})">
          네이버페이 사용
        </label>
        <div class="cash-use-amount" style="display: none;">
          <span>사용 금액:</span>
          <span class="cash-amount">0원</span>
        </div>
      </div>
      <div class="payment-amount">
        <span>결제금액</span>
        <span class="total-amount"><fmt:formatNumber value="${product.price}" type="number"/>원</span>
      </div>
    </section>

    <section class="privacy-agreement">
      <p>개인정보 제3자 제공 동의
        <a href="#" onclick="toggleModal('privacy-modal')">자세히 보기</a>
      </p>
    </section>
  </div>

  <!-- 결제 금액 요약 -->
  <div class="payment-summary">
    <h2>결제상세</h2>
    <div class="payment-row">
      <span>총 상품금액</span>
      <span><fmt:formatNumber value="${product.price}" type="number"/>원</span>
    </div>
    <div class="payment-row">
      <span>배송비</span>
      <span>무료</span>
    </div>
    <div class="payment-total">
      <span>총 결제금액</span>
      <span><fmt:formatNumber value="${product.price}" type="number"/>원</span>
    </div>
    <button class="pay-button" onclick="processPayment()">
      <fmt:formatNumber value="${product.price}" type="number"/>원 결제하기
    </button>
  </div>
</div>

<!-- 배송지 모달 부분 -->
<div id="address-modal" class="modal">
  <div class="modal-content">
    <div class="address-container">
      <h1>배송지 목록</h1>
      <button class="new-address-btn" onclick="toggleModal('new-address-modal')">+ 배송지 신규입력</button>
      <ul class="address-list">
        <c:choose>
          <c:when test="${not empty shippingList}">
            <c:forEach var="addr" items="${shippingList}">
              <li class="address-item" data-id="${addr.shippingId}">
                <div class="name">${addr.recipient}</div>
                <div class="phone">${addr.phone}</div>
                <div class="address">${addr.address}</div>
                <div class="address2">${addr.address2}</div>
                <div class="actions">
                  <button class="select-btn" onclick="selectAddress(${addr.shippingId})">선택</button>
                  <button class="edit-btn" onclick="editAddress(${addr.shippingId})">수정</button>
                  <button class="delete-btn" onclick="deleteAddress(${addr.shippingId})">삭제</button>
                </div>
              </li>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <li class="no-address-item">
              등록된 배송지가 없습니다.
            </li>
          </c:otherwise>
        </c:choose>
      </ul>
      <button class="close-btn" onclick="toggleModal('address-modal')">&times;</button>
    </div>
  </div>
</div>

<!-- 새 배송지 입력 모달 -->
<div id="new-address-modal" class="modal">
  <div class="modal-content">
    <h2>새 배송지 입력</h2>
    <form id="new-address-form" novalidate>
      <div class="input-group">
        <label for="recipient">받는 사람*</label>
        <input type="text" id="recipient" name="recipient" required>
      </div>
      <div class="input-group">
        <label for="phone">연락처*</label>
        <input type="tel" id="phone" name="phone" required
               pattern="[0-9]{3}-[0-9]{3,4}-[0-9]{4}"
               placeholder="010-0000-0000">
      </div>
      <div class="input-group">
        <label for="address">주소*</label>
        <input type="text" id="address" name="address" readonly required>
        <input type="text" id="address2" name="address2" required>
        <button type="button" class="address-search-btn" onclick="findAddr()">주소 찾기</button>
      </div>
      <div class="input-group">
        <label class="checkbox-label">
          <input type="checkbox" name="isDefault" id="isDefault">
          기본 배송지로 설정
        </label>
      </div>
      <div class="button-group">
        <button type="submit" class="submit-btn">저장</button>
        <button type="button" class="cancel-btn" onclick="toggleModal('new-address-modal')">취소</button>
      </div>
    </form>
    <button class="close-btn" onclick="toggleModal('new-address-modal')">&times;</button>
  </div>
</div>

<!-- 개인정보 제공 동의 모달 -->
<div id="privacy-modal" class="modal">
  <div class="modal-content">
    <h2>개인정보 제3자 제공 동의</h2>
    <div class="privacy-content">
      <!-- 개인정보 제공 동의 내용 -->
    </div>
    <button class="close-btn" onclick="toggleModal('privacy-modal')">&times;</button>
  </div>
</div>
<script>
    // 캐시 사용 토글 함수
    function toggleCashUse(userCash, totalPrice) {
        const useCash = $('#use-cash').is(':checked');
        const cashUseAmount = $('.cash-use-amount');
        const totalAmountElement = $('.total-amount');
        const cashAmountElement = $('.cash-amount');

        if (useCash) {
            // 사용 가능한 캐시 계산
            const availableCash = Math.min(userCash, totalPrice);
            // 남은 결제 금액 계산
            const remainingPrice = totalPrice - availableCash;

            // 금액 표시 업데이트
            cashAmountElement.text(new Intl.NumberFormat('ko-KR').format(availableCash) + '원');
            totalAmountElement.text(new Intl.NumberFormat('ko-KR').format(remainingPrice) + '원');

            // 사용 금액 표시 영역 보이기
            cashUseAmount.show();
        } else {
            // 원래 가격으로 복원
            totalAmountElement.text(new Intl.NumberFormat('ko-KR').format(totalPrice) + '원');
            cashAmountElement.text('0원');

            // 사용 금액 표시 영역 숨기기
            cashUseAmount.hide();
        }
    }

    // 배송지 선택
    function selectAddress(shippingId) {
        $.ajax({
            url: 'get_shipping_info.jsp',
            type: 'GET',
            data: {shippingId: shippingId},
            dataType: 'json',
            success: function (data) {
                if (data.success) {
                    // 메인 화면의 배송지 정보 업데이트
                    $('.delivery-info .info-row .name').text(data.recipient);
                    $('.delivery-info .info-row .phone').text(data.phone);
                    $('.delivery-info .info-row .address').text(data.address);
                    $('.delivery-info .info-row .address2').text(data.address2);

                    // 모달 닫기
                    toggleModal('address-modal');
                } else {
                    alert(data.message || '배송지 정보를 불러오는데 실패했습니다.');
                }
            },
            error: function () {
                alert('배송지 정보를 불러오는데 실패했습니다.');
            }
        });
    }

    // 모달 제어를 위한 함수들
    function toggleModal(modalId) {
        const modal = document.getElementById(modalId);
        if (modal) {
            if (modal.style.display === 'block') {
                modal.style.display = 'none';
            } else {
                // 모든 모달 닫기
                const modals = document.getElementsByClassName('modal');
                for (let i = 0; i < modals.length; i++) {
                    modals[i].style.display = 'none';
                }
                // 선택된 모달만 열기
                modal.style.display = 'block';
            }
        }
    }

    // 배송메모 입력필드 토글
    function toggleInputField() {
        const select = document.getElementById('delivery-request');
        const customInput = document.getElementById('custom-memo');
        if (select && customInput) {
            customInput.style.display = select.value === 'custom' ? 'block' : 'none';
            if (select.value === 'custom') {
                customInput.focus();
            }
        }
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function (event) {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = 'none';
        }
    };

    // DOM 로드 완료 후 초기화
    document.addEventListener('DOMContentLoaded', function () {
        // 모달 닫기 버튼에 이벤트 리스너 추가
        const closeButtons = document.getElementsByClassName('close-btn');
        for (let i = 0; i < closeButtons.length; i++) {
            closeButtons[i].addEventListener('click', function () {
                const modal = this.closest('.modal');
                if (modal) {
                    modal.style.display = 'none';
                }
            });
        }

        // ESC 키로 모달 닫기
        document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
                const modals = document.getElementsByClassName('modal');
                for (let i = 0; i < modals.length; i++) {
                    modals[i].style.display = 'none';
                }
            }
        });
    });

    // jQuery를 사용하는 부분은 $(document).ready() 내부로 이동
    $(document).ready(function () {
        // 새 배송지 폼 제출 처리
        $('#new-address-form').on('submit', function (e) {
            e.preventDefault();

            // 수정 모드인지 확인
            const shippingId = $(this).data('shippingId');
            const isEdit = !!shippingId;

            // 폼 데이터 수집
            const formData = {
                recipient: $('#recipient').val(),
                phone: $('#phone').val(),
                address: $('#address').val(),
                address2: $('#address2').val()
            };

            // 수정 모드일 경우 shippingId 추가
            if (isEdit) {
                formData.shippingId = shippingId;
            }

            // 유효성 검사
            if (!formData.recipient) {
                alert('받는 사람을 입력해주세요.');
                $('#recipient').focus();
                return;
            }
            if (!formData.phone) {
                alert('연락처를 입력해주세요.');
                $('#phone').focus();
                return;
            }
            if (!formData.address) {
                alert('주소를 입력해주세요.');
                $('#address').focus();
                return;
            }
            if (!formData.address2) {
                alert('상세주소를 입력해주세요.');
                $('#address2').focus();
                return;
            }

            $.ajax({
                url: isEdit ? 'update_address.jsp' : 'add_address.jsp',
                type: 'POST',
                data: formData,
                success: function (response) {
                    if (response.success) {
                        alert(isEdit ? '배송지가 수정되었습니다.' : '배송지가 추가되었습니다.');
                        location.reload();
                    } else {
                        alert(response.message || '처리 중 오류가 발생했습니다.');
                    }
                },
                error: function () {
                    alert('처리 중 오류가 발생했습니다.');
                }
            });
        });
    });

    // 배송지 수정
    function editAddress(shippingId) {
        $.ajax({
            url: 'get_shipping_info.jsp',
            type: 'GET',
            data: {shippingId: shippingId},
            dataType: 'json',
            success: function (data) {
                if (data.success) {
                    $('#recipient').val(data.recipient);
                    $('#phone').val(data.phone);
                    $('#address').val(data.address);
                    $('#address2').val(data.address2);

                    // 폼에 배송지 ID 저장
                    $('#new-address-form').data('shippingId', shippingId);

                    toggleModal('new-address-modal');
                } else {
                    alert(data.message || '배송지 정보를 불러오는데 실패했습니다.');
                }
            },
            error: function () {
                alert('배송지 정보를 불러오는데 실패했습니다.');
            }
        });
    }

    // 배송지 삭제
    function deleteAddress(shippingId) {
        if (confirm('이 배송지를 삭제하시겠습니까?')) {
            $.ajax({
                url: 'delete_address.jsp',
                type: 'POST',
                data: {shippingId: shippingId},
                dataType: 'json',
                success: function (response) {
                    if (response.success) {
                        alert('배송지가 삭제되었습니다.');
                        location.reload(); // 페이지 새로고침
                    } else {
                        alert(response.message || '배송지 삭제에 실패했습니다.');
                    }
                },
                error: function () {
                    alert('배송지 삭제 중 오류가 발생했습니다.');
                }
            });
        }
    }

    // 결제 처리 함수 수정
    function processPayment() {
        // 배송지 체크
        if (!${not empty shipping.address}) {
            alert('배송지를 선택해주세요.');
            return;
        }

        // 배송 메모 가져오기
        const deliveryMemo = $('#custom-memo').is(':visible')
            ? $('#custom-memo').val()
            : $('#delivery-request').val();

        const useCash = $('#use-cash').is(':checked');
        const totalPrice = ${product.price};
        const userCash = ${userCash};
        let cashAmount = 0;

        if (useCash) {
            cashAmount = Math.min(userCash, totalPrice);
        }

        const paymentData = {
            productId: '${product.productId}',
            color: '${param.color}',
            size: '${param.size}',
            amount: totalPrice,
            useCash: cashAmount,
            paymentMethod: 'naverpay',
            deliveryMemo: deliveryMemo,
            shippingId: '${shipping.shippingId}'
        };

        $.ajax({
            url: 'payment_process.jsp',
            type: 'POST',
            data: paymentData,
            success: function (response) {
                if (response.success) {
                    alert('결제가 완료되었습니다.');
                    location.href = 'payment_complete_modal.jsp?orderId=' + response.orderId;
                } else {
                    alert(response.message || '결제 처리 중 오류가 발생했습니다.');
                }
            },
            error: function () {
                alert('결제 처리 중 오류가 발생했습니다.');
            }
        });
    }
</script>
</body>
</html>