package com.isoftstone.rookie.framework;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.isoftstone.rookie.system.organization.entity.Organization;

public class TreeUtils {
  /**
   * 根据父节点的ID获取所有子节点
   *
   * @param list 分类表
   * @param typeId 传入的父节点ID
   * @return String
   */
  public static List<Organization> getChildPerms(List<Organization> list, int parentId) {
    List<Organization> returnList = new ArrayList<Organization>();
    for (Iterator<Organization> iterator = list.iterator(); iterator.hasNext();) {
      Organization t = (Organization) iterator.next();
      // 一、根据传入的某个父节点ID,遍历该父节点的所有子节点
      if (t.getParentId() == parentId) {
        recursionFn(list, t);
        returnList.add(t);
      }
    }
    return returnList;
  }

  /**
   * 递归列表
   *
   * @param list
   * @param Organization
   */
  private static void recursionFn(List<Organization> list, Organization t) {
    // 得到子节点列表
    List<Organization> childList = getChildList(list, t);
    t.setChildren(childList);
    for (Organization tChild : childList) {
      if (hasChild(list, tChild)) {
        // 判断是否有子节点
        Iterator<Organization> it = childList.iterator();
        while (it.hasNext()) {
          Organization n = (Organization) it.next();
          recursionFn(list, n);
        }
      }
    }
  }

  /**
   * 得到子节点列表
   */
  private static List<Organization> getChildList(List<Organization> list, Organization t) {

    List<Organization> tlist = new ArrayList<Organization>();
    Iterator<Organization> it = list.iterator();
    while (it.hasNext()) {
      Organization n = (Organization) it.next();
      if (n.getParentId().longValue() == t.getOrgId().longValue()) {
        tlist.add(n);
      }
    }
    return tlist;
  }

  List<Organization> returnList = new ArrayList<Organization>();

  /**
   * 根据父节点的ID获取所有子节点
   *
   * @param list 分类表
   * @param typeId 传入的父节点ID
   * @param prefix 子节点前缀
   */
  public List<Organization> getChildPerms(List<Organization> list, int typeId, String prefix) {
    if (list == null) {
      return null;
    }
    for (Iterator<Organization> iterator = list.iterator(); iterator.hasNext();) {
      Organization node = (Organization) iterator.next();
      // 一、根据传入的某个父节点ID,遍历该父节点的所有子节点
      if (node.getParentId() == typeId) {
        recursionFn(list, node, prefix);
      }
      // 二、遍历所有的父节点下的所有子节点
      /*
       * if (node.getParentId()==0) { recursionFn(list, node); }
       */
    }
    return returnList;
  }

  private void recursionFn(List<Organization> list, Organization node, String p) {
    // 得到子节点列表
    List<Organization> childList = getChildList(list, node);
    if (hasChild(list, node)) {
      // 判断是否有子节点
      returnList.add(node);
      Iterator<Organization> it = childList.iterator();
      while (it.hasNext()) {
        Organization n = (Organization) it.next();
        n.setOrgName(p + n.getOrgName());
        recursionFn(list, n, p + p);
      }
    } else {
      returnList.add(node);
    }
  }

  /**
   * 判断是否有子节点
   */
  private static boolean hasChild(List<Organization> list, Organization t) {
    return getChildList(list, t).size() > 0 ? true : false;
  }
}
