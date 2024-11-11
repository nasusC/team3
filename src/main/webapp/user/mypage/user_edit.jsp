<%@ page contentType="text/html;charset=UTF-8" language="java" info="" %>
<%--로그인세션필요--%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 변경</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* 전체 화면 높이 */
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4; /* 배경색 */
        }

        #passwordChangeForm {
            background-color: white; /* 폼 배경색 */
            padding: 40px; /* 더 많은 패딩 */
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
            width: 400px; /* 폼 너비 */
        }

        .form-group {
            margin-bottom: 20px; /* 더 많은 여백 */
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-size: 16px; /* 레이블 크기 */
        }

        input[type="password"] {
            width: 100%; /* 입력 필드 너비 */
            padding: 12px; /* 패딩 증가 */
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px; /* 입력 필드 글씨 크기 */
        }

        input[type="button"] {
            width: 100%; /* 버튼 너비 */
            padding: 12px; /* 패딩 증가 */
            border: none;
            border-radius: 4px;
            background-color: #4CAF50; /* 기본 버튼 색상 */
            color: white;
            cursor: pointer;
            font-size: 16px; /* 버튼 글씨 크기 */
            margin-top: 10px; /* 버튼 위 여백 */
        }

        input[type="button"]:hover {
            background-color: #45a049; /* 기본 버튼 호버 색상 */
        }

        /* 취소 버튼 스타일 추가 */
        .cancel-button {
            background-color: #FFFFFF; /* 흰색 배경 */
            color: black; /* 검정 글씨 */
            border: 1px solid #ccc; /* 테두리 추가 */
        }

        .cancel-button:hover {
            background-color: #f0f0f0; /* 호버 시 배경색 변경 */
        }

        .warning-text {
            color: red; /* 경고 텍스트 색상 */
            margin-bottom: 10px; /* 여백 추가 */
        }

        .current-password-spacing {
            margin-bottom: 30px; /* 현재 비밀번호와의 간격 */
        }
    </style>
    
    <script type="text/javascript">
        function success() {
            alert("비밀번호 변경 성공!!");
        }
    </script>
</head>
<body>
    <form id="passwordChangeForm">
        <h2>비밀번호 변경</h2>
        <div>안전한 비밀번호로 내 정보를 보호하세요</div>
        <div>*<span class="warning-text"> 다른 아이디/사이트에서 사용한적 없는 비밀번호</span></div>
        <div>*<span class="warning-text">이전에 사용한적 없는 비밀번호</span>가 안전합니다</div>
        
        <div class="form-group current-password-spacing">
            <label for="currentPassword">현재 비밀번호</label>
            <input type="password" id="currentPassword" name="currentPassword" required>
        </div>
        <div class="form-group">
            <label for="newPassword">새 비밀번호</label>
            <input type="password" id="newPassword" name="newPassword" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword">새 비밀번호 확인</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
        </div>
        <input type="button" value="확인" onclick="success()"><br>
        <input type="button" value="취소" class="cancel-button"> <!-- 클래스 추가 -->
    </form>
</body>
</html>
