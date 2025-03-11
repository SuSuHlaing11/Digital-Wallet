package com.bank.model;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Admin {
    private int a_id;
    private String username;
    private String email;
    private long phone;
    private String password;
    private String profilePicture;

    // Constructors
    public Admin() {}
    public Admin(int a_id, String username, String email, long phone, String password, String profilePicture) {
        this.a_id = a_id;
        this.username = username;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.profilePicture = profilePicture;
    }

   

    public Admin(String username, String email, long phone, String password,String profilePicture) {
        this.username = username;
        this.email = email;
        this.phone = phone;
        this.password = hashPassword(password); 
        this.profilePicture = profilePicture; 
    }
    public Admin(String username, String email, long phone, String password) {
        this(username, email, phone, password, null); // Calls the above constructor
    }
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString(); // Return the hashed password
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) { this.profilePicture = profilePicture; }

    // Getters and setters
    public String getPassword() {
        return password;
    }

    // Getters and Setters
    public int getA_id() {
        return a_id;
    }

    public void setA_id(int a_id) {
        this.a_id = a_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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

   
    public void setPassword(String password) {
        this.password = password;
    }
}
