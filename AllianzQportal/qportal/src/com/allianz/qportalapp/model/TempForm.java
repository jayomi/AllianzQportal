package com.allianz.qportalapp.model;

public class TempForm {
	
	//private int formId;
	private String formName;
	private String formDescription;
	private String formDuration;
	private int segmentId;
	private String segmentTile;
	private String segmentDescription;
	private int questionId;
	private String question;
	private String questionType;
	private String hasPredefine;
	private String predefineValues;
	
	public TempForm(String formName, String formDescription, int segmentId,
			String segmentTile, String segmentDescription, int questionId,
			String question, String questionType, String hasPredefine,
			String predefineValues) {
		super();
		this.formName = formName;
		this.formDescription = formDescription;
		this.segmentId = segmentId;
		this.segmentTile = segmentTile;
		this.segmentDescription = segmentDescription;
		this.questionId = questionId;
		this.question = question;
		this.questionType = questionType;
		this.hasPredefine = hasPredefine;
		this.predefineValues = predefineValues;
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

	public int getSegmentId() {
		return segmentId;
	}

	public void setSegmentId(int segmentId) {
		this.segmentId = segmentId;
	}

	public String getSegmentTile() {
		return segmentTile;
	}

	public void setSegmentTile(String segmentTile) {
		this.segmentTile = segmentTile;
	}

	public String getSegmentDescription() {
		return segmentDescription;
	}

	public void setSegmentDescription(String segmentDescription) {
		this.segmentDescription = segmentDescription;
	}

	public int getQuestionId() {
		return questionId;
	}

	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getQuestionType() {
		return questionType;
	}

	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}

	public String getHasPredefine() {
		return hasPredefine;
	}

	public void setHasPredefine(String hasPredefine) {
		this.hasPredefine = hasPredefine;
	}

	public String getPredefineValues() {
		return predefineValues;
	}

	public void setPredefineValues(String predefineValues) {
		this.predefineValues = predefineValues;
	}
	
}
