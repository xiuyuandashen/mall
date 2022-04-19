package com.mall.controller;


import com.mall.base.ResultVo;
import com.mall.entity.Role;
import com.mall.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author zlf
 * @since 2022-04-16
 */
@RestController
@RequestMapping("/mall/role")
public class RoleController {

    @Autowired
    RoleService roleService;

    public ResultVo add(@RequestBody Role role){


        boolean r = roleService.save(role);
        if(!r) return ResultVo.error().message("添加角色失败!");
        return ResultVo.ok();
    }
}

