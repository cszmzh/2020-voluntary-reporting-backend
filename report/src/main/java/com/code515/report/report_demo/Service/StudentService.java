package com.code515.report.report_demo.Service;

import com.code515.report.report_demo.Entity.Student;

public interface StudentService {

    /**
     * 1.保存学生
     * @param student
     * @return Student类
     */
    public Student save(Student student);

    /**
     * 2.通过学号查找学生
     * @param id
     * @return
     */
    public Student findById(Integer id);

    /**
     * 3.录取学生
     * @param id    学生id
     * @param flag  志愿 1或2
     */
    public boolean enroll(Integer id, Integer flag);

    /**
     * 4.更新学生信息
     * @param student
     * @return
     */
    public Student update(Student student);

    /**
     * 5.删除学生信息
     */
    public void deleteById(Integer stdId);
}
