package com.code515.report.report_demo.Service.Impl;

import com.code515.report.report_demo.Entity.Report;
import com.code515.report.report_demo.Enums.EnrollStatusEnum;
import com.code515.report.report_demo.Repository.StudentRepository;
import com.code515.report.report_demo.Service.ReportService;
import com.code515.report.report_demo.Service.StudentService;
import com.code515.report.report_demo.Entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentRepository repository;
    @Autowired
    private ReportService reportService;


    @Override
    public Student save(Student student) {
        return repository.save(student);
    }

    @Override
    public Student findById(Integer id) {
        return repository.findById(id).orElse(null);
    }

    @Override
    public boolean enroll(Integer id, Integer flag) {
        Student student = repository.findById(id).orElse(null);
        Report report = reportService.findEntityByStdId(id);
        //第一志愿录取
        if(flag == 1 && student.getStuStatus().equals(EnrollStatusEnum.UNDER_ENROLL.getMessage())){
            student.setOrgId(report.getVolFirst());
            student.setStuStatus(EnrollStatusEnum.FIRST_ENROLL.getMessage());
            repository.save(student);   //保存学生信息
            return true;
        }
        //第二志愿录取
        if(flag == 2 && student.getStuStatus().equals(EnrollStatusEnum.UNDER_ENROLL.getMessage())){
            student.setOrgId(report.getVolSecond());
            student.setStuStatus(EnrollStatusEnum.SECOND_ENROLL.getMessage());
            repository.save(student);   //保存学生信息
            return true;
        }
        return false;
    }

    @Override
    public Student update(Student student) {
        return repository.saveAndFlush(student);
    }

    @Override
    public void deleteById(Integer stdId) {
        repository.deleteById(stdId);
    }
}
