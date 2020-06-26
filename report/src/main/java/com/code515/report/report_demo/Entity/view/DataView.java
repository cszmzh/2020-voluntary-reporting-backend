package com.code515.report.report_demo.Entity.view;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
@Data
public class DataView {

    @Id
    private Integer totalReport;
    private Integer tuanweiFirst;
    private Integer tuanweiSecond;
    private Integer xueshenghuiFirst;
    private Integer xueshenghuiSecond;
    private Integer kexieFirst;
    private Integer kexieSecond;
    private Integer zhuxueFirst;
    private Integer zhuxueSecond;
    private Integer xinwenFirst;
    private Integer xinwenSecond;

}
