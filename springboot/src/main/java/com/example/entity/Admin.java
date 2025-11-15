package com.example.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * 管理员信息
 */
public class Admin extends Account{
    @Setter
    @Getter
    private Integer id;
    @Setter
    @Getter
    private String username;
    @Setter
    @Getter
    private String password;
    @Setter
    @Getter
    private String name;
    @Setter
    @Getter
    private String phone;
    @Setter
    @Getter
    private String email;
    @Setter
    @Getter
    private String role;
    private String token;

    @Override
    public String getToken() {return token;}

    @Override
    public void setToken(String token) {this.token = token;}

}