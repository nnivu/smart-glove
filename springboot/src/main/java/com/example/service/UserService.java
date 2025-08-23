package com.example.service;

import cn.hutool.core.util.StrUtil;
import com.example.entity.Account;
import com.example.entity.User;
import com.example.exception.CustomerException;
import com.example.mapper.UserMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 普通用户服务层实现类
 * 处理普通用户相关的核心业务逻辑，包括数据验证、业务规则处理等
 * 事务控制也在此层进行管理
 */
@Service
public class UserService {

    // 注入数据访问层对象，用于数据库操作
    @Resource
    UserMapper userMapper;

    /**
     * 添加新普通用户
     * 包含账号查重、默认密码设置等业务逻辑
     * @param user 普通用户实体对象
     * @throws CustomerException 当账号已存在时抛出异常
     */
    public void add(User user) {
        // 账号唯一性校验
        User dbUser = userMapper.selectByUsername(user.getUsername());
        if (dbUser != null) {
            throw new CustomerException("账号已存在，请更换用户名");
        }

        // 若未设置密码，使用默认密码
        if(StrUtil.isBlank(user.getPassword())){
            user.setPassword("123456"); // 实际项目中建议使用加密存储
        }

        // 若未设置昵称，默认使用账号
        if(StrUtil.isBlank(user.getName())){
            user.setName(user.getName());
        }

        user.setRole("user");
        // 执行插入操作
        userMapper.insert(user);
    }

    /**
     * 更新普通用户信息
     * @param user 包含更新信息的普通用户实体（必须包含ID）
     * @throws CustomerException 当普通用户不存在时抛出异常
     */
    public void update(User user) {
        // 验证普通用户是否存在
        User existingUser = userMapper.selectById(user.getId());
        if (existingUser == null) {
            throw new CustomerException("普通用户不存在，无法更新");
        }

        // 执行更新操作
        userMapper.updateById(user);
    }

    /**
     * 根据ID删除普通用户
     * @param id 普通用户ID
     * @throws CustomerException 当普通用户不存在时抛出异常
     */
    public void deleteById(Integer id) {
        // 验证普通用户是否存在
        User user = userMapper.selectById(id);
        if (user == null) {
            throw new CustomerException("普通用户不存在，无法删除");
        }

        // 执行删除操作
        userMapper.deleteById(id);
    }

    /**
     * 批量删除普通用户
     * 使用事务al注解保证事务一致性，确保所有删除操作要么全部成功，要么全部失败
     * @param list 包含待删除普通用户ID的列表
     */
    @Transactional
    public void deleteBatch(List<User> list) {
        if (list == null || list.isEmpty()) {
            throw new CustomerException("请选择要删除的普通用户");
        }

        for (User user : list) {
            // 调用已有的删除方法，复用验证逻辑
            this.deleteById(user.getId());
        }
    }

    /**
     * 根据名称查询普通用户信息
     * @param name 普通用户名称
     * @return 普通用户实体对象
     * @throws CustomerException 当普通用户不存在或名称为空时抛出异常
     */
    public User getUserByName(String name) {
        // 参数校验
        if (StrUtil.isBlank(name)) {
            throw new CustomerException("普通用户名称不能为空");
        }

        // 从数据库查询普通用户信息
        User user = userMapper.selectByUsername(name);

        // 验证查询结果
        if (user == null) {
            throw new CustomerException("普通用户不存在");
        }

        // 返回查询到的普通用户对象（实际项目中可考虑返回DTO，隐藏敏感字段）
        return user;
    }

    /**
     * 查询所有普通用户信息
     * @return 普通用户列表
     */
    public List<User> selectAll() {
        return userMapper.selectAll(null);
    }

    /**
     * 分页查询普通用户信息
     * @param pageNum 页码（从1开始）
     * @param pageSize 每页条数
     * @param user 查询条件对象
     * @return 分页查询结果（包含数据列表和分页信息）
     */
    public PageInfo<User> selectPage(Integer pageNum, Integer pageSize, User user) {
        // 参数校验
        if (pageNum == null || pageNum < 1) {
            pageNum = 1;
        }
        if (pageSize == null || pageSize < 1 || pageSize > 100) {
            pageSize = 10; // 限制最大每页条数，防止查询过大
        }

        // 开启分页并执行查询
        PageHelper.startPage(pageNum, pageSize);
        List<User> list = userMapper.selectAll(user);
        return PageInfo.of(list);
    }

    public User login(Account account) {
        // 根据用户名查询数据库
        User dbUser = userMapper.selectByUsername(account.getUsername());

        // 验证账号是否存在
        if (dbUser == null) {
            throw new CustomerException("账号不存在");
        }

        // 验证密码是否正确
        if (!dbUser.getPassword().equals(account.getPassword())) {
            throw new CustomerException("账号或密码错误");
        }

        // 登录成功，返回普通用户信息（实际项目中可移除敏感字段）
        return dbUser;
    }

    public void register(User user) {
        this.add(user);
    }
}
