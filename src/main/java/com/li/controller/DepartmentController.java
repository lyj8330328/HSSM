package com.li.controller;

import com.li.pojo.Department;
import com.li.pojo.Message;
import com.li.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {


    @Autowired
    private DepartmentService departmentService;

    @RequestMapping(value = "/depts")
    @ResponseBody
    public Message getDept(){
        return  Message.success().add("depts",departmentService.list());
    }
}
