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
    //FilterConfig�����ڷ���Filter��������Ϣ
    private FilterConfig config;
    
    //ʵ�ֳ�ʼ������
    @Override
    public void init(
        FilterConfig config)
        throws ServletException
    {
        this.config = config;
    }
    
    //ʵ�����ٷ���
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
        //����request�����õ��ַ���
        request.setCharacterEncoding("UTF-8");
        HttpServletRequest hrequest =
            (HttpServletRequest)request;
        HttpSession session =
            hrequest.getSession();
        //��ȡ�ͻ������ҳ��
        String requestPath =
            hrequest.getServletPath();
        //���session��Χ��userΪnull��������û�е�½���û�����ļȲ��ǵ�¼ҳ�棬Ҳ���Ǵ����½��ҳ��
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
        
        //forward����½ҳ��
        request.setAttribute("tip",
            "����û�е�½");
        request.getRequestDispatcher(loginUrl)
            .forward(request,
                response);
        
    }
    
}
