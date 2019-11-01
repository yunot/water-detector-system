package com.isoftstone.rookie.framework.annotation;

import static com.isoftstone.rookie.framework.constant.ModConstant.FUNCTION_BRANCH.OTHER;
import static com.isoftstone.rookie.framework.constant.SysConstant.MODULE_BRANCH.SM.ROLE_MANAGER;

import java.lang.annotation.*;

/**
 * �Զ��������־��¼ע��
 *
 * @author zsj
 */
@Target({ElementType.PARAMETER, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Log
{
    /** ģ�� */
    String module() default ROLE_MANAGER;
    
    /** ���� */
    int function() default OTHER;
    
    /** �Ƿ񱣴�����Ĳ��� */
    boolean isSaveRequestData() default true;
}
