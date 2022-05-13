package com.mall.entity;

import com.baomidou.mybatisplus.annotation.*;

import java.util.Date;
import java.io.Serializable;
import java.util.List;

import com.mall.domain.Role;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

@Data
@EqualsAndHashCode(callSuper = false)
@TableName("mall_user")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    @TableId(value = "user_id", type = IdType.AUTO)
    @NotNull(message = "用户Id不能为空")
    private Long userId;

    /**
     * 用户账号
     */
    @NotNull(message = "用户名称不能为空")
    @Length(min = 3, max = 20, message = "用户名称长度在3-20之间")
    private String userName;

    /**
     * 用户昵称
     */
    @Length(min = 3, max = 10, message = "用户昵称长度在3-10之间")
    private String nickName;

    /**
     * 用户邮箱
     */
    @Email(message = "邮箱格式不规范")
    @NotNull(message = "邮箱不能为空")
    private String email;

    /**
     * 手机号码
     */
    @Pattern(regexp = "^(13[0-9]|14[01456879]|15[0-35-9]|16[2567]|17[0-8]|18[0-9]|19[0-35-9])\\d{8}$", message = "手机号码格式错误")
    private String phonenumber;

    /**
     * 用户性别（0男 1女 2未知）
     */
    private String sex;

    /**
     * 头像地址
     */
    private String avatar;

    /**
     * 密码
     */
    @NotNull(message = "密码不能为空")
    @Length(min = 6, max = 20, message = "密码长度在6-20之间")
    private String password;

    /**
     * 帐号状态（0正常 1停用）
     */
    private String status;

    /**
     * 删除标志（0代表存在 1代表删除）
     */
    @TableLogic
    private String delFlag;

    /**
     * 最后登录IP
     */
    private String loginIp;

    /**
     * 最后登录时间
     */
    private Date loginDate;

    /**
     * 创建者
     */
    private String createBy;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 更新者
     */
    private String updateBy;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;

    /**
     * 备注
     */
    private String remark;

    /** 角色对象 */
    // select =false 查询过滤字段，这样在使用mybatis-plus的查询时是不会查出这个
    @TableField(select = false, exist = false)
    private List<Role> roles;

    /** 角色组 */
    @TableField(select = false, exist = false)
    private Long[] roleIds;

    /** 角色ID */
    @TableField(select = false, exist = false)
    private Long roleId;
}
