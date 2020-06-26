package com.code515.report.report_demo.Service.Impl;

import com.code515.report.report_demo.Enums.UserStatusEnum;
import com.code515.report.report_demo.Holder.UserOrgHolder;
import com.code515.report.report_demo.Holder.UserStatusHolder;
import com.code515.report.report_demo.Repository.ReportRepository;
import com.code515.report.report_demo.Repository.ReportViewRepository;
import com.code515.report.report_demo.Service.ReportService;
import com.code515.report.report_demo.Entity.Report;
import com.code515.report.report_demo.Entity.view.ReportView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private ReportViewRepository reportViewRepository;

    @Autowired
    private ReportRepository reportRepository;

    @Override
    public Page<ReportView> getAll(Integer pageNum, Integer pageSize) {

        //判断身份以返回不同结果
        if(UserStatusHolder.get().equals(UserStatusEnum.ROOT.getCode().toString())){
            Pageable pageable = PageRequest.of(pageNum, pageSize);
            Page<ReportView> page = reportViewRepository.findAll(pageable);
            return page;
        }else{
            //通过登录用户所属组织id查找相关志愿
            Pageable pageable = PageRequest.of(pageNum, pageSize);
            Page<ReportView> page = reportViewRepository.findByOrgName(UserOrgHolder.get(),pageable);
            return page;
        }
    }


    @Override
    public void deleteByStdId(Integer studentId) {
        reportRepository.deleteByStudentId(studentId);
    }

    @Override
    public Report save(Report report) {
        return reportRepository.save(report);
    }

    @Override
    public ReportView findByStdId(Integer stdId) {
        return reportViewRepository.findById(stdId).orElse(null);
    }

    @Override
    public Report findEntityByStdId(Integer stdId) {
        return reportRepository.findByStudentId(stdId);
    }

    @Override
    public Report update(Report report) {
        return reportRepository.saveAndFlush(report);
    }
}
