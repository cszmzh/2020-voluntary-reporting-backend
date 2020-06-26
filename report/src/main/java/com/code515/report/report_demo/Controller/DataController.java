package com.code515.report.report_demo.Controller;

import com.code515.report.report_demo.Service.DataViewService;
import com.code515.report.report_demo.VO.ResultVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/data")
public class DataController {

    @Autowired
    private DataViewService dataViewService;

    /**
     * 1.获取数据分析情况
     * @return ResultVO
     */
    @GetMapping("/get")
    public ResultVO getData_ADMIN(){
        ResultVO resultVO = new ResultVO();
        resultVO.setCode(0);
        resultVO.setMsg("success");
        resultVO.setData(dataViewService.getCountData());
        return resultVO;
    }

}
