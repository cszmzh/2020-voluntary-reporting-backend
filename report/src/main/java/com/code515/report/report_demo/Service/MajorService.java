package com.code515.report.report_demo.Service;

import com.code515.report.report_demo.Entity.Major;

public interface MajorService {

    /**
     * 1.通过专业名寻找专业信息
     * @param name  专业名
     * @return
     */
    Major findByMajorName(String name);

}
