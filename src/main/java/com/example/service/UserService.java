package com.example.service;

import cn.hutool.core.util.StrUtil;
import com.example.entity.Account;
import com.example.entity.User;
import com.example.exception.BusinessException;
import com.example.mapper.UserMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.security.crypto.bcrypt.BCrypt;
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

    // 注入JWT工具类（替换原有硬编码Token生成逻辑）
    @Resource
    TokenUtils tokenUtils;

    /**
     * 添加新普通用户
     * 核心修改：
     * 1. 密码BCrypt加密存储（默认密码也加密）
     * 2. 修复昵称默认值赋值错误
     * @param user 普通用户实体对象
     * @throws BusinessException 当账号已存在时抛出异常
     */
    public void add(User user) {
        // 账号唯一性校验
        User dbUser = userMapper.selectByUsername(user.getUsername());
        if (dbUser != null) {
            throw new BusinessException("账号已存在，请更换用户名");
        }

        // 新增：固定盐值强度为10（兼容所有BCrypt版本）
        int saltRounds = 10;
        String salt = BCrypt.gensalt(saltRounds);

        // 密码加密逻辑（用固定盐值）
        if(StrUtil.isBlank(user.getPassword())){
            String defaultPwd = "123456";
            String encryptDefaultPwd = BCrypt.hashpw(defaultPwd, salt);
            System.out.println("【注册日志】用户名：" + user.getUsername() + "，默认密码加密后：" + encryptDefaultPwd);
            user.setPassword(encryptDefaultPwd);
        } else {
            // 清洗密码（去空格）
            String cleanPwd = StrUtil.trim(user.getPassword());
            String encryptPwd = BCrypt.hashpw(cleanPwd, salt);
            System.out.println("【注册日志】用户名：" + user.getUsername() + "，明文密码：" + cleanPwd + "，加密后：" + encryptPwd);
            user.setPassword(encryptPwd);
        }

        // 原有逻辑：昵称兜底
        if(StrUtil.isBlank(user.getName())){
            user.setName(user.getUsername());
        }
        user.setRole("user");
        userMapper.insert(user);
    }

    /**
     * 更新普通用户信息
     * 扩展：若更新密码，自动加密；未更新则沿用原加密密码
     * @param user 包含更新信息的普通用户实体（必须包含ID）
     * @throws BusinessException 当普通用户不存在时抛出异常
     */
    public void update(User user) {
        // 验证普通用户是否存在
        User existingUser = userMapper.selectById(user.getId());
        if (existingUser == null) {
            throw new BusinessException("普通用户不存在，无法更新");
        }

        // 若更新了密码，自动加密（核心修改）
        if (StrUtil.isNotBlank(user.getPassword()) && !user.getPassword().equals(existingUser.getPassword())) {
            user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
        } else {
            // 未更新密码，沿用原加密密码（避免覆盖）
            user.setPassword(existingUser.getPassword());
        }

        // 执行更新操作
        userMapper.updateById(user);
    }

    /**
     * 根据ID删除普通用户
     * @param id 普通用户ID
     * @throws BusinessException 当普通用户不存在时抛出异常
     */
    public void deleteById(Integer id) {
        // 验证普通用户是否存在
        User user = userMapper.selectById(id);
        if (user == null) {
            throw new BusinessException("普通用户不存在，无法删除");
        }

        // 执行删除操作
        userMapper.deleteById(id);
    }

    /**
     * 批量删除普通用户
     * 使用Transactional注解保证事务一致性，确保所有删除操作要么全部成功，要么全部失败
     * @param list 包含待删除普通用户ID的列表
     */
    @Transactional
    public void deleteBatch(List<User> list) {
        if (list == null || list.isEmpty()) {
            throw new BusinessException("请选择要删除的普通用户");
        }

        for (User user : list) {
            // 调用已有的删除方法，复用验证逻辑
            this.deleteById(user.getId());
        }
    }

    /**
     * 根据名称查询普通用户信息
     * 扩展：隐藏密码敏感字段
     * @param name 普通用户名称
     * @return 普通用户实体对象
     * @throws BusinessException 当普通用户不存在或名称为空时抛出异常
     */
    public User getUserByName(String name) {
        // 参数校验
        if (StrUtil.isBlank(name)) {
            throw new BusinessException("普通用户名称不能为空");
        }

        // 从数据库查询普通用户信息
        User user = userMapper.selectByUsername(name);

        // 验证查询结果
        if (user == null) {
            throw new BusinessException("普通用户不存在");
        }

        // 隐藏敏感字段（核心修改：不返回密码）
        user.setPassword(null);
        return user;
    }

    /**
     * 根据ID查询用户
     * 扩展：隐藏密码敏感字段
     */
    public User selectById(Integer id) {
        User user = userMapper.selectById(id);
        // 隐藏密码字段（核心修改）
        if (user != null) {
            user.setPassword(null);
        }
        return user;
    }

    /**
     * 查询所有普通用户信息
     * 扩展：隐藏所有用户的密码字段
     * @return 普通用户列表
     */
    public List<User> selectAll() {
        List<User> userList = userMapper.selectAll(null);
        // 隐藏密码字段（核心修改）
        userList.forEach(user -> user.setPassword(null));
        return userList;
    }

    /**
     * 分页查询普通用户信息
     * 扩展：隐藏密码字段
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
        // 隐藏密码字段（核心修改）
        list.forEach(item -> item.setPassword(null));
        return PageInfo.of(list);
    }

    /**
     * 普通用户登录方法
     * 核心修改：
     * 1. 改用BCrypt验证密码（适配加密存储）
     * 2. 改用固定秘钥生成Token（不再用密码作为签名）
     * 3. 隐藏返回的密码字段
     * 4. 增加参数校验
     * @param account 登录账号信息
     * @return 登录成功的用户信息（含Token）
     */
    public User login(Account account) {
        // 参数校验+清洗
        String username = StrUtil.trim(account.getUsername());
        String password = StrUtil.trim(account.getPassword());
        if (StrUtil.isBlank(username) || StrUtil.isBlank(password)) {
            throw new BusinessException("账号或密码不能为空");
        }

        // 查询用户
        User dbUser = userMapper.selectByUsername(username);
        if (dbUser == null) {
            throw new BusinessException("账号不存在");
        }

        // 核心：直接校验，日志精准
        boolean isMatch = BCrypt.checkpw(password, dbUser.getPassword());
        System.out.println("【登录日志】用户名：" + username);
        System.out.println("【登录日志】明文密码：" + password);
        System.out.println("【登录日志】数据库密文：" + dbUser.getPassword());
        System.out.println("【登录日志】匹配结果：" + isMatch);

        if (!isMatch) {
            throw new BusinessException("账号或密码错误");
        }

        // 生成Token+隐藏密码
        String token = tokenUtils.createToken(dbUser.getId().toString(), "user");
        dbUser.setToken(token);
        dbUser.setPassword(null);

        return dbUser;
    }

    /**
     * 普通用户注册（复用add方法）
     */
    public void register(User user) {
        this.add(user);
    }

    /**
     * 新增：根据用户名查询用户（供注册查重使用）
     * 适配控制器中的注册用户名查重逻辑
     */
    public User selectByUsername(String username) {
        if (StrUtil.isBlank(username)) {
            return null;
        }
        return userMapper.selectByUsername(username);
    }
}