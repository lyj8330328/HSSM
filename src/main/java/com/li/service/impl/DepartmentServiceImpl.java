package com.li.service.impl;

import com.li.dao.DepartmentMapper;
import com.li.pojo.Department;

import com.li.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> list() {
        return departmentMapper.selectByExample(null);
    }

    public void add(Department department) {
        departmentMapper.insertSelective(department);
    }

    public void update(Department department) {
        departmentMapper.updateByExampleSelective(department,null);
    }

    public void delete(int id) {
        departmentMapper.deleteByPrimaryKey(id);
    }

    public Department get(int id) {
        return departmentMapper.selectByPrimaryKey(id);
    }
}
