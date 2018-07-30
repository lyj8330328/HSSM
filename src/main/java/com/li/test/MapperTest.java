package com.li.test;


import com.li.dao.DepartmentMapper;
import com.li.dao.EmployeeMapper;
import com.li.pojo.Department;
import com.li.pojo.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class MapperTest {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private SqlSession sqlSession;

    /**
     * 测试DepartmentMapper
     */
    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);
        System.out.println(employeeMapper);

        //1.插入部门
//        departmentMapper.insertSelective(new Department(null,"开发部门"));
//        departmentMapper.insertSelective(new Department(null,"测试部门"));

        //2.插入员工
        //employeeMapper.insertSelective(new Employee(null,"A","M","897987@qq.com",1));

        //3.批量出入多个员工
//        EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
//        for (int i=0;i<1000;i++){
//            String uid=UUID.randomUUID().toString().substring(0,5)+i;
//            mapper.insertSelective(new Employee(null,uid,"M",uid+"@lyj.com",1));
//        }


    }
}
