package shop.faq;

import java.sql.Timestamp;

public class FaQDataBean {
	private int faq_no;
	private String manager_id;
	private String q_kind;
	private String subject;
	private String content;
	private Timestamp reg_date;
	
	// getter
	public int getFaq_no() {
		return faq_no;
	}

	public String getManager_id() {
		return manager_id;
	}
	
	public String getQ_kind() {
		return q_kind;
	}
	
	public String getSubject() {
		return subject;
	}
	
	public String getContent() {
		return content;
	}
	
	public Timestamp getReg_date() {
		return reg_date;
	}
	
	// setter
	public void setFaq_no(int faq_no) {
		this.faq_no = faq_no;
	}
	
	public void setManager_id(String manager_id) {
		this.manager_id = manager_id;
	}
	
	public void setQ_kind(String q_kind) {
		this.q_kind = q_kind;
	}
	
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}	

}
