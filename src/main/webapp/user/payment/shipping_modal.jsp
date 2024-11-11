<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%--&lt;%&ndash;로그인세션필요&ndash;%&gt;--%>
<%--<!doctype html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
<%--  <meta charset="UTF-8">--%>
<%--  <meta name="viewport"--%>
<%--        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">--%>
<%--  <meta http-equiv="X-UA-Compatible" content="ie=edge">--%>
<%--  <title>Document</title>--%>
<%--  <link rel="stylesheet" href="">--%>
<%--  <style>--%>
<%--      /* 모달 기본 스타일 */--%>
<%--      .modal {--%>
<%--          display: none;--%>
<%--          position: fixed;--%>
<%--          z-index: 1000;--%>
<%--          left: 0;--%>
<%--          top: 0;--%>
<%--          width: 100%;--%>
<%--          height: 100%;--%>
<%--          background-color: rgba(0, 0, 0, 0.6);--%>
<%--          font-family: 'Apple SD Gothic Neo', 'Noto Sans KR', sans-serif;--%>
<%--      }--%>

<%--      .modal-content {--%>
<%--          background-color: white;--%>
<%--          margin: 5% auto;--%>
<%--          padding: 30px;--%>
<%--          border-radius: 10px;--%>
<%--          width: 400px;--%>
<%--          position: relative;--%>
<%--          box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);--%>
<%--          animation: fadeIn 0.3s ease;--%>
<%--      }--%>

<%--      @keyframes fadeIn {--%>
<%--          from { opacity: 0; transform: translateY(-10px); }--%>
<%--          to { opacity: 1; transform: translateY(0); }--%>
<%--      }--%>

<%--      /* 모달 닫기 버튼 */--%>
<%--      .close-btn {--%>
<%--          position: absolute;--%>
<%--          top: 15px;--%>
<%--          right: 15px;--%>
<%--          font-size: 24px;--%>
<%--          border: none;--%>
<%--          background: none;--%>
<%--          cursor: pointer;--%>
<%--          color: #333;--%>
<%--      }--%>

<%--      /* 제목 스타일 */--%>
<%--      .address-container h1 {--%>
<%--          font-size: 1.5em;--%>
<%--          color: #333;--%>
<%--          margin-bottom: 20px;--%>
<%--          font-weight: 600;--%>
<%--      }--%>

<%--      /* 신규 입력 버튼 스타일 */--%>
<%--      .new-address-btn {--%>
<%--          display: inline-block;--%>
<%--          width: 100%;--%>
<%--          padding: 12px;--%>
<%--          margin-bottom: 20px;--%>
<%--          background-color: #00c73c;--%>
<%--          color: white;--%>
<%--          border: none;--%>
<%--          border-radius: 6px;--%>
<%--          font-size: 16px;--%>
<%--          font-weight: 500;--%>
<%--          cursor: pointer;--%>
<%--          text-align: center;--%>
<%--          transition: background-color 0.3s ease;--%>
<%--      }--%>

<%--      .new-address-btn:hover {--%>
<%--          background-color: #00a62c;--%>
<%--      }--%>

<%--      /* 주소 목록 스타일 */--%>
<%--      .address-list {--%>
<%--          list-style: none;--%>
<%--          padding: 0;--%>
<%--          margin: 0;--%>
<%--      }--%>

<%--      .address-item {--%>
<%--          border: 1px solid #ddd;--%>
<%--          padding: 15px;--%>
<%--          margin-bottom: 15px;--%>
<%--          border-radius: 6px;--%>
<%--          transition: background-color 0.3s ease, box-shadow 0.3s ease;--%>
<%--      }--%>

<%--      .address-item:hover {--%>
<%--          background-color: #f8f9fa;--%>
<%--          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);--%>
<%--      }--%>

<%--      .address-item .name {--%>
<%--          font-weight: 600;--%>
<%--          font-size: 16px;--%>
<%--          color: #333;--%>
<%--          margin-bottom: 5px;--%>
<%--      }--%>

<%--      .address-item .phone {--%>
<%--          color: #666;--%>
<%--          font-size: 14px;--%>
<%--          margin-bottom: 8px;--%>
<%--      }--%>

<%--      .address-item .address {--%>
<%--          color: #333;--%>
<%--          font-size: 14px;--%>
<%--          line-height: 1.5;--%>
<%--      }--%>

<%--      /* 추가 주소 입력 필드 */--%>
<%--      .address-input {--%>
<%--          width: 100%;--%>
<%--          padding: 10px;--%>
<%--          border: 1px solid #ddd;--%>
<%--          border-radius: 4px;--%>
<%--          margin-top: 10px;--%>
<%--          font-size: 14px;--%>
<%--      }--%>

<%--      /* 수정, 삭제 버튼 스타일 */--%>
<%--      .actions {--%>
<%--          display: flex;--%>
<%--          gap: 10px;--%>
<%--          margin-top: 10px;--%>
<%--      }--%>

<%--      .edit-btn, .delete-btn {--%>
<%--          padding: 8px 16px;--%>
<%--          border-radius: 4px;--%>
<%--          font-size: 14px;--%>
<%--          cursor: pointer;--%>
<%--          border: none;--%>
<%--          font-weight: 500;--%>
<%--      }--%>

<%--      .edit-btn {--%>
<%--          background-color: #00c73c;--%>
<%--          color: white;--%>
<%--      }--%>

<%--      .edit-btn:hover {--%>
<%--          background-color: #00a62c;--%>
<%--      }--%>

<%--      .delete-btn {--%>
<%--          background-color: #f44336;--%>
<%--          color: white;--%>
<%--      }--%>

<%--      .delete-btn:hover {--%>
<%--          background-color: #d32f2f;--%>
<%--      }--%>
<%--  </style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div id="address-modal" class="modal">--%>
<%--  <div class="modal-content">--%>
<%--    <div class="address-container">--%>
<%--      <h1>배송지 목록</h1>--%>
<%--      <button class="new-address-btn" onclick="findAddr()">+ 배송지 신규입력</button>--%>
<%--      <ul class="address-list">--%>
<%--        <c:forEach var="addr" items="${shippingDAO.selectAllShipping(userId)}">--%>
<%--          <li class="address-item" data-id="${addr.shippingId}">--%>
<%--            <div class="name">${addr.recipient}</div>--%>
<%--            <div class="phone">${addr.phone}</div>--%>
<%--            <div class="address">${addr.address}</div>--%>
<%--            <input type="text" class="address" value="${addr.address2}">--%>
<%--            <div class="actions">--%>
<%--              <button class="edit-btn" onclick="editAddress(${addr.shippingId})">수정</button>--%>
<%--              <button class="delete-btn" onclick="deleteAddress(${addr.shippingId})">삭제</button>--%>
<%--            </div>--%>
<%--          </li>--%>
<%--        </c:forEach>--%>
<%--      </ul>--%>
<%--    </div>--%>
<%--    <button class="close-btn" onclick="toggleModal('address-modal')">&times;</button>--%>
<%--  </div>--%>
<%--</div>--%>

<%--<script>--%>
<%--    // 주소 API 사용--%>
<%--    function findAddr() {--%>
<%--        new daum.Postcode({--%>
<%--            oncomplete: function(data) {--%>
<%--                var addr = '';--%>
<%--                if (data.userSelectedType === 'R') {--%>
<%--                    addr = data.roadAddress;--%>
<%--                } else {--%>
<%--                    addr = data.jibunAddress;--%>
<%--                }--%>

<%--                // 신규 주소 추가 처리--%>
<%--                $.ajax({--%>
<%--                    url: 'add_address.jsp',--%>
<%--                    type: 'POST',--%>
<%--                    data: {--%>
<%--                        address: addr,--%>
<%--                        userId: ${userId}--%>
<%--                    },--%>
<%--                    success: function(response) {--%>
<%--                        if(response.success) {--%>
<%--                            location.reload();--%>
<%--                        } else {--%>
<%--                            alert('주소 추가 실패');--%>
<%--                        }--%>
<%--                    }--%>
<%--                });--%>
<%--            }--%>
<%--        }).open();--%>
<%--    }--%>

<%--    function selectAddress(shippingId) {--%>
<%--        $.ajax({--%>
<%--            url: 'update_shipping.jsp',--%>
<%--            type: 'POST',--%>
<%--            data: {--%>
<%--                shippingId: shippingId,--%>
<%--                orderId: ${param.orderId}--%>
<%--            },--%>
<%--            success: function(response) {--%>
<%--                if(response.success) {--%>
<%--                    location.reload();--%>
<%--                } else {--%>
<%--                    alert('배송지 변경 실패');--%>
<%--                }--%>
<%--            }--%>
<%--        });--%>
<%--    }--%>

<%--    function editAddress(shippingId) {--%>
<%--        // 수정 모달 또는 폼 표시--%>
<%--        const addressItem = document.querySelector(`[data-id="${shippingId}"]`);--%>
<%--        // ... 수정 로직 구현--%>
<%--    }--%>

<%--    function deleteAddress(shippingId) {--%>
<%--        if(confirm('이 배송지를 삭제하시겠습니까?')) {--%>
<%--            $.ajax({--%>
<%--                url: 'delete_address.jsp',--%>
<%--                type: 'POST',--%>
<%--                data: { shippingId: shippingId },--%>
<%--                success: function(response) {--%>
<%--                    if(response.success) {--%>
<%--                        location.reload();--%>
<%--                    } else {--%>
<%--                        alert('배송지 삭제 실패');--%>
<%--                    }--%>
<%--                }--%>
<%--            });--%>
<%--        }--%>
<%--    }--%>

<%--    // 모달 제어--%>
<%--    function toggleModal(modalId) {--%>
<%--        const modal = document.getElementById(modalId);--%>
<%--        modal.style.display = modal.style.display === 'none' ? 'block' : 'none';--%>
<%--    }--%>

<%--    // 모달 외부 클릭 시 닫기--%>
<%--    window.onclick = function(event) {--%>
<%--        if (event.target.classList.contains('modal')) {--%>
<%--            event.target.style.display = "none";--%>
<%--        }--%>
<%--    }--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>
<%--<!-- 배송지 변경 모달 -->--%>
