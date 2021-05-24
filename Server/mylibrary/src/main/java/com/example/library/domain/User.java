package com.example.library.domain;


import lombok.Data;

@Data
public class User {

    private String username;
    private String password;
    private String email;
    private String phone;
    private int status;

    public User(int status,String username,String password,String email,String phone){
        this.status = status;
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
    }
    public User(){}

}
