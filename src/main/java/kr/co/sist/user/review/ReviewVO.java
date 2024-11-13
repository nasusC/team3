package kr.co.sist.user.review;

import java.sql.Date;

/**
 * @author : S.H.CHA
 */
public class ReviewVO {
    private int reviewId;        // REVIEW_ID
    private String userId;       // USER_ID
    private int productId;       // PRODUCT_ID
    private String content;      // CONTENT
    private Date createdAt;      // CREATED_AT
    private int rating;          // RATING

    private String reviewImg;

    public String getReviewImg() {
        return reviewImg;
    }

    public void setReviewImg(String reviewImg) {
        this.reviewImg = reviewImg;
    }
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
}