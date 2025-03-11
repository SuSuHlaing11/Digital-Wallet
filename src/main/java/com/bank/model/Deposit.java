package com.bank.model;

public class Deposit {
    private int accno;
    private double amount;
    private String password;

    public Deposit(int accno, double amount, String password) {
        this.accno = accno;
        this.amount = amount;
        this.password = password;
    }

    public int getAccno() {
        return accno;
    }

    public double getAmount() {
        return amount;
    }

    public String getPassword() {
        return password;
    }
}
