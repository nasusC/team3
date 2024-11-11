<%@ page import="kr.co.sist.user.product.UserProductDAO" %>
<%@ page import="kr.co.sist.user.product.ProductVO" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.co.sist.user.review.ReviewVO" %>
<%@ page import="kr.co.sist.user.product.SizeVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
  // 상품 ID 파라미터 받기
  String productId = request.getParameter("id");

  // DAO 인스턴스 생성
  UserProductDAO dao = new UserProductDAO();

  // 상품 상세 정보 조회
  ProductVO product = dao.selectByProductId(Integer.parseInt(productId));

  // 리뷰 목록 조회 - 수정된 부분
  List<ReviewVO> reviewList = dao.selectAllProductReview(Integer.parseInt(productId));
  // 상품 사이즈 목록 조회 추가
  List<SizeVO> sizeList = dao.selectProductSizes(Integer.parseInt(productId));

  // request에 데이터 설정
  request.setAttribute("product", product);
  request.setAttribute("sizeList", sizeList);
  request.setAttribute("reviewList", reviewList);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${product.name} - 에고엠포리움</title>

  <!-- CSS 파일 -->
  <link rel="stylesheet" href="../../user/css/main.css">
  <link rel="stylesheet" href="../../user/css/product_details.css">
  <link rel="stylesheet" href="../../user/css/review.css">


  <!-- jQuery -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

  <!-- FontAwesome CDN 추가 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

  <style>
      /* 상품 상세 테이블 스타일 */
      table {
          width: 55%;
          margin: 0 auto;
          border-collapse: collapse;
          margin-bottom: 10px;
      }

      th, td {
          padding: 8px;
          text-align: left;
          border-top: 1px solid #e0e0e0;
          border-bottom: 1px solid #e0e0e0;
      }

      th {
          width: 25%;
          background-color: #f5f5f5;
          font-weight: normal;
      }

      .highlight {
          background-color: #f5f5f5;
      }
  </style>
  <style>

  </style>
</head>
<body>
<!-- 헤더 include -->
<jsp:include page="../../common/header.jsp"/>

<div class="product-container">
  <!-- 상품 이미지 -->
  <div class="product-image">
    <img src="${product.mainImg}" alt="${product.name}">
  </div>

  <!-- 상품 상세 정보 -->
  <div class="product-details">
    <h1>${product.name}</h1>

    <div class="price-container">
      <span class="price">
        <fmt:formatNumber value="${product.price}" type="number"/>원
      </span>
    </div>

    <div class="free-exchange">무료배송</div>

    <!-- 옵션 선택 -->
    <select id="color" name="color" onchange="updatePrice()">
      <option value="">컬러</option>
      <option value="black">블랙</option>
      <!-- 추가 컬러 옵션 -->
    </select>

    <!-- 사이즈 선택 부분 수정 -->
    <select id="size" name="size" onchange="updatePrice()">
      <option value="">사이즈</option>
      <c:forEach var="size" items="${sizeList}">
        <option value="${size.chooseSizeId}">${size.chooseSizeId}</option>
      </c:forEach>
    </select>

    <!-- 총 금액 -->
    <div class="totals">
      <div class="total-amount">총 상품 금액</div>
      <div>
        <span class="total-quantity" id="total-quantity">총 수량 0개</span>
        <span class="total-price" id="total-price">0원</span>
      </div>
    </div>

    <!-- 구매 버튼 -->
    <button class="buy-button" onclick="handleBuyClick()">구매하기</button>
  </div>
</div>

<!-- 탭 메뉴 -->
<div class="tabs">
  <div class="tab active" data-tab="details">상세정보</div>
  <div class="tab" data-tab="reviews">리뷰</div>
</div>

<!-- 상품 상세 정보 -->
<div id="details" class="tab-content active">
  <table>
    <tr>
      <th>상품번호</th>
      <td>${product.productId}</td>
      <th class="highlight">상품상태</th>
      <td>신상품</td>
    </tr>
    <tr>
      <th>제조사</th>
      <td>${product.brand}</td>
      <th class="highlight">브랜드</th>
      <td>${product.brand}</td>
    </tr>
    <tr>
      <th>원산지</th>
      <td colspan="3">대한민국</td>
    </tr>
    <tr>
      <th>A/S 안내</th>
      <td colspan="3">상세페이지 참조</td>
    </tr>
  </table>

  <!-- 상세 이미지 -->
  <div class="expanded-content">
    <img src="" alt="상세 정보">
  </div>

  <div class="parent-container">
    <button class="expand-button">상세정보 펼쳐보기</button>
  </div>
</div>

<!-- 리뷰 섹션 -->
<div id="reviews" class="tab-content">
  <div class="review-container">
    <h1>상품 리뷰</h1>
    <div class="filter-container">
    </div>

    <c:choose>
      <c:when test="${not empty reviewList}">
        <c:forEach var="review" items="${reviewList}">
          <div class="review">
            <div class="review-header">
              <span class="stars" data-rating="${review.rating}">
                <!-- 별점 표시 수정 -->
                <c:choose>
                  <c:when test="${review.rating eq 1}">★☆☆☆☆</c:when>
                  <c:when test="${review.rating eq 2}">★★☆☆☆</c:when>
                  <c:when test="${review.rating eq 3}">★★★☆☆</c:when>
                  <c:when test="${review.rating eq 4}">★★★★☆</c:when>
                  <c:when test="${review.rating eq 5}">★★★★★</c:when>
                </c:choose>
              </span>
              <div class="user-info">
                <span class="user">${review.userId}</span>
                <span class="separator">|</span>
                <span class="date"><fmt:formatDate value="${review.createdAt}" pattern="yyyy.MM.dd"/></span>
              </div>
              <div class="product-info">
                <span>색상: 블랙</span>
                <span>사이즈: 260</span>
              </div>
            </div>
            <div class="review-body">
              <div class="review-content">
                <p>${review.content}</p>
              </div>
              <div class="review-image">
                <img src="/images/default-review.jpg" alt="리뷰 이미지">
              </div>
            </div>
          </div>
        </c:forEach>
      </c:when>
      <c:otherwise>
        <div style="text-align: center; padding: 50px 0;">
          <p>등록된 리뷰가 없습니다.</p>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>


<!-- JavaScript -->
<script>
    // 가격 업데이트
    function updatePrice() {
        const color = document.getElementById("color").value;
        const size = document.getElementById("size").value;
        const totalPrice = document.getElementById("total-price");
        const totalQuantity = document.getElementById("total-quantity");

        if (color !== "" && size !== "") {
            totalPrice.textContent = '<fmt:formatNumber value="${product.price}" type="number"/>원';
            totalQuantity.textContent = "총 수량 1개";
        } else {
            totalPrice.textContent = "0원";
            totalQuantity.textContent = "총 수량 0개";
        }
    }

    // 구매 버튼 클릭
    function handleBuyClick() {
        const color = document.getElementById("color").value;
        const size = document.getElementById("size").value;

        if (color === "" || size === "") {
            alert("옵션을 선택해주세요.");
            return;
        }

        location.href = '../payment/payment.jsp?productId=${product.productId}&color=' + color + '&size=' + size;
    }

    // 탭 전환
    document.querySelectorAll('.tab').forEach(tab => {
        tab.addEventListener('click', () => {
            const tabId = tab.getAttribute('data-tab');

            // 탭 활성화 상태 변경
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(content => content.classList.remove('active'));

            tab.classList.add('active');
            document.getElementById(tabId).classList.add('active');
        });
    });

    // 상세정보 펼치기/접기
    const expandButton = document.querySelector('.expand-button');
    const expandedContent = document.querySelector('.expanded-content');

    expandButton.addEventListener('click', () => {
        expandedContent.classList.toggle('active');
        expandButton.textContent = expandedContent.classList.contains('active')
            ? '상세정보 접기'
            : '상세정보 펼쳐보기';

        // 스크롤 이동
        const scrollTarget = expandedContent.classList.contains('active')
            ? expandButton
            : expandedContent;
        scrollTarget.scrollIntoView({behavior: 'smooth'});
    });
</script>

<!-- 푸터 include -->
<jsp:include page="../../common/footer.jsp"/>
</body>
</html>