package com.mall.service.impl;

import com.mall.entity.Role;
import com.mall.mapper.RoleMapper;
import com.mall.service.RoleService;
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
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    @Override
    public List<com.mall.domain.Role> selectRolesByUserId(Long userId) {
        return baseMapper.selectRolesByUserId(userId);
    }
}
