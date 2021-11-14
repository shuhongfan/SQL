### 数据库期中考试题型及样题

```sql
一、选择题：
1．下列SQL关键字中用于修改表结构的是(  A  )。
A．ALTER		B、CREATE		C、UPDATE		D、INSERT   

2．SQL中创建视图应使用(  C  )语句。
    A．CREATE SCHEMA	B、CREATE TABLE	C、CREATE VIEW  D、CREATE DATABASE     

3. SELECT语句执行的结果是(  B  )。
A．数据项        B．元组       C．表        D．视图

二、判断题
1. 一条UPDATE中只能使用一个表。  ×
2. 当通过视图修改数据成功时，实际上对应基本表的数据也修改成功.  √

三、 程序阅读题
1. select departmentId, count（*） from  Employee group by  departmentId
查出员工的部门号和人数，按部门号分组

2. Declare  cur_Stu cursor for  select * from Student where birthdate>'2001-1-1'
创建游标cur_Stu，查询在'2001-1-1'出生的学生信息

四、设计题
1. 设某图书管理系统中有2个实体集，
一是“读者”实体集，属性有读者编号、读者姓名、性别、以及年龄；
二是“图书”实体集，属性有图书编号、图书名称、价格、价格以及入库时间；
一个读者可以借阅多本图书，一本图书也可以为多个读者借阅，请画出对应的E-R图。


2. 写出如下关系模式的建表语句
（1）学生（学号，姓名，性别，年龄，专业）
（2）课程（课程号，课程名，学时，学分）
（3）选课（学号，课程号，成绩）
create table 学生(
    学号 int primary key,
    姓名 varchar(50),
    性别 int,
    年龄 int,
    专业 varchar(50)
);

create table 课程(
    课程号 int primary key,
    课程名 varchar(50),
    学时 int,
    学分 int
);

create table 选课(
    学号 int primary key ,
    课程号 int,
    成绩 float
);

3. 针对上面三个表，写出下面操作对应的SQL语句
（1）查询年龄为20岁的学生信息
select * from 学生 where 年龄=20;

（2）统计各专业的学生人数
select 专业,count(*) from 学生 group by 专业;

（3）查询数据库课程学生的成绩，列出学号、姓名、性别、成绩
select 学号,姓名,性别,成绩 from 学生,选课,课程 where 学生.学号=选课.学号 and 选课.课程号=课程.课程号 and 课程名='数据库'

（4）删除没有选课的学生
delete from 学生 where 学号 not in(select distinct 学号 from 选课);

（5）将男生的年龄增加1岁
update 学生 set 年龄=年龄+1 where 性别='男';

（6）设置学号为200201的学生选修004号课程
insert into 选课(学号,课程号) values('200201',004);

（7）创建的“计算机”专业的学生视图，列名为：学号、姓名、性别、年龄
create view 计算机专业 as
select 学号,姓名,性别,年龄 from 学生 where 专业='计算机';
```

![image-20211114142642045](https://cdn.jsdelivr.net/gh/shuhongfan/Typora@main/img/202111141426138.png)

### 数据库复习资料

```sql
-- 针对员工管理数据库中的下面的三个表：
-- Employee(EmployeeID, EmpName, sex, birthdate, DeptId) //员工(员工ID，姓名，性别，部门ID)
-- Department(DeptId, DepartmentName,Tel) //部门(部门ID，部门名称，电话)
-- Salary(SalId, EmployeeID, year, month, income, outcome)// 工资Id，员工Id，年，月份，收入，扣减)

-- 1. 请写出下面的语句的功能：
select EmpName from Employee where sex =1 and birthdate>= '2000-1-1'
-- 从员工表中查询出性别为1并且生日大于‘2000-1-1’员工姓名

select sex, count(*) from  Employee group by  sex
-- 从员工表中通过性别分组，分别查询男和女的人数

select EmployeeID, EmpName, sex, DepartmentName
    from Employee E inner join Department D
        on E.DeptID =D.DeptID
        where EmpName like  '%国%'
-- 查询员工姓名中含有‘国’的员工ID、姓名、性别、部门名称

select EmployeeID, EmpName
from Employee
where EmployeeID in (
    select EmployeeID from Salary
        where income – outcome >10000
    )
-- 查询 实际收入(收入-扣减) 大于10000 的员工ID、姓名


-- 3. 下面是学生成绩数据库中的下面的三个关系模式（表），其含义见右侧的汉字说明。
-- Student(sno, sname, sex, age, major)  //学生（学号，姓名，性别，年龄，所在专业）
-- Course(cno, cname, credit, term, hours) //课程（课程号，课程名，学分，学期，学时）
-- SC(sno, cno, grade)   //选课(学号，课程号，成绩)
-- 请写出下面的操作（应用需求）对应的语句：

-- (2) 查询“计算机”专业男生的学号和姓名
select sno,sname from Student where major='计算机'

-- (3) 查询第1学期所上的所有课程的总学时
select sum(学时) from Course where term=1

-- (4)查询“数据库”课程的学生成绩，列出学号、姓名、所在专业、成绩，按成绩降序、学号升序排列；
select Student.sno,sname,major,grade
from Student,SC
where Student.sno=SC.sno
order by grade desc,Student.sno asc

-- (5) 查询成绩不及格的学生学号和姓名；
select sno,sname from Student where sno in(
    select sno from SC where grade<60
)

-- (6)查询“数据库”课程的选课人数、最高分、最低分、平均分；
select count(sno) 选课人数,max(grade) 最高分,min(grade) 最低分,avg(isnull(grade,0)) 平均分 from SC where cno in(
    select cno from Course where cname='数据库'
)

-- (7) 设置学号为21001的学生选修课程号为BX001的课程——考查添加记录
insert into SC(sno, cno) values('21001','BX001');

-- (8) 将原学时数在4以上的课程的学时增加1。
alter table Course set hours=hours+1 where hours>4;

-- (9) 删除成绩为空的选课记录。
delete from SC where grade is null

-- (10)将有成绩在90分以上的学生的学号、姓名建立视图V_ExcelStu。
create view V_ExcelStu as
    select sno, sname from Student where sno in(
        select distinct sno from SC where grade>90
        )
        
create table 图书(
    书号 char(20) primary key,
    书名 varchar(40) not null,
    出版年份 int,
    印刷数量 int,
    单价 int
);
create table 作者(
    作者号 char(20) primary key,
    作者名 varchar(40) not null,
    职称 char(4) check(职称 in('高级','中级'))
);
create table 出版(
    书号 char(20) references 图书(书号),
    作者号 char(20) references 作者(作者号),
    作者序号 tinyint,
    primary key (书号,作者号)
);

select 书名,单价 from 图书 where 出版年份=2014;

select sum(印刷数量) from 图书,作者,出版
where 图书.书号=出版.书号 and 作者.作者号=出版.作者号 and 职称='高级';

update 图书 set 单价=单价*0.9 where 出版年份<2012;

insert into 作者 values ('z100','新作者',null);

create view V1 as
    select 书名,出版年份,印刷数量 from 图书 where 印刷数量>5000;




create table 教师(
    教师号 char(10) primary key ,
    教师名 varchar(20) not null ,
    所在部门 varchar(30),
    职称 char(6) check(职称 in ('教授','副教授','其他'))
)
create table 课程(
    课程号 char(20) primary key ,
    课程名 varchar(40) not null ,
    学时数 tinyint,
    开课学期 tinyint
)
create table 授课(
    教师号 char(10),
    课程号 char(20),
    授课时数 int,
    授课年份 int,
    primary key (教师号,课程号,授课年份),
    foreign key(教师号) references 教师(教师号),
    foreign key(课程号) references 课程(课程号)
)

select 教师名,所在部门 from 教师 where 职称='教授'

select 开课学期,count(*) 课程门数 from 课程 where 学时数>40 group by 开课学期;

select 课程名,学时数,教师名,授课时数
from 课程
    join 授课 on 课程.课程号 = 授课.课程号
    join 教师 on 授课.教师号 = 教师.教师号
where 授课年份=2012;

delete from 课程 where 课程号 not in(
    select 课程号 from 授课
    )

create view V2 as
    select 教师名,课程名,授课时数
    from 授课
    join 教师 on 授课.教师号=教师.教师号
    join 课程 on 授课.课程号 = 课程.课程号
    where 授课年份=2014



create table 汽车(
    汽车型号 char(20) primary key ,
    汽车类别 char(6) check(汽车类别 in('小轿车','商务车')),
    生产年份 int
);
create table 经销商(
    经销商号 char(20) primary key ,
    经销商名 varchar(40) not null ,
    地址 varchar(50)
);
create table 销售(
    经销商号 char(20),
    汽车型号 char(20),
    销售时间 datetime,
    销售价格 int,
    primary key(经销商号,汽车型号,销售时间),
    foreign key (经销商号) references 经销商(经销商号),
    foreign key (汽车型号) references 汽车(汽车型号)
);

select 汽车型号,汽车类别 from 汽车 where 生产年份=2014;

select count(*) 销售总数量 from 销售 where 销售价格 >= 300000;

update 销售 set 销售价格=销售价格-50000 where 销售价格>500000;

insert into 汽车 values ('Q100','小轿车',2014);

create view V3 as
    select 经销商名,地址 from 经销商
    join 销售 on 经销商.经销商号 = 销售.经销商号
    join 汽车 on 汽车.汽车型号 = 销售.汽车型号
where 汽车类别='小轿车'
```



### 视图

```sql
-- 视图是一张虚拟表，他所存储的不是实际数据，而是查询语句，但我们可以对视图进行像数据表一样的操作
-- 视图创建
create view vm_city
as
select cityName from city;

-- 视图查询
select * from vm_city;

```



### 游标

```sql
-- 定义游标
declare orderNum_02_cursor cursor scroll for select OrderId from bigorder where orderNum='ZEORD003402';

-- 打开游标
open orderNum_02_cursor;

-- 提取数据
-- 第一行
fetch first from orderNum_02_cursor;

-- 最后一行
fetch last from orderNum_02_cursor;

-- 相对 从当前位置数 到n行
fetch relative 3 from orderNum_02_cursor;

-- 绝对 从游标的第一行开始数 到n行
fetch absolute 3 from orderNum_02_cursor;

-- 当前位置的下一行
fetch next from orderNum_02_cursor;

-- 当前位置的上一行
fetch prior from orderNum_02_cursor;


-- 提前数据赋值给变量
declare @OrderId int;
fetch absolute 3 from orderNum_02_cursor into @OrderId;

-- 通过检测全局变量@@Fetch_Status的值，获得提取状态信息
-- 0，Fetch语句成功。
-- -1：Fetch语句失败或行不在结果集中。
-- -2：提取的行不存在
declare @OrderId int;
fetch absolute 3 from orderNum_02_cursor into @OrderId;
while @@FETCH_STATUS=0 -- 提取成功，进行下一条数据的提取操作
    select @OrderId as id  fetch next from orderNum_02_cursor into @OrderId;


-- 利用游标更新删除数据
-- 1.声明游标
declare orderNum_03_cursor cursor scroll
for select OrderId,userId from bigorder where orderNum='ZEORD003402';

-- 2.打开游标
open orderNum_03_cursor;

-- 3.声明游标提取数据所要存放的变量
declare @OrderId int,@userId varchar(15);

-- 4.定位游标到哪一行
fetch first from orderNum_03_cursor into @OrderId,@userId
while @@FETCH_STATUS=0
    if @OrderId=122182
        update bigorder set UserId='123' where Current of orderNum_03_cursor; -- 5.修改
    if @OrderId=154074
        delete bigorder where current of orderNum_03_cursor; -- 5.删除当前行
    fetch next from orderNum_03_cursor into @OrderId,@userId; -- 移动游标

-- 6. 关闭游标
close orderNum_03_cursor;

-- 7.删除游标
deallocate orderNum_03_cursor;
```

### 课本习题

```sql
create database test on(
    name=test_data,
    filename='D:\Develop\sqlServer\test_data.mdf',
    size=3,
    maxsize=5,
    filegrowth=1
)
log on(
    name=test_data_log,
    filename='D:\Develop\sqlServer\test_data_log',
    size=1,
    maxsize=2,
    filegrowth=1
    )
go

create table teacher(
    ID int identity(1,1) not null ,
    Name varchar(20) not null,
    Sex Char(2) not null,
    Phone varchar(20) not null,
    Sallary smallmoney null,
    Address varchar(100) null ,
    Email varchar(30) null
)
go

drop database test;
go

drop table teacher
go

alter database test modify name=test1110;
go

alter table teacher add price money default 23.8
go

alter table teacher drop column price
go

insert into teacher values(01,'王明','男','1980-1-1');
go

select * from teacher where ID=01
go

delete teacher where ID=1
go

update student set sex='女' where student_ID=1
select * from student where student_ID=1
go

update BOOKS set ISREAD='true'
select * from BOOKS
go

select book_name,price,price*0.8 as newprice from books
go

select top 10 * from hosts
go

select * from books where not price>40
go

select * from books where price<40 and price>20
go

select * from student where 姓名 like '高%'
go

select * from student where 姓名 like '[陈_高,肖_赵]%'
go

select * from books where price between 20 and 40
go

select * from books order by price desc
go

begin select stu_id from student
goto skip
select * from student
skip:
    print '的说法是函数'
end


declare @x int,@y int,@z int
select @x=2,@y=5,@z=4
if @x>@y
    print 'x>y'
else if @y>@z
    print 'y>z'
else
    print 'z>y'

select score,
case
when score>90 then '非常优秀'
when score>80 then '优秀'
when score>70 then '良好'
when score>60 then '及格'
else '不及格'
end
from score;

declare @i int
set @i = 5
while @i>-1
begin
    print @i
    set @i=@i-1
    if @i=1 break
end
go


create table S(
    S# varchar(20) primary key,
    SN varchar(50) not null,
    SD varchar(50) not null,
    SA int not null
)

create table C(
    C# varchar(20) primary key,
    CN varchar(50) not null
)

create table SC(
    S# varchar(20) primary key ,
    C# varchar(20) not null,
    G float not null
)
go

select S.S#,SN from S,C,SC where S.S#=SC.S# and C.C#=SC.C# and CN= '税收基础'
go

select S#,SN from S where S#=(select S# from SC where C# in(select C# from C where CN='税收基础'))
go

select SN,SD from S,SC where S.S#=SC.S# and C#='C2'
go

select distinct count(*) from SC group by S#
go

select SN,SD from S where S# in (
    select S#
    from SC,C
    group by S#
    having count(distinct S#) = (select count(*) from C)
)
go

create database test1 on(
    name='test',
    filename='D:\Develop\sqlServer\test.mdf',
    size=1024kb,
    maxsize=unlimited,
    filegrowth=10%
    ) log on(
        name='test_Log',
        filename='D:\Develop\sqlServer\test.ldf',
        size=1024kb,
        maxsize=5120kb,
        filegrowth=1024kb
    )
go

alter database test
add file(
    name='test1',
    filename='D:\Develop\sqlServer\test1.mdf',
    size=5mb,
    maxsize=5MB
),
(
    name='test2',
    filename='D:\Develop\sqlServer\test2.mdf',
    size=3mb,
    maxsize=10mb,
    filegrowth=1mb
)
go

alter database test
add log file(
    name=testlog,
    filename='D:\Develop\sqlServer\testlog.ldf',
    size=5mb,
    maxsize=100mb,
    filegrowth=5mb
)
go

alter database test add filegroup test_group
go

alter database test add file(
    name=test2,
    filename='D:\Develop\sqlServer\resr.ndf',
) to filegroup test_group
go

drop database test
go

backup database test to disk='D:\Develop\sqlServer'
go

create table yuanxi(
    id int identity primary key ,
    name varchar(10) not null unique,
    miaoshu varchar(100)
)
create table xuesheng(
    id int identity primary key,
    name varchar(10) not null,
    xuehao varchar(18) not null unique,
    sex char(1) check(sex in('男','女')),
    shengri smalldatetime check(shengri<='2000-1-1'),
    dianhua varchar(30),
    xiebieID int references yuanxi(id),
    miaoshu varchar(100)
)
go

alter table xuesheng add dizhi varchar(50) null ;
go

alter table xuesheng drop column dizhi
go

alter table xuesheng alter column dizhi varchar(100) null
go

drop table xuesheng
go

create rule mobile_phone_rule as @mobile_phone like '1[3,5][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
go

create rule age_rule as @age between 12 and 45
go

create rule sex_rule as @sex in('男','女')
go

sp_bindrule mobile_phone_rule,'student.dianhua'
go

create database READBOOK on(
    name=Readbook_dat,
    filename='D:\readbook_dat.mdf',
    size=2MB,
    maxsize=10MB,
    filegrowth=15%
)
    log on
(
    name=Readbook_log,
    filename='D:\readbook_log.ldf',
    size=1MB,
    filegrowth=10%
)
go

create table book(
    bookid int not null primary key,
    bookname varchar(40) not null,
    publish varchar(60) null ,
    pubdate datetime null default(getdate()),
    price decimal(7,2) null ,
    author varchar(60) null ,
    remarks text null
)
go

create rule price_rule as @price between 1 and 200;
sp_bindrule price_rule,'book.price';
sp_unbindrule price_rule,'book.price';
go

select ID,score,score*1.1 as new_score from score;
go

select 姓名=NAME,年龄=AGE from student;
go

select '姓名：',NAME as 姓名,'年龄：',AGE age 年龄 from student;
go

select top 5 ID,NAME,AGE from student;
go

select top 30 percent id,name,age from student;
go

declare @N int
set @N=5
select Top @n id,name,age from student
go

select * from student where age>24
go

select * from student where age>24 or name like '高%'
go

select * from student where not age=24;
go

select * from student where age between 24 and 26
go

select * from student where age in(23,25,26)
go

select * from student where age is null
go

select top 5 * from student order by age desc;
go

select top 5 * into new_stu from student
select * from new_stu
go

select name,avg(age) as avg_age from student group by name;
go

select * from student where age<24 order by name



create database xscj1;
drop database xscj1;

create database test2 on(
    name=test2,
    filename='D:\test1.mdf',
    size=5MB,
    maxsize=50MB,
    filegrowth=10%
)
log on
(
    name=test2_log,
    filename='D:\test2_log.ldf',
    size=2MB,
    maxsize=5mb,
    filegrowth=1mb
);

create database test3 on
primary
(
    name=test3_data1,
    filename='D:\test3_data1.mdf',
    size=20mb,
    maxsize=unlimited,
    filegrowth=10%
),
(
    name=test3_data2,
    filename='D:\test3_data2.ndf',
    size=20mb,
    maxsize=unlimited,
    filegrowth=10%
)
log on
(
    name=test3_log,
    filename='D:\test3_log.ldf',
    size=50mb,
    maxsize=100mb,
    filegrowth=10%
);


create database test4
on primary
(
    name='test4_data1',
    filename='D:\test4_data1.mdf',
    size=20mb,
    maxsize=60mb,
    filegrowth=5mb
),filegroup test4Group1
(
    name='test4_data2',
    filename='D:\test4_data2.ndf',
    size=10mb,
    maxsize=unlimited,
    filegrowth=10%
);


alter database test1 modify file(
    name='test1_data',
    maxsize=unlimited,
    filegrowth=20%
);

alter database test1 add file(
    name='test1bak',
    filename='D:\test1bak.ndf',
    size=50mb,
    maxsize=unlimited,
    filegrowth=5%
    );

alter database test1 remove file test1bak;

alter database test1 add filegroup fgroup;

alter database test1 add file(
    name='test1_data2',
    filename='D:\test1_Data2.ndf',
    size=10mb,
    maxsize=unlimited
    ),(
        name='test1_data2',
        filename='D:\test1_data2.ndf',
        size=10mb,
        maxsize=unlimited
    ) to filegroup fgroup;

alter database test1 remove file test1_data2;
alter database test1 remove file test1_data3;
alter database test1 remove filegroup fgroup;

drop database test1;

create database xscj1;
use xscj1;

create table xsb(
    学号 char(6) not null primary key,
    姓名 char(8) not null,
    性别 bit not null default 1,
    出生时间 date null,
    专业 char(12) null default '计算机',
    总学分 int null default 0,
    备注 varchar(500) null ,
    年龄 as 2015-year(出生时间) persisted
);

-- 复制表的结构 不复制数据
select * into xsb1 from xsb;

alter table xsb1 add 入学时间 date;

alter table xsb1 alter column 姓名 char(10);

alter table xsb1 alter column 入学时间 smalldatetime;

alter table xsb1 drop column 入学时间,年龄;

drop table xsb1;

insert into xsb1 values('231301','王一平',1,'1990-02-10','管理工程',50,null);
insert into xsb1(学号,姓名,出生时间,专业,总学分) values('191301','王琳','1990-02-10','管理工程',50);

insert into xsb1 values ('201301','王海',1,'1991-05-10','软件工程',50,null),('201302','李娜',0,'1991-04-12','软件工程',52,null);

update xsb1 set 备注='校外互认学分课程',总学分=总学分+3 where 学号='231301';

delete from xsb1 where 专业='软件工程';

-- 删除表中所有记录
truncate table xsb1;

select * from xsb;

select 学号,姓名,总学分 from xsb where 专业='计算机';

select 学号 as number,姓名 as name,总学分 as mark from xsb1 where 专业='计算机';
select 'student number'=学号,'student name'=姓名,mark=总学分 from xsb where 专业='计算机';


select 学号,姓名,等级=
case
    when 总学分 is null then '尚未选课'
    when 总学分 < 50 then '不及格'
    when 总学分 >=50 and 总学分 <=52 then '合格'
    else '优秀'
end
from xsb where 专业='计算机';

select 学号,姓名,出生时间,year(getdate())-year(出生时间) as 年龄 from xsb where 专业='通信工程';

select distinct 专业 from xsb;

select top 10 姓名,专业,总学分 from xsb;

select sum(学分) as '总学分' from kcb;
select avg(成绩) as '计算机基础平均成绩' from cjb where 课程号='101'

select max(成绩) as '计算机基础最高分',min(成绩) as '计算机基础最低分' from cjb where 课程表='101';

select * from xsb where 专业='通信工程' and 总学分>=42;

select * from xsb where 姓名 like '王_';

select 姓名,专业 from xsb where 学号 like '%9___[^1-5]';

select 学号,姓名,专业,出生时间 from xsb where 出生时间 not between '1995-1-1' and '1995-12-31';

select 学号,姓名,专业,出生时间 from xsb where year(出生时间)!=1995;

select * from xsb where 专业 in ('软件工程','通信工程');

select * from xsb where 专业='计算机' or 专业='通信工程';

select * from xsb where 总学分 is null;

select * from xsb where 学号 in(
    select 学号 from cjb where 课程号='206'
    );

select 学号,姓名 from xsb where 学号 not in(
    select 学号 from cjb where 课程号 in(
        select distinct 课程号 from kcb where 课程名='离散数学')
);

select 学号,姓名 from xsb,kcb where xsb.学号=kcb.学号 and 课程号 =(select distinct 课程号 from kcb where 课程名='离散数学');

select * from xsb where 出生时间 < all(select 出生时间 from xsb where 专业='计算机');

-- 查询206课程号成绩不低于101课程号最低成绩的学生学号
select * from cjb where 课程号='206' and 成绩 !<any (
    select 成绩 from cjb where '课程号'='101'
    );

-- 查询选修206课程的学生姓名
select 姓名 from xsb where exists(
    select * from cjb where 学号=xsb.学号 and 课程号='206'
                             );

select 姓名 from xsb where not exists(
    select * from kcb where not exists(
        select * from sjb where 学号=xsb.学号 and 课程号=kcb.课程号
        )
    )

select 成绩 from cjb,kcb where cjb.课程=kcb.课程号 and 学号='191301' and 课程名='计算机基础'


select 姓名,学号,总学分 from(
                     select 姓名,学号,性别,总学分 from xsb where 总学分>=50
                         ) as student where 性别=1;

select xsb.*,cjb.课程号,cjb.成绩 from xsb,cjb where xsb.学号=cjb.学号;

select 姓名,成绩 from xsb,cjb where xsb.学号=cjb.学号 and 课程表='206' and 成绩 >=80;

select xsb.学号,姓名,课程名,成绩 from xsb,kcb,cjb where xsb.学号=cjb.学号 and kcb.课程名=cjb.课程号 and 课程名='计算机基础' and 成绩>=80;

select 学号,姓名,成绩名,成绩 from xsb,kcb,cjb where xsb.学号=cjb.学号 and kcb.课程号=cjb.课程号 and 课程名='计算机基础' and 成绩>=80;

select * from xsb inner join cjb on xsb.学号=cjb.学号;

select 姓名,成绩 from xsb join cjb on xsb.学号=cjb.学号 where 课程号='206' and 成绩>=80;

select xsb.学号,姓名,课程名,成绩 from xsb,kcb,cjb where xsb.学号=cjb.学号
and kcb.课程号=cjb.课程号
and 课程名='计算机基础'
and 成绩>80;

select * from xsb inner join cjb on xsb.学号=cjb.学号 where 课程号='206' and 成绩>=80;

select xsb.学号,姓名,课程名,成绩 from xsb join cjb join kcb
on cjb.课程号=kcb.课程号
on xsb.学号=cjb.学号
where 课程名='计算机基础' and 成绩>=80;

-- 查询不同课程成绩相同的学业上学号、课程号和成绩
select a.学号,a.课程号,b.课程号,a.成绩 from cjb a inner join cjb b where a.成绩=b.成绩 and a.学号=b.学号 and a.课程号!=b.课程号；

select xsb.*,课程号 from xsb left outer join cjb on xsb.学号=cjb.学号;

-- 列出学生所有可能的选课情况
select 学号,姓名,课程号,课程名 from xsb cross join kcb;

select 专业,性别,count(*) as '人数' from xsb group by rollup(专业,性别);

select 专业,性别,count(*) as '人数' from xsb group by 专业,性别;

select 学号,avg(成绩) 平均成绩 from cjb having avg(成绩)>=85;

select 学号 from cjb where 成绩>=80 group by 学号 having count(*)>2;

select 学号,姓名 into 计算机学生 from xsb where 专业='计算机';

select * from 计算机学生 where 学号='191301'
union all
select * from 通信工程学生 where 学号='221301';

select * from xsb where 专业='计算机'
except
select * from xsb where 性别=1;

select * from xsb where 总学分>42
intersect
select * from xsb where 性别=1;

create view ccj_avg as
select xsb.学号,课程号,成绩 from xsb,cjb where xsb.学号=cjb.学号 and 专业='计算机';

select * from ccj_avg;
select * from ccj_avg where score_avg>=75;
drop view ccj_avg;

declare xs_cur1 cursor for
 select 学号,姓名,性别,出生日期,总学分 from xsb where 专业='计算机'
for read only;

declare xs_cur2 cursor
dynamic for
select 学号,姓名,总学分 from xsb where 专业='计算机' for update of 总学分;

declare xs_cur3 cursor
local scroll scroll_locks for
select 学号,姓名,总学分 from xsb
for update of 总学分;
open xs_cur3;
select '游标xs_cur3数据行数'=@@CURSOR_ROWS;

declare xs_cur4 cursor for
select 学号,姓名,性别,出生日期,总学分 from xsb where 专业='计算机'
for read only;
open xs_cur4;
fetch next from xs_cur4;
fetch next from xs_cur4;

declare xs_cur5 cursor
dynamic for
select 学号,姓名,总学分 from xsb where 专业='计算机'
for update of 总学分;
open xs_cur5;
fetch next from xs_cur5;
fetch next from xs_cur5;
fetch relative 2 from xs_cur5;
fetch prior from xs_cur5;
fetch relative -3 from xs_cur5;
select '执行情况'=@@FETCH_STATUS
fetch first from xs_cur5
close xs_cur5

deallocate xs_cur5;
```

