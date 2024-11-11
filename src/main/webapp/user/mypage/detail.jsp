<%@ page contentType="text/html;charset=UTF-8" language="java" info="" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상세 주소 입력</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            width: 380px; 
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 18px;
        }
        .address-container {
            display: none; 
            margin-bottom: 10px;
        }
        .input-container {
            width: 100%;
            position: relative; 
            margin-bottom: 15px; 
        }
        label {
            display: block; 
            margin-bottom: 5px; 
            font-size: 14px; 
        }
        input {
            width: 100%;
            padding: 15px; 
            border: none;
            outline: none; 
            text-align: left; 
            transition: border-bottom 0.3s;
            padding-right: 5px; 
            font-size: 16px; 
        }
        .underline {
            position: absolute;
            bottom: 10px; 
            left: 0;
            right: 0; 
            height: 1px; 
            background-color: #ccc; 
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50; 
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 10px;
        }
        button:hover {
            background-color: #45a049; 
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>상세 주소 입력</h1>
        <div id="selected-address" class="address-container"></div> <!-- 주소 선택 시 보이게 설정 -->
        
        <div class="input-container">
            <label for="recipient">받는 이</label>
            <input type="text" id="recipient" placeholder="" />
            <div class="underline"></div>
        </div>

        <div class="input-container">
            <label for="contact">연락처</label>
            <input type="text" id="contact" placeholder="" />
            <div class="underline"></div>
        </div>

        <div class="input-container">
            <label for="detailed-address">주소</label>
            <input type="text" id="detailed-address" placeholder="" />
            <div class="underline"></div>
        </div>
        
        <button id="save-button">저장</button>
    </div>

    <script>
        function getQueryParam(param) {
            const urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(param);
        }

        // 쿼리 매개변수에서 주소 가져오기
        const address = getQueryParam('address');
        const selectedAddressDiv = document.getElementById('selected-address');
        
        // 주소가 null이 아닐 때만 선택한 주소를 보여줌
        if (address) {
            selectedAddressDiv.textContent = `선택한 주소: ${address}`;
            selectedAddressDiv.style.display = 'block'; // 주소가 있을 경우 보여줌
        }

        // 저장 버튼 클릭 시 처리
        document.getElementById('save-button').addEventListener('click', () => {
            const recipient = document.getElementById('recipient').value;
            const contact = document.getElementById('contact').value;
            const detailedAddress = document.getElementById('detailed-address').value;
            if (recipient && contact && detailedAddress) {
                alert(`주소가 저장되었습니다:\n받는 이: ${recipient}\n연락처: ${contact}\n주소: ${address}, ${detailedAddress}`);
                // 저장 로직 추가 (예: 서버로 전송 등)
            } else {
                alert('모든 정보를 입력해 주세요.');
            }
        });
    </script>
</body>
</html>
