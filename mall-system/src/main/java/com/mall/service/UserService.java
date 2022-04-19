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
}
