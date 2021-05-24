package com.example.library.controller;

import com.example.library.domain.User;
import com.example.library.mapper.UserMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;

@Slf4j
@RequestMapping("user")
@RestController
public class UserController {

    @Autowired
    private UserMapper userMapper;

    @RequestMapping("login")
    public User login(String password,String phone){

        User user = userMapper.selectUser(phone);
        if(user==null){
            return new User(-1,null,null,null,null);
        }
        if(Objects.equals(password,user.getPassword())){
            user.setStatus(1);
            return user;
        }
        return new User(0,null,null,null,null);
    }

    @RequestMapping("register")
    public String register(String username,String password,String email,String phone){
        log.info("username{}",username);
        log.info("password{}",password);
        log.info("email{}",email);
        log.info("phone{}",phone);

        if(StringUtils.isEmpty(username)){
            return "用户名不能为空";
        }
        if(StringUtils.isEmpty(password)){
            return "密码不能为空";
        }
        if(StringUtils.isEmpty(email)){
            return "邮箱不能为空";
        }
        if(StringUtils.isEmpty(phone)){
            return "手机号不能为空";
        }
        User user = userMapper.selectUser(phone);
        if(user != null){
            return "注册失败，用户已存在";
        }

        int resultCount=userMapper.saveUser(username,password,email,phone);
        if(resultCount == 0){
            return "注册失败";
        }


        return "注册成功";
    }


}
