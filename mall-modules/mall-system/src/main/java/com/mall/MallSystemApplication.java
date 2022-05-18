package com.mall;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication(scanBasePackages = "com.mall")
@MapperScan("com.mall.mapper")
@EnableFeignClients(basePackages = "com.mall")
public class MallSystemApplication {

    public static void main(String[] args) {
        SpringApplication.run(MallSystemApplication.class,args);
    }
}
