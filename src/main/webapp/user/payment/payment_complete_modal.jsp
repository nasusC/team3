<%@ page contentType="text/html;charset=UTF-8" language="java" info="" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 처리 모달</title>
    <style>
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
        }
        .modal {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            width: 90%;
            max-width: 400px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .modal-header {
            padding: 15px 20px;
            font-size: 18px;
            font-weight: bold;
            text-align: center;
            color: white;
        }
        .modal-header.success {
            background-color: #4CAF50;
        }
        .modal-header.error {
            background-color: #f44336;
        }
        .modal-body {
            padding: 20px;
            text-align: center;
        }
        .modal-body p {
            margin-bottom: 20px;
            color: #333;
        }
        .btn {
            display: block;
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        .btn-error {
            background-color: #f44336;
            color: white;
        }
        .btn-secondary {
            background-color: white;
            color: #333;
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>
<button onclick="showSuccessModal()">성공 모달 테스트</button>
<button onclick="showErrorModal()">실패 모달 테스트</button>

<!-- 성공 모달 -->
<div id="successModal" class="modal-overlay">
    <div class="modal">
        <div class="modal-header success">
            주문 완료
        </div>
        <div class="modal-body">
            <p>주문이 정상적으로 완료되었습니다</p>
            <button onclick="goToPurchaseHistory()" class="btn btn-primary">구매내역 보기</button>
            <button onclick="closeModal('successModal')" class="btn btn-secondary">완료</button>
        </div>
    </div>
</div>

<!-- 실패 모달 -->
<div id="errorModal" class="modal-overlay">
    <div class="modal">
        <div class="modal-header error">
            결제 오류
        </div>
        <div class="modal-body">
            <p>결제 처리 중 오류가 발생했습니다</p>
            <p style="font-size: 14px; color: #666;">잠시 후 다시 시도해주세요</p>
            <button onclick="retryPayment()" class="btn btn-error">다시 시도</button>
            <button onclick="closeModal('errorModal')" class="btn btn-secondary">닫기</button>
        </div>
    </div>
</div>

<script>
    function showSuccessModal() {
        document.getElementById('successModal').style.display = 'flex';
    }

    function showErrorModal() {
        document.getElementById('errorModal').style.display = 'flex';
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }

    function goToPurchaseHistory() {
        // 구매내역 페이지로 이동
        location.href = '/user/mypage/purchase_history.jsp';
    }

    function retryPayment() {
        closeModal('errorModal');
        // 결제 프로세스 재시작
        processPayment();
    }

    function processPayment() {
        // 결제 처리 로직
        try {
            // 결제 처리 코드...

            // 성공 시
            showSuccessModal();
        } catch (error) {
            // 실패 시
            showErrorModal();
        }
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
        if (event.target.classList.contains('modal-overlay')) {
            event.target.style.display = 'none';
        }
    }
</script>
</body>
</html>