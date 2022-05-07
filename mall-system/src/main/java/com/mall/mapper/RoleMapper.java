package com.mall.mapper;

import com.mall.entity.Role;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author zlf
 * @since 2022-04-16
 */
@Repository
public interface RoleMapper extends BaseMapper<Role> {

    List<com.mall.domain.Role> selectRolesByUserId(Long userId);

    com.mall.domain.Role checkRoleNameUnique(String roleName);

    com.mall.domain.Role checkRoleKeyUnique(String roleKey);

    com.mall.domain.Role findByRoleId(Long roleId);
}
