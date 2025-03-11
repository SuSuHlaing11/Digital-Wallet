package com.bank.model;

import java.sql.Date;

public class User {
    private int id;
    private int accno;
    private String fullname;
    private String username;
    private Date dob;
    private String gender;
    private String nrc;
    private String address;
    private String email;
    private long phone;
    private String acctype;
    private String password;
    private int code;
    private String status;
    private String profilePicture;
    private boolean frozen;
    private boolean deleted; 
    
    public User() {
    }

    public User(int id, int accno, String fullname, String username, Date dob, String gender, 
                String nrc, String address, String email, long phone, String acctype, 
                String password, int code, String status, String profilePicture, boolean frozen, boolean deleted) {
        this.id = id;
        this.accno = accno;
        this.fullname = fullname;
        this.username = username;
        this.dob = dob;
        this.gender = gender;
        this.nrc = nrc;
        this.address = address;
        this.email = email;
        this.phone = phone;
        this.acctype = acctype;
        this.password = password;
        this.code = code;
        this.status = status;
        this.profilePicture = profilePicture;
        this.frozen = frozen;
        this.deleted = deleted; 
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccno() {
        return accno;
    }

    public void setAccno(int accno) {
        this.accno = accno;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getNrc() {
        return nrc;
    }

    public void setNrc(String nrc) {
        this.nrc = nrc;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public long getPhone() {
        return phone;
    }

    public void setPhone(long phone) {
        this.phone = phone;
    }

    public String getAcctype() {
        return acctype;
    }

    public void setAcctype(String acctype) {
        this.acctype = acctype;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }
    
    public boolean isFrozen() { 
    	return frozen; 
    }
    
    public void setFrozen(boolean frozen) {
    	this.frozen = frozen; 
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }
}