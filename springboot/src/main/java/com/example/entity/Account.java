package com.example.entity;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class Account {
    private Integer id;
    private String username;
    private String password;
    private String name;
    private String phone;
    private String email;
    private String role;
    private String token;

}