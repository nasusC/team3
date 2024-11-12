package kr.co.sist.user.temp;

public class NoticeVO {
	private int noticeId, categoryId, hits;
	private String title, createdAt, content, category;
	
	public NoticeVO(int noticeId, int categoryId, int hits, String title, String createdAt, String content,
			String category) {
		this.noticeId = noticeId;
		this.categoryId = categoryId;
		this.hits = hits;
		this.title = title;
		this.createdAt = createdAt;
		this.content = content;
		this.category = category;
	}

	public NoticeVO() {
	}
	
	
	public int getHits() {
		return hits;
	}
	public void setHits(int hits) {
		this.hits = hits;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getNoticeId() {
		return noticeId;
	}
	public void setNoticeId(int noticeId) {
		this.noticeId = noticeId;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
}
