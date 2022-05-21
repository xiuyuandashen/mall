package com.mall.controller;

import com.mall.base.ResultVo;
import com.mall.entity.Menu;
import com.mall.service.MenuService;
import com.mall.utils.MenuTree;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author zlf
 * @since 2022-04-16
 */
@RestController
@RequestMapping("/mall/system/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @GetMapping("/ids")
    public ResultVo findMenuIds(Long[] ids) {
//        List<Long> list = Arrays.stream(ids).collect(Collectors.toList());
        List<Menu> menus = menuService.selectMenuByIds(ids);
        // 转成tree
        MenuTree menuTree = new MenuTree(menus);
        List<Menu> menus1 = menuTree.builTree();
        return ResultVo.ok().data("items", menus1);
    }

    /**
     * 获取所有Menu并生成树结构
     *
     * @return
     */
    @GetMapping("/list")
    public ResultVo selectList() {
        List<Menu> list = menuService.list();
        MenuTree menuTree = new MenuTree(list);
        List<Menu> menus = menuTree.builTree();
        return ResultVo.ok().data("items", menus);
    }

    /**
     * 添加菜单
     *
     * @param menu
     * @return
     */
    @Transactional
    @PreAuthorize("hasAnyAuthority('system','system:menu:add')")
    @PostMapping
    public ResultVo insertMenu(@RequestBody Menu menu) {
        menuService.save(menu);
        return ResultVo.ok();
    }

    /**
     * 删除菜单
     * @param menuId
     * @return
     */
    @PreAuthorize("hasAnyAuthority('system','system:menu:delete')")
    @DeleteMapping("/{menuId}")
    public ResultVo removeById(@PathVariable("menuId") Long menuId) {
        // 递归删除菜单
        menuService.removeChildById(menuId);
        return ResultVo.ok();
    }

    @PutMapping("/status/{menuId}/{status}")
    public ResultVo updateStatusById(@PathVariable("menuId") Long menuId,@PathVariable("status") String status){
        menuService.updateStatusChildById(menuId,status);
        return ResultVo.ok();
    }
}
