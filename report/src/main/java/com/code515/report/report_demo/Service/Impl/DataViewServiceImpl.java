package com.code515.report.report_demo.Service.Impl;

import com.code515.report.report_demo.Entity.view.DataView;
import com.code515.report.report_demo.Repository.DataViewRepository;
import com.code515.report.report_demo.Service.DataViewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DataViewServiceImpl implements DataViewService {

    @Autowired
    private DataViewRepository repository;

    @Override
    public DataView getCountData() {
        return repository.findAll().get(0);
    }
}
