<%--
  Created by IntelliJ IDEA.
  User: lyj
  Date: 2018/7/25
  Time: 17:48
  To change this template use File | Settings | File Templates.
--%>
<!-- web路径：
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
http://localhost:3306/crud
-->

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>Bootstrap 101 Template</title>
    <!-- Bootstrap -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim 和 Respond.js 是为了让 IE8 支持 HTML5 元素和媒体查询（media queries）功能 -->
    <!-- 警告：通过 file:// 协议（就是直接将 html 页面拖拽到浏览器中）访问页面时 Respond.js 不起作用 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
<!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    <!--添加员工信息对话框 -->
    <div class="modal fade" id="empAddDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">Name</label>
                            <div class="col-sm-10">
                                <input name="empName" type="text" class="form-control" id="empName_add_input" placeholder="empName">
                                <span class="help-block"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input type="email" name="email" class="form-control" id="email_add_input" placeholder="Email">
                                <span class="help-block"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender"  id="gender1_add_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label  class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <select class="form-control" name="dId">
                                    <!--从数据库中查找-->
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                </div>
            </div>
        </div>
    </div>

    <!--修改员工信息对话框-->
    <div class="modal fade" id="empEditDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">员工修改</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">Name</label>
                            <div class="col-sm-10">
                                <p class="form-control-static" id="empName_static"></p>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email_edit_input" class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input type="email" name="email" class="form-control" id="email_edit_input" placeholder="Email">
                                <span class="help-block"></span>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender"  id="gender1_edit_input" value="M" checked="checked"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_edit_input" value="F"> 女
                                </label>
                            </div>
                        </div>

                        <div class="form-group">
                            <label  class="col-sm-2 control-label">deptName</label>
                            <div class="col-sm-4">
                                <select id="dep_select" class="form-control" name="dId">
                                    <!--从数据库中查找-->
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_edit_btn">更新</button>
                </div>
            </div>
        </div>
    </div>

    <!--员工信息展示-->
    <div class="container">
        <!--标题-->
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <h1>H-SSM-CRUD</h1>
            </div>
        </div>
        <!--按钮-->
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button  class="btn btn-primary"  id="emp_add_modal_btn">
                    新增
                </button>
                <button  class="btn btn-danger" id="emp_delete_all_btn">
                    删除
                </button>
            </div>
        </div>
        <br />
        <!--显示表格数据-->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="emps_table">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="check_all">
                            </th>
                            <th>#</th>
                            <th>empName</th>
                            <th>gender</th>
                            <th>email</th>
                            <th>deptName</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
        <!--显示分页信息-->
        <div class="row">
            <!--分页信息-->
            <div class="col-md-6" id="pageInfo">
            </div>
            <!--分页条信息-->
            <div class="col-md-6" id="page_nav_area">
                <nav aria-label="Page navigation">
                    <ul class="pagination" id="pagenation">
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <script type="text/javascript">


        var currentPage;//保存当前页数

        //1.页面加载完成以后，直接发送ajax请求，要到分页数据

        $(function () {
            to_page(1);
        })

        //获取指定页面的数据
        function to_page(start) {
            $.ajax({
                url:"${APP_PATH}/emps",
                data:"start="+start,
                type:"GET",
                success:function (result) {
                    console.log(result)
                    //1.解析页面显示员工数据
                    build_emps_table(result)
                    //2.解析分页信息
                    build_page_info(result)
                    //3.解析分页条
                    build_page_nav(result)
                }
            })
        }

        //解析员工数据
        function build_emps_table(result){
            //清空table
            $("#emps_table tbody").empty();
            var emps=result.extend.pageInfo.list;
            $.each(emps,function (index,item) {
                var checkboxTd=$("<td></td>").append($("<input type='checkbox' class='check_item' />"))
                var empIdTd=$("<td></td>").append(item.empId);
                var empNameTd=$("<td></td>").append(item.empName);
                var genderTd=$("<td></td>").append(item.gender=='M'?"男":"女");
                var emailTd=$("<td></td>").append(item.email);
                var deptNameTd=$("<td></td>").append(item.department.deptName);
                var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                                                  .append($("<span></span>")
                                                      .addClass("glyphicon glyphicon-pencil"))
                                                            .append("编辑").attr("edit-id",item.empId);
                var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>")
                        .addClass("glyphicon glyphicon-trash"))
                    .append("删除").attr("delete-id",item.empId);
                var optBtn=$("<td></td>").append(editBtn).append(" ").append(delBtn);
                $("<tr></tr>").append(checkboxTd)
                              .append(empIdTd)
                              .append(empNameTd)
                              .append(genderTd)
                              .append(emailTd)
                              .append(deptNameTd)
                              .append(optBtn)
                    .appendTo("#emps_table tbody");

            })
        }
        //分页信息
        function build_page_info(result) {
            //清空分页信息
            $("#pageInfo").empty();
            var pageInfo=result.extend.pageInfo;

            //分页信息
            var pageNum=pageInfo.pageNum;
            var pages=pageInfo.pages;
            var total=pageInfo.total;
            currentPage=pageNum;
            $("<div></div>").append("当前第"+pageNum+"页,共有"+pages+"页,"+"总计"+total+"条记录").appendTo("#pageInfo");
        }

        //分页条
        function build_page_nav(result) {
            $("#page_nav_area").empty();
            var pageInfo=result.extend.pageInfo;
            var pageNum=pageInfo.pageNum;
            var pages=pageInfo.pages;

            $("#page_nav_area").empty();
            var ulPage=$("<ul></ul>").addClass("pagination")
            //分页
            //1.首页按钮
            var firstPageLi=$("<li></li>").append($("<a></a>").append("首页"));
            //2.后退按钮
            var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));

            if(pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else {
                firstPageLi.click(function () {
                    to_page(1);
                });
                prePageLi.click(function () {
                    to_page(pageNum-1);
                })
            }
            ulPage.append(firstPageLi).append(prePageLi);
            //3.页码按钮

            $.each(pageInfo.navigatepageNums,function (index,item) {
                var li=$("<li></li>").append($("<a></a>").append(item));
                if(item==pageNum){
                     li.addClass("active");
                }
                li.click(function () {
                    to_page(item)
                });
                ulPage.append(li);
            })
            //4.前进按钮
            var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
            //5.尾页按钮
            var lastPageLi=$("<li></li>").append($("<a></a>").append("尾页"));

            if(pageInfo.hasNextPage==false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else {
                nextPageLi.click(function () {
                    to_page(pageNum+1)
                })
                lastPageLi.click(function () {
                    to_page(pages)
                })
            }

            ulPage.append(nextPageLi).append(lastPageLi);

            var navEle = $("<nav></nav>").append(ulPage);
            navEle.appendTo("#page_nav_area");
        }


        //清空表单中的校验信息和基本信息
        function clearForm(ele){
            $(ele)[0].reset();

            //清空表单样式
            $(ele).find("*").removeClass("has-success has-error");  //表单中的所有控件
            $(ele).find(".help-block").text("");//清空校验信息提示框
        }



        //点击新增按钮弹出对话框
        $("#emp_add_modal_btn").click(function () {
            //发送ajax请求，查出部门信息，显示在下拉列表中

            //弹出对话框前重置表单数据
            clearForm("#empAddDialog form");

            getDepts("#empAddDialog select");
            //弹出对话框
            $("#empAddDialog").modal({
                backdrop:"static"
            })
        })

        //查出所有的部门信息并显示在下拉列表中
        function getDepts(ele) {
            //显示部门信息前先清空
            $(ele).empty();
            $.ajax({
                url:"${APP_PATH}/depts",
                type: "GET",
                success:function (result) {
                    //console.log(result);
                    $.each(result.extend.depts,function () {
                        var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                        optionEle.appendTo(ele)
                    })
                }
            })
        }

        //  实时校验姓名和邮箱

        //姓名校验
        $("#empName_add_input").bind('input propertychange',function () {
            //字段不为空进行校验，否则情况校验状态和信息
            var empName=$("#empName_add_input").val();
            if(empName!=""){
                var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
                if(!regName.test(empName)){
                    show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合")
                    return false;
                }else {
                    //用户名的输入没有问题，那么需要继续检验用户名是否在数据库中重复
                    $.ajax({
                        url:"${APP_PATH}/checkuser",
                        type:"GET",
                        data:"empName="+empName,
                        success:function (result) {
                            console.log(result.msg);
                            if(result.code==100){
                                show_validate_msg("#empName_add_input","success","")
                                //给保存按钮设置一个校验属性
                                $("#emp_save_btn").attr("ajax-va-name","success");
                            }else if(result.code==200){
                                $("#emp_save_btn").attr("ajax-va-name","fail");
                                show_validate_msg("#empName_add_input","error","姓名重复，请重新输入信息")
                            }
                        }

                    })
                }
            }else {
                $("#empName_add_input").parent().removeClass("has-success has-error");
                $("#empName_add_input").next("span").text("");
            }
        })

        //邮箱校验
        $("#email_add_input").bind('input propertychange',function () {
            //字段不为空进行校验，否则情况校验状态和信息

            var email=$("#email_add_input").val();
            //当文本框的值不为空的
            if(email!=""){
                var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regEmail.test(email)){
                    $("#emp_save_btn").attr("ajax-va-email","fail");
                    show_validate_msg("#email_add_input","error","邮箱格式不正确");
                    return false;
                }
                else {
                    //邮箱的输入没有问题，那么需要继续检验邮箱是否在数据库中重复
                    $.ajax({
                        url:"${APP_PATH}/checkemail",
                        type:"GET",
                        data:"email="+email,
                        success:function (result) {
                            console.log(result.msg);
                            if(result.code==100){
                                $("#emp_save_btn").attr("ajax-va-email","success");
                                show_validate_msg("#email_add_input","success","");
                            }else if(result.code==200){
                                $("#emp_save_btn").attr("ajax-va-email","fail");
                                show_validate_msg("#email_add_input","error","邮箱重复")
                            }
                        }

                    })
                }
            }else {
                $("#email_add_input").parent().removeClass("has-success has-error");
                $("#email_add_input").next("span").text("");
            }
        })

        //显示校验提示信息
        function show_validate_msg(ele,status,msg){
            //清除当前元素的校验状态
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");

            if(status === "success"){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if(status === "error"){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }

        //点击保存员工信息
        //校验：前端+后端
        $("#emp_save_btn").click(function () {

            //1.校验表单数据

            //拿到保存按钮中ajax-va属性的值，判断是否双重验证通过
            if($(this).attr("ajax-va-name") === "fail" ||$(this).attr("ajax-va-email") === "fail"){
                return false;
            }else if($(this).attr("ajax-va-name") === "success"&&$(this).attr("ajax-va-email") === "success"){
                //2.保存数据
                $.ajax({
                    url:"${APP_PATH}/emp",
                    type:"PUT",
                    data:$("#empAddDialog form").serialize(),//获取表单数据
                    success:function (result) {
                        if(result.code === 100){
                            //1. 关闭对话框
                            $("#empAddDialog").modal("hide")

                            //2.刷新页面
                            to_page(1);
                        }else if(result.code === 200){
                            //显示失败信息
                            console.log(result);
                            //有哪个字段的错误信息就显示
                            if(result.extend.errorFields.email !== undefined){
                                //显示邮箱错误信息
                                show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                            }
                            if(result.extend.errorFields.empName !== undefined){
                                //显示名字的错误信息
                                show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                            }
                        }

                    }
                })
            }else {
                return false;
            }
        })



        //校验员工修改对话框中的邮箱
        $("#email_edit_input").bind('input propertychange',function () {
            //字段不为空进行校验，否则情况校验状态和信息
            //console.log(123123);
            var email=$("#email_edit_input").val();

            //当文本框的值不为空的
            if(email!=""){
                console.log(email)
                var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if(!regEmail.test(email)){
                    $("#emp_edit_btn").attr("ajax-va-email","fail");
                    show_validate_msg("#email_edit_input","error","邮箱格式不正确");
                    return false;
                }
                else {
                    $("#emp_edit_btn").attr("ajax-va-email","success");
                    show_validate_msg("#email_edit_input","success","");
                }
            }else {
                $("#email_edit_input").parent().removeClass("has-success has-error");
                $("#email_edit_input").next("span").text("");
            }
        })

        //给动态生成的按钮添加点击事件
        //给编辑按钮绑定click事件，弹出修改信息对话框
        //on()方法：在选择元素上绑定一个或多个事件的事件处理函数。
        $(document).on("click",".edit_btn",function () {
            //0.清空对话框样式
            clearForm("#empEditDialog form")
            //1.查出员工信息
            getEmp($(this).attr("edit-id"))
            //2.查出部门信息
            getDepts("#empEditDialog select");
            //3.弹出编辑框，并讲员工Id传递到更新按钮上
            $("#emp_edit_btn").attr("edit-id",$(this).attr("edit-id"))
            $("#empEditDialog").modal({
                backdrop:"static"
            })
        })


        //查询单个员工信息
        function getEmp(id) {
            //会出现请求不到的情况
            $.ajax({
                url:"${APP_PATH}/emp/"+id,
                type:"GET",
                success:function (result) {
                    if(result.code==100) {
                        var employee = result.extend.employee;
                        $("#empName_static").text(employee.empName);
                        $("#email_edit_input").val(employee.email);
                        $("#empEditDialog input[name=gender]").val([employee.gender]);
                        $("#empEditDialog select ").val(employee.dId);
                    }
                    else {
                        alert("请求失败！")
                    }
                }
            })
        }


        //点击更新，更新员工信息
        $("#emp_edit_btn").click(function () {
            //1.先验证邮箱
            //2.发送ajax请求，保存员工信息
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
                type:"POST",
                data:$("#empEditDialog form").serialize(),
                success:function (result) {
                    //1.关闭修改框
                    $("#empEditDialog").modal("hide")
                    //2.跳转到修改页面
                    to_page(currentPage);
                }
            })
        })


        //给单个删除按钮添加点击事件
        //on()方法：在选择元素上绑定一个或多个事件的事件处理函数。
        $(document).on("click",".delete_btn",function () {
            //1.弹出是否确认删除对话框(需要显示被删条目的empName)
            //当前按钮的父元素为<td>，所以使用parents才能找到tr
            var empName=$(this).parents("tr").find("td:eq(2)").text();
            var empId=$(this).attr("delete-id");
            if(confirm("确认删除【"+empName+"】吗?")){
                //确认  发ajax请求，删除
                $.ajax({
                    url:"${APP_PATH}/emp/"+empId,
                    type:"DELETE",
                    success:function (result) {
                        //删完以后回到本页
                        to_page(currentPage);
                    }
                })
            }


        })

        //完成全选/全不全
        $("#check_all").click(function () {
            //获取dom原生的属性，不能使用attr，使用prop
            $(".check_item").prop("checked",$(this).prop("checked"))
        })

        //check_item全部选了，check_all也选定,因为选择框都是动态生成的，所以要使用on
        $(document).on("click",".check_item",function () {
            //判断是否选满
            let flag=$(".check_item:checked").length==$(".check_item").length
            $("#check_all").prop("checked",flag)
        })

        //点击全部删除
        $("#emp_delete_all_btn").click(function () {
            var empNames="";
            var del=""
            $.each($(".check_item:checked"),function () {
                //组装员工名字
                empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
                //组装员工id
                del+=$(this).parents("tr").find("td:eq(1)").text()+"-";
            })
            if(confirm("确认删除【"+empNames.substring(0,empNames.length-1)+"】吗？")){
                //发送ajax请求
                $.ajax({
                    url:"${APP_PATH}/emp/"+del.substring(0,del.length-1),
                    type:"DELETE",
                    success:function (result) {
                        alert(result.msg);
                        //回到当前页面
                        to_page(currentPage);
                    }
                })
            }

        })

    </script>

</body>
</html>

