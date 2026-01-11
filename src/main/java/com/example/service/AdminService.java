package com.example.service;

import cn.hutool.core.util.StrUtil;
import com.example.entity.Account;
import com.example.entity.Admin;
import com.example.exception.BusinessException;
import com.example.mapper.AdminMapper;
import com.example.utils.TokenUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 管理员服务层实现类
 * 处理管理员相关的核心业务逻辑，包括数据验证、业务规则处理等
 * 事务控制也在此层进行管理
 */
@Service
public class AdminService {

    // 注入数据访问层对象，用于数据库操作
    @Resource
    AdminMapper adminMapper;

    /**
     * 添加新管理员
     * 包含账号查重、默认密码设置等业务逻辑
     * @param admin 管理员实体对象
     * @throws BusinessException 当账号已存在时抛出异常
     */
    public void add(Admin admin) {
        // 账号唯一性校验
        Admin dbAdmin = adminMapper.selectByUsername(admin.getUsername());
        if (dbAdmin != null) {
            throw new BusinessException("账号已存在，请更换用户名");
        }

        // 若未设置密码，使用默认密码
        if(StrUtil.isBlank(admin.getPassword())){
            admin.setPassword("123456"); // 实际项目中建议使用加密存储
        }

        admin.setRole("admin");
        // 执行插入操作
        adminMapper.insert(admin);
    }

    /**
     * 更新管理员信息
     * @param admin 包含更新信息的管理员实体（必须包含ID）
     * @throws BusinessException 当管理员不存在时抛出异常
     */
    public void update(Admin admin) {
        // 验证管理员是否存在
        Admin existingAdmin = adminMapper.selectById(admin.getId());
        if (existingAdmin == null) {
            throw new BusinessException("管理员不存在，无法更新");
        }

        // 执行更新操作
        adminMapper.updateById(admin);
    }

    /**
     * 根据ID删除管理员
     * @param id 管理员ID
     * @throws BusinessException 当管理员不存在时抛出异常
     */
    public void deleteById(Integer id) {
        // 验证管理员是否存在
        Admin admin = adminMapper.selectById(id);
        if (admin == null) {
            throw new BusinessException("管理员不存在，无法删除");
        }

        // 执行删除操作
        adminMapper.deleteById(id);
    }

    /**
     * 批量删除管理员
     * 使用事务al注解保证事务一致性，确保所有删除操作要么全部成功，要么全部失败
     * @param list 包含待删除管理员ID的列表
     */
    @Transactional
    public void deleteBatch(List<Admin> list) {
        if (list == null || list.isEmpty()) {
            throw new BusinessException("请选择要删除的管理员");
        }

        for (Admin admin : list) {
            // 调用已有的删除方法，复用验证逻辑
            this.deleteById(admin.getId());
        }
    }

    /**
     * 根据名称查询管理员信息
     * @param name 管理员名称
     * @return 管理员实体对象
     * @throws BusinessException 当管理员不存在或名称为空时抛出异常
     */
    public Admin getAdminByName(String name) {
        // 参数校验
        if (StrUtil.isBlank(name)) {
            throw new BusinessException("管理员名称不能为空");
        }

        // 从数据库查询管理员信息
        Admin admin = adminMapper.selectByUsername(name);

        // 验证查询结果
        if (admin == null) {
            throw new BusinessException("管理员不存在");
        }

        // 返回查询到的管理员对象（实际项目中可考虑返回DTO，隐藏敏感字段）
        return admin;
    }

    public Admin selectById(Integer id) {
        return adminMapper.selectById(id);
    }

    /**
     * 查询所有管理员信息
     * @return 管理员列表
     */
    public List<Admin> selectAll() {
        return adminMapper.selectAll(null);
    }

    /**
     * 分页查询管理员信息
     * @param pageNum 页码（从1开始）
     * @param pageSize 每页条数
     * @param admin 查询条件对象
     * @return 分页查询结果（包含数据列表和分页信息）
     */
    public PageInfo<Admin> selectPage(Integer pageNum, Integer pageSize, Admin admin) {
        // 参数校验
        if (pageNum == null || pageNum < 1) {
            pageNum = 1;
        }
        if (pageSize == null || pageSize < 1 || pageSize > 100) {
            pageSize = 10; // 限制最大每页条数，防止查询过大
        }

        // 开启分页并执行查询
        PageHelper.startPage(pageNum, pageSize);
        List<Admin> list = adminMapper.selectAll(admin);
        return PageInfo.of(list);
    }

    public Admin login(Account account) {
        // 根据用户名查询数据库
        Admin dbAdmin = adminMapper.selectByUsername(account.getUsername());

        // 验证账号是否存在
        if (dbAdmin == null) {
            throw new BusinessException("账号不存在");
        }

        // 验证密码是否正确
        if (!dbAdmin.getPassword().equals(account.getPassword())) {
            throw new BusinessException("账号或密码错误");
        }

        //创建token并返回给前端
        String token = TokenUtils.createToken(dbAdmin.getId()+"-"+"Admin",dbAdmin.getPassword());
        dbAdmin.setToken(token);
        // 登录成功，返回管理员信息（实际项目中可移除敏感字段）
        return dbAdmin;
    }

}
