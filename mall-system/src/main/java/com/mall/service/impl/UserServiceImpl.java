package com.mall.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.mall.base.GlobalException;
import com.mall.base.ResultCode;
import com.mall.domain.User;
import com.mall.entity.UserRole;
import com.mall.mapper.UserMapper;
import com.mall.mapper.UserRoleMapper;
import com.mall.service.UserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.AutoConfigurationPackage;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Arrays;
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
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Autowired
    UserRoleMapper userRoleMapper;

    @Override
    public int countByUserName(String userName) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_name", userName);
        return count(queryWrapper);
    }

    @Override
    public int deleteUserByIds(Long[] userIds) {
        // 需要删除用户与角色的依赖
        return baseMapper.deleteBatchIds(Arrays.asList(userIds));
    }

    @Override
    public void insertUserAuth(Long userId, Long[] roleIds) {
        userRoleMapper.deleteUserRoleByUserId(userId);
        insertUserRole(userId, roleIds);
    }

    @Override
    public User selectUserByUserName(String username) {
        return baseMapper.selectUserByUserName(username);
    }

    @Override
    public void checkUserAllowed(User sysUser) {
        if (sysUser.getUserId() != null && sysUser.getUserId() == 1L) {
            throw new GlobalException("不允许操作超级管理员用户", ResultCode.ERROR.getCode());
        }
    }

    @Override
    public boolean checkPhoneUnique(User user) {
        User info = baseMapper.checkPhoneUnique(user.getPhonenumber());
        Long id = user.getUserId() == null ? -1L : user.getUserId();
        // 不唯一
        if (info != null && id.longValue() != info.getUserId().longValue()) {
            return false;
        }
        return true;
    }

    @Override
    public boolean checkEmailUnique(User sysUser) {
        User info = baseMapper.checkEmailUnique(sysUser.getEmail());
        Long id = sysUser.getUserId() == null ? -1L : sysUser.getUserId();
        if (info != null && id.longValue() != id.longValue()) {
            return false;
        }
        return true;
    }

    @Override
    public int updateUser(User user) {
        Long userId = user.getUserId();
        // 删除角色与用户的关系
        userRoleMapper.deleteUserRoleByUserId(userId);
        // 添加角色与用户的关系
        insertUserRole(userId,user.getRoleIds());

        return baseMapper.updateUser(user);
    }

    @Override
    public int resetPwd(User user) {
        return baseMapper.updateUser(user);
    }

    @Override
    public int changeStatus(User user) {
        return baseMapper.updateUser(user);
    }

    @Override
    public User selecUserByUserId(Long userId) {
        return null;
    }

    @Override
    public User getUserByUserId(Long userId) {
        return baseMapper.getUserByUserId(userId);
    }

    public void insertUserRole(Long userId, Long[] roleIds) {
        if (!StringUtils.isEmpty(roleIds)) {
            // 新增用户与角色管理
            List<UserRole> list = new ArrayList<UserRole>();
            for (Long roleId : roleIds) {
                UserRole ur = new UserRole();
                ur.setUserId(userId);
                ur.setRoleId(roleId);
                list.add(ur);
            }
            if (list.size() > 0) {
                userRoleMapper.batchUserRole(list);
            }
        }
    }
}
