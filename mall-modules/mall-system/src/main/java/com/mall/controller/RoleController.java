package com.mall.controller;

import com.mall.base.ResultVo;
import com.mall.entity.Role;
import com.mall.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.security.Principal;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author zlf
 * @since 2022-04-16
 */
@RestController
@RequestMapping("/mall/system/role")
public class RoleController {

    @Autowired
    RoleService roleService;

    /**
     * 添加角色
     * 
     * @param role
     * @param principal
     * @return
     */
    @PreAuthorize("hasAnyAuthority('system','system:role:add')")
    @PostMapping
    public ResultVo add(@RequestBody Role role, Principal principal) {
        String roleName = role.getRoleName();
        if (roleName != null && roleName.trim().length() > 0 && !roleService.checkRoleNameUnique(role)) {
            return ResultVo.error().message("角色名称已存在");
        }
        String roleKey = role.getRoleKey();
        if (roleKey != null && roleKey.trim().length() > 0 && !roleService.checkRoleKeyUnique(role)) {
            return ResultVo.error().message("角色权限字符串已存在");
        }
        role.setCreateBy(principal.getName());
        boolean r = roleService.save(role);
        if (!r)
            return ResultVo.error().message("添加角色失败!");
        return ResultVo.ok().message("添加成功");
    }

    /**
     * 修改角色
     * 
     * @param role
     * @param principal
     * @return
     */
    @PreAuthorize("hasAnyAuthority('system','system:role:edit')")
    @PutMapping
    public ResultVo edit(@Valid @RequestBody Role role, Principal principal) {
        // 判断是否是管理员角色，管理员角色不可修改
        roleService.checkRoleAllowed(role);
        String roleName = role.getRoleName();
        if (roleName != null && roleName.trim().length() > 0 && !roleService.checkRoleNameUnique(role)) {
            return ResultVo.error().message("角色名称已存在");
        }
        String roleKey = role.getRoleKey();
        if (roleKey != null && roleKey.trim().length() > 0 && !roleService.checkRoleKeyUnique(role)) {
            return ResultVo.error().message("角色权限字符串已存在");
        }
        role.setUpdateBy(principal.getName());
        roleService.update(role);
        return ResultVo.ok().message("保存成功");
    }

    /**
     * 删除角色
     * 
     * @param roleId
     * @return
     */
    @PreAuthorize("hasAnyAuthority('system','system:role:delete')")
    @DeleteMapping("/{roleId}")
    public ResultVo delete(@PathVariable("roleId") Long roleId) {
        roleService.delete(roleId);
        return ResultVo.ok().message("删除成功");
    }

    /**
     * 根据RoleId查询角色信息
     * 
     * @param roleId
     * @return
     */
    @GetMapping("/{roleId}")
    public ResultVo findByRoleId(@PathVariable("roleId") Long roleId) {
        com.mall.domain.Role role = roleService.findByRoleId(roleId);
        return ResultVo.ok().data("item", role);
    }

    /**
     * 分配权限
     * 
     * @param roleId
     * @param menuIds
     * @return
     */
    @PreAuthorize("hasAnyAuthority('system','system:role:permission')")
    @PostMapping("/permission")
    public ResultVo assignPermission(@RequestParam("roleId") Long roleId, @RequestParam("menuIds") Long[] menuIds) {
        roleService.assignPermission(roleId, menuIds);
        return ResultVo.ok().message("分配成功");

    }
}
