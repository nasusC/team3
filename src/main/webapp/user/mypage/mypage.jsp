<%@ page contentType="text/html;charset=UTF-8" language="java" info="" %>
<%--로그인세션필요--%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

    <style type="text/css">
        #mypage {
            margin-top: 20px;
        }
        #mypage p {
            cursor: pointer; /* 마우스 커서를 포인터로 변경 */
            color: blue; /* 텍스트 색상 변경 */
            text-decoration: underline; /* 밑줄 추가 */
            margin: 5px 0; /* 항목 간 간격 추가 */
        }
    </style>
    
    <script type="text/javascript">
        $(document).ready(function() {
            $('#mypage').hide(); // 초기 상태에서 마이페이지 숨김
            
            // 마이페이지 토글 함수
            $('a._3C8i4VFUIv').click(function(event) {
                event.preventDefault(); // 기본 링크 동작 방지
                $('#mypage').toggle(); // 마이페이지 보이기/숨기기
            });
        });

        // 각 페이지로 이동하는 함수
        function passch() {
            window.location.href = "user_edit.jsp"; // 사용자 정보 수정 페이지로 이동
        }

        function seachOrder() {
            window.location.href = "order_list.jsp"; // 주문 목록 조회 페이지로 이동
        }

        function seachQandA() {
            window.location.href = "qa_list.jsp"; // 나의 Q&A 조회 페이지로 이동
        }
    </script>
</head>
<body>
    <a href="#" class="_3C8i4VFUIv">마이페이지<span class="blind">펼치기</span></a>

    <div id="mypage">
        <p onclick="passch()">사용자정보 수정</p>
        <p onclick="seachOrder()">주문목록조회</p>
        <p onclick="seachQandA()">나의 Q&A조회</p>
    </div>
</body>
</html>