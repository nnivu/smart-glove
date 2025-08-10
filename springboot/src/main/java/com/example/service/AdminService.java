package com.example.service;

import cn.hutool.core.util.StrUtil;
import com.example.entity.Admin;
import com.example.exception.CustomerException;
import com.example.mapper.AdminMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AdminService {

    @Resource
    AdminMapper adminMapper;
    //增加数据
    public void add(Admin admin) {
        //账号查重
        Admin dbadmin = adminMapper.selectByUsername(admin.getUsername());
        if (dbadmin != null) {
            throw new CustomerException("账号重复");
        }
        //默认密码
        if(StrUtil.isBlank(admin.getPassword())){
            admin.setPassword("123456");
        }
        adminMapper.insert(admin);
    }

    //修改数据
    public void update(Admin admin) {
        adminMapper.updateById(admin);
    }

    //删除数据
    public void deleteById(Integer id) {
        adminMapper.deleteById(id);
    }

    //查找数据
    public String admin(String name) {
        if ("admin".equals(name)) {
            return "admin";
        } else {
            throw new CustomerException("账号错误");
        }
    }

    public List<Admin> selectAll() {
        return adminMapper.selectAll(null);
    }

    // 开启分页查询
    public PageInfo<Admin> selectPage(Integer pageNum, Integer pageSize, Admin admin) {
        PageHelper.startPage(pageNum, pageSize);
        List<Admin> list = adminMapper.selectAll(admin);
        return PageInfo.of(list);
    }


}