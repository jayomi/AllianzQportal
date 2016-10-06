package com.allianz.qportalapp.model;

public class ResultForm {
	
	private int formId;
	private String userName;
	private int noOfQuestions;
	private int noOfcorrectAnswer;
	private int noOfunAnswer;
	private int passMark;
	private int turn;
	
	public ResultForm(int formId, String userName, int noOfQuestions,
			int noOfcorrectAnswer, int noOfunAnswer, int passMark,int turn) {
		super();
		this.formId = formId;
		this.userName = userName;
		this.noOfQuestions = noOfQuestions;
		this.noOfcorrectAnswer = noOfcorrectAnswer;
		this.noOfunAnswer = noOfunAnswer;
		this.passMark = passMark;
		this.turn=turn;
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

	public int getNoOfQuestions() {
		return noOfQuestions;
	}

	public void setNoOfQuestions(int noOfQuestions) {
		this.noOfQuestions = noOfQuestions;
	}

	public int getNoOfcorrectAnswer() {
		return noOfcorrectAnswer;
	}

	public void setNoOfcorrectAnswer(int noOfcorrectAnswer) {
		this.noOfcorrectAnswer = noOfcorrectAnswer;
	}

	public int getNoOfunAnswer() {
		return noOfunAnswer;
	}

	public void setNoOfunAnswer(int noOfunAnswer) {
		this.noOfunAnswer = noOfunAnswer;
	}

	public int getPassMark() {
		return passMark;
	}

	public void setPassMark(int passMark) {
		this.passMark = passMark;
	}

	public int getTurn() {
		return turn;
	}

	public void setTurn(int turn) {
		this.turn = turn;
	}
	
	
	
	

}
