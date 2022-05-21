package com.mall.controller;

import com.mall.base.ResultVo;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 404 异常处理
 * Springboot 404 问题默认会转到 /error
 */
@RestController
public class errorController implements ErrorController {

    @RequestMapping("/error")
    public ResultVo handlerError(){
        return ResultVo.error().code(404).message("接口不存在");
    }

}
