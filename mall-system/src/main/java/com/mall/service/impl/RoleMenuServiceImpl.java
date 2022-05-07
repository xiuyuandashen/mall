package com.mall.service.impl;

import com.mall.entity.RoleMenu;
import com.mall.mapper.RoleMenuMapper;
import com.mall.service.RoleMenuService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author zlf
 * @since 2022-04-16
 */
@Service
public class RoleMenuServiceImpl extends ServiceImpl<RoleMenuMapper, RoleMenu> implements RoleMenuService {

    @Override
    public int deleteRoleMenuByRoleId(Long roleId) {

        return baseMapper.deleteRoleMenuByRoleId(roleId);
    }

    @Override
    public int batchRoleMenu(List<RoleMenu> list) {
        return baseMapper.batchRoleMenu(list);
    }
}
