package kr.co.sist.user.temp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class OrderDAO {

	private static OrderDAO oDAO;
	
	private OrderDAO() {
		
	}
	
	public static OrderDAO getInstance() {
		if(oDAO == null) {
			oDAO=new OrderDAO();
			
		}//end if
		return oDAO;
	}//getInstance
	
	
	/**
	 * userId에 해당하는 주문목록을 조회하는 method
	 * @param userId
	 * @return
	 * @throws SQLException
	 */
	public List<OrderListVO> SelectOrderList(String userId) throws SQLException{
		List<OrderListVO> list=new ArrayList<OrderListVO>();
		Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    DbConnection dbCon = DbConnection.getInstance();

	    try {
	        con = dbCon.getConn("192.168.10.225", "project1", "tiger");

	        StringBuilder select = new StringBuilder();
	        select
	        .append("	select 	o.order_id, d.status as shippingstatus, p.name as productname, p.main_img as imgname	")
	        .append("	from 	orders o	")
	        .append("	join 	delivery d on o.user_id = d.user_id	")
	        .append("	join 	ordered_product op on o.order_id = op.order_id	")
	        .append("	join 	products p on op.product_id = p.product_id	")
	        .append("	where 	o.user_id = ?	");
	        
	        pstmt = con.prepareStatement(select.toString());
	        pstmt.setString(1, userId);

	        rs = pstmt.executeQuery();
	        
	        OrderListVO olVO=null;
	        while (rs.next()) {
	            // 결과가 있을 경우 olVO 객체에 데이터 설정
	            olVO = new OrderListVO();
	            olVO.setOrderId(rs.getInt("order_id"));
	            olVO.setShippingStatus(rs.getString("shippingstatus"));
	            olVO.setProductName(rs.getString("productname"));
	            olVO.setImgName(rs.getString("imgname"));
	            list.add(olVO);
	        }//while
	    } finally {
	        dbCon.dbClose(rs, pstmt, con);
	    }//end finally
		
		return list;
	}//SelectShippingByOrderId
	
	public int updateOrderStatus(String orderId, String orderStatus)throws SQLException{
		int rowCnt=0;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		try {
			//connection얻기
			con = dbCon.getConn("192.168.10.225", "project1", "tiger");
			//쿼리문 생성 객체 얻기
			StringBuilder updateBoard=new StringBuilder();
			updateBoard
			.append("	update 	orders	")
			.append("	set 	order_status=?	")
			.append("	where 	order_id=?	");
			
			pstmt=con.prepareStatement(updateBoard.toString());
			//바인드변수 값 설정
			pstmt.setString(1, orderStatus);
			pstmt.setString(2, orderId);
			
			//쿼리문 수행 후 결과얻기
			rowCnt=pstmt.executeUpdate();
						
		}finally {
			dbCon.dbClose(null, pstmt, con);
		}//end finally
		
		return rowCnt;
	}//updateBoard
	
	/**
	 * 리뷰작성 process페이지에서 사용하기 위한 product_id를 구하는 메소드
	 * @param orderId
	 * @return
	 * @throws SQLException
	 */
	public int selectProductId(String orderId) throws SQLException {
	    int productId = 0;
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    DbConnection dbCon = DbConnection.getInstance();
	    
	    try {
	        con = dbCon.getConn("192.168.10.225", "project1", "tiger");
	        
	        StringBuilder selectProductId = new StringBuilder();
	        selectProductId
	            .append(" select op.product_id ")
	            .append(" from orders o ")
	            .append(" join ordered_product op on o.order_id = op.order_id ")
	            .append(" where o.order_id = ? ");
	            
	        pstmt = con.prepareStatement(selectProductId.toString());
	        pstmt.setString(1, orderId);
	        
	        rs = pstmt.executeQuery();
	        
	        if(rs.next()) {
	            productId = rs.getInt("product_id");
	        }//end if
	        
	    } finally {
	        dbCon.dbClose(rs, pstmt, con);
	    }//end finally
	    return productId;
	}//selectProductId
	
	public int insertCancelReason(String orderId, String reason) throws SQLException {
	    int rowCnt = 0;
	    
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    
	    DbConnection dbCon = DbConnection.getInstance();
	    
	    try {
	        con = dbCon.getConn("192.168.10.225", "project1", "tiger");
	        
	        StringBuilder insertCancel = new StringBuilder();
	        insertCancel
	            .append("	insert 	into order_cancel(order_id, reason) ")
	            .append("	values	(?, ?) ");
	            
	        pstmt = con.prepareStatement(insertCancel.toString());
	        
	        pstmt.setString(1, orderId);
	        pstmt.setString(2, reason);
	        
	        rowCnt = pstmt.executeUpdate();
	        
	    } finally {
	        dbCon.dbClose(null, pstmt, con);
	    }//end finally
	    
	    return rowCnt;
	}//insertCancelReason
	
}
