package com.ims.model;

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
    private String lastLoginFormatted; 

    public UserModel() { 
    }

    // Constructor for creating a new user (from form)
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

    // Constructor based on the first screenshot (typically for loading from DB)
    public UserModel(int userId, String firstName, String lastName, String email, String role, 
                     java.sql.Date dob, String gender, String password, String address, 
                     String department, java.sql.Timestamp createdAt, java.sql.Timestamp lastLogin) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.role = role;
        if (dob != null) {
            this.dob = dob.toLocalDate();
        }
        this.gender = gender;
        this.password = password; 
        this.address = address;
        this.department = department;
        if (createdAt != null) {
            this.createdAt = createdAt.toLocalDateTime();
        }
        if (lastLogin != null) {
            this.lastLogin = lastLogin.toLocalDateTime();
        }
    }

    // Constructor based on the second screenshot (possibly for login or partial load)
    public UserModel(int userId, String firstName, String lastName, String email, String role) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.role = role;
    }

    // NEW CONSTRUCTOR based on the latest screenshot for getUserById
    public UserModel(int userId, String firstName, String lastName, String email, String role,
                     String phoneNumber, java.sql.Date dob, String gender, String address,
                     String department, String profilePicture, String password,
                     java.sql.Timestamp createdAt, java.sql.Timestamp lastLogin) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.role = role;
        this.phoneNumber = phoneNumber;
        if (dob != null) {
            this.dob = dob.toLocalDate();
        }
        this.gender = gender;
        this.address = address;
        this.department = department;
        this.profilePicture = profilePicture;
        this.password = password; // Storing password hash from DB
        if (createdAt != null) {
            this.createdAt = createdAt.toLocalDateTime();
        }
        if (lastLogin != null) {
            this.lastLogin = lastLogin.toLocalDateTime();
        }
    }


    // Getters and Setters for all fields

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
    
    public void setDob(java.sql.Date dob) {
        if (dob != null) {
            this.dob = dob.toLocalDate();
        } else {
            this.dob = null;
        }
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }


    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
    
    public void setCreatedAt(java.sql.Timestamp createdAt) {
        if (createdAt != null) {
            this.createdAt = createdAt.toLocalDateTime();
        } else {
            this.createdAt = null;
        }
    }


    public LocalDateTime getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(LocalDateTime lastLogin) {
        this.lastLogin = lastLogin;
    }

    public void setLastLogin(java.sql.Timestamp lastLogin) {
        if (lastLogin != null) {
            this.lastLogin = lastLogin.toLocalDateTime();
        } else {
            this.lastLogin = null;
        }
    }

    public String getLastLoginFormatted() {
        return lastLoginFormatted;
    }

    public void setLastLoginFormatted(String lastLoginFormatted) {
        this.lastLoginFormatted = lastLoginFormatted;
    }
}