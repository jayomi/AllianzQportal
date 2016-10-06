package com.allianz.qportalapp.model;

import java.util.Date;

import javax.servlet.ServletContext;

public class FormType {
	
	private int formId;
	private String formName;
	private String formDescription;
	private String formType;
	private String formAccessType;
	private int passMark;
	private String duration;
	private String department;
	private ServletContext context;
	private int depRowIndex;
	private Date start;
	private Date end;
	
	public FormType() {
		super();
	}	

	public FormType(int formId, String formName, String formDescription,
			String formType,String formAccessType, int passMark, String duration,String department) {
		super();
		this.formId = formId;
		this.formName = formName;
		this.formDescription = formDescription;
		this.formType = formType;
		this.formAccessType = formAccessType;		
		this.passMark = passMark;
		this.duration = duration;
		this.department = department; 
	}

	public FormType(String formName, String formDescription,String formType,String formAccessType,int passMark,String duration,String departments) {
		super();
		this.formName = formName;
		this.formDescription = formDescription;
		this.duration=duration;
		this.passMark=passMark;
		this.formType=formType;
		this.formAccessType = formAccessType;
		this.department = departments;
	}
	
	public FormType(int formId, String formName, String formDescription,
			String formType,String formAccessType, int passMark, String duration) {
		super();
		this.formId = formId;
		this.formName = formName;
		this.formDescription = formDescription;
		this.formType = formType;
		this.formAccessType = formAccessType;		
		this.passMark = passMark;
		this.duration = duration;
		
	}
	
	public FormType(int formId, String formName, String formDescription,
			String formType, String formAccessType, int passMark,
			String duration, int depRowIndex, Date start, Date end) {
		super();
		this.formId = formId;
		this.formName = formName;
		this.formDescription = formDescription;
		this.formType = formType;
		this.formAccessType = formAccessType;
		this.passMark = passMark;
		this.duration = duration;
		this.depRowIndex = depRowIndex;
		this.start = start;
		this.end = end;
	}
	
	

	public FormType(int formId, String formName, String formDescription,
			String formType, String formAccessType, int passMark,
			String duration, int depRowIndex, String department,Date start,
			Date end) {
		super();
		this.formId = formId;
		this.formName = formName;
		this.formDescription = formDescription;
		this.formType = formType;
		this.formAccessType = formAccessType;
		this.passMark = passMark;
		this.duration = duration;
		this.department = department;
		this.depRowIndex = depRowIndex;
		this.start = start;
		this.end = end;
	}

	public int getFormId() {
		return formId;
	}

	public void setFormId(int formId) {
		this.formId = formId;
	}

	public String getFormName() {
		return formName;
	}

	public void setFormName(String formName) {
		this.formName = formName;
	}

	public String getFormDescription() {
		return formDescription;
	}

	public void setFormDescription(String formDescription) {
		this.formDescription = formDescription;
	}



	public String getDuration() {
		return duration;
	}



	public void setDuration(String duration) {
		this.duration = duration;
	}



	public int getPassMark() {
		return passMark;
	}



	public void setPassMark(int passMark) {
		this.passMark = passMark;
	}

	public String getFormType() {
		return formType;
	}

	public void setFormType(String formType) {
		this.formType = formType;
	}

	public String getFormAccessType() {
		return formAccessType;
	}

	public void setFormAccessType(String formAccessType) {
		this.formAccessType = formAccessType;
	}

	
	
	
	public void setServletContext(ServletContext context){
		this.context=context;
	}

	public ServletContext getContext() {
		return context;
	}

	public void setContext(ServletContext context) {
		this.context = context;
	}

	public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	public int getDepRowIndex() {
		return depRowIndex;
	}

	public void setDepRowIndex(int depRowIndex) {
		this.depRowIndex = depRowIndex;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}
	
	
	

}
