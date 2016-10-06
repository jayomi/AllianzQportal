package com.allianz.qportalapp.model;

public class Department {
	
	private int id;
	private String departmentName;
	private String description;
	
	
	public Department(String departmentName) {
		super();
		this.departmentName = departmentName;
	}
	
	

	public Department(String departmentName, String description) {
		super();
		this.departmentName = departmentName;
		this.description = description;
	}
	
	

	public Department(int id, String departmentName, String description) {
		super();
		this.id = id;
		this.departmentName = departmentName;
		this.description = description;
	}



	public String getDepartmentName() {
		return departmentName;
	}
	
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}



	public String getDescription() {
		return description;
	}



	public void setDescription(String description) {
		this.description = description;
	}



	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}
	
	

}
