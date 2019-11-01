package com.isoftstone.platform.tld;

import java.util.List;

import javax.servlet.jsp.JspWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import com.isoftstone.platform.sm.entity.MenuBean;
import com.isoftstone.platform.sm.repository.MenuDao;

public class MenuTag extends RequestContextAwareTag
{
    private static final long serialVersionUID = 1109314818737519968L;
    
    @Autowired
    private MenuDao menuDao;
    
    private List<MenuBean> list;
    
    public void setList(List<MenuBean> list)
    {
        this.list = list;
    }
    
    @Override
    protected int doStartTagInternal()
        throws Exception
    {
        String path = this.getRequestContext().getContextPath();
        menuDao = this.getRequestContext().getWebApplicationContext().getBean(MenuDao.class);
        JspWriter out = pageContext.getOut();
        out.write("<div id='manageCore'>");
        for (int i = 0; i < list.size(); i++)
        {// 找到一级菜单
         // 获取一级菜单的ID
            int firstID = list.get(i).getMenuID();
            // 获取一级菜单的父ID
            Integer firstParentID = list.get(i).getParentID();
            if (firstParentID == -1)
            {
                out.write("<li class='firstMeNu'><a href='#' class='ui-state-default ui-corner-all cbe-button' "
                    + " style='cursor:pointer;' flag='1'>" + list.get(i).getMenuName() + "</a>");
                out.write("<ul>");
                for (int j = 0; j < list.size(); j++)
                {// 找到关联的二级菜单
                 // 获取二级菜单的ID
                    int secondID = list.get(j).getMenuID();
                    // 获取二级菜单的父ID
                    Integer secondParentID = list.get(j).getParentID();
                    if (secondParentID != null && firstID == secondParentID)
                    {
                        out.write("<li class='secondMeNu' >");
                        out.write("<a href='#' class='ui-state-default ui-corner-all cbe-button'"
                            + "style='cursor:pointer;'><span class='" + list.get(j).getIconClass() + "'></span>"
                            + list.get(j).getMenuName() + "</a>");
                        out.write("<ul>");
                        for (int k = 0; k < list.size(); k++)
                        {// 找到关联的三级菜单
                         // 获取三级菜单的父ID
                            Integer thirdParentID = list.get(k).getParentID();
                            if (thirdParentID != null && thirdParentID == secondID)
                            {
                                String menuUrl = list.get(k).getMenuUrl();
                                String url = null;
                                if (menuUrl == null || "".equals(menuUrl))
                                {
                                    url = path + "/temp.jsp";
                                }
                                else
                                {
                                    url = path + menuUrl;
                                }
                                out.write("<li class='menu3 ui-state-default ui-corner-all cbe-button'>"
                                    + "<a href='#' onclick=\"menuShowPage(this,'" + url + "')\"><span class='"
                                    + list.get(k).getIconClass() + "'></span>" + list.get(k).getMenuName()
                                    + "</a></li>");
                            }
                        }
                        out.write("</ul>");
                        out.write("</li>");
                    }
                }
                out.write("</ul>");
                out.write("</li>");
            }
        }
        out.write("</ul>");
        out.write("</div>");
        out.flush();
        return 0;
    }
}
