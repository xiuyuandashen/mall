package com.mall.components;


import com.alibaba.fastjson.JSON;
import com.mall.api.RemoteUserService;
import com.mall.base.GlobalException;
import com.mall.base.ResultCode;
import com.mall.base.ResultVo;
import com.mall.model.loginUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: zlf
 * @Date: 2021/03/30/23:38
 * @Description:
 */
@Component
public class MyUserDetailsService implements UserDetailsService {

    @Autowired
    RemoteUserService remoteUserService;



    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        ResultVo resultVo = remoteUserService.userInfo(username);
        Object o = resultVo.getData().get("user");
        String json = JSON.toJSONString(o);
        loginUser userVo = JSON.parseObject(json, loginUser.class);
        if(userVo == null) throw new GlobalException("用户名错误", ResultCode.ERROR.getCode());
        List<GrantedAuthority> authorityList = new ArrayList<>();
        /* 此处查询数据库得到角色权限列表，这里可以用Redis缓存以增加查询速度 */
        Set<String> permissions = userVo.getPermissions();
        for (String perm:
             permissions) {
            authorityList.add(new SimpleGrantedAuthority(perm));
        }
        //authorityList.add(new SimpleGrantedAuthority(role.getRoleName()));
        return new org.springframework.security.core.userdetails.User(username,  new BCryptPasswordEncoder().encode(userVo.getSysUser().getPassword()), authorityList);
    }
}
