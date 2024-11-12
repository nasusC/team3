package kr.co.sist.user.temp;

public class SearchVO {
	private int strartNum, endNum, currentPage, totalPage, 
				totalCount;
	private String keyword, url;
	
	
	public SearchVO() {
	}
	public SearchVO(int strartNum, int endNum, int currentPage, int totalPage, int totalCount, String keyword,
			String url) {
		this.strartNum = strartNum;
		this.endNum = endNum;
		this.currentPage = currentPage;
		this.totalPage = totalPage;
		this.totalCount = totalCount;
		this.keyword = keyword;
		this.url = url;
	}
	public int getStrartNum() {
		return strartNum;
	}
	public void setStrartNum(int strartNum) {
		this.strartNum = strartNum;
	}
	public int getEndNum() {
		return endNum;
	}
	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}

	
}
