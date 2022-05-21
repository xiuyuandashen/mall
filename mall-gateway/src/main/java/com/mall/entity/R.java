package com.mall.entity;

import java.io.Serializable;
import java.util.HashMap;


public class R implements Serializable {
    private Integer code;
    private Boolean success;
    private String message;
    private HashMap<String,Object> data = new HashMap<>();

    public static R SUCCESS(){
        R resultVo = new R();
        resultVo.setSuccess(true);
        resultVo.setMessage(null);
        resultVo.setCode(200);
        return resultVo;
    }

    public static R SUCCESS(String message){
        R resultVo = new R();
        resultVo.setSuccess(true);
        resultVo.setMessage(message);
        resultVo.setCode(200);
        return resultVo;
    }



    public  R data(String key, Object val){
        this.data.put(key,val);
        return this;
    }

    public R message(String msg){
        this.setMessage(msg);
        return this;
    }

    public static R ERROR(){
        R resultVo = new R();
        resultVo.setSuccess(false);
        resultVo.setMessage(null);
        resultVo.setCode(201);
        return resultVo;
    }

    public R code(int code){
        this.setCode(code);
        return this;
    }

    public static R ERROR(String message){
        R resultVo = new R();
        resultVo.setSuccess(false);
        resultVo.setMessage(message);
        resultVo.setCode(201);
        return resultVo;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public Boolean getSuccess() {
        return success;
    }

    public void setSuccess(Boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public HashMap<String, Object> getData() {
        return data;
    }

    public void setData(HashMap<String, Object> data) {
        this.data = data;
    }
}
