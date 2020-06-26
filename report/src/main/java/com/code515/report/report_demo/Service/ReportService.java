package com.code515.report.report_demo.Service;

import com.code515.report.report_demo.Entity.Report;
import com.code515.report.report_demo.Entity.view.ReportView;
import org.springframework.data.domain.Page;

public interface ReportService {

    /**
     * 1.查询当前所有志愿信息
     * @param page  //当前页数
     * @param pageSize  //一页显示多少条
     * @return Page<ReportView>
     */
    public Page<ReportView> getAll(Integer page, Integer pageSize);

    /**
     * 2.通过学号删除一条志愿信息
     */
    public void deleteByStdId(Integer studentId);

    /**
     * 3.保存一条志愿信息
     */
    public Report save(Report report);

    /**
     * 4.根据学号查找一条志愿信息（视图）
     * @param stdId
     * @return
     */
    public ReportView findByStdId(Integer stdId);

    /**
     * 5.根据学号查找一条志愿实体类
     * @param stdId
     * @return
     */
    public Report findEntityByStdId(Integer stdId);

    /**
     * 6.更新一条志愿信息
     * @param report
     * @return
     */
    public Report update(Report report);

}
