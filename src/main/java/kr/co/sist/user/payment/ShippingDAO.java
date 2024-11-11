package kr.co.sist.user.payment;

import kr.co.sist.db.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


/**
 * @author : S.H.CHA
 */
public class ShippingDAO {

    // 모든 배송지 조회
    public List<ShippingVO> selectAllShipping(String userId) throws SQLException {
        List<ShippingVO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConnection();

            StringBuilder selectQuery = new StringBuilder();
            selectQuery
                    .append(" SELECT d.SHIPPING_ID, d.ORDER_ID, d.RECIPIENT, ")
                    .append(" d.PHONE, d.ADDRESS, d.ADDRESS2, d.MEMO, d.STATUS, d.INPUT_DATE ")  // INPUT_DATE 추가
                    .append(" FROM DELIVERY d ")
                    .append(" JOIN ORDERS o ON d.ORDER_ID = o.ORDER_ID ")
                    .append(" WHERE o.USER_ID = ? ")
                    .append(" ORDER BY d.INPUT_DATE DESC ");  // DISTINCT 제거

            pstmt = con.prepareStatement(selectQuery.toString());
            pstmt.setString(1, userId);

            rs = pstmt.executeQuery();

            while(rs.next()) {
                ShippingVO sVO = new ShippingVO();
                sVO.setShippingId(rs.getInt("SHIPPING_ID"));
                sVO.setOrderId(rs.getInt("ORDER_ID"));
                sVO.setRecipient(rs.getString("RECIPIENT"));
                sVO.setPhone(rs.getString("PHONE"));
                sVO.setAddress(rs.getString("ADDRESS"));
                sVO.setAddress2(rs.getString("ADDRESS2"));
                sVO.setMemo(rs.getString("MEMO"));
                sVO.setShippingStatus(rs.getString("STATUS"));
                list.add(sVO);
            }

        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }

        return list;
    }

    // 특정 배송지 조회
    public ShippingVO selectOneShipping(int shippingId) throws SQLException {
        ShippingVO sVO = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConnection();

            String selectQuery =
                    " SELECT SHIPPING_ID, ORDER_ID, RECIPIENT, PHONE, ADDRESS, ADDRESS2, MEMO, STATUS " +
                            " FROM DELIVERY WHERE SHIPPING_ID = ?";

            pstmt = con.prepareStatement(selectQuery);
            pstmt.setInt(1, shippingId);

            rs = pstmt.executeQuery();

            if(rs.next()) {
                sVO = new ShippingVO();
                sVO.setShippingId(rs.getInt("SHIPPING_ID"));
                sVO.setOrderId(rs.getInt("ORDER_ID"));
                sVO.setRecipient(rs.getString("RECIPIENT"));
                sVO.setPhone(rs.getString("PHONE"));
                sVO.setAddress(rs.getString("ADDRESS"));
                sVO.setAddress2(rs.getString("ADDRESS2"));
                sVO.setMemo(rs.getString("MEMO"));
                sVO.setShippingStatus(rs.getString("STATUS"));
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }

        return sVO;
    }

    // 새 배송지 추가
    public int insertNewShipping(ShippingVO sVO) throws SQLException {
        int result = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConnection();

            StringBuilder insertQuery = new StringBuilder();
            insertQuery
                    .append(" INSERT INTO DELIVERY ")
                    .append(" (SHIPPING_ID, ORDER_ID, RECIPIENT, PHONE, ADDRESS, ADDRESS2, MEMO, STATUS) ")
                    .append(" VALUES (DELIVERY_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?) ");

            pstmt = con.prepareStatement(insertQuery.toString());
            pstmt.setInt(1, sVO.getOrderId());
            pstmt.setString(2, sVO.getRecipient());
            pstmt.setString(3, sVO.getPhone());
            pstmt.setString(4, sVO.getAddress());
            pstmt.setString(5, sVO.getAddress2());
            pstmt.setString(6, sVO.getMemo());
            pstmt.setString(7, "PENDING"); // 초기 상태

            result = pstmt.executeUpdate();
        } finally {
            dbCon.dbClose(null, pstmt, con);
        }

        return result;
    }

    // 배송지 정보 수정
    public int updateShipping(ShippingVO sVO) throws SQLException {
        int result = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConnection();

            StringBuilder updateQuery = new StringBuilder();
            updateQuery
                    .append(" UPDATE DELIVERY ")
                    .append(" SET RECIPIENT = ?, ")
                    .append(" PHONE = ?, ")
                    .append(" ADDRESS = ?, ")
                    .append(" ADDRESS2 = ? ")
                    .append(" WHERE SHIPPING_ID = ? ");

            pstmt = con.prepareStatement(updateQuery.toString());
            pstmt.setString(1, sVO.getRecipient());
            pstmt.setString(2, sVO.getPhone());
            pstmt.setString(3, sVO.getAddress());
            pstmt.setString(4, sVO.getAddress2());
            pstmt.setInt(5, sVO.getShippingId());

            result = pstmt.executeUpdate();

        } finally {
            dbCon.dbClose(null, pstmt, con);
        }

        return result;
    }

    // 배송지 삭제
    public int deleteShipping(int shippingId) throws SQLException {
        int result = 0;
        Connection con = null;
        PreparedStatement pstmt = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConnection();

            String deleteQuery = "DELETE FROM DELIVERY WHERE SHIPPING_ID = ?";

            pstmt = con.prepareStatement(deleteQuery);
            pstmt.setInt(1, shippingId);

            result = pstmt.executeUpdate();
        } finally {
            dbCon.dbClose(null, pstmt, con);
        }

        return result;
    }

    // 사용자의 기본 배송지 조회
    public ShippingVO selectDefaultShipping(String userId) throws SQLException {
        ShippingVO sVO = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConnection();

            StringBuilder selectQuery = new StringBuilder();
            selectQuery
                    .append(" SELECT d.SHIPPING_ID, d.ORDER_ID, d.RECIPIENT, ")
                    .append(" d.PHONE, d.ADDRESS, d.ADDRESS2, d.MEMO, d.STATUS ")
                    .append(" FROM DELIVERY d ")
                    .append(" JOIN ORDERS o ON d.ORDER_ID = o.ORDER_ID ")
                    .append(" WHERE o.USER_ID = ? ")
                    .append(" AND ROWNUM = 1 ")
                    .append(" ORDER BY d.INPUT_DATE DESC ");

            pstmt = con.prepareStatement(selectQuery.toString());
            pstmt.setString(1, userId);

            rs = pstmt.executeQuery();

            if(rs.next()) {
                sVO = new ShippingVO();
                sVO.setShippingId(rs.getInt("SHIPPING_ID"));
                sVO.setOrderId(rs.getInt("ORDER_ID"));
                sVO.setRecipient(rs.getString("RECIPIENT"));
                sVO.setPhone(rs.getString("PHONE"));
                sVO.setAddress(rs.getString("ADDRESS"));
                sVO.setAddress2(rs.getString("ADDRESS2"));
                sVO.setMemo(rs.getString("MEMO"));
                sVO.setShippingStatus(rs.getString("STATUS"));
            }

        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }

        return sVO;
    }
}


