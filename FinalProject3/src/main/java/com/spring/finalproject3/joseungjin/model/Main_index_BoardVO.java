package com.spring.finalproject3.joseungjin.model;

public class Main_index_BoardVO {
	private String seq;          // 글번호 
	private String fk_perno;	 // 사람번호(학번,교수번호,관리자번호?)
    private String subject;      // 글제목
    private String content;      // 글내용 
    private String files;		 // 파일
    private String categoryno;	 // 카테고리번호(1:자유,2:중고,3:모집)
    private String good;		 // 좋아요
    private String readCount;    // 글조회수
    private String regDate;      // 글쓴시간
    private String status;       // 글삭제여부   1:사용가능한 글,  0:삭제된글
    private String commentCount; // 댓글수 
    private String namecheck;     // 익명선택여부( 0: 익명아님, 1:익명)
	
    public Main_index_BoardVO() {}
    
    private String name; 
    
    public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
    public Main_index_BoardVO(String seq, String fk_perno, String subject, String content, String files, String categoryno,
			String good, String readCount, String regDate, String status, String commentCount, String namecheck) {
		super();
		this.seq = seq;
		this.fk_perno = fk_perno;
		this.subject = subject;
		this.content = content;
		this.files = files;
		this.categoryno = categoryno;
		this.good = good;
		this.readCount = readCount;
		this.regDate = regDate;
		this.status = status;
		this.commentCount = commentCount;
		this.namecheck = namecheck;
	}
    
    public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getFk_perno() {
		return fk_perno;
	}
	public void setFk_perno(String fk_perno) {
		this.fk_perno = fk_perno;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFiles() {
		return files;
	}
	public void setFiles(String files) {
		this.files = files;
	}
	public String getCategoryno() {
		return categoryno;
	}
	public void setCategoryno(String categoryno) {
		this.categoryno = categoryno;
	}
	public String getGood() {
		return good;
	}
	public void setGood(String good) {
		this.good = good;
	}
	public String getReadCount() {
		return readCount;
	}
	public void setReadCount(String readCount) {
		this.readCount = readCount;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(String commentCount) {
		this.commentCount = commentCount;
	}
	public String getNamecheck() {
		return namecheck;
	}
	public void setNamecheck(String namecheck) {
		this.namecheck = namecheck;
	}
}
