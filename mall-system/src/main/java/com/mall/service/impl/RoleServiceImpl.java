package com.mall.service.impl;

import com.mall.base.GlobalException;
import com.mall.base.ResultCode;
import com.mall.entity.Role;
import com.mall.entity.RoleMenu;
import com.mall.mapper.RoleMapper;
import com.mall.service.RoleMenuService;
import com.mall.service.RoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author zlf
 * @since 2022-04-16
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    @Autowired
    RoleMenuService roleMenuService;

    @Override
    public List<com.mall.domain.Role> selectRolesByUserId(Long userId) {
        return baseMapper.selectRolesByUserId(userId);
    }

    @Override
    public boolean checkRoleNameUnique(Role role) {
        com.mall.domain.Role r = baseMapper.checkRoleNameUnique(role.getRoleName());
        Long rid = r.getRoleId() == null ? -1l : r.getRoleId();
        if (r != null && rid != role.getRoleId()) {
            return false;
        }
        return true;
    }

    @Override
    public boolean checkRoleKeyUnique(Role role) {
        com.mall.domain.Role r = baseMapper.checkRoleKeyUnique(role.getRoleKey());
        Long rid = r.getRoleId() == null ? -1l : r.getRoleId();
        if (r != null && rid != role.getRoleId()) {
            return false;
        }
        return true;

    }

    @Override
    public void checkRoleAllowed(Role role) {
        if (role != null && "admin".equals(role.getRoleKey())) {
            throw new GlobalException("不允许操作超级管理员角色", ResultCode.ERROR.getCode());
        }
    }

    @Override
    public int update(Role role) {
        // 删除角色与资源的关系
        roleMenuService.deleteRoleMenuByRoleId(role.getRoleId());
        // 添加角色与资源的关系
        insertRoleMenu(role);
        return baseMapper.updateById(role);
    }

    @Override
    public int delete(Long roleId) {
        // 删除角色与资源的依赖
        roleMenuService.deleteRoleMenuByRoleId(roleId);
        return baseMapper.deleteById(roleId);
    }

    @Override
    public com.mall.domain.Role findByRoleId(Long roleId) {

        return baseMapper.findByRoleId(roleId);
    }

    @Override
    public void assignPermission(Long roleId, Long[] menuIds) {
        // 删除角色与资源的依赖
        roleMenuService.deleteRoleMenuByRoleId(roleId);
        insertRoleMenu(roleId, menuIds);
    }

    public void insertRoleMenu(Role role) {
        ArrayList<RoleMenu> list = new ArrayList<>();
        for (Long id : role.getMenuIds()) {
            RoleMenu roleMenu = new RoleMenu();
            roleMenu.setMenuId(id);
            roleMenu.setRoleId(role.getRoleId());
            list.add(roleMenu);
        }
        if (list.size() > 0) {
            roleMenuService.batchRoleMenu(list);
        }
    }

    public void insertRoleMenu(Long roleId, Long[] menuIds) {
        ArrayList<RoleMenu> list = new ArrayList<>();
        for (Long id : menuIds) {
            RoleMenu roleMenu = new RoleMenu();
            roleMenu.setMenuId(id);
            roleMenu.setRoleId(roleId);
            list.add(roleMenu);
        }
        if (list.size() > 0) {
            roleMenuService.batchRoleMenu(list);
        }
    }
}
