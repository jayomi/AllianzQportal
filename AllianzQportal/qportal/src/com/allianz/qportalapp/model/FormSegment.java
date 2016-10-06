package com.allianz.qportalapp.model;

public class FormSegment {
	
	private int formId;
	private int segmentId;
	private String segmentName;
	private String segmentDescription;
	private int order;
	
	public FormSegment(String segmentName,
			String segmentDescription,int formId) {
		super();
		this.formId = formId;		
		this.segmentName = segmentName;
		this.segmentDescription = segmentDescription;
	}
	
	

	public FormSegment(int segmentId,String segmentName,
			String segmentDescription) {
		super();
		this.segmentId = segmentId;
		this.segmentName = segmentName;
		this.segmentDescription = segmentDescription;
		
	}

	public FormSegment(String segmentName,int order,String segmentDescription) {
		super();		
		this.segmentName = segmentName;
		this.segmentDescription = segmentDescription;
		this.order = order;
	}

	

	/*public void formSegment(int formId, String segmentName, String segmentDescription) {
	
		this.formId = formId;
		this.segmentName = segmentName;
		this.segmentDescription = segmentDescription;
	}*/



	public FormSegment(String segmentName, String segmentDescription) {
		super();
		this.segmentName = segmentName;
		this.segmentDescription = segmentDescription;
	}



	public int getFormId() {
		return formId;
	}

	public void setFormId(int formId) {
		this.formId = formId;
	}

	public int getSegmentId() {
		return segmentId;
	}

	public void setSegmentId(int segmentId) {
		this.segmentId = segmentId;
	}

	public String getSegmentName() {
		return segmentName;
	}

	public void setSegmentName(String segmentName) {
		this.segmentName = segmentName;
	}

	public String getSegmentDescription() {
		return segmentDescription;
	}

	public void setSegmentDescription(String segmentDescription) {
		this.segmentDescription = segmentDescription;
	}



	public int getOrder() {
		return order;
	}



	public void setOrder(int order) {
		this.order = order;
	}
	
	
	
	
	
}
