package com.mall2.components;

import cn.hutool.json.JSONUtil;
import com.mall.base.ResultVo;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @Description: 当未登录或者token失效访问接口时，自定义的返回结果
 * @Author: zlf
 * @Date: 2021/3/30
 */
@Component
public class RestAuthenticationEntryPoint implements AuthenticationEntryPoint {
        @Override
        public void commence(HttpServletRequest request, HttpServletResponse response,
                        AuthenticationException authException) throws IOException, ServletException {
                response.setContentType("application/json;Charset=UTF-8");
                response.getWriter().println(JSONUtil.parse(ResultVo.error().code(50014).message("token过期或未登录！")));
                response.getWriter().flush();
        }
}
