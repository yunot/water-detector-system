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
     * ǰ��֪ͨ �������ز���
     *
     * @param joinPoint �е�
     */
    @AfterReturning(pointcut = "logPointCut()")
    public void doBefore(JoinPoint joinPoint)
    {
        handleLog(joinPoint, null);
    }
    
    /**
     * �����쳣����
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
            // *========����̨���=========*//
            // ���ע��
            Log controllerLog = getAnnotationLog(joinPoint);
            if (controllerLog == null)
            {
                return;
            }
            
            // ��ȡ��ǰ���û�
            UserInfoBean currentUser = (UserInfoBean)SecurityUtils.getSubject().getPrincipal();
            
            // *========���ݿ���־=========*//
            OperLog operLog = new OperLog();
            operLog.setOperName(currentUser.getName());
            operLog.setStatus(BusinessStatus.SUCCESS.ordinal());
            // ����ĵ�ַ
            String ip = SecurityUtils.getSubject().getSession().getHost();
            operLog.setOperIp(ip);
            operLog.setOperUrl(getRequestAttributes().getRequest().getRequestURI());
            if (e != null)
            {
                operLog.setStatus(BusinessStatus.FAIL.ordinal());
                operLog.setErrorMsg(substring(e.getMessage(), 0, 2000));
            }
            // ���÷�������
            String className = joinPoint.getTarget().getClass().getName();
            String methodName = joinPoint.getSignature().getName();
            operLog.setMethod(className + "." + methodName + "()");
            // ��������ע���ϵĲ���
            getControllerMethodDescription(controllerLog, operLog);
            // �������ݿ�
            operLogService.insertOperlog(operLog);
        }
        catch (Exception exp)
        {
            // ��¼�����쳣��־
            log.error("==ǰ��֪ͨ�쳣==");
            log.error("�쳣��Ϣ:{}" + exp.getMessage());
            exp.printStackTrace();
        }
    }
    
    /**
     * ��ȡע���жԷ�����������Ϣ ����Controller��ע��
     *
     * @param joinPoint �е�
     * @return ��������
     * @throws Exception
     */
    public void getControllerMethodDescription(Log log, OperLog operLog)
        throws Exception
    {
        // ����action����
        operLog.setBusinessType(log.function());
        // ���ñ���
        operLog.setTitle(log.module());
        // �Ƿ���Ҫ����request��������ֵ
        if (log.isSaveRequestData())
        {
            // ��ȡ��������Ϣ�����뵽���ݿ��С�
            setRequestValue(operLog);
        }
    }
    
    /**
     * ��ȡ����Ĳ������ŵ�log��
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
    
    /** �Ƿ����ע�⣬������ھͻ�ȡ */
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
    
    /** ��ȡrequest */
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
