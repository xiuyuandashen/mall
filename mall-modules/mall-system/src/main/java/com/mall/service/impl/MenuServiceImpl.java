package com.mall.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.mall.entity.Menu;
import com.mall.mapper.MenuMapper;
import com.mall.mapper.RoleMenuMapper;
import com.mall.service.MenuService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
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
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements MenuService {

    private static Logger logger = LoggerFactory.getLogger(MenuServiceImpl.class);

    @Autowired
    private RoleMenuMapper roleMenuMapper;

    @Override
    public List<String> selectPermsByUserId(Long userId) {
        return baseMapper.selectPermsByUserId(userId);
    }

    @Override
    public List<Menu> selectMenuByIds(Long[] menuIds) {
        return baseMapper.selectListByIds(menuIds);
    }

    /**
     * 删除菜单
     * @param menuId
     */
    @Transactional
    @Override
    public void removeChildById(Long menuId) {
        List<Long> idList = new ArrayList<>();
        // 获取所有子节点
        this.selectChildListById(menuId, idList);
        // 添加本身
        idList.add(menuId);
        // 删除menu与role的依赖
        roleMenuMapper.deleteRoleMenuByMenuIds(idList);
        // 删除menu
        baseMapper.deleteBatchIds(idList);
    }

    /**
     * 递归修改状态
     * @param menuId
     * @param status
     */
    @Transactional
    @Override
    public void updateStatusChildById(Long menuId,String status){
        List<Long> idList = new ArrayList<>();
        // 获取所有子节点
        this.selectChildListById(menuId, idList,status.equals("0")?"1":"0");
        idList.add(menuId);
        // 删除menu与role的依赖
        if("1".equals(status))
            roleMenuMapper.deleteRoleMenuByMenuIds(idList);
        // 修改状态
        baseMapper.updateStatusIds(idList,status);
    }

    /**
     * 递归获取子节点
     *
     * @param menuId
     * @param idList
     */
    private void selectChildListById(Long menuId, List<Long> idList) {
        // 获取 parentId 为 menuId的节点
        QueryWrapper<Menu> queryWrapper = new QueryWrapper<>();
        // 仅返回menuId
        queryWrapper.eq("parent_id", menuId).eq("status","0").select("menu_id");
        List<Menu> menus = baseMapper.selectList(queryWrapper);
        menus.forEach(item -> {
            idList.add(item.getMenuId());
            // 递归添加该节点的子节点
            selectChildListById(item.getMenuId(), idList);
        });
    }

    /**
     * 递归查询节点扁平化
     * @param menuId
     * @param idList
     * @param status
     */
    private void selectChildListById(Long menuId, List<Long> idList,String status) {
        // 获取 parentId 为 menuId的节点
        QueryWrapper<Menu> queryWrapper = new QueryWrapper<>();
        // 仅返回menuId
        queryWrapper.eq("parent_id", menuId).eq("status",status).select("menu_id");
        List<Menu> menus = baseMapper.selectList(queryWrapper);
        menus.forEach(item -> {
            idList.add(item.getMenuId());
            // 递归添加该节点的子节点
            selectChildListById(item.getMenuId(), idList);
        });
    }
}
