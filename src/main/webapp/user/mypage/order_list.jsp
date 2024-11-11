<%@ page contentType="text/html;charset=UTF-8" language="java" info="" %>
<%--로그인세션필요--%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 목록 조회</title>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            text-align: center;
        }
        .order-container {
            border: 1px solid #ccc;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            display: inline-block;
        }
        .order-info {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .order-info img {
            width: 60px; /* 이미지 크기 조정 */
            margin-right: 15px;
        }

        /* Progress bar setup */
        .progress-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
            padding: 0 10px;
            position: relative;
            height: 40px;
        }

        /* Line for progress bar */
        .progress-bar::before {
            content: '';
            position: absolute;
            top: 50%; /* 선을 점의 중앙에 위치 */
            transform: translateY(-50%);
            left: 17%;
            right: 17%;
            height: 4px;
            background-color: lightgray;
            z-index: -1;
        }

        /* Individual progress points */
        .progress-bar div {
            position: relative;
            flex: 1;
            text-align: center;
        }

        /* Circles */
        .circle {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background-color: lightgray;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        /* Active (completed) circles */
        .active .circle {
            background-color: green;
        }

        /* Status text (placed below the progress bar) */
        .status {
            margin-top: 10px;
            font-size: 14px;
            font-weight: bold;
        }

        /* Text below circles */
        .progress-text {
            display: flex;
            justify-content: space-between;
            padding: 0 10%;
            margin-top: 10px;
        }

        .progress-text p {
            flex: 1;
            text-align: center;
            font-size: 14px;
            font-weight: bold;
        }

        /* Connect active circles with a green line */
        .progress-bar div.active + div::before {
            content: '';
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            left: -50%;
            width: 100%;
            height: 4px;
            background-color: green;
            z-index: -1;
        }

        /* Button styles */
        .button-container {
            margin-top: 10px;
        }
        button {
            padding: 8px 12px;
            font-size: 12px;
            color: #333;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            margin-right: 5px;
        }
        .confirm, .cancel, .exchange {
            background-color: #f0f0f0;
        }
        .confirm:hover, .cancel:hover, .exchange:hover {
            background-color: #ddd;
        }

        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 20% auto;
            padding: 15px;
            border: 1px solid #888;
            width: 80%;
            max-width: 300px;
            text-align: center;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 20px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        textarea {
            width: 100%;
            height: 60px;
            margin-top: 10px;
        }
        .logo img {
            width: 120px;
        }

        /* Additional styles */
        .review {
            background-color: #87CEEB; /* 하늘색 */
            color: white; /* 흰색 글씨 */
            border: none; /* 테두리 제거 */
            transition: background-color 0.3s; /* 호버 효과 부드럽게 */
        }
        .review:hover {
            background-color: #2196F3; /* 호버 색상 */
        }
        .submit-btn {
            background-color: #4CAF50; /* 초록색 */
            color: white; /* 흰색 글씨 */
            padding: 8px 12px; /* 패딩 추가 */
            border: none; /* 테두리 제거 */
            border-radius: 3px; /* 모서리 둥글게 */
            cursor: pointer; /* 포인터 커서 */
            width: 100%;
        }
        .submit-btn:hover {
            background-color: #45a049; /* 호버 색상 */
            width: 100%;
        }
        .cancel-btn {
            background-color: white; /* 흰색 배경 */
            color: black; /* 검정 글씨 */
            border: 1px solid #ccc; /* 회색 테두리 */
            border-radius: 3px; /* 모서리 둥글게 */
            width: 100%;
        }

        /* New styles for reason input */
        .reason-label {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
            font-weight: bold;
            font-size: 14px;
        }

        /* Styles for product name in modals */
        .product-name {
            font-size: 14px; /* 글자 크기를 줄였습니다. */
        }
    </style>
    
</head>
<body>
    <div class="order-container">
        <div class="logo">
            <img src="http://localhost:8080/test/dg/%EC%83%81%ED%91%9C.png" alt="Ego Emporium">
        </div>
        <div class="order-info">
            <img src="http://localhost:8080/test/dg/20241010_235120.png" alt="Nike V2K" />
            <div>
                <h2>나이키 V2K 런 블랙 앤트러사이트 FD0736-001</h2>
            </div>
        </div>

        <!-- Progress bar -->
        <div class="progress-bar">
            <div class="active">
                <div class="circle"></div>
            </div>
            <div class="active">
                <div class="circle"></div>
            </div>
            <div>
                <div class="circle"></div>
            </div>
        </div>

        <!-- Text below progress circles -->
        <div class="progress-text">
            <p>배송 준비중</p>
            <p>배송중</p>
            <p>배송 완료</p>
        </div>

        <div class="button-container">
            <button class="confirm" onclick="showReviewModal()">구매 확정</button>
            <button class="cancel" onclick="showCancelModal()">취소 요청</button>
            <button class="exchange" onclick="showExchangeModal()">교환 요청</button>
        </div>
    </div>

    <!-- 리뷰 작성 모달 -->
    <div id="reviewModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('reviewModal')">&times;</span>
            <h3>주문 하신 상품이 마음에 드셨나요?</h3><br>
            <div>
                소중한 경험을 리뷰로 남겨주세요.<br>
                더 나은 서비스 제공과 다른 이용자들의 선택에 <br>
                큰 도움이 됩니다
            </div><br>
            <div class="review-container">
                <button class="review" onclick="goToReviewPage()">리뷰 쓰러가기</button>
            </div>
        </div>
    </div>

    <!-- 취소 요청 모달 -->
    <div id="cancelModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('cancelModal')">&times;</span>
            <div class="order-info">
                <img src="http://localhost:8080/test/dg/20241010_235120.png" alt="Nike V2K" />
                <div>
                    <h2 class="product-name">나이키 V2K 런 블랙 앤트러사이트 FD0736-001</h2>
                </div>
            </div>
            <div class="reason-label">
                <span>상세 이유 입력</span>
                <span id="cancelCharCount">0/100자</span>
            </div>
            <textarea id="cancelReason" placeholder="취소 이유를 입력해주세요." oninput="updateCharCount('cancelReason', 'cancelCharCount')"></textarea>
            <button class="submit-btn" onclick="submitCancelRequest()">확인</button>
            <button class="cancel-btn" onclick="closeModal('cancelModal')">닫기</button>
        </div>
    </div>

    <!-- 교환 요청 모달 -->
    <div id="exchangeModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal('exchangeModal')">&times;</span>
            <div class="order-info">
                <img src="http://localhost:8080/test/dg/20241010_235120.png" alt="Nike V2K" />
                <div>
                    <h2 class="product-name">나이키 V2K 런 블랙 앤트러사이트 FD0736-001</h2>
                </div>
            </div>
            <div class="reason-label">
                <span>상세 이유 입력</span>
                <span id="exchangeCharCount">0/100자</span>
            </div>
            <textarea id="exchangeReason" placeholder="교환 이유를 입력해주세요." oninput="updateCharCount('exchangeReason', 'exchangeCharCount')"></textarea>
            <button class="submit-btn" onclick="submitExchangeRequest()">확인</button>
            <button class="cancel-btn" onclick="closeModal('exchangeModal')">닫기</button>
        </div>
    </div>

    <script>
        function showReviewModal() {
            document.getElementById("reviewModal").style.display = "block";
        }
        function showCancelModal() {
            document.getElementById("cancelModal").style.display = "block";
        }
        function showExchangeModal() {
            document.getElementById("exchangeModal").style.display = "block";
        }
        function closeModal(modalId) {
            document.getElementById(modalId).style.display = "none";
        }
        function updateCharCount(textareaId, countId) {
            const textarea = document.getElementById(textareaId);
            const charCount = document.getElementById(countId);
            charCount.innerText = `${textarea.value.length}/100자`;
        }
        function submitCancelRequest() {
            const reason = document.getElementById('cancelReason').value;
            alert(`취소 요청이 완료되었습니다. 이유: ${reason}`);
            closeModal('cancelModal');
        }
        function submitExchangeRequest() {
            const reason = document.getElementById('exchangeReason').value;
            alert(`교환 요청이 완료되었습니다. 이유: ${reason}`);
            closeModal('exchangeModal');
        }
        function goToReviewPage() {
            window.location.href = "review_write.jsp"; // 리뷰 작성 페이지로 이동
            closeModal('reviewModal');
        }
    </script>
</body>
</html>
