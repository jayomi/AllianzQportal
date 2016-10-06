package com.allianz.qportalapp.model;

import java.util.Date;

public class SubmitForm {
	
	private int formId;
	private String userName;
	private Date startDate;
	private Date endDate;
	private Date doneDate;
	private int turn;
	private String department;
	private String formName;
	private String description;
	private String formType;
	private String time;
	
	
	public SubmitForm(int formId, String userName, int turn) {
		super();
		this.formId = formId;
		this.userName = userName;
		this.turn = turn;
	}

	public SubmitForm(int formId, String userName,
			Date doneDate, int turn) {
		super();
		this.formId = formId;
		this.userName = userName;
		
		this.doneDate = doneDate;
		this.turn = turn;
	}
	
	public SubmitForm(int formId, String userName, Date startDate,
			Date endDate, int turn, String department) {
		super();
		this.formId = formId;
		this.userName = userName;
		this.startDate = startDate;
		this.endDate = endDate;
		this.turn = turn;
		this.department = department;
	}
	
	
	
	public SubmitForm(int formId, String formName,String description,String formType, int turn,Date doneDate,  
			 String time) {
		super();
		this.formId = formId;
		this.formName = formName;
		this.description = description;
		this.formType = formType;
		this.turn = turn;
		this.doneDate = doneDate;
		this.time = time;
	}

	public int getFormId() {
		return formId;
	}
	public void setFormId(int formId) {
		this.formId = formId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public int getTurn() {
		return turn;
	}
	public void setTurn(int turn) {
		this.turn = turn;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public Date getDoneDate() {
		return doneDate;
	}

	public void setDoneDate(Date doneDate) {
		this.doneDate = doneDate;
	}

	public String getFormName() {
		return formName;
	}

	public void setFormName(String formName) {
		this.formName = formName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getFormType() {
		return formType;
	}

	public void setFormType(String formType) {
		this.formType = formType;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
	
	

}
