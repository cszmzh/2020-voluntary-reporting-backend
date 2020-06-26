package com.code515.report.report_demo.Controller;

import com.code515.report.report_demo.Enums.EnrollStatusEnum;
import com.code515.report.report_demo.Enums.UserStatusEnum;
import com.code515.report.report_demo.Holder.UserOrgHolder;
import com.code515.report.report_demo.Holder.UserStatusHolder;
import com.code515.report.report_demo.Service.*;
import com.code515.report.report_demo.VO.ResultVO;
import com.code515.report.report_demo.VO.reportVO.ReportDataVO;
import com.code515.report.report_demo.VO.reportVO.ReportInfoVO;
import com.code515.report.report_demo.VO.reportVO.ReportViewListVO;
import com.code515.report.report_demo.Entity.Report;
import com.code515.report.report_demo.Entity.Student;
import com.code515.report.report_demo.Entity.view.ReportView;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/report")
@Slf4j
public class ReportController {

    @Autowired
    private ReportService reportService;
    @Autowired
    private MajorService majorService;
    @Autowired
    private OrganizationService organizationService;
    @Autowired
    private StudentService studentService;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm"); //2020-04-12 21:40

    /**
     * 1.获取所有志愿信息接口
     * @param page 当前页数
     * @param pageSize  一页显示条数
     * @return
     */
    @GetMapping("/getAll")
    public ResultVO getAll_ADMIN(@RequestParam("page")Integer page, @RequestParam("pageSize")Integer pageSize){

        //这里page-1，为了前端容易理解
        Page<ReportView> reportViewPage = reportService.getAll(page-1, pageSize);
        List<ReportView> reportViewList = reportViewPage.getContent();

        //封装ResultVO
        //第一层
        ResultVO resultVO = new ResultVO();
        resultVO.setCode(0);
        resultVO.setMsg("suceess");

        //第二层
        ReportDataVO reportDataVO = new ReportDataVO();
        reportDataVO.setReportTotal((int) reportViewPage.getTotalElements());

        //第三层
        List<ReportViewListVO> reportViewListVOList = new ArrayList();

        for(ReportView report: reportViewList){

            ReportViewListVO reportViewListVO = new ReportViewListVO();

            reportViewListVO.setStudentId(report.getStuId());
            reportViewListVO.setStudentName(report.getStuName());
            reportViewListVO.setMajorName(report.getMajorName());
            reportViewListVO.setClassNumber(report.getStuClass());
            reportViewListVO.setStudentQQ(report.getStuQq());
            reportViewListVO.setStudentPhone(report.getStuPhone());

            ReportInfoVO firstWill = new ReportInfoVO();
            ReportInfoVO secondWill = new ReportInfoVO();

            //填充第一志愿信息 第四层
            if(UserStatusHolder.get().equals(UserStatusEnum.ROOT.getCode().toString()) ||
                    UserOrgHolder.get().equals(report.getOrgFirst())){
                firstWill.setOrganization(report.getOrgFirst());
                firstWill.setBranch(report.getBraFirst());
                firstWill.setReason(report.getReasonFirst());
            }

            //填充第二志愿信息 第四层
            if(UserStatusHolder.get().equals(UserStatusEnum.ROOT.getCode().toString()) ||
                    UserOrgHolder.get().equals(report.getOrgSecond())){
                secondWill.setOrganization(report.getOrgSecond());
                secondWill.setBranch(report.getBraSecond());
                secondWill.setReason(report.getReasonSecond());
            }

            reportViewListVO.setFirstWill(firstWill);
            reportViewListVO.setSecondWill(secondWill);

            reportViewListVO.setIsDispensing(report.getIsDispensing());
            reportViewListVO.setIsEnroll(report.getStuStatus());
            reportViewListVO.setUpdateTime(sdf.format(report.getUpdateTime()));
            reportViewListVO.setCreateTime(sdf.format(report.getCreateTime()));

            reportViewListVOList.add(reportViewListVO); //注意这里
        }

        //封装数据
        reportDataVO.setReportViewListVO(reportViewListVOList);
        resultVO.setData(reportDataVO);

        return resultVO;
    }

    /**
     * 2.提交志愿接口
     */
    @PostMapping("/insert")
    @Transactional
    public ResultVO insert(@RequestParam("stdId")String studentId, @RequestParam("stdName")String studentName, @RequestParam("major")String studentMajor,
                           @RequestParam("classNum")String classNumber, @RequestParam("stdQQ")String studentQQ, @RequestParam("stdPhone") String studentPhone,
                           @RequestParam("firstOrg")String firstOrg, @RequestParam("firstBra")String firstBra, @RequestParam("firstReason")String firstReason,
                           String secondOrg, String secondBra, String secondReason, @RequestParam("isDispensing")Boolean disPensing,@RequestParam("code") String code, HttpServletRequest request){

        if(request.getSession().getAttribute("img-code")==null){
            log.error("验证码生成失败！");
            return new ResultVO(5,"验证码生成失败");
        }
        if(code.isEmpty() || !request.getSession().getAttribute("img-code").equals(code)){
            log.info("【插入失败】验证码错误, 正确验证码:{} , 当前验证码:{} ", request.getSession().getAttribute("img-code"), code);
            return new ResultVO(1,"验证码错误");
        }
        if(firstBra.isEmpty() || firstOrg.isEmpty() || firstReason.isEmpty()){
            log.info("【插入失败】第一志愿信息不完整，firstOrg:{} ,firstBra:{}, firstReason:{}",firstOrg,firstBra,firstReason);
            return new ResultVO(2,"第一志愿信息不完整");
        }
        if(studentService.findById(new Integer(studentId))!=null){
            log.info("【插入失败】该学号已填写过志愿信息，请先联系管理员删除");
            return new ResultVO(3,"志愿已填写");
        }
        if(studentName.isEmpty()){
            log.info("【插入失败】姓名为空");
            return new ResultVO(4,"姓名为空");
        }

        Student student = new Student();
        Report report = new Report();

        student.setStuId(new Integer(studentId));
        student.setStuName(studentName);
        student.setStuMajor(majorService.findByMajorName(studentMajor).getMajorId());
        student.setStuClass(new Integer(classNumber));
        student.setStuQq(studentQQ);
        student.setStuPhone(studentPhone);
        student.setStuStatus(EnrollStatusEnum.UNDER_ENROLL.getMessage());

        //保存学生信息
        studentService.save(student);

        report.setStudentId(new Integer(studentId));
        report.setVolFirst(organizationService.findIdByOrgNameAndBraName(firstOrg,firstBra));
        if(!secondOrg.isEmpty() && !secondBra.isEmpty()){
            report.setVolSecond(organizationService.findIdByOrgNameAndBraName(secondOrg, secondBra));
            report.setReasonSecond(secondReason);
        }
        report.setReasonFirst(firstReason);
        report.setDispensing(disPensing);

        //保存志愿信息
        reportService.save(report);

        ResultVO resultVO = new ResultVO(0, "success");

        return resultVO;
    }

    /**
     * 3.根据学生学号查找志愿接口（）
     * @param stdId 学生学号
     * @return
     */
    @PostMapping("/getByStdId")
    public ResultVO getByStdId_ADMIN(@RequestParam("stdId")String stdId){
        ReportView report = reportService.findByStdId(new Integer(stdId));

        if(report==null){
            return new ResultVO(1,"查找失败");
        }

        ResultVO resultVO = new ResultVO(0,"查找成功");
        ReportViewListVO reportViewListVO = new ReportViewListVO();

        reportViewListVO.setStudentId(report.getStuId());
        reportViewListVO.setStudentName(report.getStuName());
        reportViewListVO.setMajorName(report.getMajorName());
        reportViewListVO.setClassNumber(report.getStuClass());
        reportViewListVO.setStudentQQ(report.getStuQq());
        reportViewListVO.setStudentPhone(report.getStuPhone());

        ReportInfoVO firstWill = new ReportInfoVO();
        ReportInfoVO secondWill = new ReportInfoVO();

        //填充第一志愿信息
        if(UserStatusHolder.get().equals(UserStatusEnum.ROOT.getCode().toString()) ||
                UserOrgHolder.get().equals(report.getOrgFirst())){
            firstWill.setOrganization(report.getOrgFirst());
            firstWill.setBranch(report.getBraFirst());
            firstWill.setReason(report.getReasonFirst());
        }

        //填充第二志愿信息
        if(UserStatusHolder.get().equals(UserStatusEnum.ROOT.getCode().toString()) ||
                UserOrgHolder.get().equals(report.getOrgSecond())){
            secondWill.setOrganization(report.getOrgSecond());
            secondWill.setBranch(report.getBraSecond());
            secondWill.setReason(report.getReasonSecond());
        }

        reportViewListVO.setFirstWill(firstWill);
        reportViewListVO.setSecondWill(secondWill);

        reportViewListVO.setIsDispensing(report.getIsDispensing());
        reportViewListVO.setIsEnroll(report.getStuStatus());
        reportViewListVO.setUpdateTime(sdf.format(report.getUpdateTime()));
        reportViewListVO.setCreateTime(sdf.format(report.getCreateTime()));
        reportViewListVO.setRemark(report.getRemark());

        resultVO.setData(reportViewListVO);
        return resultVO;
    }

    /**
     * 4.录取接口 (管理员身份)
     * @param stdId 学生学号
     * @param organization  录取组织名
     * @param branch    录取分支名
     * @return
     */
    @PostMapping("/enroll_ADMIN")
    @Transactional
    public ResultVO enroll_ADMIN(@RequestParam("stdId")Integer stdId, @RequestParam("organization")String organization, @RequestParam("branch")String branch){
        ReportView reportView = reportService.findByStdId(stdId);

        if(organization.equals(reportView.getOrgFirst()) && branch.equals(reportView.getBraFirst()) && UserOrgHolder.get().equals(reportView.getOrgFirst())
        && studentService.enroll(stdId, 1)){
            log.info("录取学号一志愿: {} 成功" , stdId);
            return new ResultVO(0, "录取成功");
        }

        if(organization.equals(reportView.getOrgSecond()) && branch.equals(reportView.getBraSecond()) && UserOrgHolder.get().equals(reportView.getOrgSecond())
        && studentService.enroll(stdId, 2)){
            log.info("录取学号二志愿: {} 成功" , stdId);
            return new ResultVO(0, "录取成功");
        }
        return new ResultVO(1,"录取失败，参数错误");
    }

    /**
     * 5.录取接口 (超级管理员身份)
     * @param stdId 学生学号
     * @param organization  录取组织名
     * @param branch    录取分支名
     * @return
     */
    @PostMapping("/enroll_ROOT")
    @Transactional
    public ResultVO enroll_ROOT(@RequestParam("stdId")Integer stdId, @RequestParam("organization")String organization, @RequestParam("branch")String branch){

        ReportView reportView = reportService.findByStdId(stdId);

        if(organization.equals(reportView.getOrgFirst()) && branch.equals(reportView.getBraFirst()) && studentService.enroll(stdId, 1)){
            return new ResultVO(0, "录取成功");
        }

        if(organization.equals(reportView.getOrgSecond()) && branch.equals(reportView.getBraSecond()) && studentService.enroll(stdId, 2)){
            return new ResultVO(0, "录取成功");
        }
        return new ResultVO(1,"录取失败，参数错误");
    }

    /**
     * 6.更新志愿信息接口 （管理员身份）
     */
    @PostMapping("/update_ADMIN")
    @Transactional
    public ResultVO update_ADMIN(@RequestParam("stdId")String studentId, @RequestParam("major")String studentMajor,
                                 @RequestParam("classNum")String classNumber, @RequestParam("stdQQ")String studentQQ, @RequestParam("stdPhone") String studentPhone,
                                 String firstOrg, String firstBra, String firstReason,
                                 String secondOrg, String secondBra, String secondReason,@RequestParam("remark")String remark){

        //查询学生
        Student student = studentService.findById(new Integer(studentId));

        if(!student.getStuStatus().equals( EnrollStatusEnum.UNDER_ENROLL.getMessage())){
            log.error("【更新志愿失败】该学生已被录取，不允许修改志愿，学生号:{} ",studentId);
            return new ResultVO(1,"更新失败");
        }

        //查询志愿
        Report report = reportService.findEntityByStdId(new Integer(studentId));

        student.setStuId(new Integer(studentId));
        student.setStuMajor(majorService.findByMajorName(studentMajor).getMajorId());
        student.setStuClass(new Integer(classNumber));
        student.setStuQq(studentQQ);
        student.setStuPhone(studentPhone);
        student.setStuStatus(EnrollStatusEnum.UNDER_ENROLL.getMessage());

        //保存学生信息
        studentService.update(student);

        report.setStudentId(new Integer(studentId));

        //注意管理员身份的组织判断
        if(!firstOrg.isEmpty() && !firstBra.isEmpty() && !firstReason.isEmpty() && UserOrgHolder.get().equals(firstOrg)){

            report.setVolFirst(organizationService.findIdByOrgNameAndBraName(firstOrg,firstBra));
            report.setReasonFirst(firstReason);

        }

        if(!secondOrg.isEmpty() && !secondBra.isEmpty() && !secondReason.isEmpty() && UserOrgHolder.get().equals(secondOrg)){

            report.setVolSecond(organizationService.findIdByOrgNameAndBraName(secondOrg, secondBra));
            report.setReasonSecond(secondReason);
        }
        report.setRemark(remark);

        //保存志愿信息
        reportService.update(report);

        return new ResultVO(0, "更新成功");
    }

    /**
     * 7. 更新志愿信息接口 (超级管理员)
     */
    @PostMapping("/update_ROOT")
    @Transactional
    public ResultVO update_ROOT(@RequestParam("stdId")String studentId, @RequestParam("major")String studentMajor,
                                 @RequestParam("classNum")String classNumber, @RequestParam("stdQQ")String studentQQ, @RequestParam("stdPhone") String studentPhone,
                                 String firstOrg, String firstBra, String firstReason,
                                 String secondOrg, String secondBra, String secondReason, @RequestParam("isDispensing")Boolean disPensing, @RequestParam("remark")String remark){


        //查询学生
        Student student = studentService.findById(new Integer(studentId));

        if(!student.getStuStatus().equals(EnrollStatusEnum.UNDER_ENROLL.getMessage())){
            log.error("【更新志愿失败】该学生已被录取，不允许修改志愿，学生号:{} ",studentId);
            return new ResultVO(1,"更新失败");
        }

        //查询志愿
        Report report = reportService.findEntityByStdId(new Integer(studentId));

        student.setStuId(new Integer(studentId));
        student.setStuMajor(majorService.findByMajorName(studentMajor).getMajorId());
        student.setStuClass(new Integer(classNumber));
        student.setStuQq(studentQQ);
        student.setStuPhone(studentPhone);

        //保存学生信息
        studentService.update(student);

        report.setStudentId(new Integer(studentId));

        if(!firstOrg.isEmpty() && !firstBra.isEmpty() && !firstReason.isEmpty()){

            report.setVolFirst(organizationService.findIdByOrgNameAndBraName(firstOrg,firstBra));
            report.setReasonFirst(firstReason);

        }

        if(!secondOrg.isEmpty() && !secondBra.isEmpty() && !secondReason.isEmpty()){

            report.setVolSecond(organizationService.findIdByOrgNameAndBraName(secondOrg, secondBra));
            report.setReasonSecond(secondReason);
        }
        report.setDispensing(disPensing);
        report.setRemark(remark);

        //保存志愿信息
        reportService.update(report);

        return new ResultVO(0, "更新成功");
    }

    /**
     * 8.删除一条志愿信息接口 (超级管理员身份)
     * @param stdId
     * @return
     */
    @PostMapping("/delete")
    @Transactional
    public ResultVO delete_ROOT(@RequestParam("stdId")Integer stdId){
        reportService.deleteByStdId(stdId);
        studentService.deleteById(stdId);
        log.info("【删除志愿成功】学号：{} ", stdId);
        return new ResultVO(0,"删除成功");
    }
}
