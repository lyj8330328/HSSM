package com.li.service.impl;

import com.li.dao.EmployeeMapper;
import com.li.pojo.Employee;
import com.li.pojo.EmployeeExample;
import com.li.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    public List<Employee> list() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    public void add(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public void update(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void delete(int id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public Employee get(int id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    //检验用户名
    public boolean checkUser(String empName) {
        EmployeeExample employeeExample= new EmployeeExample();
        EmployeeExample.Criteria criteria=employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    //检验邮箱
    public boolean checkEmail(String email) {
        EmployeeExample employeeExample= new EmployeeExample();
        EmployeeExample.Criteria criteria=employeeExample.createCriteria();
        criteria.andEmailEqualTo(email);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria=example.createCriteria();
        criteria.andEmpIdIn(ids);

        employeeMapper.deleteByExample(example);
    }
}
