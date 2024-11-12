package kr.co.sist.user.temp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class UserReviewDAO {
	private static UserReviewDAO urDAO;
	
	private UserReviewDAO() {
		
	}
	
	public static UserReviewDAO getInstance() {
		if(urDAO == null) {
			urDAO=new UserReviewDAO();
			
		}//end if
		
		return urDAO;
	}//getInstance
	
	public int insertReview(ReviewVO rVO) throws SQLException{
		int rowCnt=0;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		
		DbConnection dbCon=DbConnection.getInstance();
		
		try {
			//connection얻기
			con = dbCon.getConn("192.168.10.225", "project1", "tiger");
			//쿼리문 생성 객체 얻기
			StringBuilder insertReview=new StringBuilder();
			insertReview
			.append("	insert into review(review_id, user_id, product_id, content, rating, review_img)	")
			.append("	values(review_seq.nextval, ?, ?, ?, ?, ?)	");
			
			pstmt=con.prepareStatement(insertReview.toString());
			
			// 바인드변수 값 설정 - 디버깅 추가
	        System.out.println("Setting parameters for review insert:");
	        System.out.println("userId: " + rVO.getUserId());
	        System.out.println("productId: " + rVO.getPrdNum());
	        System.out.println("content: " + rVO.getContent());
	        System.out.println("rating: " + rVO.getRating());
	        System.out.println("reviewImg: " + rVO.getReviewImg());
			
			
			//바인드변수 값 설정
			pstmt.setString(1, rVO.getUserId());
			pstmt.setInt(2, rVO.getPrdNum());
			pstmt.setString(3, rVO.getContent());
			pstmt.setInt(4, rVO.getRating());
			pstmt.setString(5, rVO.getReviewImg());
			
			//쿼리문 수행 후 결과얻기
			rowCnt=pstmt.executeUpdate();
			System.out.println("Insert result rowCnt: " + rowCnt);
						
		}finally {
			dbCon.dbClose(null, pstmt, con);
		}//end finally
		
		return rowCnt;
	}//insertReview
	
	
	
	
}
