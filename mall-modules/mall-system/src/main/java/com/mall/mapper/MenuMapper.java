package com.mall.mapper;

import com.mall.entity.Menu;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
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
public interface MenuMapper extends BaseMapper<Menu> {

    /**
     * 根据用户id获取用户权限
     * @param userId
     * @return
     */
    List<String> selectPermsByUserId(Long userId);

    List<Menu> selectListByIds(Long[] ids);

    int updateStatusIds(@Param("ids") List<Long> ids,@Param("status") String status);
}
