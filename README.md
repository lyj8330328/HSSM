# 一、功能点分析
## 1.分页
## 2.数据校验（jQuery前端校验+JSR303后端校验）
## 3.ajax（发送请求，获取并解析JSON数据）
## 4.RESTful风格的URI:使用HTTP协议请求方式的动词，来表示对资源的操作{GET（查询）、POST（修改）、PUT（新增）、DELETE（删除）}
# 二、技术点分析
## 1.基础框架SSM（Spring+SpringMVC+Mybatis）
## 2.数据库MySQL
## 3.前端框架BootStrap
## 4.Maven
## 5.分页插件PageHelper
## 6.逆向工程MyBatis Generator
# 三、基础环境搭建（IDEA）
## 1.使用IDEA创建一个maven工程
## 2.引入项目需要的jar包
<font size="4">   

- 版本号  
```bash
    <properties>
        <spring.version>4.3.7.RELEASE</spring.version>
    </properties>
```
- Spring  
```bash
    <!--Spring JDBC-->
    <!-- https://mvnrepository.com/artifact/org.springframework/spring-jdbc -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-jdbc</artifactId>
        <version>${spring.version}</version>
    </dependency>
    <!--Spring面向切面编程-->
    <!-- https://mvnrepository.com/artifact/org.springframework/spring-aspects -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-aspects</artifactId>
        <version>${spring.version}</version>
    </dependency>

    <!-- https://mvnrepository.com/artifact/org.springframework/spring-context -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-context</artifactId>
        <version>${spring.version}</version>
    </dependency>

    <!--Spring单元测试-->
    <!-- https://mvnrepository.com/artifact/org.springframework/spring-test -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-test</artifactId>
        <version>${spring.version}</version>
    </dependency>
```
- Spring MVC
```bash
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-webmvc</artifactId>
        <version>${spring.version}</version>
    </dependency>
```
- Mybatis
```bash
    <!--Mybatis-->

    <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
    <dependency>
        <groupId>org.mybatis</groupId>
        <artifactId>mybatis</artifactId>
        <version>3.4.1</version>
    </dependency>

    <!--Mybatis整合Spring的适配包-->
    <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis-spring -->
    <dependency>
        <groupId>org.mybatis</groupId>
        <artifactId>mybatis-spring</artifactId>
        <version>1.3.2</version>
    </dependency>

    <!--mybatis逆向工程-->
    <!-- https://mvnrepository.com/artifact/org.mybatis.generator/mybatis-generator-core -->
    <dependency>
        <groupId>org.mybatis.generator</groupId>
        <artifactId>mybatis-generator-core</artifactId>
        <version>1.3.5</version>
    </dependency>
```
- 数据库连接池，驱动
```bash
    <dependency>
        <groupId>com.alibaba</groupId>
        <artifactId>druid</artifactId>
        <version>1.0.18</version>
    </dependency>

    <!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <version>5.1.46</version>
    </dependency>
```
- 其他（jstl、servlet-api、jsp-api、junit、pagehelper、jackson-databind、hibernate-validator）
```bash
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>jstl</artifactId>
        <version>1.2</version>
    </dependency>

    <!-- https://mvnrepository.com/artifact/taglibs/standard -->
    <dependency>
        <groupId>taglibs</groupId>
        <artifactId>standard</artifactId>
        <version>1.1.2</version>
    </dependency>

    <!-- https://mvnrepository.com/artifact/javax.servlet/javax.servlet-api -->
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>javax.servlet-api</artifactId>
        <version>3.1.0</version>
        <scope>provided</scope>
    </dependency>

    <!-- https://mvnrepository.com/artifact/javax.servlet/jsp-api -->
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>jsp-api</artifactId>
        <version>2.0</version>
        <scope>provided</scope>
    </dependency>


    <!-- https://mvnrepository.com/artifact/junit/junit -->
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.12</version>
    </dependency>

    <!--分页-->
    <!-- https://mvnrepository.com/artifact/com.github.pagehelper/pagehelper -->
    <dependency>
        <groupId>com.github.pagehelper</groupId>
        <artifactId>pagehelper</artifactId>
        <version>5.1.4</version>
    </dependency>

    <dependency>
        <groupId>com.fasterxml.jackson.core</groupId>
        <artifactId>jackson-databind</artifactId>
        <version>2.8.8</version>
    </dependency>


    <!--JSR303数据校验支持-->
    <!-- https://mvnrepository.com/artifact/org.hibernate/hibernate-validator -->
    <dependency>
        <groupId>org.hibernate</groupId>
        <artifactId>hibernate-validator</artifactId>
        <version>5.4.1.Final</version>
    </dependency>

```
</font>  

## 3.引入BootStrap框架
## 4.SSM配置
<font size="4">  

- Spring配置（applicationContext.xml）  
<1>配置自动扫描的包component-scan，并且设置不扫描带Controller注解的类，将其交由Spring MVC来扫描  
<2>加载静态数据库配置信息（username、password、url、driverClassName）  
<3>配置数据库连接池Druid  
<4>整合Mybatis（加载mybatis-config.xml配置文件，配置第三方分页插件）  
<5>配置事务控制
- Spring MVC 配置（springMVC.xml）  
<1>配置自动扫描的包（mvc层只负责扫描controller）  
<2>配置视图解析器  
<3>允许加载静态资源（bootstrap,jquery）  
<4>开启注解驱动
- Mybatis配置（mybatis-config.xml）  
配置typeAliases
- 数据库信息资源  
配置username、password、url、driverClassName
- web.xml配置  
<1>加载Spring的配置文件  
<2>加载Spring MVC的配置文件（DispatcherServlet）  
<3>配置过滤器（编码、实现RESTful、处理PUT请求）
- SSM配置依赖图  
![SSM配置依赖图](https://image-1255440489.cos.ap-chengdu.myqcloud.com/HSSM%E9%85%8D%E7%BD%AE%E7%BB%93%E6%9E%84%E5%9B%BE.jpg)
</font>  
## 5.配置Mybatis Generator（mybatisGeneratorConfig.xml用来生成pojo对象和对应的mapper）  
## 6.测试mapper
# 四、查询
## 1.访问首页
## 2.首页发送ajax请求，分页查询员工数据
## 3.服务器将查出的数据以JSON字符串的形式返回给首页
## 4.首页收到JSON数据后，使用js对JSON数据进行解析，js通过dom增、删、改来显示数据
# 五、新增
## 1.点击新增按钮
## 2.弹出增加员工对话框
## 3.去数据库中查询部分列表显示在对话框的下拉列表中
## 4.输入数据，进行校验
<font size="4">  

- jQuery前端校验
- ajax用户名、邮箱重复校验
- 后端JSR303校验
- 数据库校验（唯一约束）  
</font>  

## 5.完成保存
# 六、修改
## 1.点击编辑
## 2.弹出修改对话框（显示用户信息，弹出之前需要ajax发送请求，获取要修改用户的数据）
## 3.用户名无法修改，需要对邮箱进行再次校验
## 4.点击更新，完成用户修改，修改完回到该数据所在页
# 七、删除
## 1.单个/批量删除
<font size="4">  
删除单个数据，直接将对应id传入后台即可；删除多个，将要删除的数据id进行拼接，传入后台后再进行分割，然后批量删除。
</font>  

## 2.URI:/emp/{ids} ELETE
# 八、总结
![总结](https://image-1255440489.cos.ap-chengdu.myqcloud.com/HSSM%E6%80%BB%E7%BB%93.png )

