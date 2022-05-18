package com.mall.mapper;

import com.mall.entity.UserRole;
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
public interface UserRoleMapper extends BaseMapper<UserRole> {

    void deleteUserRoleByUserId(Long userId);

    void batchUserRole(List<UserRole> list);
}
