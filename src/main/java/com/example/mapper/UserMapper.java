package com.example.mapper;

import com.example.entity.User;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface UserMapper {
    void insert(User user);

    void updateById(User user);

    @Delete("delete from `user` where id = #{id}")
    void deleteById(Integer id);

    List<User> selectAll(User user);

    @Select("select * from `user` where username = #{username}")
    User selectByUsername(String username);

    @Select("select * from `user` where id = #{id}")
    User selectById(Integer id);
}