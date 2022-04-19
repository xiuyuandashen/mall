package com.mall.mapper;

import com.mall.domain.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.springframework.stereotype.Repository;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author zlf
 * @since 2022-04-16
 */
@Repository
public interface UserMapper extends BaseMapper<User> {

    User selectUserByUserName(String username);
}
