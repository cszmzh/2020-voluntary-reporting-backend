package com.code515.report.report_demo.Service;

public interface OrganizationService {

    /**
     * 1.通过组织名和分支名查找id
     * @param orgName 组织名
     * @param braName 分支名
     * @return 返回id
     */
    public Integer findIdByOrgNameAndBraName(String orgName, String braName);

    /**
     * 2.通过id查找组织名
     * @param Id 组织id
     * @return
     */
    public String findNameByOrgId(Integer Id);

}
