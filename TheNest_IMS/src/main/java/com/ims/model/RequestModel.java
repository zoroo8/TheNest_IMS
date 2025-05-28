package com.ims.model;

import java.sql.Date;

public class RequestModel {
    private int requestId;
    private int requestQty;
    private Date requestDate;
    private String requestStatus;
    private String requestNote;
    
    // Getters and setters
    
	public int getRequestId() {
		return requestId;
	}
	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}
	public int getRequestQty() {
		return requestQty;
	}
	public void setRequestQty(int requestQty) {
		this.requestQty = requestQty;
	}
	public Date getRequestDate() {
		return requestDate;
	}
	public void setRequestDate(Date requestDate) {
		this.requestDate = requestDate;
	}
	public String getRequestStatus() {
		return requestStatus;
	}
	public void setRequestStatus(String requestStatus) {
		this.requestStatus = requestStatus;
	}
	public String getRequestNote() {
		return requestNote;
	}
	public void setRequestNote(String requestNote) {
		this.requestNote = requestNote;
	}
}