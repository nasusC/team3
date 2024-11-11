<%@ page contentType="text/html;charset=UTF-8" language="java" info="" %>
<%--로그인세션필요--%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성</title>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            text-align: center; /* 전체 중앙 정렬 */
        }
        h2 {
            margin-bottom: 20px;
        }
        .review-container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .product-info {
            display: flex;
            align-items: center; /* 이미지와 텍스트 수평 정렬 */
            margin-bottom: 20px;
        }
        .product-info img {
            width: 100px; /* 이미지 크기 조정 */
            margin-right: 15px; /* 이미지와 이름 사이 간격 */
        }
        .star-rating {
            display: flex;
            justify-content: center;
            margin-bottom: 10px;
        }
        .star {
            font-size: 40px; /* 별 크기 증가 */
            color: lightgray;
            cursor: pointer;
        }
        .star.selected {
            color: gold;
        }
        .prompt {
            text-align: center; /* 중앙 정렬 */
            margin: 10px 0; /* 여백 추가 */
            font-weight: bold; /* 진하게 */
            font-size: 18px; /* 글자 크기 증가 */
        }
        .review-textarea {
            width: 100%; /* 전체 너비 사용 */
            height: 100px;
            margin-top: 10px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            resize: none;
            background-color: white; /* 흰색 배경 */
            box-sizing: border-box; /* 패딩 및 테두리 포함 */
        }
        .upload-btn {
            margin-top: 10px;
            width: 95%; /* 전체 너비 사용 */
            border: 2px dashed #ccc; /* 점선 테두리 */
            background-color: #fff; /* 흰색 배경 */
            padding: 10px;
            border-radius: 5px;
            text-align: center; /* 중앙 정렬 */
        }
        .upload-btn label {
            color: #333; /* 진한 검정색 글씨 */
            cursor: pointer; /* 손가락 커서 */
            display: block; /* 블록으로 변경하여 전체 너비 사용 */
        }
        .button-container {
            display: flex;
            justify-content: center; /* 중앙 정렬 */
            margin-top: 20px;
        }
        button {
            padding: 10px 0; /* 수직 패딩 */
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: calc(50% - 10px); /* 반반 크기 조정 */
            margin: 0 5px; /* 버튼 간격 */
        }
        .submit {
            background-color: #808080; /* 회색 */
            color: white; /* 흰색 글씨 */
        }
        .cancel {
            background-color: white; /* 흰색 */
            color: black; /* 검정색 글씨 */
            border: 1px solid #ccc; /* 회색 테두리 */
        }
        .submit:hover {
            background-color: #696969; /* 어두운 회색 */
        }
        .cancel:hover {
            background-color: #f0f0f0; /* 밝은 회색 */
        }
        .small-text {
            font-size: 12px; /* 작은 글씨 크기 */
            color: #666; /* 회색 */
            margin-top: -5px; /* 약간 위로 위치 조정 */
        }
    </style>
</head>
<body>
    <div class="review-container">
        <h2>리뷰 작성</h2>
        <div class="product-info">
            <img src="http://localhost:8080/test/dg/20241010_235120.png" alt="상품 이미지" /> <!-- 상품 이미지 -->
            <div>나이키 V2K 런 블랙 앤트러사이트 FD0736-001</div> <!-- 상품 이름 -->
        </div>
        <div class="prompt">상품은 만족하셨나요?</div>
        <div class="star-rating">
            <span class="star" data-value="1">★</span>
            <span class="star" data-value="2">★</span>
            <span class="star" data-value="3">★</span>
            <span class="star" data-value="4">★</span>
            <span class="star" data-value="5">★</span>
        </div>
        <div class="small-text">선택하세요</div> <!-- 작은 글씨 추가 -->
        <div class="prompt">어떤 점이 좋았나요?</div>
        <textarea class="review-textarea" id="reviewText" placeholder="리뷰 내용을 10자 이상 입력하세요..."></textarea>
        <div class="upload-btn">
            <label for="imageUpload">사진 첨부하기</label>
            <input type="file" id="imageUpload" accept="image/*" style="display:none;"> <!-- 숨김 -->
        </div>
        <div class="button-container">
            <button class="cancel" onclick="window.close()">취소</button>
            <button class="submit" onclick="submitReview()">확인</button>
        </div>
    </div>

    <script>
        // 별점 선택 기능
        const stars = document.querySelectorAll('.star');
        let selectedRating = 0;

        stars.forEach(star => {
            star.addEventListener('click', () => {
                selectedRating = star.getAttribute('data-value');
                updateStarRating();
            });
        });

        function updateStarRating() {
            stars.forEach(star => {
                star.classList.remove('selected');
                if (star.getAttribute('data-value') <= selectedRating) {
                    star.classList.add('selected');
                }
            });
        }

        function submitReview() {
            const reviewText = document.getElementById('reviewText').value;
            if (reviewText.length < 10) {
                alert('리뷰는 최소 10자 이상 입력해야 합니다.');
                return;
            }

            const rating = selectedRating ? selectedRating : 0;
            alert(`리뷰 제출 완료!\n별점: ${rating}\n리뷰: ${reviewText}`);
            // 여기에 리뷰를 서버로 전송하는 코드 추가
            window.close(); // 창 닫기
        }
    </script>
</body>
</html>
