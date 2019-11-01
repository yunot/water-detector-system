package com.isoftstone.platform.common.tag;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import com.isoftstone.platform.entity.BaseSelectBean;
import com.isoftstone.rookie.system.dictionary.dao.DictDataMapper;
import com.isoftstone.rookie.system.dictionary.entity.DictData;

/** @author Administrator */
public class resourceTag extends RequestContextAwareTag
{
    
    private Logger log = Logger.getLogger(resourceTag.class);
    
    /**
     * ע������
     */
    private static final long serialVersionUID = 4558517731858754283L;
    
    @Autowired
    private DictDataMapper dictDataMapper;
    
    private String selectId = null;
    
    private String selectName = null;
    
    private String dictType = null;
    
    private String selected = null;
    
    private String onchange = null;
    
    private List<BaseSelectBean> baseSelectBean = null;
    
    @Override
    public int doStartTagInternal()
    {
        HttpServletRequest request = null;
        Session session = SecurityUtils.getSubject().getSession();
        String siteLanguage = (String)session.getAttribute("language");
        dictDataMapper = this.getRequestContext().getWebApplicationContext().getBean(DictDataMapper.class);
        StringBuffer menuHtml = new StringBuffer();
        List<DictData> dictData = dictDataMapper.selectDictDataByType(dictType, siteLanguage);
        menuHtml.append("<script type=\"text/javascript\">\n" + "            $(function () {\n"
            + "                $(\"#");
        menuHtml.append(selectId);
        menuHtml.append("\").combobox();\n" + "            });\n" + "        </script>\n" + "        <select id=\"");
        menuHtml.append(selectId);
        menuHtml.append("\" name=\"");
        menuHtml.append(selectName);
        menuHtml.append("\" onchange=\"");
        menuHtml.append(onchange);
        menuHtml.append("\">");
        menuHtml.append("<option value =\"" + "" + "\">" + "</option>");
        if (dictData != null && baseSelectBean == null)
        {
            for (DictData data : dictData)
            {
                String selectedV = null;
                if (selected != null && !"".equals(selected))
                {
                    if (selected.equals(data.getDictValue()))
                    {
                        selectedV = data.getDictValue();
                        menuHtml.append("<option value =\"" + data.getDictValue() + "\"  selected = \"selected\">"
                            + data.getDictLabel() + "</option>");
                    }
                }
                if (data.getDictValue() != selectedV)
                {
                    menuHtml.append("<option value =\"" + data.getDictValue() + "\">" + data.getDictLabel()
                        + "</option>");
                }
            }
        }
        else
        {
            for (BaseSelectBean baseData : baseSelectBean)
            {
                String selectedV = null;
                if (selected != null && !"".equals(selected))
                {
                    if (selected.equals(baseData.getValue()))
                    {
                        selectedV = baseData.getValue();
                        menuHtml.append("<option value =\"" + baseData.getValue() + "\"  selected = \"selected\">"
                            + baseData.getLabel() + "</option>");
                    }
                }
                if (baseData.getValue() != selectedV)
                {
                    menuHtml.append("<option value =\"" + baseData.getValue() + "\">" + baseData.getLabel()
                        + "</option>");
                }
            }
        }
        //        pageContext.getAttribute(name)
        menuHtml.append("</select>");
        JspWriter out = pageContext.getOut();
        try
        {
            out.write(menuHtml.toString());
            out.flush();
        }
        catch (IOException e)
        {
            log.error(e.getMessage(), e);
        }
        return TagSupport.EVAL_PAGE;
    }
    
    public String getSelectId()
    {
        return selectId;
    }
    
    public void setSelectId(String selectId)
    {
        this.selectId = selectId;
    }
    
    public String getDictType()
    {
        return dictType;
    }
    
    public void setDictType(String dictType)
    {
        this.dictType = dictType;
    }
    
    public String getSelectName()
    {
        return selectName;
    }
    
    public void setSelectName(String selectName)
    {
        this.selectName = selectName;
    }
    
    public String getSelected()
    {
        return selected;
    }
    
    public void setSelected(String selected)
    {
        this.selected = selected;
    }
    
    public String getOnchange()
    {
        return onchange;
    }
    
    public void setOnchange(String onchange)
    {
        this.onchange = onchange;
    }
    
    public List<BaseSelectBean> getBaseSelectBean()
    {
        return baseSelectBean;
    }
    
    public void setBaseSelectBean(List<BaseSelectBean> baseSelectBean)
    {
        this.baseSelectBean = baseSelectBean;
    }
    
}
