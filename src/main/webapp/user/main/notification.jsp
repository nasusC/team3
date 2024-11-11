<%@ page contentType="text/html;charset=UTF-8" language="java" info="" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/notification.css">

<body>
<jsp:include page="../../common/header.jsp" />
	<!-- 콘텐츠 섹션 -->
	<script>
        function setActive(element) {
            // 모든 .nav-button에서 active 클래스 제거 및 색상 회색으로 변경
            const buttons = document.querySelectorAll('.nav-button');
            buttons.forEach(button => {
                button.classList.remove('active');
                button.style.color = 'gray'; // 회색으로 변경
            });

            // 클릭된 버튼에 active 클래스 추가 및 색상 검정으로 변경
            element.classList.add('active');
            element.style.color = 'black'; // 클릭한 버튼을 검정색으로 변경

            // 모든 콘텐츠 숨김
            const contents = document.querySelectorAll('.content');
            contents.forEach(content => {
                content.style.display = 'none'; // 모든 콘텐츠 숨김
            });

            // 클릭된 버튼에 해당하는 콘텐츠 표시
            const contentId = element.textContent.trim();
            const contentElement = document.getElementById(contentId);
            if (contentElement) {
                contentElement.style.display = 'block'; // 해당 콘텐츠 표시
            }
        }

        // 페이지 로드 시 공지사항 버튼을 검정색으로 설정하고 해당 콘텐츠 표시
        document.addEventListener('DOMContentLoaded', () => {
            const noticeButton = document.querySelector('.nav-button.active'); // 공지사항 버튼 선택
            if (noticeButton) {
                setActive(noticeButton); // 공지사항 버튼 활성화 및 콘텐츠 표시
            }
        });

</script>

	<section class="notice">
		<div class="page-title">
			<div class="container">
				<h3
					style="font-weight: bold; text-align: left; padding-right: -30px;">공지사항</h3>
			</div>
		</div>

		<!-- board list area -->
		<div id="board-list">
			<div class="container">
				<table class="board-table">
					<thead>
						<tr>
							<th scope="col" class="th-num">구분</th>
							<th scope="col" class="th-title">제목</th>
							<th scope="col" class="th-date">작성일</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>일반</td>
							<th><a
								href="notice_detail_page.jsp">기본
									공지</a></th>
							<td>2024.08.09</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<!-- Pagination area (페이지 번호 영역) -->
		<div class="pagination">
			<div class="page-box">1</div>
		</div>

		<!-- board search area -->
		<div id="board-search">
			<div class="container">
				<div class="search-window">
					<form action="">
						<div class="search-wrap">
							<label for="search" class="blind">공지사항 내용 검색</label> <input
								id="search" type="search" name="" placeholder="검색어를 입력해주세요."
								value="">
							<button type="button" class="btn btn-dark">검색</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>


	<footer class="footer">
		<p>사업자등록번호 010-10-10101</p>
		<p>통신판매업신고번호 1010-1010-1010호</p>
		<p>대표이사 홍길동 경기도 성남시 분당구 정자일로 95, 1784, 13561</p>
		<p>전화 1588-3819 이메일 egoempo@naver.com 사업자등록정보 확인</p>
	</footer>