package com.mall.service.impl;

import com.mall.entity.Menu;
import com.mall.mapper.MenuMapper;
import com.mall.service.MenuService;
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
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements MenuService {

    @Override
    public List<String> selectPermsByUserId(Long userId) {
        return baseMapper.selectPermsByUserId(userId);
    }
}
