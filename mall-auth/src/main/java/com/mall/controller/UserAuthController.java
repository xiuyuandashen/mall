package com.mall.controller;

import com.alibaba.fastjson.JSON;
import com.mall.api.RemoteUserService;
import com.mall.base.ResultVo;
import com.mall.domain.User;
import com.mall.model.loginUser;
import com.mall.utils.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

@RestController
@RequestMapping("/mall/auth")
public class UserAuthController {
    @Autowired
    RemoteUserService remoteUserService;
    @Autowired
    JwtTokenUtil jwtTokenUtil;

    @Value("${jwt.tokenHead}")
    private String tokenHead;

    @GetMapping("/test")
    public ResultVo test(){
        return remoteUserService.test();
    }

    @PostMapping("/login")
    public ResultVo login(@RequestParam("username") String username,@RequestParam("password") String password){
        ResultVo resultVo = remoteUserService.userInfo(username);
        System.out.println(resultVo);
        Object o = resultVo.getData().get("user");
        String json = JSON.toJSONString(o);
        loginUser userVo = JSON.parseObject(json, loginUser.class);
        User user = userVo.getSysUser();
        if(user==null) return ResultVo.error().message("用户名错误");
        if(!password.equals(user.getPassword())) return ResultVo.error().message("密码错误");
        HashMap<String,Object> map = new HashMap<>();
        map.put("username",user.getUserName());
        String token = jwtTokenUtil.generateToken(map);
        return ResultVo.ok().data("token",tokenHead+" "+token);
    }


}
