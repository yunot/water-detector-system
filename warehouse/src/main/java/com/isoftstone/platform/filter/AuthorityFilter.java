package com.isoftstone.platform.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class AuthorityFilter
    implements Filter
{
    //FilterConfig可用于访问Filter的配置信息
    private FilterConfig config;
    
    //实现初始化方法
    @Override
    public void init(
        FilterConfig config)
        throws ServletException
    {
        this.config = config;
    }
    
    //实现销毁方法
    @Override
    public void destroy()
    {
        this.config = null;
    }
    
    @Override
    public void doFilter(
        ServletRequest request,
        ServletResponse response,
        FilterChain chain)
        throws IOException,
        ServletException
    {
        
        ServletContext servletContext =
            request.getServletContext();
        String filterChainDefinitions =
            servletContext.getInitParameter("filterChainDefinitions");
        if (filterChainDefinitions == null)
        {
            chain.doFilter(request,
                response);
        }
        String loginUrl =
            servletContext.getInitParameter("loginUrl");
        //设置request编码用的字符集
        request.setCharacterEncoding("UTF-8");
        HttpServletRequest hrequest =
            (HttpServletRequest)request;
        HttpSession session =
            hrequest.getSession();
        //获取客户请求的页面
        String requestPath =
            hrequest.getServletPath();
        //如果session范围的user为null，即表明没有登陆且用户请求的既不是登录页面，也不是处理登陆的页面
        if (requestPath != null)
        {
            String[] condition =
                filterChainDefinitions.split("\n");
            for (String item : condition)
            {
                item = item.trim();
                item =
                    item.replace("**",
                        ".*");
                if (requestPath.matches(item))
                {
                    chain.doFilter(request,
                        response);
                    return;
                }
            }
            if (session.getAttribute("userInfo") != null)
            {
                chain.doFilter(request,
                    response);
                return;
            }
        }
        
        //forward到登陆页面
        request.setAttribute("tip",
            "您还没有登陆");
        request.getRequestDispatcher(loginUrl)
            .forward(request,
                response);
        
    }
    
}
