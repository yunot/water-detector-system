package com.isoftstone.rookie.framework.constant;

public interface SysConstant
{
    interface Module_System
    {
        
        /** 数据字典种类标识：系统管理  */
        String MODULE_SM = "sys_manger";
    }
    
    interface MODULE_BRANCH
    {
        interface SM
        {
            String USER_MANAGER = "user_manager";
            
            String ROLE_MANAGER = "role_manager";
            
            String OPERLOG_MANAGER = "operlog_manager";
        }
    }
    
    interface FUNCTION_BRANCH
    {
        interface ROLE_MANAGER
        {
            String BUTTON = "sys_module_role";
        }
        
        interface USER_MANAGER
        {
            String BUTTON = "sys_module_user";
        }
    }
    
    interface ORGANIZATION_TYPE
    {
        String HEAD_OFFICE = "head_office";
        
        String BRANCH_OFFICE = "branch_office";
        
        String POWER_PLANT = "power_plant";
    }
    
    interface ORGANIZATION_BRANCH
    {
        String ORGANIZATION = "organization";
        
        String DEPT = "dept";
        
        String POST = "post";
    }
    
}
