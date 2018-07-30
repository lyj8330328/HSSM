package com.li.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.li.pojo.Employee;
import com.li.pojo.Message;
import com.li.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;


    @RequestMapping(value = "/emps",method = RequestMethod.GET)
    @ResponseBody
    //获取全部员工数据
    public Message getEmpsWithJson(@RequestParam(value = "start",defaultValue = "1") int start, @RequestParam(value = "size",defaultValue = "10") int size){
        PageHelper.startPage(start,size,"emp_id desc");
        List<Employee> employeeList=employeeService.list();
        //每回显示连续的5页
        /**
         * 原理：当前查询页为start,显示连续的5页即获取的分页为：start-2,start-1,start,start+1,start+2
         */
        PageInfo<Employee> pageInfo=new PageInfo<Employee>(employeeList,5);
        return Message.success().add("pageInfo",pageInfo);
    }

    @RequestMapping(value = "/emp",method = RequestMethod.PUT)
    @ResponseBody
    //保存员工信息
    public Message saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //校验失败
            Map<String,Object> map=new HashMap<String, Object>();
            List<FieldError> errors=result.getFieldErrors();
            for(FieldError fieldError:errors){
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Message.fail().add("errorFields",map);
        }else {
            employeeService.add(employee);
            return Message.success();
        }
    }

    @RequestMapping(value = "/checkuser",method = RequestMethod.GET)
    @ResponseBody
    //检验名字是否重复
    public Message checkEmpUser(@RequestParam("empName") String empName){

        boolean check=employeeService.checkUser(empName);
        if(check){
            return Message.success();
        }else {
            return Message.fail();
        }
    }

    @RequestMapping(value = "/checkemail",method = RequestMethod.GET)
    @ResponseBody
    //检验邮箱是否重复
    public Message checkEmpEmail(@RequestParam("email") String email){

        boolean check=employeeService.checkEmail(email);
        if(check){
            return Message.success();
        }else {
            return Message.fail();
        }
    }

    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    //查询单个员工信息
    public Message getEmp(@PathVariable("id") int empId){

        Employee employee=employeeService.get(empId);
        if (employee!=null){
            return Message.success().add("employee",employee);
        }else {
            return Message.fail();
        }
    }

    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.POST)
    //注意这儿的请求路径所带id的变量名为什么是empId？因为只有与employee  pojo中的字段名相同，这样员工id才能被封装进employee对象当中去
    @ResponseBody
    //更新员工信息
    public Message updateEmp(Employee employee){
        employeeService.update(employee);
        return Message.success();
    }

    /**
     * 单个、批量删除二合一
     * 批量删除：1-2-3
     * 单个删除：单个id
     * @param ids
     * @return
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    //批量或者删除一条员工信息
    public Message deleteEmpById(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            String[] str_id=ids.split("-");
            List<Integer> id_list=new ArrayList<Integer>();
            for (String id:str_id){
                id_list.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(id_list);
        }else {
            employeeService.delete(Integer.parseInt(ids));
        }
        return Message.success();
    }


}
