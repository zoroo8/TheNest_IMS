package com.ims.model;

import java.util.Date;

public class StaffRequestViewModel {
    private int requestId;
    private String department;
    private Date date;
    private int itemCount;
    private String status;
    private String notes;

    // Getters and Setters
    public int getRequestId() { return requestId; }
    public void setRequestId(int requestId) { this.requestId = requestId; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public int getItemCount() { return itemCount; }
    public void setItemCount(int itemCount) { this.itemCount = itemCount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public String getStatusClass() {
        if (status == null) return "default";
        String lowerStatus = status.toLowerCase();
        if (lowerStatus.contains("pending")) return "pending";
        if (lowerStatus.contains("approved")) return "approved";
        if (lowerStatus.contains("rejected")) return "rejected";
        if (lowerStatus.contains("dispatched")) return "dispatched"; // Assuming "dispatched" is a status
        if (lowerStatus.contains("completed")) return "completed"; // Example, if "completed" is a status
        return lowerStatus;
    }
}