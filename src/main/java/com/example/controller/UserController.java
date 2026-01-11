package com.example.controller; // 定义控制器所在的包路径，遵循MVC架构中控制器层的包结构

import com.example.common.Result;
import com.example.entity.User;
import com.example.service.UserService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController // 标识该类为REST风格控制器，所有方法返回数据默认会被转换为JSON格式
@RequestMapping("/user") // 定义基础请求路径，当前控制器所有接口的URL前缀为 /user
public class UserController {

    // 注入UserService接口的实现类对象，由Spring容器自动管理和注入
    // 采用接口编程，降低控制器与具体业务实现的耦合度
    @Resource
    UserService userService;

    /**
     * 根据名称查询管理员信息
     * 处理查询单个或多个管理员的请求，支持模糊查询或精确查询（取决于服务层实现）
     * @param name 管理员名称（通过URL查询参数传递，如：/user?name=user1）
     *             若参数为null或空字符串，可能返回所有管理员或按默认规则查询（取决于服务层实现）
     * @return Result对象，包含查询结果：
     *         - 成功：状态码200，data字段为查询到的管理员信息（字符串格式，可能为JSON字符串）
     *         - 失败：状态码非200，message字段包含错误信息
     */
    @GetMapping("") // 处理HTTP GET请求，完整访问路径为 /user
    public Result getUserByName(String name) {
        // 调用服务层方法执行查询逻辑，控制器不处理具体业务
        User user = userService.getUserByName(name);
        // 使用统一响应工具类封装成功结果，自动设置状态码为200
        return Result.success(user);
    }

    /**
     * 添加新管理员
     * 处理创建新管理员的请求，接收客户端提交的管理员信息并保存到数据库
     * @param user 管理员实体对象，通过请求体（RequestBody）以JSON格式传递
     *              包含管理员的各项属性（如用户名、密码、权限等）
     * @return Result对象，包含操作结果：
     *         - 成功：状态码200，无具体数据（或包含新创建管理员的ID）
     *         - 失败：状态码非200，message字段包含错误信息（如用户名已存在）
     */
    @PostMapping("/add") // 处理HTTP POST请求，完整访问路径为 /user/add
    public Result add(@RequestBody User user) { // @RequestBody注解自动将JSON请求体转换为User对象
        // 调用服务层方法执行添加操作，包含数据验证和数据库插入逻辑
        userService.add(user);
        // 返回成功响应，无数据时可省略参数
        return Result.success();
    }

    /**
     * 更新管理员信息
     * 处理修改已有管理员信息的请求，根据管理员ID更新对应的记录
     * @param user 包含更新信息的管理员实体对象，通过请求体以JSON格式传递
     *              必须包含管理员ID（用于定位要更新的记录）和需要修改的字段
     * @return Result对象，包含操作结果：
     *         - 成功：状态码200
     *         - 失败：状态码非200（如管理员不存在、数据验证失败）
     */
    @PutMapping("/update") // 处理HTTP PUT请求，完整访问路径为 /user/update
    public Result update(@RequestBody User user) { // 接收JSON格式的更新数据
        // 调用服务层方法执行更新操作，包含乐观锁或版本控制（取决于服务层实现）
        userService.update(user);
        return Result.success();
    }

    /**
     * 根据ID删除管理员
     * 处理单个管理员的删除请求，支持逻辑删除（更新状态）或物理删除（从数据库移除）
     * @param id 管理员ID，通过URL路径参数传递（如：/user/delete/1001）
     * @return Result对象，包含操作结果：
     *         - 成功：状态码200
     *         - 失败：状态码非200（如管理员不存在、存在关联数据无法删除）
     */
    @DeleteMapping("/delete/{id}") // 处理HTTP DELETE请求，路径包含动态参数id
    public Result delete(@PathVariable Integer id) { // @PathVariable获取URL路径中的id参数
        // 调用服务层方法执行删除操作
        userService.deleteById(id);
        return Result.success();
    }

    /**
     * 批量删除管理员
     * 处理多个管理员的批量删除请求，提高操作效率
     * @param list 待删除的管理员对象列表，通过请求体以JSON数组格式传递
     *             列表中的每个对象至少包含管理员ID（用于标识要删除的记录）
     * @return Result对象，包含操作结果：
     *         - 成功：状态码200
     *         - 失败：状态码非200（可能部分删除成功，取决于服务层事务处理）
     */
    @DeleteMapping("/deleteBatch") // 处理HTTP DELETE请求，完整路径为 /user/deleteBatch
    public Result deleteBatch(@RequestBody List<User> list) { // 接收JSON数组并转换为List<User>
        // 调用服务层批量删除方法，建议在服务层使用事务保证原子性
        userService.deleteBatch(list);
        return Result.success();
    }

    /**
     * 查询所有管理员信息
     * 处理获取系统中所有管理员列表的请求，通常用于管理员管理页面的列表展示
     * @return Result对象，包含查询结果：
     *         - 成功：状态码200，data字段为List<User>集合
     *         - 失败：状态码非200
     * 注意：当数据量较大时，不建议使用此接口，应采用分页查询
     */
    @GetMapping("/selectAll") // 处理HTTP GET请求，完整路径为 /user/selectAll
    public Result selectAll() {
        // 调用服务层方法查询全部管理员数据
        List<User> userList = userService.selectAll();
        // 将查询到的列表数据放入响应结果
        return Result.success(userList);
    }

    /**
     * 分页查询管理员信息
     * 处理带分页和条件的查询请求，支持按管理员属性筛选并分页返回结果
     * 适用于数据量较大的场景，提高查询效率和前端渲染性能
     * @param pageNum 当前页码，从1开始，默认值为1（当客户端未传递时使用）
     * @param pageSize 每页显示的记录数，默认值为10
     * @param user 可选的查询条件对象，通过请求参数传递（如：/user/selectPage?username=user）
     *              包含的非空字段将作为查询条件（如按用户名、角色等筛选）
     * @return Result对象，包含分页查询结果：
     *         - 成功：状态码200，data字段为分页对象（通常包含列表数据、总条数、总页数等）
     *         - 失败：状态码非200
     */
    @GetMapping("/selectPage") // 处理HTTP GET请求，完整路径为 /user/selectPage
    public Result selectPage(
            @RequestParam(defaultValue = "1") Integer pageNum, // 页码参数，指定默认值
            @RequestParam(defaultValue = "10") Integer pageSize, // 每页条数参数，指定默认值
            @ModelAttribute User user) { // 使用@ModelAttribute接收对象类型的查询参数
        // 调用服务层分页查询方法，返回分页结果对象
        Object pageResult = userService.selectPage(pageNum, pageSize, user);
        // 将分页结果放入响应
        return Result.success(pageResult);
    }
}