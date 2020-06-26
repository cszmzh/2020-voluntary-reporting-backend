package com.code515.report.report_demo.Repository;

import com.code515.report.report_demo.Entity.view.ReportView;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


public interface ReportViewRepository extends JpaRepository<ReportView, Integer> {

    /**
     * 通过所属组织名称查找组织所有志愿信息
     * @param orgName
     * @return
     */
    @Query("select a from ReportView a where a.orgFirst=:orgName or " +
            "a.orgSecond=:orgName")
    Page<ReportView> findByOrgName(@Param("orgName")String orgName, Pageable pageable);

    

}
