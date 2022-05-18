package com.mall.service;

import com.mall.api.*;
import com.baomidou.mybatisplus.extension.service.IService;
import com.mall.domain.User;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zlf
 * @since 2022-04-16
 */
public interface UserService extends IService<User> {

    int countByUserName(String userName);

    int deleteUserByIds(Long[] userIds);

    void insertUserAuth(Long userId, Long[] roleIds);

    User selectUserByUserName(String username);

    void checkUserAllowed(User sysUser);

    boolean checkPhoneUnique(User user);

    /**
     * 验证email是否唯一
     * @param sysUser
     * @return
     */
    boolean checkEmailUnique(User sysUser);

    int updateUser(User sysUser);

    int resetPwd(User user);

    int changeStatus(User user);

    User selecUserByUserId(Long userId);

    User getUserByUserId(Long userId);
}
