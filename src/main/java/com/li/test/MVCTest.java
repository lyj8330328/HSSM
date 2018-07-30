package com.li.test;

import com.github.pagehelper.PageInfo;
import com.li.dao.DepartmentMapper;
import com.li.dao.EmployeeMapper;
import com.li.pojo.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 测试CRUD请求
 */

/**
 * 报错java.lang.NoClassDefFoundError: javax/servlet/SessionCookieConfig
 * 需要servlet3.0支持
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration(value = "src/main/resources") //要修改路径
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springMVC.xml"})
public class MVCTest {

    //传入Spring mvc的IOC
    @Autowired
    WebApplicationContext context;

    //虚拟的mvc请求
    MockMvc mockMvc;

    @Before
    public void initMockMvc(){
       mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception{
       MvcResult mvcResult=mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("start","1")).andReturn();
       MockHttpServletRequest request=mvcResult.getRequest();
       PageInfo pageInfo=(PageInfo) request.getAttribute("pageInfo");
       System.out.println("当前页码："+pageInfo.getPageNum());
        System.out.println("总页码："+pageInfo.getPages());
        System.out.println("总记录数："+pageInfo.getTotal());
        System.out.println("在页面需要连续显示的页码：");
        int [] nums=pageInfo.getNavigatepageNums();
        for (int i:nums){
            System.out.println(" "+i);
        }

        //获取员工数据
        List<Employee> employeeList=pageInfo.getList();
        for(Employee employee:employeeList){
            System.out.println("ID:"+employee.getEmpId());
        }
    }

}
