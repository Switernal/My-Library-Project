package com.example.library.mapper;


import com.example.library.domain.User;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;

@Repository
public interface UserMapper {

    @Insert("INSERT INTO UserInfo(UserName,Email,`Password`,Phone) VALUES(#{username},#{email},#{password},#{phone})")
    int saveUser(@Param("username") String username, @Param("password") String password, @Param("email") String email, @Param("phone") String phone);
    @Select("SELECT UserName,Password,Email,Phone FROM UserInfo WHERE Phone=#{phone}")
    User selectUser(@Param("phone") String phone) ;
}
