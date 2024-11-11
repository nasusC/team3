<%@ page contentType="text/html;charset=UTF-8" language="java" info="" %>
<%--로그인세션필요--%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Q&A 목록 및 문의하기</title>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h2 {
            margin-bottom: 20px;
            text-align: center;
        }
        .logo {
            text-align: center;
            margin-bottom: 20px;
        }
        .logo img {
            max-width: 200px;
        }
        .search-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .search-bar input {
            width: 50%; /* 검색바 길이 증가 */
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .search-bar button {
            padding: 10px 15px;
            background-color: #9E9E9E; /* 회색으로 변경 */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-left: 5px;
        }
        .search-bar button:hover {
            background-color: #7E7E7E; /* 호버 시 더 어두운 회색 */
        }
        .qa-table {
            width: 100%;
            border-collapse: collapse;
        }
        .qa-table th, .qa-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        .qa-table th {
            background-color: #f2f2f2;
        }
        .qa-item {
            cursor: pointer;
        }
        .qa-content {
            display: none; /* 초기 상태는 숨김 */
            background-color: #f9f9f9;
            padding: 10px;
            margin-top: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .admin-reply {
            margin-top: 10px;
            border: 1px dashed #ccc;
            padding: 10px;
            border-radius: 5px;
        }
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
            padding-top: 60px;
        }
        .modal-content {
            background-color: #fefefe;
            margin: 5% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 50%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        table td {
            padding: 10px;
            vertical-align: middle;
        }
        .input-group {
            margin-bottom: 15px;
        }
        .input-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .input-group input,
        .input-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .warning-text {
            padding: 10px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 0.9em;
            color: #555;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .button-group button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .button-group button.cancel {
            background-color: #f44336;
        }
        .button-group button:hover {
            opacity: 0.9;
        }
        #inquiryText {
            height: 150px; /* 텍스트 에리어 크기 고정 */
            resize: none; /* 크기 조절 비활성화 */
        }
    </style>
</head>
<body>

    <div class="logo">
        <img src="http://localhost:8080/test/dg/%EC%83%81%ED%91%9C.png" alt="Ego Emporium">
    </div>

    <h2>Q&A 목록</h2>

    <div class="search-bar">
        <div style="display: flex; align-items: center;">
            <input type="text" id="searchInput" placeholder="제목을 검색하세요...">
            <button onclick="searchQuestions()">검색</button>
        </div>
        <button onclick="openModal()">문의하기</button>
    </div>

    <table class="qa-table">
        <thead>
            <tr>
                <th>번호</th>
                <th>문의 종류</th>
                <th style="width: 40%;">제목</th>
                <th>문의자</th>
                <th>등록일</th>
            </tr>
        </thead>
        <tbody id="qaList">
            <!-- 등록된 문의 목록은 여기에 추가할 수 있습니다. -->
        </tbody>
    </table>

    <!-- 문의하기 모달 -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <h2>문의하기</h2>

            <!-- 문의 폼 테이블 형식 -->
            <table>
                <tr>
                    <td style="background-color: #f0f0f0;"><strong>문의 종류</strong></td>
                    <td colspan="4">
                        <label><input type="checkbox" name="inquiryType" value="상품" onclick="checkOnlyOne(this)"> 상품</label>
                        <label><input type="checkbox" name="inquiryType" value="배송" onclick="checkOnlyOne(this)"> 배송</label>
                        <label><input type="checkbox" name="inquiryType" value="취소" onclick="checkOnlyOne(this)"> 취소</label>
                        <label><input type="checkbox" name="inquiryType" value="반품/교환" onclick="checkOnlyOne(this)"> 반품/교환</label>
                        <label><input type="checkbox" name="inquiryType" value="기타" onclick="checkOnlyOne(this)"> 기타</label>
                    </td>
                </tr>
                <tr>
                    <td style="background-color: #f0f0f0;"><strong>아이디</strong></td>
                    <td colspan="4">
                        <input type="text" id="writerName" placeholder="아이디" rows="4" style="width: 80%; resize: none;">
                    </td>
                </tr>
                <tr>
                    <td style="background-color: #f0f0f0;"><strong>제목</strong></td>
                    <td colspan="4">
                        <input type="text" id="inquiryTitle" placeholder="문의 제목" rows="4" style="width: 80%; resize: none;">
                    </td>
                </tr>
                <tr>
                    <td style="background-color: #f0f0f0;"><strong>내용</strong></td>
                    <td colspan="4">
                        <textarea id="inquiryText" placeholder="문의 내용을 작성하세요..." rows="4" style="width: 80%; height: 150px; resize: none;"></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="5" class="warning-text">
                        <strong>문의 시 유의해주세요!</strong><br>
                        회원간 직거래로 발생하는 피해에 대해 책임지지 않습니다.<br>
                        주민등록번호, 연락처 등의 정보는 타인에게 노출될 경우 개인정보 도용의 위험이 있으니 주의해 주시기 바랍니다.<br>
                        비방, 광고, 불건전한 내용의 글은 관리자에 의해 삭제될 수 있습니다.
                    </td>
                </tr>
            </table>

            <div class="button-group">
                <button onclick="submitInquiry()">확인</button>
                <button class="cancel" onclick="closeModal()">취소</button>
            </div>
        </div>
    </div>

    <script>
        let inquiryCount = 0; // 문의 번호 카운터
        const inquiries = []; // 문의 내용을 저장할 배열

        function openModal() {
            document.getElementById("myModal").style.display = "block";
        }

        function closeModal() {
            document.getElementById("myModal").style.display = "none";
            document.getElementById("writerName").value = '';
            document.getElementById("inquiryTitle").value = '';
            document.getElementById("inquiryText").value = '';
            const checkboxes = document.getElementsByName('inquiryType');
            checkboxes.forEach(checkbox => checkbox.checked = false);
        }

        function searchQuestions() {
            const input = document.getElementById("searchInput").value.toLowerCase();
            const rows = document.querySelectorAll("#qaList tr:not(.qa-content)"); // 내용 행을 제외하고 검색
            rows.forEach(row => {
                const title = row.cells[2].textContent.toLowerCase();
                row.style.display = title.includes(input) ? "" : "none";
                const contentRow = row.nextElementSibling; // 해당 행의 다음 요소(내용 행)
                if (contentRow) {
                    contentRow.style.display = title.includes(input) ? "none" : "none"; // 내용도 숨김
                }
            });
        }

        function submitInquiry() {
            const writerName = document.getElementById("writerName").value;
            const inquiryTitle = document.getElementById("inquiryTitle").value;
            const inquiryText = document.getElementById("inquiryText").value;
            const inquiryType = Array.from(document.getElementsByName('inquiryType'))
                .find(checkbox => checkbox.checked)?.value || '미지정';

            inquiryCount++; // 문의 번호 증가

            // 문의자의 이름을 첫 세 글자만 보여주고 나머지는 *로 마스킹
            let maskedName = writerName.length > 3 ? writerName.slice(0, 3) + '*'.repeat(writerName.length - 3) : writerName;

            // Q&A 목록에 새로운 문의 추가
            const newRow = document.createElement('tr');
            newRow.className = 'qa-item';
            newRow.innerHTML = 
                `<td>${inquiryCount}</td>
                <td>${inquiryType}</td>
                <td style="text-align: left;" onclick="toggleDetails(this)">${inquiryTitle}</td>
                <td>${maskedName}</td>
                <td>${new Date().toLocaleDateString()}</td>`;
            
            const contentRow = document.createElement('tr');
            contentRow.className = 'qa-content'; // 클래스 추가
            contentRow.innerHTML = 
                `<td colspan="5" style="text-align: left;">
                    <div><strong>내용:</strong> ${inquiryText}</div>
                    <div><strong>답변:</strong> <span class="admin-reply">답변이 없습니다.</span></div>
                </td>`;
            contentRow.style.display = 'none'; // 초기 상태는 숨김
            document.getElementById("qaList").appendChild(newRow);
            document.getElementById("qaList").appendChild(contentRow); // 내용 행 추가

            // 문의 내용을 비워줌
            closeModal();
        }


        function toggleDetails(titleCell) {
            const contentRow = titleCell.parentElement.nextElementSibling; // 다음 요소(내용 행)
            if (contentRow.style.display === 'none' || contentRow.style.display === '') {
                contentRow.style.display = 'table-row'; // 테이블 행으로 표시
            } else {
                contentRow.style.display = 'none';
            }
        }

        function checkOnlyOne(checkbox) {
            const checkboxes = document.getElementsByName(checkbox.name);
            checkboxes.forEach((item) => {
                if (item !== checkbox) item.checked = false;
            });
        }
    </script>

</body>
</html>
