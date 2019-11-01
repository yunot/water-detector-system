package com.isoftstone.rookie.framework.annotation;

import static com.isoftstone.rookie.framework.constant.ModConstant.FUNCTION_BRANCH.OTHER;
import static com.isoftstone.rookie.framework.constant.SysConstant.MODULE_BRANCH.SM.ROLE_MANAGER;

import java.lang.annotation.*;

/**
 * 自定义操作日志记录注解
 *
 * @author zsj
 */
@Target({ElementType.PARAMETER, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Log
{
    /** 模块 */
    String module() default ROLE_MANAGER;
    
    /** 功能 */
    int function() default OTHER;
    
    /** 是否保存请求的参数 */
    boolean isSaveRequestData() default true;
}
