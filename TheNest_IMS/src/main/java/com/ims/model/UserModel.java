package com.ims.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class UserModel {
    private int userId;
    private String firstName;
    private String lastName;
    private String phoneNumber;
    private LocalDate dob;
    private String gender;
    private String email;
    private String address;
    private String role;
    private String department;
    private String profilePicture;
    private String password;
    private LocalDateTime createdAt;
    private LocalDateTime lastLogin;

    // Constructor without userId, createdAt, lastLogin
    public UserModel(String firstName, String lastName, String phoneNumber, LocalDate dob, String gender,
            String email, String address, String role, String department, String profilePicture,
            String password) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.phoneNumber = phoneNumber;
		this.dob = dob;
		this.gender = gender;
		this.email = email;
		this.address = address;
		this.role = role;
		this.department = department;
		this.profilePicture = profilePicture;
		this.password = password;
		}
    
    public UserModel(int userId, String firstName, String lastName, String email, String role) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.role = role;
    }

	public UserModel(int int1, String string, String string2, String string3, String string4, String string5, Date date,
			String string6, String string7, String string8, String string9, String string10, Timestamp timestamp,
			Timestamp timestamp2) {
		// TODO Auto-generated constructor stub
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public LocalDate getDob() {
		return dob;
	}

	public void setDob(LocalDate dob) {
		this.dob = dob;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getDepartment() {
		return department;
	}

	public void setDepartment(String department) {
		this.department = department;
	}

	public String getProfilePicture() {
		return profilePicture;
	}

	public void setProfilePicture(String profilePicture) {
		this.profilePicture = profilePicture;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public LocalDateTime getLastLogin() {
		return lastLogin;
	}

	public void setLastLogin(LocalDateTime lastLogin) {
		this.lastLogin = lastLogin;
	}
	
    
}
