package kr.co.sist.user.order;

import kr.co.sist.db.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    /**
     * 새로운 주문과 주문 상품을 등록합니다.
     */
    public int insertOrder(OrderVO oVO, OrderProductVO opVO) throws SQLException {
        int orderId = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConnection();
            con.setAutoCommit(false);

            // MAX 값을 이용한 ORDER_ID 생성
            String selectMaxOrderId = "SELECT NVL(MAX(ORDER_ID), 0) + 1 FROM ORDERS";
            pstmt = con.prepareStatement(selectMaxOrderId);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                orderId = rs.getInt(1);
            }

            // 1. 주문 정보 저장
            StringBuilder insertOrderQuery = new StringBuilder();
            insertOrderQuery
                    .append(" INSERT INTO ORDERS ")
                    .append(" (ORDER_ID, USER_ID, ORDER_NAME, ORDER_DATE, ")
                    .append(" ORDER_STATUS, TOTAL_AMOUNT, ORDER_FLAG) ")
                    .append(" VALUES (?, ?, ?, ?, ?, ?, ?) ");

            pstmt = con.prepareStatement(insertOrderQuery.toString());

            int idx = 1;
            pstmt.setInt(idx++, orderId);
            pstmt.setString(idx++, oVO.getUserId());
            pstmt.setString(idx++, oVO.getOrderName());
            pstmt.setDate(idx++, oVO.getOrderDate());
            pstmt.setString(idx++, oVO.getOrderStatus());
            pstmt.setInt(idx++, oVO.getTotalAmount());
            pstmt.setString(idx++, oVO.getOrderFlag());

            int result = pstmt.executeUpdate();

            if(result > 0) {
                // 2. 주문 상품 정보 저장
                StringBuilder insertProductQuery = new StringBuilder();
                insertProductQuery
                        .append(" INSERT INTO ORDERED_PRODUCT ")
                        .append(" (ORDER_ITEM_ID, ORDER_ID, PRODUCT_ID, ")
                        .append(" PRICE, QUANTITY) ")
                        .append(" SELECT NVL(MAX(ORDER_ITEM_ID), 0) + 1, ?, ?, ?, ? ")
                        .append(" FROM ORDERED_PRODUCT ");

                pstmt = con.prepareStatement(insertProductQuery.toString());

                idx = 1;
                pstmt.setInt(idx++, orderId);
                pstmt.setInt(idx++, opVO.getProductId());
                pstmt.setInt(idx++, opVO.getPrice());
                pstmt.setInt(idx++, opVO.getQuantity());

                result = pstmt.executeUpdate();

                if(result > 0) {
                    con.commit();
                    return orderId;  // 성공 시 orderId 반환
                } else {
                    con.rollback();
                }
            }
            con.rollback();

        } catch(SQLException e) {
            if(con != null) {
                con.rollback();
            }
            throw e;
        } finally {
            if(con != null) {
                con.setAutoCommit(true);
            }
            dbCon.dbClose(rs, pstmt, con);
        }

        return 0;  // 실패 시 0 반환
    }

    /**
     * 주문 상태를 업데이트합니다.
     */
    public int updateOrderStatus(String orderId, String orderStatus) throws SQLException {
        int result = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConnection();

            String updateQuery =
                    " UPDATE ORDERS SET ORDER_STATUS = ? WHERE ORDER_ID = ? ";

            pstmt = con.prepareStatement(updateQuery);
            pstmt.setString(1, orderStatus);
            pstmt.setString(2, orderId);

            result = pstmt.executeUpdate();

        } finally {
            dbCon.dbClose(null, pstmt, con);
        }

        return result;
    }

    /**
     * 특정 주문을 조회합니다.
     */
    public OrderVO selectOrder(String orderId) throws SQLException {
        OrderVO oVO = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConnection();

            StringBuilder selectQuery = new StringBuilder();
            selectQuery
                    .append(" SELECT ORDER_ID, USER_ID, ORDER_NAME, ")
                    .append(" ORDER_DATE, ORDER_STATUS, TOTAL_AMOUNT, ORDER_FLAG ")
                    .append(" FROM ORDERS ")
                    .append(" WHERE ORDER_ID = ? ");

            pstmt = con.prepareStatement(selectQuery.toString());
            pstmt.setString(1, orderId);

            rs = pstmt.executeQuery();

            if(rs.next()) {
                oVO = new OrderVO();
                oVO.setOrderId(rs.getInt("ORDER_ID"));
                oVO.setUserId(rs.getString("USER_ID"));
                oVO.setOrderName(rs.getString("ORDER_NAME"));
                oVO.setOrderDate(rs.getDate("ORDER_DATE"));
                oVO.setOrderStatus(rs.getString("ORDER_STATUS"));
                oVO.setTotalAmount(rs.getInt("TOTAL_AMOUNT"));
                oVO.setOrderFlag(rs.getString("ORDER_FLAG"));
            }

        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }

        return oVO;
    }

    /**
     * 사용자의 주문 목록을 조회합니다.
     */
    public List<OrderVO> selectOrdersByUserId(String userId) throws SQLException {
        List<OrderVO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConnection();

            StringBuilder selectQuery = new StringBuilder();
            selectQuery
                    .append(" SELECT ORDER_ID, USER_ID, ORDER_NAME, ")
                    .append(" ORDER_DATE, ORDER_STATUS, TOTAL_AMOUNT, ORDER_FLAG ")
                    .append(" FROM ORDERS ")
                    .append(" WHERE USER_ID = ? ")
                    .append(" ORDER BY ORDER_DATE DESC ");

            pstmt = con.prepareStatement(selectQuery.toString());
            pstmt.setString(1, userId);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                OrderVO oVO = new OrderVO();
                oVO.setOrderId(rs.getInt("ORDER_ID"));
                oVO.setUserId(rs.getString("USER_ID"));
                oVO.setOrderName(rs.getString("ORDER_NAME"));
                oVO.setOrderDate(rs.getDate("ORDER_DATE"));
                oVO.setOrderStatus(rs.getString("ORDER_STATUS"));
                oVO.setTotalAmount(rs.getInt("TOTAL_AMOUNT"));
                oVO.setOrderFlag(rs.getString("ORDER_FLAG"));
                list.add(oVO);
            }

        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }

        return list;
    }
}