package com.mall.base;

import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import javax.validation.ConstraintViolationException;
import java.util.Objects;

/**
 * Created with IntelliJ IDEA.
 *
 * @Auther: zlf
 * @Date: 2021/11/05/17:58
 * @Description:
 */
@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    @ExceptionHandler(GlobalException.class)
    public ResultVo GlobalException(GlobalException globalException){
        log.error("发生的异常为：{},",globalException.getMsg());
        return ResultVo.error().message(globalException.getMsg());
    }

    // 使用valid校验
    @ExceptionHandler({MethodArgumentNotValidException.class})
    public ResultVo MethodArgumentNotValidExceptionHandler(MethodArgumentNotValidException e) {
        // 从异常对象中拿到ObjectError对象
        ObjectError objectError = e.getBindingResult().getAllErrors().get(0);
        log.info(objectError.getDefaultMessage());
        return ResultVo.error().message(objectError.getDefaultMessage());
    }

    // 对于未使用 Valid注解进行校验
    @ExceptionHandler({ConstraintViolationException.class})
    public ResultVo ConstraintViolationExceptionHandler(ConstraintViolationException e) {
        // 从异常对象中拿到ObjectError对象

//        ObjectError objectError = e.getBindingResult().getAllErrors().get(0);
        log.info(e.getMessage());
        return ResultVo.error().message(e.getMessage());
    }

    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    public ResultVo mismatchErrorHandler(MethodArgumentTypeMismatchException e) {
        log.error("参数转换失败，方法：" + Objects.requireNonNull(e.getParameter().getMethod()).getName() + ",参数：" +
                e.getName() + "，信息：" + e.getLocalizedMessage());
        return ResultVo.error().message("请填写参数");
    }
}
