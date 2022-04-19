package com.mall.api;


import com.mall.base.ResultVo;
import com.mall.domain.User;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@FeignClient(value = "mall-system")
public interface RemoteUserService {

    @PostMapping("/mall/system/user/test")
    ResultVo test();


    @GetMapping("/mall/system/user/info/{username}")
    ResultVo userInfo(@PathVariable("username") String username);


}
