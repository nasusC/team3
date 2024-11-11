<%@ page contentType="text/html;charset=UTF-8" language="java" info="" %>
<!DOCTYPE html>
<html lang="ko" xmlns:th="http://www.thymeleaf.org">
<head>
  <meta charset="UTF-8">
  <title>header.jsp</title>
  <link rel="stylesheet" href="../user/css/main.css">
  <!--    bootstrap CDN  start-->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
          crossorigin="anonymous"></script>
  <!--    JQuery CDN start-->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

  <style>


  </style>
</head>
<body>
<div class="head">
  <div class="header">
    <div class="header-content">
      <a href="http://localhost:8080/index.jsp"> <img
          src="http://localhost:8080/common/egoporium.png" alt="쇼핑몰 로고"></a>
    </div>

    <div class="search-and-login">
      <div class="search-bar">
        <form action="index.jsp" method="get" id="searchForm">
          <input type="text" name="name" placeholder="검색..." id="searchInput">
          <button type="submit" aria-label="검색">🔍</button>
        </form>
      </div>
      <div class="auth-buttons">
        <button class="login-button" onclick="location.href='login.html'">로그인</button>
        <button class="auth-button" id="logout-button"
                style="display: none;" onclick="logout()">로그아웃
        </button>
        <a href=http://localhost:8080/user/mypage/mypage.jsp" id="mypage-button" style="display: none;"
           class="auth-button">마이페이지</a>
      </div>
    </div>
  </div>

  <div class="logo-container">
    <a href="http://localhost:8080/index.jsp"> <img
        src="http://localhost:8080/common/egoporium.png" alt="로고"
        class="main-logo"></a>
  </div>

  <div class="nav-section">
    <div class="nav-wrapper">
      <ul class="nav-list">
        <li><a href="/index.jsp?category=best" class="nav-item ${param.category eq 'best' ? 'active' : ''}">베스트상품</a></li>
        <li><a href="/index.jsp" class="nav-item ${empty param.category and empty param.brand ? 'active' : ''}">전체상품</a></li>
        <li class="brand-menu">
          <span class="nav-item">브랜드</span>
          <ul class="brand-submenu">
            <li><a href="/index.jsp?brand=ADIDAS" class="${param.brand eq 'ADIDAS' ? 'active' : ''}">아디다스</a></li>
            <li><a href="/index.jsp?brand=NIKE" class="${param.brand eq 'NIKE' ? 'active' : ''}">나이키</a></li>
            <li><a href="/index.jsp?brand=NEWBALANCE" class="${param.brand eq 'NEWBALANCE' ? 'active' : ''}">뉴발란스</a></li>
            <li><a href="/index.jsp?brand=ASICS" class="${param.brand eq 'ASICS' ? 'active' : ''}">아식스</a></li>
          </ul>
        </li>
        <li><a href="/user/main/notification.jsp" class="nav-item">공지사항</a></li>
      </ul>
    </div>
  </div>
</div>
<script>
    $(function () {

    })
</script>

</body>
</html>
