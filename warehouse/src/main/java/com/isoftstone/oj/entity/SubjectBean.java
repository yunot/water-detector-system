package com.isoftstone.oj.entity;

import com.isoftstone.platform.entity.Columns;

public class SubjectBean
{
    //题目编号
    @Columns("subject_id")
    private int subjectId;
    
    //题目名称
    @Columns("subject_name")
    private String subjectName;
    
    //题目描述
    @Columns("subject_desc")
    private String subjectDesc;
    
    //题目输入
    @Columns("subject_input")
    private String subjectInput;
    
    //题目输出
    @Columns("subject_out")
    private String subjectOut;
    
    //样例输入
    @Columns("sample_input")
    private String sampleInput;
    
    //样例输出
    @Columns("sample_out")
    private String sampleOut;
    
    //创建时间
    @Columns("create_time")
    private String createTime;
    
    //修改时间
    @Columns("modify_time")
    private String modifyTime;
    
    //用例输入
    @Columns("unit_input")
    private String unitInput;
    
    //用例输出
    @Columns("unit_out")
    private String unitOut;
    
    private String userInput;
    
    public int getSubjectId()
    {
        return subjectId;
    }
    
    public void setSubjectId(int subjectId)
    {
        this.subjectId = subjectId;
    }
    
    public String getSubjectName()
    {
        return subjectName;
    }
    
    public void setSubjectName(String subjectName)
    {
        this.subjectName = subjectName;
    }
    
    public String getSubjectDesc()
    {
        return subjectDesc;
    }
    
    public void setSubjectDesc(String subjectDesc)
    {
        this.subjectDesc = subjectDesc;
    }
    
    public String getSubjectInput()
    {
        return subjectInput;
    }
    
    public void setSubjectInput(String subjectInput)
    {
        this.subjectInput = subjectInput;
    }
    
    public String getSubjectOut()
    {
        return subjectOut;
    }
    
    public void setSubjectOut(String subjectOut)
    {
        this.subjectOut = subjectOut;
    }
    
    public String getSampleInput()
    {
        return sampleInput;
    }
    
    public void setSampleInput(String sampleInput)
    {
        this.sampleInput = sampleInput;
    }
    
    public String getSampleOut()
    {
        return sampleOut;
    }
    
    public void setSampleOut(String sampleOut)
    {
        this.sampleOut = sampleOut;
    }
    
    public String getCreateTime()
    {
        return createTime;
    }
    
    public void setCreateTime(String createTime)
    {
        this.createTime = createTime;
    }
    
    public String getModifyTime()
    {
        return modifyTime;
    }
    
    public void setModifyTime(String modifyTime)
    {
        this.modifyTime = modifyTime;
    }
    
    public String getUnitInput()
    {
        return unitInput;
    }
    
    public void setUnitInput(String unitInput)
    {
        this.unitInput = unitInput;
    }
    
    public String getUnitOut()
    {
        return unitOut;
    }
    
    public void setUnitOut(String unitOut)
    {
        this.unitOut = unitOut;
    }
    
    public String getUserInput()
    {
        return userInput;
    }
    
    public void setUserInput(String userInput)
    {
        this.userInput = userInput;
    }
    
}
