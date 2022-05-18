package com.mall.service;

import com.mall.entity.RoleMenu;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author zlf
 * @since 2022-04-16
 */
public interface RoleMenuService extends IService<RoleMenu> {

    int deleteRoleMenuByRoleId(Long roleId);

    int batchRoleMenu(List<RoleMenu> list);
}
