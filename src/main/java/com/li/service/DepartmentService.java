package com.li.service;

import com.li.pojo.Department;


import java.util.List;

public interface DepartmentService {
    List<Department> list();

    void add(Department department);

    void update(Department department);

    void delete(int id);

    Department get(int id);
}
