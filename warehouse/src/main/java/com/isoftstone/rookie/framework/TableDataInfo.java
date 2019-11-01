package com.isoftstone.rookie.framework;

import java.io.Serializable;
import java.util.List;

/**
 * 表格分页数据对象
 *
 * @author zsj
 */
public class TableDataInfo implements Serializable {
  /** 总记录数 */
  private long count;
  /** 列表数据 */
  private List<?> data;
  /** 消息状态码 */
  private int code;
  /** 返回消息 */
  private String msg;

  /** 表格数据对象 */
  public TableDataInfo() {}

  /**
   * 分页
   *
   * @param list 列表数据
   * @param count 总记录数
   */
  public TableDataInfo(List<?> list, int count) {
    this.data = list;
    this.count = count;
  }

  public long getCount() {
    return count;
  }

  public void setCount(long count) {
    this.count = count;
  }

  public List<?> getData() {
    return data;
  }

  public void setData(List<?> data) {
    this.data = data;
  }

  public int getCode() {
    return code;
  }

  public void setCode(int code) {
    this.code = code;
  }

  public String getMsg() {
    return msg;
  }

  public void setMsg(String msg) {
    this.msg = msg;
  }
}
