package com.code515.report.report_demo.Entity;

import lombok.Data;
import org.hibernate.annotations.DynamicUpdate;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import java.util.Date;

@Entity
@Data
@DynamicUpdate
public class Report {

  @Id
  @GeneratedValue
  private Integer reportId;
  private Integer studentId;
  private Integer volFirst;
  private Integer volSecond;
  private String reasonFirst;
  private String reasonSecond;
  private boolean isDispensing;
  private Date updateTime;
  private Date createTime;
  private String remark;
}
