package dto;

public class Paging {
	private int currentPage;
	private int rowPerPage;
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) { 
		this.currentPage = currentPage;
	}
	public int getRowPerPage() {
		return rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	
	public int getBeginRow() {
		return (this.currentPage - 1) * this.rowPerPage;
	}
	
	public int getLastPage(int totalRow) { // (매개변수) -> 매개변수에 전달된 값으로 메소드 내부 코드 실행
		int lastPage = totalRow / this.rowPerPage;
		if(totalRow % this.rowPerPage != 0) {
			lastPage = lastPage + 1;
		}
		return lastPage;
	}
}
