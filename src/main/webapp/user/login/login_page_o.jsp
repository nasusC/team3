<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="로그인 페이지"
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shotcut icon" href="http://192.168.10.218/jsp_prj/common/images/favicon.ico"/>
    <link rel="stylesheet" href="../css/main.css">
<!-- bootstrap CDN 시작 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- jQuery CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style type="text/css">
.container {
	margin: 0px auto;
	margin-top: 20px;
    text-align: center;
    background-color: white;
    padding: 30px;
    border-radius: 10px;
    width: 350px;
}

.login_head{ 
	border: 3px solid #adadeb; 
	border-radius: 10px;
	display: flex;
	justify-content: center;   /* 가로 중앙 정렬 */
    align-items: center;       /* 세로 중앙 정렬 */
    height: 50px;
	}
	
.login_text{
	font-size: 30px;
	font-weight: bold;
}

.logo_link {
    display: block;
    margin-bottom: 20px;
    text-align: center;
}

.login_logo {
    width: 180px;
    margin: 0 auto;
}

.login_form {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 15px;
    
}

.login_form input {
    width: 100%;
    padding: 10px;
    margin: 5px 0;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
}

#loginBtn {
    width: 100%;
    padding: 10px;
    background-color: #28a745;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    margin-top: 10px;
}

#loginBtn:hover {
    background-color: #218838;
}

.login_links {
    margin-top: 10px;
}

.login_links a {
    color: #007bff;
    font-size:12px;
    text-decoration: none;
    margin: 0 5px;
}

.login_links a:hover {
    text-decoration: underline;
}

.login_page_footer {
    padding-top: 30px;
    font-size: 12px;
}

.login_page_footer a {
    color: #6c757d;
    text-decoration: none;
    margin: 5px 5px;
}

.login_page_footer a:hover {
    text-decoration: underline;
}
</style>
<script type="text/javascript">
$(function(){
	$("#loginBtn").click(function(event){
		event.preventDefault();
		chkNull();
	});
});//ready

function chkNull(){
	if($("#id").val().trim() == ""){
		alert("아이디를 확인해주세요");
		$("#id").focus();
		return;
	}//end if
	if($("#password").val().trim() == ""){
		alert("비밀번호를 확인해주세요");
		$("#password").focus();
		return;
	}//end if
	
	$("#login_form").submit();
}//chkNull
</script>
</head>
<body>
<div id="wrap">
<div class="container">
    <a href="/index.jsp" class="logo_link">
        <img src="images/logo.png" alt="EGO EMPORIUM" class="login_logo">
    </a>
    <div class="login_head"><span class="login_text">로그인</span></div>
    
    <form class="login_form" id="login_form" action="login_form_process.jsp" method="post">
        <input type="text" id="id" name="id" placeholder="아이디 또는 전화번호">
        <input type="password" id="password" name="password" placeholder="비밀번호">
        <button id="loginBtn" name="loginBtn">로그인</button>
    </form>
    
    <div class="login_links">
        <a href="find_password_1.jsp">비밀번호 찾기</a> |
        <a href="find_id.jsp">아이디 찾기</a> |
        <a href="sign_up_1.jsp">회원가입</a>
    </div>
    
    <div class="login_page_footer">
        <a href="https://policy.naver.com/rules/service.html">이용약관</a> |
        <a href="#">개인정보처리방침</a> |
        <a href="#">책임의 한계와 법적고지</a> |
        <a href="#">회원정보 고객센터</a>
    </div>
</div>
</div>
</body>
</html>