package com.li.service;

import com.li.pojo.Employee;

import java.util.List;

public interface EmployeeService {

    List<Employee> list();

    void add(Employee employee);

    void update(Employee employee);

    void delete(int id);

    Employee get(int id);

    boolean checkUser(String empName);

    boolean checkEmail(String email);

    void deleteBatch(List<Integer> ids);
}
