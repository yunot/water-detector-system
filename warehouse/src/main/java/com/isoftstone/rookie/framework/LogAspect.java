package com.isoftstone.rookie.framework;

import java.lang.reflect.Method;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.alibaba.fastjson.JSONObject;
import com.isoftstone.platform.sm.entity.UserInfoBean;
import com.isoftstone.rookie.framework.annotation.Log;
import com.isoftstone.rookie.framework.enums.BusinessStatus;
import com.isoftstone.rookie.monitor.operlog.entity.OperLog;
import com.isoftstone.rookie.monitor.operlog.service.IOperLogService;

@Aspect
@Component
public class LogAspect
{
    private static final Logger log = Logger.getLogger(LogAspect.class);
    
    @Resource
    IOperLogService operLogService;
    
    @Pointcut("@annotation(com.isoftstone.rookie.framework.annotation.Log)")
    public void logPointCut()
    {
    }
    
    /**
     * 前置通知 用于拦截操作
     *
     * @param joinPoint 切点
     */
    @AfterReturning(pointcut = "logPointCut()")
    public void doBefore(JoinPoint joinPoint)
    {
        handleLog(joinPoint, null);
    }
    
    /**
     * 拦截异常操作
     *
     * @param joinPoint
     * @param e
     */
    @AfterThrowing(value = "logPointCut()", throwing = "e")
    public void doAfter(JoinPoint joinPoint, Exception e)
    {
        handleLog(joinPoint, e);
    }
    
    protected void handleLog(final JoinPoint joinPoint, final Exception e)
    {
        try
        {
            // *========控制台输出=========*//
            // 获得注解
            Log controllerLog = getAnnotationLog(joinPoint);
            if (controllerLog == null)
            {
                return;
            }
            
            // 获取当前的用户
            UserInfoBean currentUser = (UserInfoBean)SecurityUtils.getSubject().getPrincipal();
            
            // *========数据库日志=========*//
            OperLog operLog = new OperLog();
            operLog.setOperName(currentUser.getName());
            operLog.setStatus(BusinessStatus.SUCCESS.ordinal());
            // 请求的地址
            String ip = SecurityUtils.getSubject().getSession().getHost();
            operLog.setOperIp(ip);
            operLog.setOperUrl(getRequestAttributes().getRequest().getRequestURI());
            if (e != null)
            {
                operLog.setStatus(BusinessStatus.FAIL.ordinal());
                operLog.setErrorMsg(substring(e.getMessage(), 0, 2000));
            }
            // 设置方法名称
            String className = joinPoint.getTarget().getClass().getName();
            String methodName = joinPoint.getSignature().getName();
            operLog.setMethod(className + "." + methodName + "()");
            // 处理设置注解上的参数
            getControllerMethodDescription(controllerLog, operLog);
            // 保存数据库
            operLogService.insertOperlog(operLog);
        }
        catch (Exception exp)
        {
            // 记录本地异常日志
            log.error("==前置通知异常==");
            log.error("异常信息:{}" + exp.getMessage());
            exp.printStackTrace();
        }
    }
    
    /**
     * 获取注解中对方法的描述信息 用于Controller层注解
     *
     * @param joinPoint 切点
     * @return 方法描述
     * @throws Exception
     */
    public void getControllerMethodDescription(Log log, OperLog operLog)
        throws Exception
    {
        // 设置action动作
        operLog.setBusinessType(log.function());
        // 设置标题
        operLog.setTitle(log.module());
        // 是否需要保存request，参数和值
        if (log.isSaveRequestData())
        {
            // 获取参数的信息，传入到数据库中。
            setRequestValue(operLog);
        }
    }
    
    /**
     * 获取请求的参数，放到log中
     *
     * @param operLog
     * @param request
     */
    private void setRequestValue(OperLog operLog)
    {
        Map<String, String[]> map = getRequest().getParameterMap();
        String params = JSONObject.toJSONString(map);
        operLog.setOperParam(substring(params, 0, 255));
    }
    
    /** 是否存在注解，如果存在就获取 */
    private Log getAnnotationLog(JoinPoint joinPoint)
        throws Exception
    {
        Signature signature = joinPoint.getSignature();
        MethodSignature methodSignature = (MethodSignature)signature;
        Method method = methodSignature.getMethod();
        
        if (method != null)
        {
            return method.getAnnotation(Log.class);
        }
        return null;
    }
    
    public static ServletRequestAttributes getRequestAttributes()
    {
        RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
        return (ServletRequestAttributes)attributes;
    }
    
    /** 获取request */
    public static HttpServletRequest getRequest()
    {
        return getRequestAttributes().getRequest();
    }
    
    public static String substring(final String str, int start, int end)
    {
        if (str == null)
        {
            return "";
        }
        
        if (end < 0)
        {
            end = str.length() + end;
        }
        if (start < 0)
        {
            start = str.length() + start;
        }
        
        if (end > str.length())
        {
            end = str.length();
        }
        
        if (start > end)
        {
            return "";
        }
        
        if (start < 0)
        {
            start = 0;
        }
        if (end < 0)
        {
            end = 0;
        }
        return str.substring(start, end);
    }
}
