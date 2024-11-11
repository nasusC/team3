<%@ page contentType="text/html;charset=UTF-8" language="java" info="" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>에고엠포리움</title>
<link rel="stylesheet" href="../css/main.css">

<style>
body {
	font-family: 'Malgun Gothic', sans-serif;
	width: 100%;
	margin: 0;
	padding: 0;
}

.container {
	width: 100%;
	padding: 20px;
	box-sizing: border-box;
}

.h {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 10px;
}

.title {
	font-size: 16px;
	font-weight: bold;
}

.view-all {
	font-size: 12px;
	color: #666;
	text-decoration: none;
}

hr {
	border: none;
	border-top: 1px solid #000;
	margin: 0 0 15px 0;
}

.p-title-wrapper {
	display: flex; 
	align-items: center; 
}

.p-title {
	color: #8000ff;
	font-size: 14px;
	margin-bottom: 5px;
}

.basic-notice {
	margin-left: 5px;
	font-size: 14px;
}

.post-info {
	color: #666;
	font-size: 12px;
	margin: 10px 0; 
}

.post-info-line {
	border-top: 1px solid #ccc; 
	margin: 5px 0; 
}

.content-image {
	width: 100%;
	max-width: 800px;
	height: auto;
	margin: 40px 0; 
	display: block;
	margin-left: auto;
	margin-right: auto;
}

.nav-button {
	color: gray; 
	text-decoration: none;
	padding: 10px 15px;
	display: inline-block;
}

.nav-button:hover {
	color: black; 
}

.nav-button.active {
	color: black; 
}

.content {
	display: none; 
}
</style>
</head>

<body>

	<div class="header">
		<div class="header-content">
			<a href="main.jsp"> <img
				src="http://localhost/html_prj/common/images/EGO.png" alt="쇼핑몰 로고">
			</a>
		</div>

		<div class="search-and-login">
			<div class="search-bar">
				<input type="text" placeholder="검색...">
				<button aria-label="검색">🔍</button>
			</div>
			<button class="login-button">로그인</button>
		</div>
	</div>

	<div class="logo-container">
		<a href="main.jsp"> <img
			src="http://localhost/html_prj/common/images/EGO.png" alt="로고"
			class="main-logo">
		</a>
	</div>

	<div class="nav-section">
		<a href="http://localhost/html_prj/project/main.html" class="nav-button"
			onclick="setActive(this)">베스트상품</a> <a href="#"
			class="nav-button product-link" onclick="setActive(this)">전체상품</a>
		<div class="catalog">
			<ul>
				<li><a href="page1.html">아디다스</a></li>
				<li><a href="page2.html">나이키</a></li>
				<li><a href="page3.html">뉴발란스</a></li>
				<li><a href="page4.html">아식스</a></li>
			</ul>
		</div>
		<a href="http://localhost/html_prj/project/notification.html"
			class="nav-button active" onclick="setActive(this)">공지사항</a>
	</div>

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
<body>
	<div class="container">
		<div class="h">
			<span class="title">전체 1</span> <a
				href="http://localhost/html_prj/project/notification.html"
				class="view-all">전체 공지사항 보기</a>
		</div>
		<hr>
		<div class="p-title-wrapper">
			<div class="p-title">[일반]</div>
			<div class="basic-notice">기본공지</div>
			<!-- 기본공지 텍스트를 추가 -->
		</div>
		<div class="post-info">2024.08.09 15:51 조회수 125</div>
		<div class="post-info-line"></div>
		<!-- 회색 선 추가 -->
		<img
			src="https://shop-phinf.pstatic.net/20240809_234/1723186293935oyl9M_JPEG/%EA%B3%B5%EC%A7%80%EC%82%AC%ED%95%AD.jpg?type=w860"
			alt="에고엠포리움 공지사항" class="content-image">
	</div>

	<footer class="footer">
		<p>사업자등록번호 010-10-10101</p>
		<p>통신판매업신고번호 1010-1010-1010호</p>
		<p>대표이사 최수연 경기도 성남시 분당구 정자일로 95, 1784, 13561</p>
		<p>전화 1588-3819 이메일 egoempo@naver.com 사업자등록정보 확인</p>
	</footer>

</body>
</html>