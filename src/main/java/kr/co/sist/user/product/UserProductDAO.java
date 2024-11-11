package kr.co.sist.user.product;

import kr.co.sist.db.DbConnection;
import kr.co.sist.user.review.ReviewVO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserProductDAO {


    // 이 메소드는 JSP에서 처리하였음.
//    // 상품명으로 검색
//    public ProductVO selectSearchProductName(String productName) throws SQLException {
//        ProductVO pVO = null;
//        Connection con = null;
//        PreparedStatement pstmt = null;
//        ResultSet rs = null;
//        DbConnection dbCon = DbConnection.getInstance();
//
//        try {
//            con = dbCon.getConnection();
//
//            StringBuilder selectQuery = new StringBuilder();
//            selectQuery
//                    .append(" SELECT P.PRODUCT_ID, P.NAME, P.PRICE, P.BRAND, ")
//                    .append(" P.DESCRIPTION, P.STOCK_QUANTITY, P.main_img, ")
//                    .append(" P.CREATED_AT, ")
//                    .append(" P.MODEL_NAME, P.SALES_STATUS, PC.CATALOG_ID ")
//                    .append(" FROM PRODUCTS P ")
//                    .append(" LEFT JOIN PRODUCT_CATALOG PC ON P.PRODUCT_ID = PC.PRODUCT_ID ")
//                    .append(" WHERE P.NAME LIKE ? ");
//
//            pstmt = con.prepareStatement(selectQuery.toString());
//            pstmt.setString(1, "%" + productName + "%");
//
//            rs = pstmt.executeQuery();
//
//            if (rs.next()) {
//                pVO = new ProductVO();
//                pVO.setProductId(rs.getInt("PRODUCT_ID"));
//                pVO.setName(rs.getString("NAME"));
//                pVO.setPrice(rs.getInt("PRICE"));
//                pVO.setBrand(rs.getString("BRAND"));
//                pVO.setDescription(rs.getString("DESCRIPTION"));
//                pVO.setStockQuantity(rs.getInt("STOCK_QUANTITY"));
//                pVO.setCreatedAt(rs.getDate("CREATED_AT"));
//                pVO.setModelName(rs.getString("MODEL_NAME"));
//                pVO.setSalesStatus(rs.getString("SALES_STATUS"));
//            }
//
//        } finally {
//            dbCon.dbClose(rs, pstmt, con);
//        }
//
//        return pVO;
//    }

    // 상품 전체 목록 조회 (검색조건, 정렬조건 포함)
    public List<ProductVO> selectAll(ProductVO pVO, String sortMethod) throws SQLException {
        List<ProductVO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConnection();

            StringBuilder selectQuery = new StringBuilder();
            selectQuery
                    .append(" SELECT P.PRODUCT_ID, P.NAME, P.PRICE, P.BRAND, ")
                    .append(" P.DESCRIPTION, P.STOCK_QUANTITY, P.MAIN_IMG, P.CREATED_AT, ")
                    .append(" P.MODEL_NAME, P.SALES_STATUS ")
                    .append(" FROM PRODUCTS P ")
                    .append(" WHERE 1=1 ");

            List<Object> parameters = new ArrayList<>();

            // 검색 조건 추가
            if (pVO != null) {
                if (pVO.getBrand() != null && !pVO.getBrand().isEmpty()) {
                    selectQuery.append(" AND P.BRAND = ? ");
                    parameters.add(pVO.getBrand());
                }
                if (pVO.getName() != null && !pVO.getName().isEmpty()) {
                    selectQuery.append(" AND P.NAME LIKE ? ");
                    parameters.add("%" + pVO.getName() + "%");
                }
                if (pVO.getPrice() > 0) {
                    selectQuery.append(" AND P.PRICE <= ? ");
                    parameters.add(pVO.getPrice());
                }
                if (pVO.getModelName() != null && !pVO.getModelName().isEmpty()) {
                    selectQuery.append(" AND P.MODEL_NAME LIKE ? ");
                    parameters.add("%" + pVO.getModelName() + "%");
                }
                if (pVO.getSalesStatus() != null && !pVO.getSalesStatus().isEmpty()) {
                    selectQuery.append(" AND P.SALES_STATUS = ? ");
                    parameters.add(pVO.getSalesStatus());
                }
            }

            // 정렬 조건
            switch (sortMethod != null ? sortMethod : "latest") {
                case "popular":
                    selectQuery.append(" ORDER BY P.STOCK_QUANTITY DESC");
                    break;
                case "lowPrice":
                    selectQuery.append(" ORDER BY P.PRICE ASC");
                    break;
                case "highPrice":
                    selectQuery.append(" ORDER BY P.PRICE DESC");
                    break;
                default:
                    selectQuery.append(" ORDER BY P.CREATED_AT DESC");
            }

            pstmt = con.prepareStatement(selectQuery.toString());

            // 파라미터 설정
            for (int i = 0; i < parameters.size(); i++) {
                pstmt.setObject(i + 1, parameters.get(i));
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
                ProductVO tempVO = new ProductVO();
                tempVO.setProductId(rs.getInt("PRODUCT_ID"));
                tempVO.setName(rs.getString("NAME"));
                tempVO.setPrice(rs.getInt("PRICE"));
                tempVO.setBrand(rs.getString("BRAND"));
                tempVO.setDescription(rs.getString("DESCRIPTION"));
                tempVO.setStockQuantity(rs.getInt("STOCK_QUANTITY"));
                tempVO.setMainImg(rs.getString("MAIN_IMG"));
                tempVO.setCreatedAt(rs.getDate("CREATED_AT"));
                tempVO.setModelName(rs.getString("MODEL_NAME"));
                tempVO.setSalesStatus(rs.getString("SALES_STATUS"));

                list.add(tempVO);
            }

        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }

        return list;
    }

    // 상품 사이즈 목록 조회
    public List<SizeVO> selectProductSizes(int productId) throws SQLException {
        List<SizeVO> sizeList = new ArrayList<>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConnection();

            String selectQuery =
                    "SELECT CHOOSE_SIZE_ID, PRODUCT_ID FROM SIZES WHERE PRODUCT_ID = ? ORDER BY CHOOSE_SIZE_ID";

            pstmt = con.prepareStatement(selectQuery);
            pstmt.setInt(1, productId);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                SizeVO sizeVO = new SizeVO();
                sizeVO.setChooseSizeId(rs.getInt("CHOOSE_SIZE_ID"));
                sizeVO.setProductId(rs.getInt("PRODUCT_ID"));
                sizeList.add(sizeVO);
            }

        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }

        return sizeList;
    }

//    // 카탈로그별 상품 조회
//    public List<ProductVO> selectByCatalogId(int catalogId) throws SQLException {
//        List<ProductVO> list = new ArrayList<>();
//        Connection con = null;
//        PreparedStatement pstmt = null;
//        ResultSet rs = null;
//        DbConnection dbCon = DbConnection.getInstance();
//
//        try {
//            con = dbCon.getConnection();
//
//            StringBuilder selectQuery = new StringBuilder();
//            selectQuery
//                    .append(" SELECT P.PRODUCT_ID, P.NAME, P.PRICE, P.BRAND, ")
//                    .append(" P.DESCRIPTION, P.STOCK_QUANTITY, P.MAIN_IMG, ")
//                    .append(" P.CREATED_AT, ")
//                    .append(" P.MODEL_NAME, P.SALES_STATUS, PC.CATALOG_ID ")
//                    .append(" FROM PRODUCTS P ")
//                    .append(" JOIN PRODUCT_CATALOG PC ON P.PRODUCT_ID = PC.PRODUCT_ID ")
//                    .append(" WHERE PC.CATALOG_ID = ? ")
//                    .append(" ORDER BY P.CREATED_AT DESC ");
//
//            pstmt = con.prepareStatement(selectQuery.toString());
//            pstmt.setInt(1, catalogId);
//
//            rs = pstmt.executeQuery();
//
//            while (rs.next()) {
//                ProductVO tempVO = new ProductVO();
//                tempVO.setProductId(rs.getInt("PRODUCT_ID"));
//                tempVO.setName(rs.getString("NAME"));
//                tempVO.setPrice(rs.getInt("PRICE"));
//                tempVO.setBrand(rs.getString("BRAND"));
//                tempVO.setDescription(rs.getString("DESCRIPTION"));
//                tempVO.setStockQuantity(rs.getInt("STOCK_QUANTITY"));
//                tempVO.setCreatedAt(rs.getDate("CREATED_AT"));
//                tempVO.setModelName(rs.getString("MODEL_NAME"));
//                tempVO.setSalesStatus(rs.getString("SALES_STATUS"));
//
//                list.add(tempVO);
//            }
//
//        } finally {
//            dbCon.dbClose(rs, pstmt, con);
//        }
//
//        return list;
//    }

    // 상품 ID로 상세 정보 조회
    public ProductVO selectByProductId(int productId) throws SQLException {
        ProductVO pVO = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConnection();

            StringBuilder selectQuery = new StringBuilder();
            selectQuery
                    .append(" SELECT PRODUCT_ID, NAME, PRICE, BRAND, ")
                    .append(" DESCRIPTION, STOCK_QUANTITY, MAIN_IMG, ")
                    .append(" CREATED_AT, MODEL_NAME ")
                    .append(" FROM PRODUCTS ")
                    .append(" WHERE PRODUCT_ID = ? ");

            pstmt = con.prepareStatement(selectQuery.toString());
            pstmt.setInt(1, productId);

            rs = pstmt.executeQuery();

            if(rs.next()) {
                pVO = new ProductVO();
                pVO.setProductId(rs.getInt("PRODUCT_ID"));
                pVO.setName(rs.getString("NAME"));
                pVO.setPrice(rs.getInt("PRICE"));
                pVO.setBrand(rs.getString("BRAND"));
                pVO.setDescription(rs.getString("DESCRIPTION"));
                pVO.setStockQuantity(rs.getInt("STOCK_QUANTITY"));
                pVO.setCreatedAt(rs.getDate("CREATED_AT"));
                pVO.setModelName(rs.getString("MODEL_NAME"));
            }

        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }

        return pVO;
    }

    // 상품의 리뷰 목록 조회
    public List<ReviewVO> selectAllProductReview(int productId) throws SQLException {  // 반환 타입 변경
        List<ReviewVO> list = new ArrayList<>();  // ReviewVO 리스트로 변경
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        DbConnection dbCon = DbConnection.getInstance();

        try {
            con = dbCon.getConnection();

            StringBuilder selectQuery = new StringBuilder();
            selectQuery
                    .append(" SELECT r.REVIEW_ID, r.USER_ID, r.PRODUCT_ID, ")
                    .append(" r.CONTENT, r.RATING, r.CREATED_AT, ")
                    .append(" p.NAME as PRODUCT_NAME, p.MAIN_IMG ")
                    .append(" FROM REVIEW r ")
                    .append(" JOIN PRODUCTS p ON r.PRODUCT_ID = p.PRODUCT_ID ")
                    .append(" WHERE r.PRODUCT_ID = ? ")
                    .append(" ORDER BY r.CREATED_AT DESC ");

            pstmt = con.prepareStatement(selectQuery.toString());
            pstmt.setInt(1, productId);

            rs = pstmt.executeQuery();

            while(rs.next()) {
                ReviewVO reviewVO = new ReviewVO();  // ReviewVO 객체 생성
                reviewVO.setReviewId(rs.getInt("REVIEW_ID"));
                reviewVO.setUserId(rs.getString("USER_ID"));
                reviewVO.setProductId(rs.getInt("PRODUCT_ID"));
                reviewVO.setContent(rs.getString("CONTENT"));
                reviewVO.setRating(rs.getInt("RATING"));
                reviewVO.setCreatedAt(rs.getDate("CREATED_AT"));

                list.add(reviewVO);
            }
        } finally {
            dbCon.dbClose(rs, pstmt, con);
        }

        return list;
    }

}