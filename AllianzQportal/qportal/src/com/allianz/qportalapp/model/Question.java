package com.allianz.qportalapp.model;

public class Question {
	
	private int segmentId;
	private int questionId;
	private String questionName;
	private String questionType;
	private String hasPreDefineValue;
	private String preAnswers;
	private String correctAnswer;
	private int questionOrder;
	
	
	public Question(int segmentId, int questionId, int questionOrder,String questionName,
			String questionType,String preAnswers,String correctAnswer) {
		super();
		this.segmentId = segmentId;
		this.questionId = questionId;
		this.questionOrder=questionOrder;
		this.questionName = questionName;
		this.questionType = questionType;		
		this.preAnswers = preAnswers;
		this.correctAnswer=correctAnswer;
	}
	
	

	public Question(int segmentId, int questionId,int questionOrder, String questionName,
			String questionType, String preAnswers) {
		super();
		this.segmentId = segmentId;
		this.questionId = questionId;
		this.questionName = questionName;
		this.questionType = questionType;
		this.preAnswers = preAnswers;
		this.questionOrder=questionOrder;
	}



	public Question(int questionId,int questionOrder, String questionName, String questionType,
			String preAnswers, String correctAnswer) {
		super();
		this.questionId = questionId;
		this.questionName = questionName;
		this.questionType = questionType;
		this.preAnswers = preAnswers;
		this.correctAnswer = correctAnswer;
		this.questionOrder=questionOrder;
	}



	public Question(String questionName, String questionType,
			String preAnswers,int segmentId) {
		super();
		this.questionId = segmentId;
		this.questionName = questionName;
		this.questionType = questionType;		
		this.preAnswers = preAnswers;
	}

	

	public Question(int segmentId, String questionName, String questionType,
			String preAnswers) {
		super();
		this.segmentId = segmentId;
		this.questionName = questionName;
		this.questionType = questionType;		
		this.preAnswers = preAnswers;
	}
	

	public int getSegmentId() {
		return segmentId;
	}

	public void setSegmentId(int segmentId) {
		this.segmentId = segmentId;
	}

	public int getQuestionId() {
		return questionId;
	}

	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}

	public String getQuestionName() {
		return questionName;
	}

	public void setQuestionName(String questionName) {
		this.questionName = questionName;
	}

	public String getQuestionType() {
		return questionType;
	}

	public void setQuestionType(String questionType) {
		this.questionType = questionType;
	}

	

	public String getPreAnswers() {
		return preAnswers;
	}

	public void setPreAnswers(String preAnswers) {
		this.preAnswers = preAnswers;
	}



	public String getCorrectAnswer() {
		return correctAnswer;
	}



	public void setCorrectAnswer(String correctAnswer) {
		this.correctAnswer = correctAnswer;
	}



	public String getHasPreDefineValue() {
		return hasPreDefineValue;
	}



	public void setHasPreDefineValue(String hasPreDefineValue) {
		this.hasPreDefineValue = hasPreDefineValue;
	}



	public int getQuestionOrder() {
		return questionOrder;
	}



	public void setQuestionOrder(int questionOrder) {
		this.questionOrder = questionOrder;
	}
	
	

}
