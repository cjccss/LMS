package com.spring.finalproject3.joseungjin.model;


public class MainSubjectVO {
	private int subno;          // 과목정보
	private int fk_perno;	 // 사람번호(학번,교수번호,관리자번호?)
    private int fk_colno;      // 단과대학ID
    private String subname;      // 과목명
    private int credit;		 // 학점
    private int semeter;	 // 개설학기
    private String day;		 // 수업요일
    private String time;
    private String name; 	//교수명
    private String fk_majseq;
    
    private String content;
    private String majseq;
    
    public MainSubjectVO() {}
    
    public MainSubjectVO(int subno, int fk_perno, int fk_colno, String subname, 
    					int credit, int semeter,String day,String name,String time,String fk_majseq
    					,String content,String majseq) {
		super();
		this.subno = subno;
		this.fk_perno = fk_perno;
		this.fk_colno = fk_colno;
		this.subname = subname;
		this.credit = credit;
		this.semeter = semeter;
		this.day = day;
		this.name = name;
		this.time = time;
		this.fk_majseq = fk_majseq;
		this.content=content;
		this.majseq=majseq;
	}
    
	public int getSubno() {
		return subno;
	}
	public void setSubno(int subno) {
		this.subno = subno;
	}
	public int getFk_perno() {
		return fk_perno;
	}
	public void setFk_perno(int fk_perno) {
		this.fk_perno = fk_perno;
	}
	public int getFk_colno() {
		return fk_colno;
	}
	public void setFk_colno(int fk_colno) {
		this.fk_colno = fk_colno;
	}
	public String getSubname() {
		return subname;
	}
	public void setSubname(String subname) {
		this.subname = subname;
	}
	public int getCredit() {
		return credit;
	}
	public void setCredit(int credit) {
		this.credit = credit;
	}
	public int getSemeter() {
		return semeter;
	}
	public void setSemeter(int semeter) {
		this.semeter = semeter;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getFk_majseq() {
		return fk_majseq;
	}

	public void setFk_majseq(String fk_majseq) {
		this.fk_majseq = fk_majseq;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMajseq() {
		return majseq;
	}

	public void setMajseq(String majseq) {
		this.majseq = majseq;
	}
	

	
}
