package model1.board;

public class BoardDTO {
	//멤버변수 : board 테이블에 생성된 컬럼과 동일하게 선언
    private String num;
    private String title;
    private String content;
    private String id;
    private java.sql.Date postdate;
    private String visitcount;
    /* member테이블과의 join을 통해 회원 이름을 출력해야 할때를 위해
    멤버변수를 추가한다. */
    private String name;
    
    private String tname;

    //파일첨부형 테이블 
    private String pass;
	private String ofile;
	private String sfile;
	private int downcount; //다운로드 카운트 int형
	private String virtualNum ;
    
    //특별한 이유가 없다면 생성자는 선언하지 않는다. 

    //getter/setter 메서드 
    public String getNum() {
        return num;
    }
    public void setNum(String num) {
        this.num = num;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public java.sql.Date getPostdate() {
        return postdate;
    }
    public void setPostdate(java.sql.Date postdate) {
        this.postdate = postdate;
    }
    public String getVisitcount() {
        return visitcount;
    }
    public void setVisitcount(String visitcount) {
        this.visitcount = visitcount;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getOfile() {
		return ofile;
	}
	public void setOfile(String ofile) {
		this.ofile = ofile;
	}
	public String getSfile() {
		return sfile;
	}
	public void setSfile(String sfile) {
		this.sfile = sfile;
	}
	public int getDowncount() {
		return downcount;
	}
	public void setDowncount(int downcount) {
		this.downcount = downcount;
	}
	public String getVirtualNum() {
		return virtualNum;
	}
	public void setVirtualNum(String virtualNum) {
		this.virtualNum = virtualNum;
	}
    
    
}
