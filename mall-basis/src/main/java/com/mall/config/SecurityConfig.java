package com.mall.config;


import com.mall.components.JwtAuthenticationTokenFilter;
import com.mall.components.MyUserDetailsService;
import com.mall.components.RestAuthenticationEntryPoint;
import com.mall.components.RestfulAccessDeniedHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: zlf
 * @Date: 2021/03/30/20:45
 * @Description:
 */
@EnableWebSecurity
//  @EnableGlobalMethodSecurity 注解生效 @PreAuthorize
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {


    @Bean(name = "encoder")
    public BCryptPasswordEncoder getEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Autowired
    private MyUserDetailsService userDetailsService;

    @Autowired
    private RestfulAccessDeniedHandler restfulAccessDeniedHandler;
    @Autowired
    private RestAuthenticationEntryPoint restAuthenticationEntryPoint;

    @Autowired
    private JwtAuthenticationTokenFilter jwtAuthenticationTokenFilter;


    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {
        httpSecurity.csrf()// 由于使用的是JWT，我们这里不需要csrf
                .disable()
                .sessionManagement()// 基于token，所以不需要session
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .authorizeRequests()
                .antMatchers(HttpMethod.GET, // 允许对于网站静态资源的无授权访问
                        "/",
                        "/*.html",
                        "/favicon.ico",
                        "/**/*.html",
                        "/**/*.css",
                        "/**/*.js",
                        "/swagger-resources/**",
                        "/v2/api-docs/**"
                )
                .permitAll()
                .antMatchers(

                        "/mall/auth/login",
                        "/mall/system/user/info/**"
//                        "/mall/system/user/register"
//                        "/mall/user/**"
                )// 对登录注册要允许匿名访问
                .permitAll()
                .antMatchers(HttpMethod.OPTIONS)//跨域请求会先进行一次options请求
                .permitAll()
//                .antMatchers("/**")//测试时全部运行访问
//                .permitAll()
                .anyRequest()
                .permitAll();
        // 不需要 authenticated 也行 因为 @PreAuthorize 可以拦截 所以我全部放行 这样没有使用@PreAuthorize的的接口无需登录和权限即可访问
        // 除上面外的所有请求全部需要鉴权认证
//                .authenticated();
        // 禁用缓存
        httpSecurity.headers().cacheControl();
        // 添加JWT filter
        httpSecurity.addFilterBefore(jwtAuthenticationTokenFilter, UsernamePasswordAuthenticationFilter.class);
        //添加自定义未授权和未登录结果返回
        httpSecurity.exceptionHandling()
                .accessDeniedHandler(restfulAccessDeniedHandler)
                .authenticationEntryPoint(restAuthenticationEntryPoint);
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService)
                .passwordEncoder(new BCryptPasswordEncoder());
    }


    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }
}

