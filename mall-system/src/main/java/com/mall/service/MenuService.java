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
}
