package com.allianz.qportalapp.model;

import java.util.Date;

public class DepartmentForm {
	
	private int id;
	private int formId;
	private String formName;
	private String department;
	private Date startDate;
	private Date endDate;
	
	
	public DepartmentForm(int id,int formId, String formName, String department) {
		super();
		this.id = id;
		this.formId = formId;
		this.formName = formName;
		this.department = department;
	}
	
	
	
	public DepartmentForm(int id, int formId, String formName,
			String department, Date startDate, Date endDate) {
		super();
		this.id = id;
		this.formId = formId;
		this.formName = formName;
		this.department = department;
		this.startDate = startDate;
		this.endDate = endDate;
		
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
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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
	
	
	

}
