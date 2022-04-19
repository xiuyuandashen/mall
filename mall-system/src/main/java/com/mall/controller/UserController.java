package com.mall.controller;


import com.mall.base.ResultVo;
import com.mall.domain.*;
import com.mall.model.loginUser;
import com.mall.service.MenuService;
import com.mall.service.UserService;
import com.sun.tracing.dtrace.ProviderAttributes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.HashSet;
import java.util.List;

/**
 * <p>
 *  前端控制器
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

    @PostMapping("/register")
    public ResultVo register(@RequestBody User user){

        String userName = user.getUserName();
        if(userService.countByUserName(userName) > 0){
            return ResultVo.error().message("注冊失敗，注冊用戶已存在!");
        }
        boolean r = userService.save(user);
        if(!r) return ResultVo.error().message("注冊失敗");
        return ResultVo.ok();
    }


    @PreAuthorize("hasAnyAuthority('system','system:user:delete')")
    @DeleteMapping("/delete")
    public ResultVo remove(@RequestParam("userIds") Long [] userIds){
        int r =  userService.deleteUserByIds(userIds);
        if(r < 1) return ResultVo.error().message("删除失败");
        return ResultVo.ok();
    }

    /**
     * 授权角色
     * @return
     */
    @PreAuthorize("hasAuthority('system:user:auth')")
    @PutMapping("/authRole")
    public ResultVo insertAuthRole(Long userId,Long roleIds[]){

        userService.insertUserAuth(userId, roleIds);
        return ResultVo.ok();
    }

    @GetMapping("/info/{username}")
    public ResultVo userInfo(@PathVariable("username") String username){
        User user =  userService.selectUserByUserName(username);
        loginUser  resultUser = new loginUser();
        resultUser.setSysUser(user);
        List<String> perms = menuService.selectPermsByUserId(user.getUserId());
        resultUser.setPermissions(new HashSet<>(perms));

        return ResultVo.ok().data("user",resultUser);
    }

    @PreAuthorize("hasAnyAuthority('system:user:edit')")
    @PutMapping
    public ResultVo edit(User sysUser){

        return ResultVo.ok();
    }

}

