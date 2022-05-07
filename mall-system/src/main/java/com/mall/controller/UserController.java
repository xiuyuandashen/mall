package com.mall.controller;


import com.mall.base.ResultVo;
import com.mall.domain.*;
import com.mall.model.loginUser;
import com.mall.service.MenuService;
import com.mall.service.RoleService;
import com.mall.service.UserService;
import com.sun.tracing.dtrace.ProviderAttributes;
import org.apache.catalina.Pipeline;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.nio.charset.Charset;
import java.security.Principal;
import java.util.HashSet;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author zlf
 * @since 2022-04-16
 */
@RestController
@RequestMapping("/mall/system/user")
public class UserController {


    @Autowired
    UserService userService;
    @Autowired
    MenuService menuService;

    @Autowired
    RoleService roleService;

    @PostMapping("/register")
    public ResultVo register(@Valid @RequestBody User user) {

        String userName = user.getUserName();
        if (userName!=null && userName.trim().length()>0
                && userService.countByUserName(userName) > 0) {
            return ResultVo.error().message("注冊失敗，注冊用戶已存在");
        }
        if(user.getEmail() != null && user.getEmail().trim().length()>0
                && !userService.checkEmailUnique(user)){
            return ResultVo.error().message("邮箱已存在");
        }
        if (user.getPhonenumber() != null && user.getPhonenumber().length()>0
                && !userService.checkPhoneUnique(user)) {
            return ResultVo.error().message("电话号码已存在");
        }
        boolean r = userService.save(user);
        if (!r) return ResultVo.error().message("注冊失敗");
        return ResultVo.ok();
    }


    @PreAuthorize("hasAnyAuthority('system','system:user:delete')")
    @DeleteMapping("/delete")
    public ResultVo remove(@RequestParam("userIds") Long[] userIds) {
        int r = userService.deleteUserByIds(userIds);
        if (r < 1) return ResultVo.error().message("删除失败");
        return ResultVo.ok();
    }

    /**
     * 授权角色
     *
     * @return
     */
    @PreAuthorize("hasAnyAuthority('system:user:auth','system')")
    @PutMapping("/authRole")
    public ResultVo insertAuthRole(Long userId, Long roleIds[]) {
        userService.insertUserAuth(userId, roleIds);
        return ResultVo.ok();
    }

    /**
     * 获取用户信息
     * @param username
     * @return
     */
    @GetMapping("/info/{username}")
    public ResultVo userInfo(@PathVariable("username") String username) {
        User user = userService.selectUserByUserName(username);
        loginUser resultUser = new loginUser();
        resultUser.setSysUser(user);
        List<String> perms = menuService.selectPermsByUserId(user.getUserId());
        resultUser.setPermissions(new HashSet<>(perms));
        return ResultVo.ok().data("user", resultUser);
    }

    /**
     * 修改用户
     *
     * @param sysUser
     * @return
     */
    @PreAuthorize("hasAnyAuthority('system','system:user:edit')")
    @PutMapping
    public ResultVo edit(@RequestBody User sysUser ,  Principal principal) {
        // 判断是否为admin，admin不可修改
        userService.checkUserAllowed(sysUser);
        // 可以判断一下用户是否有权限 比如测试可不可以查询到数据
        if (sysUser.getPhonenumber() != null && sysUser.getPhonenumber().trim().length() > 0
                && !userService.checkPhoneUnique(sysUser)
        ) {
            return ResultVo.error().message("用户电话号码不唯一");
        }
        if (sysUser.getEmail() != null && sysUser.getEmail().trim().length() > 0
                && !userService.checkEmailUnique(sysUser)
        ) {
            return ResultVo.error().message("用户邮箱不唯一");
        }
        sysUser.setUpdateBy(principal.getName());
        userService.updateUser(sysUser);
        return ResultVo.ok();
    }



    /**
     * 重置密码
     * @param user
     * @param principal
     * @return
     */
    @PreAuthorize("hasAnyAuthority('system','system:user:edit')")
    @PutMapping("/resetPwd")
    public ResultVo resetPwd(@RequestBody User user, Principal principal){
        userService.checkUserAllowed(user);
        user.setUpdateBy(principal.getName());
        userService.resetPwd(user);
        return ResultVo.ok().message("重置成功");
    }

    /**
     * 更改用户信息
     * @param user
     * @param principal
     * @return
     */
    @PreAuthorize("hasAnyAuthority('system','system:user:edit')")
    @PutMapping("/changeStatus")
    public ResultVo changeStatus(User user, Principal principal){
        userService.checkUserAllowed(user);
        user.setUpdateBy(principal.getName());
        userService.changeStatus(user);
        return ResultVo.ok().message("修改成功");
    }

    /**
     * 根据用户编号获取授权角色
     * @param userId
     * @return
     */
    @GetMapping("/authRole/{userId}")
    public ResultVo authRole(@PathVariable("userId") Long userId)
    {

        User user = userService.getUserByUserId(userId);
        if(user == null) {
            return ResultVo.error().message("用户不存在");
        }
        // TODO
        List<Role> roles = roleService.selectRolesByUserId(userId);
        return ResultVo.ok().data("roles",roles);
    }
}

