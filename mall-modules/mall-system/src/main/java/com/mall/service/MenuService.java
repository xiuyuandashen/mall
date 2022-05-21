package com.mall.service;

import com.mall.entity.Menu;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author zlf
 * @since 2022-04-16
 */
public interface MenuService extends IService<Menu> {


    List<String> selectPermsByUserId(Long userId);

    List<Menu> selectMenuByIds(Long[] menuIds);

    /**
     * 递归删除菜单
     * @param menuId
     */
    void removeChildById(Long menuId);

    /**
     * 递归修改状态
     * @param menuId
     * @param status
     */
    void updateStatusChildById(Long menuId,String status);
}
