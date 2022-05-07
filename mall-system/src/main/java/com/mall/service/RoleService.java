package com.mall.service;

import com.mall.entity.Role;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zlf
 * @since 2022-04-16
 */
public interface RoleService extends IService<Role> {

    List<com.mall.domain.Role> selectRolesByUserId(Long userId);

    boolean checkRoleNameUnique(Role role);

    boolean checkRoleKeyUnique(Role role);

    void checkRoleAllowed(Role role);

    int update(Role role);

    int delete(Long roleId);

    com.mall.domain.Role findByRoleId(Long roleId);

    void assignPermission(Long roleId, Long[] menuIds);
}
